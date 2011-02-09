def insaltricod(finestraingr)
	minsaltricod = Gtk::Window.new("Codici a barre non standard")
	minsaltricod.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxinsaltricodv = Gtk::VBox.new(false, 0)
	boxinsaltricod1 = Gtk::HBox.new(false, 5)
	boxinsaltricod2 = Gtk::HBox.new(false, 5)
	boxinsaltricod3 = Gtk::HBox.new(false, 5)
	boxinsaltricodv.pack_start(boxinsaltricod1, false, false, 5)
	boxinsaltricodv.pack_start(boxinsaltricod2, false, false, 5)
	boxinsaltricodv.pack_start(boxinsaltricod3, false, false, 5)
	minsaltricod.add(boxinsaltricodv)
	labelcod = Gtk::Label.new("Inserisci codice a barre:")
	boxinsaltricod1.pack_start(labelcod, false, false, 5)
	entrycod = Gtk::Entry.new
	entrycod.width_chars=(30)
	boxinsaltricod1.pack_start(entrycod, false, false, 5)

	bottins = Gtk::Button.new( "OK" )
	boxinsaltricod2.pack_start(bottins, false, false, 5)

	entrycod.signal_connect("activate") {
		if entrycod.text == ""
			Errore.avviso(minsaltricod, "Il codice è vuoto.")
		else
			altramarca = "FR" + entrycod.text[0,10]
			altranascita = entrycod.text[17,6]
			@marca.text = "#{altramarca}"
			@nascita.text = "#{altranascita}"
			minsaltricod.destroy
			finestraingr.present
		end
	}
	bottins.signal_connect( "clicked" ) {
		if entrycod.text == ""
			Errore.avviso(minsaltricod, "Il codice è vuoto.")
		else
			altramarca = "FR" + entrycod.text[0,10]
			altranascita = entrycod.text[17,6]
			minsaltricod.destroy
			@marca.text = "#{altramarca}"
			@nascita.text = "#{altranascita}"
			finestraingr.present
		end
	}
	minsaltricod.show_all
end
