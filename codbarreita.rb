def codbarreita(finestraingr)
	mcodbarreita = Gtk::Window.new("Codice a barre italiano")
	mcodbarreita.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxcodbarreitav = Gtk::VBox.new(false, 0)
	boxcodbarreita1 = Gtk::HBox.new(false, 5)
	boxcodbarreita2 = Gtk::HBox.new(false, 5)
	boxcodbarreita3 = Gtk::HBox.new(false, 5)
	boxcodbarreitav.pack_start(boxcodbarreita1, false, false, 5)
	boxcodbarreitav.pack_start(boxcodbarreita2, false, false, 5)
	boxcodbarreitav.pack_start(boxcodbarreita3, false, false, 5)
	mcodbarreita.add(boxcodbarreitav)
	labelcod = Gtk::Label.new("Inserisci codice a barre della marca:")
	boxcodbarreita1.pack_start(labelcod, false, false, 5)
	entrycod = Gtk::Entry.new
	entrycod.width_chars=(30)
	boxcodbarreita1.pack_start(entrycod, false, false, 5)
	labelcod2 = Gtk::Label.new("Inserisci codice a barre dei dati:")
	boxcodbarreita2.pack_start(labelcod2, false, false, 5)
	entrycod2 = Gtk::Entry.new
	entrycod2.width_chars=(30)
	boxcodbarreita2.pack_start(entrycod2, false, false, 5)

	bottins = Gtk::Button.new( "OK" )
	boxcodbarreita2.pack_start(bottins, false, false, 5)
	marca = ""
	razza = ""
	datanascita = ""
	sesso = ""
	entrycod.signal_connect("activate") {
		if entrycod.text == ""
			Errore.avviso(mcodbarreita, "Il codice è vuoto.")
		else
			marca = entrycod.text
			entrycod2.grab_focus
#			altranascita = entrycod.text[17,6]
#			@marca.text = "#{altramarca}"
#			@nascita.text = "#{altranascita}"
#			mcodbarreita.destroy
#			finestraingr.present
			puts marca.inspect
		end
	}
	entrycod2.signal_connect("activate") {
		if entrycod2.text == ""
			Errore.avviso(mcodbarreita2, "Il codice è vuoto.")
		else
			dati = entrycod2.text
			razza = Razzas.find(:first, :conditions => ["cod_razza= ?", "#{dati[0,3]}"])
			puts razza.inspect
			sesso = dati[3,1]
			puts sesso.inspect
			datanascita = dati[4,4] + dati[10,2]
			puts datanascita.inspect
#			altranascita = entrycod.text[17,6]
			@marca.text = "#{marca}"
			@razza.text = "#{razza.razza}" if razza != nil
			@nascita.text = "#{datanascita}"
			if sesso == "M"
				@sesso1.active=(true)
			else
				@sesso2.active=(true)
			end
			mcodbarreita.destroy
			finestraingr.present
			#puts marca.inspect
		end
	}
	bottins.signal_connect( "clicked" ) {
		if entrycod.text == ""
			Errore.avviso(mcodbarreita, "Il codice è vuoto.")
		else
			dati = entrycod2.text
			razza = Razzas.find(:first, :conditions => ["cod_razza= ?", "#{dati[0,3]}"])
			puts razza.inspect
			sesso = dati[3,1]
			puts sesso.inspect
			datanascita = dati[4,4] + dati[10,2]
			puts datanascita.inspect
#			altranascita = entrycod.text[17,6]
			@marca.text = "#{marca}"
			@razza.text = "#{razza.razza}" if razza != nil
			@nascita.text = "#{datanascita}"
			if sesso == "M"
				@sesso1.active=(true)
			else
				@sesso2.active=(true)
			end
			mcodbarreita.destroy
			finestraingr.present
		end
	}
	mcodbarreita.show_all
end
