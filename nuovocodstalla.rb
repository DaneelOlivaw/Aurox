# Inserisci stalla
def nuovocodstalla(finestra, listacombo)
	mcodstalla = Gtk::Window.new("Inserimento codice di stalla")
	mcodstalla.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxcodstallav = Gtk::VBox.new(false, 0)
	boxcodstalla1 = Gtk::HBox.new(false, 5)
	boxcodstalla2 = Gtk::HBox.new(false, 5)
	boxcodstalla3 = Gtk::HBox.new(false, 5)
	boxcodstalla4 = Gtk::HBox.new(false, 5)
	boxcodstalla5 = Gtk::HBox.new(false, 5)
	boxcodstalla6 = Gtk::HBox.new(false, 5)
	boxcodstalla7 = Gtk::HBox.new(false, 5)
	boxcodstallav.pack_start(boxcodstalla1, false, false, 5)
	boxcodstallav.pack_start(boxcodstalla2, false, false, 5)
	boxcodstallav.pack_start(boxcodstalla3, false, false, 5)
	boxcodstallav.pack_start(boxcodstalla4, false, false, 5)
	boxcodstallav.pack_start(boxcodstalla5, false, false, 5)
	boxcodstallav.pack_start(boxcodstalla6, false, false, 5)
	boxcodstallav.pack_start(boxcodstalla7, false, false, 5)
	mcodstalla.add(boxcodstallav)
	labelstalla = Gtk::Label.new("Codice 317 stalla:")
	boxcodstalla1.pack_start(labelstalla, false, false, 5)
	codstalla = Gtk::Entry.new
	codstalla.max_length=(8)
	codstalla.width_chars=(10)
	boxcodstalla1.pack_start(codstalla, false, false, 5)
	labelvia = Gtk::Label.new("Indirizzo:")
	boxcodstalla2.pack_start(labelvia, false, false, 5)
	codvia = Gtk::Entry.new
	codvia.max_length=(50)
	codvia.width_chars=(50)
	boxcodstalla2.pack_start(codvia, false, false, 5)
	labelcomune = Gtk::Label.new("Comune:")
	boxcodstalla3.pack_start(labelcomune, false, false, 5)
	codcomune = Gtk::Entry.new
	codcomune.max_length=(50)
	codcomune.width_chars=(50)
	boxcodstalla3.pack_start(codcomune, false, false, 5)
	labelprovincia = Gtk::Label.new("Provincia (sigla):")
	boxcodstalla4.pack_start(labelprovincia, false, false, 5)
	codprovincia = Gtk::Entry.new
	codprovincia.max_length=(2)
	codprovincia.width_chars=(5)
	boxcodstalla4.pack_start(codprovincia, false, false, 5)

	labelcodreg = Gtk::Label.new("Regione:")
	boxcodstalla4.pack_start(labelcodreg, false, false, 5)
	listareg = Gtk::ListStore.new(Integer, String, String)
	selreg = Regions.find(:all, :order => "regione")
	selreg.each do |r|
		iter1 = listareg.append
		iter1[0] = r.id.to_i
		iter1[1] = r.codreg
		iter1[2] = r.regione
	end
	comboreg = Gtk::ComboBox.new(listareg)
	renderer1 = Gtk::CellRendererText.new
	comboreg.pack_start(renderer1,false)
	comboreg.set_attributes(renderer1, :text => 2)
	boxcodstalla4.pack_start(comboreg, false, false, 5)
	labelnulss = Gtk::Label.new("Ulss n°:")
	boxcodstalla5.pack_start(labelnulss, false, false, 5)
	codnulss = Gtk::Entry.new
	#codnulss.max_length=(2)
	codnulss.width_chars=(5)
	boxcodstalla5.pack_start(codnulss, false, false, 5)
	labelcitta = Gtk::Label.new("Di (città ULSS):")
	boxcodstalla6.pack_start(labelcitta, false, false, 5)
	codcitta = Gtk::Entry.new
	codcitta.max_length=(50)
	codcitta.width_chars=(50)
	boxcodstalla6.pack_start(codcitta, false, false, 5)



	bottcodstalla = Gtk::Button.new( "Inserisci la stalla" )
	boxcodstalla7.pack_start(bottcodstalla, false, false, 5)
	bottcodstalla.signal_connect("clicked") {
		if codstalla.text == "" or codvia.text == "" or codcomune.text == "" or codprovincia.text == "" or codnulss.text == "" or codcitta.text == "" or comboreg.active == -1
			Errore.avviso(mcodstalla, "Mancano dei dati.")
		else
			controllo = Stalles.find(:first, :conditions => "cod317 = '#{codstalla.text.upcase}'")
			if controllo == nil
				Stalles.create(:cod317 => "#{codstalla.text.upcase}", :via => "#{codvia.text.upcase}", :comune => "#{codcomune.text.upcase}", :provincia => "#{codprovincia.text.upcase}", :region_id => "#{comboreg.active_iter[0]}", :ulss => "#{codnulss.text.to_i}", :citta_ulss => "#{codcitta.text.upcase}")
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
	boxcodstalla7.pack_start(bottchiudi, false, false, 0)

	mcodstalla.show_all
end
