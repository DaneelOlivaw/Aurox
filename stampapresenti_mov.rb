def stampapresmov(finestra)
	selcapi = Animals.find(:all, :conditions => ["relaz_id= ? and tipo = ? and uscito = ?", "#{@stallaoper.id}", "I", "0"], :order => ["data_ingr"])
	foglio = PDF::Writer.new(:paper => "A4")
	foglio.select_font("Helvetica")
	foglio.open_object do |testa|
		foglio.save_state
		dimcar = 9
		x = foglio.margin_x_middle
		y = foglio.absolute_top_margin
		z = foglio.absolute_left_margin
		w = foglio.absolute_right_margin
		testo = "<b>Capi presenti nella stalla #{@stallaoper.stalle.cod317} di #{@stallaoper.ragsoc.ragsoc} in data #{@giorno.strftime("%d/%m/%Y")}: #{selcapi.length}</b>"
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
		data << {"prog" => "", "marca" => "#{i.marca}"}
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
		Conferma.conferma(finestra, "Non ci sono dati da stampare.")
	end
end
