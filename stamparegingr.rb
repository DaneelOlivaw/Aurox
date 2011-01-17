# Stampa registro ingresso

def registroingr(mstamparegistro)
	foglio = PDF::Writer.new(:paper => "A4") # , :font_size => 5)
	foglio.margins_mm(20, 10, 7)
	foglio.select_font("Helvetica")
#	foglio.start_page_numbering(10, 10, 6, :center, "<PAGENUM>/08", 1)
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
	#selcapi = Registros.find(:all, :conditions => "relaz_id='#{@stallaoper}' and stampacarico='0'")

	#contid = Relazs.find(:first, :conditions => "id = '#{@stallaoper.id}'")
	selcapi = Registros.find(:all, :conditions => ["contatori_id = ? and stampacarico= ?", "#{@stallaoper.contatori_id}", "0"], :order => ["dataingresso, id"])
	selcapi.each do |i, index|
		data << {"prog" => "#{i.progressivo.to_s}", "marca" => "#{i.marca}", "razza" => "#{i.razza}", "sesso" => "#{i.sesso}", "madre" => "#{i.madre}",	"nc" => "#{i.tipoingresso}", "nascita" => "#{i.datanascita.strftime("%d/%m/%Y")}", "ingresso" => "#{i.dataingresso.strftime("%d/%m/%Y")}", "prov" => "#{i.provenienza}"}
	end
	if data.length != 0
		tabella.data.replace data
		tabella.render_on(foglio)
		foglio.save_as("#{@dir}/registro/registro_ingresso.pdf")
		if @sistema == "linux"
			system("evince #{@dir}/registro/registro_ingresso.pdf")
		else
#			foglio.save_as('.\registro\registro_ingresso.pdf')
			@shell.ShellExecute('.\registro\registro_ingresso.pdf', '', '', 'open', 3)
		end
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
end
