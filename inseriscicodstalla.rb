# Inserisci stalla
def inscodstalla(finestra, listacombo)
	mcodstalla = Gtk::Window.new("Inserimento codice di stalla")
	mcodstalla.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxcodstallav = Gtk::VBox.new(false, 0)
	boxcodstalla1 = Gtk::HBox.new(false, 5)
	boxcodstalla2 = Gtk::HBox.new(false, 5)
	boxcodstalla3 = Gtk::HBox.new(false, 5)
	boxcodstalla4 = Gtk::HBox.new(false, 5)
	boxcodstallav.pack_start(boxcodstalla1, false, false, 5)
	boxcodstallav.pack_start(boxcodstalla2, false, false, 5)
	boxcodstallav.pack_start(boxcodstalla3, false, false, 5)
	boxcodstallav.pack_start(boxcodstalla4, false, false, 5)
	mcodstalla.add(boxcodstallav)
	labelstalla = Gtk::Label.new("Codice 317 stalla:")
	boxcodstalla1.pack_start(labelstalla, false, false, 5)
	codstalla = Gtk::Entry.new()
	codstalla.max_length=(8)
	boxcodstalla1.pack_start(codstalla, false, false, 5)
	labelvia = Gtk::Label.new("Indirizzo:")
	boxcodstalla2.pack_start(labelvia, false, false, 5)
	codvia = Gtk::Entry.new()
	codvia.max_length=(50)
	boxcodstalla2.pack_start(codvia, false, false, 5)
	labelcomune = Gtk::Label.new("Comune:")
	boxcodstalla3.pack_start(labelcomune, false, false, 5)
	codcomune = Gtk::Entry.new()
	codcomune.max_length=(50)
	boxcodstalla3.pack_start(codcomune, false, false, 5)
	
	bottcodstalla = Gtk::Button.new( "Inserisci la stalla" )
	boxcodstalla4.pack_start(bottcodstalla, false, false, 5)
	bottcodstalla.signal_connect("clicked") {
		if codstalla.text == ""
			Errore.avviso(mcodstalla, "Mancano dei dati.")
		else
			controllo = Stalles.find(:first, :conditions => "cod317 = '#{codstalla.text.upcase}'")
			if controllo == nil
				Stalles.create(:cod317 => "#{codstalla.text.upcase}", :via => "#{codvia.text.upcase}", :comune => "#{codcomune.text.upcase}")
				Conferma.conferma(mcodstalla, "Dati inseriti correttamente")
				mcodstalla.destroy
				sel1 = Stalles.find(:all)
				listacombo.clear
				sel1.each do |r|
					iter1 = listacombo.append
					iter1[0] = r.id
					iter1[1] = r.cod317
				end
				finestra.present
			else
				Errore.avviso(mcodstalla, "Il codice stalla è già presente.")
			end
		end
	}
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mcodstalla.destroy
		finestra.present
	}
	boxcodstallav.pack_start(bottchiudi, false, false, 0)

	mcodstalla.show_all
end
