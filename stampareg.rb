def registronuovo(window)
	#rimanenze = Registros.count(:all, :conditions => ["contatori_id= ? and stampascarico= ? and tipouscita != ?", "#{@stallaoper.contatori_id}", "0", "null"], :order => ["dataingresso, id"])
	rimanenze = Registros.count(:all, :conditions => ["relaz_id= ? and tipouscita IS NULL", "#{@stallaoper.id}"])
	fogliousc = PDF::Writer.new(:paper => "A4", :orientation => :landscape) # , :font_size => 5)
	fogliousc.margins_mm(20, 6, 12)
	fogliousc.select_font("Helvetica")
#	fogliousc.start_page_numbering(10, 10, 6, :center, "<PAGENUM>/08", 1)
	fogliousc.open_object do |piede|
		fogliousc.save_state
		dimcar = 6
#		x = 500 #spostamento orizzontale
		y = fogliousc.absolute_bottom_margin
		z = fogliousc.absolute_left_margin
		w = fogliousc.absolute_right_margin
		testo = "Stampato in data #{@giorno.strftime("%d/%m/%Y")} - rimanenze: #{rimanenze}"
		boh = fogliousc.text_width(testo, dimcar) #/ 2.0
		q = fogliousc.absolute_bottom_margin + (dimcar * 1.01)
		m = w - boh
		#fogliousc.line(z, q, w, q).stroke
		fogliousc.add_text(m, y, testo, dimcar)
		fogliousc.restore_state
		fogliousc.close_object
		fogliousc.add_object(piede, :all_pages)
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
	tabella.minimum_space = 10
	tabella.column_order.push(*%w(prog marca razza sesso madre nc nascita ingresso prov motusc datausc destinazione marcaprec mod4))
	tabella.columns["prog"] = PDF::SimpleTable::Column.new("prog") { |col|
		col.heading = "Numero ordine"
		col.width = 40
	}
	tabella.columns["marca"] = PDF::SimpleTable::Column.new("marca") { |col|
		col.heading = "Marchio di identificazione"
		col.width = 76 #80
	}
	tabella.columns["razza"] = PDF::SimpleTable::Column.new("razza") { |col|
		col.heading = "Razza"
		col.width = 33 #35
	}
	tabella.columns["sesso"] = PDF::SimpleTable::Column.new("sesso") { |col|
		col.heading = "Sesso"
		col.width = 33 #35
	}
	tabella.columns["madre"] = PDF::SimpleTable::Column.new("madre") { |col|
		col.heading = "Codice madre"
		col.width = 76 #80
	}
	tabella.columns["nc"] = PDF::SimpleTable::Column.new("nc") { |col|
		#col.heading = "Nato / acquisto"
		col.heading = "N/A"
		col.width = 25 #40
	}
	tabella.columns["nascita"] = PDF::SimpleTable::Column.new("nascita") { |col|
		col.heading = "Data nascita"
		col.width = 52 #53 #55
	}
	tabella.columns["ingresso"] = PDF::SimpleTable::Column.new("ingresso") { |col|
		col.heading = "Data ingresso"
		col.width = 52 #53 #55
	}
	tabella.columns["prov"] = PDF::SimpleTable::Column.new("prov") { |col|
		col.heading = "Provenienza"
		col.width = 106 #102 #90
	}
	tabella.columns["motusc"] = PDF::SimpleTable::Column.new("motusc") { |col|
		col.heading = "Motivo uscita"
		col.width = 34
	}
	tabella.columns["datausc"] = PDF::SimpleTable::Column.new("datausc") { |col|
		col.heading = "Data uscita"
		col.width = 52 #53 #55
	}
	tabella.columns["destinazione"] = PDF::SimpleTable::Column.new("destinazione") { |col|
		col.heading = "Destinazione"
		col.width = 111 #111
	}
	tabella.columns["marcaprec"] = PDF::SimpleTable::Column.new("marcaprec") { |col|
		col.heading = "Marca precedente"
		col.width = 76 #80
	}
	tabella.columns["mod4"] = PDF::SimpleTable::Column.new("mod4") { |col|
		col.heading = "Mod. 4 / Cert. san."
		col.width = 50 #35
	}
	data = Array.new
	#contid = Relazs.find(:first, :conditions => "id = '#{@stallaoper}'")
	selcapi = Registros.find(:all, :conditions => ["relaz_id= ? and stampascarico= ? and tipouscita != ?", "#{@stallaoper.id}", "0", "null"], :order => ["dataingresso, id"])
	selcapi.each do |i, index|
		#puts i.id
		if (i.tipouscita == "V" or i.tipouscita == "C") and i.mod4usc.to_s != ""
			mod4 = i.mod4usc.split("/")
			mod4anno = mod4[1]
			mod4num = mod4[2]
			mod4pul = mod4num + "/" + mod4anno.to_s[2,2]
		else
			if i.certsanusc.split(".").length == 4
				mod4pul = i.certsanusc.split(".")[3].to_s
			else
				mod4pul = i.certsanusc
			end
		end

		if i.destinazione.length > 18
			destinazione = i.destinazione[0..16] + "..."
		else
			destinazione = i.destinazione
		end

		data << {"prog" => "#{i.progressivo.to_s}", "marca" => "#{i.marca}", "razza" => "#{i.razza}", "sesso" => "#{i.sesso}", "madre" => "#{i.madre}", "nc" => "#{i.tipoingresso}", "nascita" => "#{i.datanascita.strftime("%d/%m/%Y")}", "ingresso" => "#{i.dataingresso.strftime("%d/%m/%Y")}", "prov" => "#{i.provenienza}", "motusc" => "#{i.tipouscita}", "datausc" => "#{i.datauscita.strftime("%d/%m/%Y")}", "destinazione" => "#{destinazione}", "marcaprec" => "#{i.marcaprec}", "mod4" => "#{mod4pul}"}
	end
	if data.length != 0
		tabella.data.replace data
		tabella.render_on(fogliousc)
		fogliousc.save_as("#{@dir}/registro/registro_uscita.pdf")
		if @sistema == "linux"
			system("evince #{@dir}/registro/registro_uscita.pdf")
			else
#			fogliousc.save_as('.\registro\registro_uscita.pdf')
			@shell.ShellExecute('.\registro\registro_uscita.pdf', '', '', 'open', 3)
		end

		avviso = Gtk::MessageDialog.new(window, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "La stampa è stata eseguita correttamente?")
		#avviso.modal == true
		risposta = avviso.run
		avviso.destroy
		if risposta == Gtk::Dialog::RESPONSE_YES
			avviso2 = Gtk::MessageDialog.new(window, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Aggiorno il registro?")
			risposta2 = avviso2.run
			avviso2.destroy
			if risposta2 == Gtk::Dialog::RESPONSE_YES
				selcapi.each do |d|
					Registros.update(d.id, { :stampascarico => "1"})
				end
				Conferma.conferma(window, "Il registro è stato aggiornato.")
			else
				Conferma.conferma(window, "Il registro non è stato aggiornato.")
			end
		else
			Conferma.conferma(window, "Si dovrà rilanciare la stampa.")
		end
	else
		Conferma.conferma(window, "Non ci sono dati da stampare.")
	end
end
