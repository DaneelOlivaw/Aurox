# Stampa capi per giorni di presenza

def stampapresgiorno(capi, giornosel, numcapi)
	#puts orientamento
#	foglio = PDF::Writer.new(:paper => "A4", :orientation => :"{orientamento}") # , :font_size => 5)
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
		testo = "CAPI PRESENTI NELLA STALLA #{@stallaoper.stalle.cod317} IL GIORNO #{giornosel}: #{numcapi}</b>"
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
#	tabella.column_order.push(*%w(prog marca razza sesso madre nc nascita ingresso giornipres uscita))
	tabella.column_order.push(*%w(prog marca razza sesso madre nc nascita ingresso provenienza))
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
	tabella.columns["provenienza"] = PDF::SimpleTable::Column.new("provenienza") { |col|
		col.heading = "Provenienza"
		#col.width = 55
	}
#	tabella.columns["giornipres"] = PDF::SimpleTable::Column.new("giornipres") { |col|
#		col.heading = "Giorni di presenza"
#		#col.width = 106
#	}
#	if valtipo == "usciti"
#		#puts "colonna"
#		tabella.columns["uscita"] = PDF::SimpleTable::Column.new("uscita") { |col|
#			col.heading = "Data di uscita"
#			#col.width = 55
#		}
#	end
	data = Array.new
	#selcapi = Registros.find(:all, :conditions => "relaz_id='#{@stallaoper}' and stampacarico='0'")
	#puts capi.inspect
	#contid = Relazs.find(:first, :conditions => "id = '#{@stallaoper.id}'")
	#selcapi = Registros.find(:all, :conditions => ["contatori_id = ? and stampacarico= ?", "#{@stallaoper.contatori_id}", "0"], :order => ["dataingresso, id"])
	capi.each do |i, index|
		#puts i[13]
#		if valtipo == "presenti"
#				giorni = @giorno.to_date - i.dataingresso
#				datauscita = ""
#			else
#				giorni = i.datauscita - i.dataingresso
#				datauscita = i.datauscita.strftime("%d/%m/%Y")
#			end
		#data << {"prog" => i["prog"], "marca" => i["marca"], "razza" => i["razza}", "sesso" => "#{i.sesso}", "madre" => "#{i.madre}",	"nc" => "#{i.tipoingresso}", "nascita" => "#{i.datanascita}", "ingresso" => "#{i.dataingresso}", "prov" => "#{i.provenienza}"}
#		data << {"prog" => i["progressivo"], "marca" => i["marca"], "razza" => i["razza"], "sesso" => i["sesso"], "madre" => i["madre"],	"nc" => i["tipoingresso"], "nascita" => i["datanascita"].strftime("%d/%m/%Y"), "ingresso" => i["dataingresso"].strftime("%d/%m/%Y"), "giornipres" => giorni, "uscita" => datauscita}
		data << {"prog" => i["progressivo"], "marca" => i["marca"], "razza" => i["razza"], "sesso" => i["sesso"], "madre" => i["madre"],	"nc" => i["tipoingresso"], "nascita" => i["datanascita"].strftime("%d/%m/%Y"), "ingresso" => i["dataingresso"].strftime("%d/%m/%Y"), "provenienza" => i["provenienza"]}
	end
	#foglio.margins_mm(15, 10, 10)
	if data.length != 0
		tabella.data.replace data
		tabella.render_on(foglio)
		foglio.save_as("#{@dir}/altro/registro_presgiorno.pdf")
		if @sistema == "linux"
			system("evince #{@dir}/altro/registro_presgiorno.pdf")
		else
#			foglio.save_as('.\registro\registro_ingresso.pdf')
			@shell.ShellExecute('.\altro\registro_presgiorno.pdf', '', '', 'open', 3)
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
