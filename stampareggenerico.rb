# Stampa registro ingresso

def stampareggenerico(ordine, datainizio, datafine, orientamento)
	#puts orientamento
#	foglio = PDF::Writer.new(:paper => "A4", :orientation => :"{orientamento}") # , :font_size => 5)
	if orientamento == "portait"
		foglio = PDF::Writer.new(:paper => "A4", :orientation => :portait) # , :font_size => 5)
		#foglio.margins_mm(7, 5, 12, 13)
		if @stallaoper.detentori.detentore.length > 40
			detentore = @stallaoper.detentori.detentore[0..40] + "..."
		else
			detentore = @stallaoper.detentori.detentore
		end
		if @stallaoper.prop.prop.length > 40
			proprietario = @stallaoper.prop.prop[0..40] + "..."
		else
			proprietario = @stallaoper.prop.prop
		end
	else
		foglio = PDF::Writer.new(:paper => "A4", :orientation => :landscape) # , :font_size => 5)
		#foglio.margins_mm(7, 5, 12, 13)
		detentore = @stallaoper.detentori.detentore
		proprietario = @stallaoper.prop.prop
	end
	if datafine == ""
		fine = @giorno.strftime("%d/%m/%Y")
	else
		fine = datafine
	end
	#foglio.margins_mm(15, 10, 10)
	foglio.margins_mm(7, 5, 12, 13)
	foglio.select_font("Helvetica")
#	foglio.start_page_numbering(10, 10, 6, :center, "<PAGENUM>/08", 1)
	foglio.open_object do |testa|
		foglio.save_state
		dimcar = 8
		x = foglio.margin_x_middle
		y = foglio.absolute_top_margin
		z = foglio.absolute_left_margin
		w = foglio.absolute_right_margin
		#testo = "<b>Movimenti della stalla #{@stallaoper.stalle.cod317} di #{@stallaoper.ragsoc.ragsoc} dal #{datainizio} al #{fine}: #{ordine.length}</b>"
		testo = "MOVIMENTI DELLA STALLA #{@stallaoper.stalle.cod317} DAL #{datainizio} AL #{fine}: #{ordine.length}</b>"
		boh = foglio.text_width(testo, dimcar) / 2.0
		q = foglio.absolute_top_margin - (dimcar * 1.5)
		m = x - boh
		foglio.add_text(z, y, testo, dimcar)
		
		testoragsoc = "RAGIONE SOCIALE:  #{@stallaoper.ragsoc.ragsoc}"
#		bohragsoc = foglio.text_width(testo, dimcar) / 2.0
		qragsoc = foglio.absolute_top_margin - (dimcar * 1.5)
#		mragsoc = x - boh2
		foglio.add_text(z, qragsoc, testoragsoc, dimcar)

#		if @stallaoper.detentori.detentore.length > 40
#			detentore = @stallaoper.detentori.detentore[0..40] + "..."
#		else
#			detentore = @stallaoper.detentori.detentore
#		end
#		if @stallaoper.prop.prop.length > 40
#			proprietario = @stallaoper.prop.prop[0..40] + "..."
#		else
#			proprietario = @stallaoper.prop.prop
#		end
		testo2 = "DETENTORE:  #{detentore}  -  PROPRIETARIO:  #{proprietario}"
		boh2 = foglio.text_width(testo, dimcar) / 2.0
		q2 = qragsoc - (dimcar * 1.5)
		m2 = x - boh2
		foglio.add_text(z, q2, testo2, dimcar)
		
		
		
		
		
		
		
		
		
		
		
		#spostapagina = x + 36
		foglio.start_page_numbering(w-20, foglio.absolute_bottom_margin, 8, nil, "pag. <PAGENUM> di <TOTALPAGENUM>")
		foglio.restore_state
		foglio.close_object
		foglio.add_object(testa, :all_pages)
	end
	#foglio.margins_mm(15, 5, 15)
	foglio.margins_mm(17, 5, 15)
=begin
	foglio.open_object do |piede|
		foglio.save_state
		dimcar = 6
#		x = 500 #spostamento orizzontale
		y = foglio.absolute_bottom_margin
		z = foglio.absolute_left_margin
		w = foglio.absolute_right_margin
		testo = "Stampato in data #{@giorno.strftime("%d/%m/%Y")}"
		boh = foglio.text_width(testo, dimcar) #/ 2.0
		q = foglio.absolute_bottom_margin + (dimcar * 1.01)
		m = w - boh
		#foglio.line(z, q, w, q).stroke
		foglio.add_text(m, y, testo, dimcar)
		foglio.restore_state
		foglio.close_object
		foglio.add_object(piede, :all_pages)
	end
=end
	tabella = PDF::SimpleTable.new
#	tabella.title = "PDF dati"
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
	if orientamento == "portait"
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
		col.width = 76#90
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
		#col.width = 106
	}
	else
		#puts "altre colonne"
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
	end
	data = Array.new
	#selcapi = Registros.find(:all, :conditions => "relaz_id='#{@stallaoper}' and stampacarico='0'")

	#contid = Relazs.find(:first, :conditions => "id = '#{@stallaoper.id}'")
	#selcapi = Registros.find(:all, :conditions => ["contatori_id = ? and stampacarico= ?", "#{@stallaoper.contatori_id}", "0"], :order => ["dataingresso, id"])
	ordine.each do |i, index|
		if orientamento == "portait"
			#data << {"prog" => i["prog"], "marca" => i["marca"], "razza" => i["razza}", "sesso" => "#{i.sesso}", "madre" => "#{i.madre}",	"nc" => "#{i.tipoingresso}", "nascita" => "#{i.datanascita}", "ingresso" => "#{i.dataingresso}", "prov" => "#{i.provenienza}"}
			data << {"prog" => i["prog"], "marca" => i["marca"], "razza" => i["razza"], "sesso" => i["sesso"], "madre" => i["madre"],	"nc" => i["tipoingresso"], "nascita" => i["datanascita"], "ingresso" => i["dataingresso"], "prov" => i["provenienza"]}
		else
			#puts i["marca"]
			if i["tipouscita"] == "V" or i["tipouscita"] == "C"
				unless i["mod4usc"].to_s == ""
					mod4 = i["mod4usc"].split("/")
					mod4anno = mod4[1]
					mod4num = mod4[2]
					mod4pul = mod4num + "/" + mod4anno.to_s[2,2]
				else
					mod4pul = "..." + i["certsanusc"].split(".")[3]
				end
			else
				mod4pul = i["certsanusc"]
			end
			if i["destinazione"].to_s.length > 18
				destinazione = i["destinazione"][0..16] + "..."
			else
				destinazione = i["destinazione"]
			end
			if i["datauscita"].to_s != ""
				uscitacapo = i["datauscita"]
			else
				uscitacapo = ""
			end
#			data << {"prog" => "#{i.prog}", "marca" => "#{i.marca}", "razza" => "#{i.razza}", "sesso" => "#{i.sesso}", "madre" => "#{i.madre}", "nc" => "#{i.tipoingresso}", "nascita" => "#{i.datanascita}", "ingresso" => "#{i.dataingresso}", "prov" => "#{i.provenienza}", "motusc" => "#{i.tipouscita}", "datausc" => "#{uscitacapo}", "destinazione" => "#{destinazione}", "marcaprec" => "#{i.marcaprec}", "mod4" => "#{mod4pul}"}
			data << {"prog" => i["prog"], "marca" => i["marca"], "razza" => i["razza"], "sesso" => i["sesso"], "madre" => i["madre"], "nc" => i["tipoingresso"], "nascita" => i["datanascita"], "ingresso" => i["dataingresso"], "prov" => i["provenienza"], "motusc" => i["tipouscita"], "datausc" => "#{uscitacapo}", "destinazione" => "#{destinazione}", "marcaprec" => i["marcaprec"], "mod4" => "#{mod4pul}"}
		end
	end
	#foglio.margins_mm(15, 10, 10)
	if data.length != 0
		tabella.data.replace data
		tabella.render_on(foglio)
		foglio.save_as("#{@dir}/altro/registro_generico.pdf")
		if @sistema == "linux"
			system("evince #{@dir}/altro/registro_generico.pdf")
		else
#			foglio.save_as('.\registro\registro_ingresso.pdf')
			@shell.ShellExecute('.\altro\registro_generico.pdf', '', '', 'open', 3)
		end
	end
=begin
		avviso = Gtk::MessageDialog.new(mstamparegistro, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "La stampa è stata eseguita correttamente?")
		risposta = avviso.run
		avviso.destroy
		if risposta == Gtk::Dialog::RESPONSE_YES
			avviso2 = Gtk::MessageDialog.new(mstamparegistro, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Aggiorno il registro?")
			risposta2 = avviso2.run
			avviso2.destroy
			if risposta2 == Gtk::Dialog::RESPONSE_YES
				selcapi.each do |d|
					Registros.update(d.id, { :stampacarico => "1"})
				end
				Conferma.conferma(mstamparegistro, "Il registro è stato aggiornato.")
			else
				Conferma.conferma(mstamparegistro, "Il registro non è stato aggiornato.")
			end
		else
			Conferma.conferma(mstamparegistro, "Si dovrà rilanciare la stampa.")
		end
	else
		Conferma.conferma(mstamparegistro, "Non ci sono dati da stampare.")
	end
=end
end
