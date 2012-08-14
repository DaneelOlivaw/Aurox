def registronv(comboanno)
	fogliousc = PDF::Writer.new(:paper => "A4", :orientation => :landscape) # , :font_size => 5)
	fogliousc.margins_mm(7, 5, 12, 13)
	fogliousc.select_font("Helvetica")
	fogliousc.open_object do |testa|
		fogliousc.save_state
		dimcar = 8
		x = fogliousc.margin_x_middle
		y = fogliousc.absolute_top_margin
		z = fogliousc.absolute_left_margin
		w = fogliousc.absolute_right_margin
		testo = "REGISTRO NON VIDIMATO DELLA STALLA #{@stallaoper.stalle.cod317}"
		boh = fogliousc.text_width(testo, dimcar) / 2.0
		q = fogliousc.absolute_top_margin - (dimcar * 1.5)
		m = x - boh
		fogliousc.add_text(z, y, testo, dimcar)
		fogliousc.add_text(z, q, "RAGIONE SOCIALE: #{@stallaoper.ragsoc.ragsoc}", dimcar)
		testo2 = "DETENTORE: #{@stallaoper.detentori.detentore} - PROPRIETARIO: #{@stallaoper.prop.prop}"
		ltesto2 = fogliousc.text_width(testo2, dimcar) / 2.0
		oriztesto2 = x - ltesto2
		q2 = q -(dimcar*1.5)
		#registro.add_text(oriztesto2, q2, testo2, dimcar)
		fogliousc.add_text(z, q2, testo2, dimcar)
		spostapagina = x + 36
		fogliousc.start_page_numbering(w-20, fogliousc.absolute_bottom_margin, 8, nil, "pag. <PAGENUM> di <TOTALPAGENUM>")
		fogliousc.restore_state
		fogliousc.close_object
		fogliousc.add_object(testa, :all_pages)
	end
	fogliousc.margins_mm(17, 5, 15)
	tabellausc = PDF::SimpleTable.new
	tabellausc.show_lines = :all
	tabellausc.show_headings = true
	tabellausc.orientation = :right
	tabellausc.position = :left
	tabellausc.shade_rows = :none
	tabellausc.split_rows = true
	tabellausc.font_size = 8
	tabellausc.heading_font_size = 8
	tabellausc.minimum_space = 10
	tabellausc.column_order.push(*%w(prog marca razza sesso madre nc nascita ingresso prov motusc datausc destinazione marcaprec mod4))
	tabellausc.columns["prog"] = PDF::SimpleTable::Column.new("prog") { |col|
		col.heading = "N. ordine"
		col.width = 39 #40
	}
	tabellausc.columns["marca"] = PDF::SimpleTable::Column.new("marca") { |col|
		col.heading = "Marchio di identificazione"
		col.width = 76 #80
	}
	tabellausc.columns["razza"] = PDF::SimpleTable::Column.new("razza") { |col|
		col.heading = "Razza"
		col.width = 33 #35
	}
	tabellausc.columns["sesso"] = PDF::SimpleTable::Column.new("sesso") { |col|
		col.heading = "Sesso"
		col.width = 33 #35
	}
	tabellausc.columns["madre"] = PDF::SimpleTable::Column.new("madre") { |col|
		col.heading = "Codice della madre"
		col.width = 76 #80
	}
	tabellausc.columns["nc"] = PDF::SimpleTable::Column.new("nc") { |col|
		col.heading = "N/A"
		col.width = 25 #40
	}
	tabellausc.columns["nascita"] = PDF::SimpleTable::Column.new("nascita") { |col|
		col.heading = "Data di nascita"
		col.width = 52 #53 #55
	}
	tabellausc.columns["ingresso"] = PDF::SimpleTable::Column.new("ingresso") { |col|
		col.heading = "Data di ingresso"
		col.width = 52 #53 #55
	}
	tabellausc.columns["prov"] = PDF::SimpleTable::Column.new("prov") { |col|
		col.heading = "Provenienza"
		col.width = 106 #90
	}
	tabellausc.columns["motusc"] = PDF::SimpleTable::Column.new("motusc") { |col|
		col.heading = "Motivo uscita"
		col.width = 34 #35
	}
	tabellausc.columns["datausc"] = PDF::SimpleTable::Column.new("datausc") { |col|
		col.heading = "Data uscita"
		col.width = 52 #53 #55
	}
	tabellausc.columns["destinazione"] = PDF::SimpleTable::Column.new("destinazione") { |col|
		col.heading = "Destinazione"
		col.width = 111 #90
	}
	tabellausc.columns["marcaprec"] = PDF::SimpleTable::Column.new("marcaprec") { |col|
		col.heading = "Marca precedente"
		col.width = 76 #80
	}
	tabellausc.columns["mod4"] = PDF::SimpleTable::Column.new("mod4") { |col|
		col.heading = "Mod. 4"
		col.width = 50 #35
	}
	data = Array.new
	#rel = Relazs.find(:first, :conditions => "id = '#{@stallaoper}'")
	selcapi = Registros.find(:all, :conditions => ["relaz_id= ? and tipouscita != 'null' and YEAR(datauscita) = ?", "#{@stallaoper.id}", "#{comboanno.active_iter[0]}"], :order => ["dataingresso, id"])
	selcapi.each do |i, index|
		if i.tipouscita == "V" or i.tipouscita == "C"
			mod4 = i.mod4usc.split("/")
			mod4anno = mod4[1]
			mod4num = mod4[2]
			mod4pul = mod4num + "/" + mod4anno.to_s[2,2]
		else
			mod4pul = i.certsanusc
		end
		if i.destinazione.length > 18
			destinazione = i.destinazione[0..16] + "..."
		else
			destinazione = i.destinazione
		end
		data << {"prog" => "#{i.progressivo.to_s}", "marca" => "#{i.marca}", "razza" => "#{i.razza}", "sesso" => "#{i.sesso}", "madre" => "#{i.madre}",	"nc" => "#{i.tipoingresso}", "nascita" => "#{i.datanascita.strftime("%d/%m/%Y")}", "ingresso" => "#{i.dataingresso.strftime("%d/%m/%Y")}", "prov" => "#{i.provenienza}", "motusc" => "#{i.tipouscita}", "datausc" => "#{i.datauscita.strftime("%d/%m/%Y")}", "destinazione" => "#{destinazione}",	"marcaprec" => "#{i.marcaprec}", "mod4" => "#{mod4pul}"}
	end
	tabellausc.data.replace data
	tabellausc.render_on(fogliousc)
	fogliousc.save_as("#{@dir}/regnv/registronv.pdf")
	if @sistema == "linux"
#		fogliousc.save_as('./regnv/registro_uscitanv.pdf')
		system("evince #{@dir}/regnv/registronv.pdf")
	else
#		fogliousc.save_as('.\regnv\registro_uscitanv.pdf')
		@shell.ShellExecute('.\regnv\registronv.pdf', '', '', 'open', 3)
	end
end
=begin
def stampapres
	selcapi = Registros.find(:all, :conditions => "relaz_id='#{@stallaoper}' and tipouscita IS NULL", :order => ["dataingresso, id"])
	foglio = PDF::Writer.new(:paper => "A4")
	foglio.select_font("Helvetica")
	foglio.open_object do |testa|
		foglio.save_state
		dimcar = 9
		x = foglio.margin_x_middle
		y = foglio.absolute_top_margin
		z = foglio.absolute_left_margin
		w = foglio.absolute_right_margin
		testo = "<b>Capi presenti nella stalla #{@combo.active_iter[1]} di #{@combo2.active_iter[1]} in data #{@giorno.strftime("%d/%m/%Y")}: #{selcapi.length}</b>"
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
	selcapi.each do |i, index|
		data << {"prog" => "#{i.progressivo.to_s}", "marca" => "#{i.marca}", "razza" => "#{i.razza}", "sesso" => "#{i.sesso}", "madre" => "#{i.madre}",	"nc" => "#{i.tipoingresso}", "nascita" => "#{i.datanascita.strftime("%d/%m/%Y")}", "ingresso" => "#{i.dataingresso.strftime("%d/%m/%Y")}", "prov" => "#{i.provenienza}"}
	end
foglio.margins_mm(15, 10, 10)
	if data.length != 0
		tabella.data.replace data
		tabella.render_on(foglio)
		foglio.save_as("#{@dir}/altro/presenze.pdf")
		if @sistema == "linux"
			system("evince #{@dir}/altro/presenze.pdf")
		else
#			foglio.save_as('.\altro\presenze.pdf')
			@shell.ShellExecute('.\altro\presenze.pdf', '', '', 'open', 3)
		end
	else
		Conferma.conferma(@window, "Non ci sono dati da stampare.")
	end
end
=end
