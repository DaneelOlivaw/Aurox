def stampapresgiorni(selmov, datainizio, datafine)
	foglio = PDF::Writer.new(:paper => "A4") # , :font_size => 5)
	foglio.select_font("Helvetica")
	foglio.open_object do |testa|
		foglio.save_state
		dimcar = 8
		x = foglio.margin_x_middle
		y = foglio.absolute_top_margin
		z = foglio.absolute_left_margin
		w = foglio.absolute_right_margin
		testo = "<b>Movimenti di ingresso della stalla #{@stallaoper.stalle.cod317} di #{@stallaoper.ragsoc.ragsoc} dal #{Time.parse(datainizio).strftime("%d/%m/%Y")} al #{Time.parse(datafine).strftime("%d/%m/%Y")}</b>"
		boh = foglio.text_width(testo, dimcar) / 2.0
		q = foglio.absolute_top_margin - (dimcar * 1.5)
		m = x - boh
		foglio.add_text(m, y, testo, dimcar)
		spostapagina = x + 36
		foglio.start_page_numbering(w-20, foglio.absolute_bottom_margin, 8, nil, "pag. <PAGENUM> di <TOTALPAGENUM>")
		foglio.restore_state
		foglio.close_object
		foglio.add_object(testa, :all_pages)
	end
	foglio.margins_mm(15, 10, 10)
	tabella = PDF::SimpleTable.new
	tabella.show_lines = :all
	tabella.show_headings = true
	tabella.orientation = :right
	tabella.position = :left
	tabella.shade_rows = :none
	tabella.split_rows = true
	tabella.font_size = 8
	tabella.heading_font_size = 8
	tabella.width = 550
	tabella.minimum_space = 10
	tabella.column_order.push(*%w(prog marca razza sesso madre nc nascita ingresso prov))
	tabella.columns["prog"] = PDF::SimpleTable::Column.new("prog") { |col|
		col.heading = "Numero ordine"
		col.width = 40
	}
	tabella.columns["marca"] = PDF::SimpleTable::Column.new("marca") { |col|
		col.heading = "Marchio di identificazione"
		col.width = 90
	}
	tabella.columns["razza"] = PDF::SimpleTable::Column.new("razza") { |col|
		col.heading = "Razza"
		col.width = 35
	}
	tabella.columns["sesso"] = PDF::SimpleTable::Column.new("sesso") { |col|
		col.heading = "Sesso"
		col.width = 35
	}
	tabella.columns["madre"] = PDF::SimpleTable::Column.new("madre") { |col|
		col.heading = "Codice della madre"
		col.width = 90
	}
	tabella.columns["nc"] = PDF::SimpleTable::Column.new("nc") { |col|
		col.heading = "Nato / acquisto"
		col.width = 40
	}
	tabella.columns["nascita"] = PDF::SimpleTable::Column.new("nascita") { |col|
		col.heading = "Data di nascita"
		col.width = 55
	}
	tabella.columns["ingresso"] = PDF::SimpleTable::Column.new("ingresso") { |col|
		col.heading = "Data di ingresso"
		col.width = 55
	}
	tabella.columns["prov"] = PDF::SimpleTable::Column.new("prov") { |col|
		col.heading = "Provenienza"
	}
	data = Array.new

		#rel = Relazs.find(:first, :conditions => "id = '#{@stallaoper.id}'")
		#selmov = Registros.find(:all, :conditions => ["contatori_id= ? and YEAR(dataingresso) = ?", "#{@stallaoper.contatori_id}", "#{comboanno.active_iter[0]}"], :order => ["dataingresso, id"])
	selmov.each do |i, index|
		#data << {"prog" => "#{i.progressivo.to_s}", "marca" => "#{i.marca}", "razza" => "#{i.razza}", "sesso" => "#{i.sesso}", "madre" => "#{i.madre}",	"nc" => "#{i.tipoingresso}", "nascita" => "#{i.datanascita.strftime("%d/%m/%Y")}", "ingresso" => "#{i.dataingresso.strftime("%d/%m/%Y")}", "prov" => "#{i.provenienza}"}
		if i.cm_ing == 1
			tipoingr = "N"
		elsif i.cm_ing == 19
			tipoingr = "C"
		else
			tipoingr = "A"
		end
		if i.cm_ing == 2 or i.cm_ing == 1 or i.cm_ing == 19 or i.cm_ing == 24 or i.cm_ing == 25 or i.cm_ing == 26
			prov = i.allevamenti.cod317
		elsif i.cm_ing == 13 or i.cm_ing == 23 or i.cm_ing == 32
			if i.certsan.to_s != ""
				prov = i.certsan
			else
				prov = i.rifloc
			end
		end
		data << {"prog" => "#{i.id}", "marca" => "#{i.marca}", "razza" => "#{i.razza.cod_razza}", "sesso" => "#{i.sesso}", "madre" => "#{i.marca_madre}",	"nc" => "#{tipoingr}", "nascita" => "#{i.data_nas.strftime("%d/%m/%Y")}", "ingresso" => "#{i.data_ingr.strftime("%d/%m/%Y")}", "prov" => "#{prov}"}		
	end
	tabella.data.replace data
	tabella.render_on(foglio)
	foglio.save_as("#{@dir}/altro/parziali_ingresso.pdf")
	if @sistema == "linux"
		system("evince #{@dir}/altro/parziali_ingresso.pdf")
	else
#		foglio.save_as('.\regnv\registro_ingressonv.pdf')
#		@shell.ShellExecute('./regnv/registro_ingressonv.pdf', '', '', 'open', 3)
		@shell.ShellExecute('.\altro\parziali_ingresso.pdf', '', '', 'open', 3)
	end
end
