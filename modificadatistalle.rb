#Modifica stalle

def modificadatistalle
	mmoddatistalle = Gtk::Window.new("Modifica dati stalle")
	mmoddatistalle.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxmoddatistallev = Gtk::VBox.new(false, 0)
	boxmoddatistalle1 = Gtk::HBox.new(false, 5)
	boxmoddatistalle2 = Gtk::HBox.new(false, 5)
	boxmoddatistalle3 = Gtk::HBox.new(false, 5)
	boxmoddatistalle4 = Gtk::HBox.new(false, 5)
	boxmoddatistalle5 = Gtk::HBox.new(false, 5)
	boxmoddatistalle6 = Gtk::HBox.new(false, 5)
	boxmoddatistalle7 = Gtk::HBox.new(false, 5)
	boxmoddatistalle8 = Gtk::HBox.new(false, 5)
	boxmoddatistallev.pack_start(boxmoddatistalle1, false, false, 5)
	boxmoddatistallev.pack_start(boxmoddatistalle2, false, false, 5)
	boxmoddatistallev.pack_start(boxmoddatistalle3, false, false, 5)
	boxmoddatistallev.pack_start(boxmoddatistalle4, false, false, 5)
	boxmoddatistallev.pack_start(boxmoddatistalle5, false, false, 5)
	boxmoddatistallev.pack_start(boxmoddatistalle6, false, false, 5)
	boxmoddatistallev.pack_start(boxmoddatistalle7, false, false, 5)
	boxmoddatistallev.pack_start(boxmoddatistalle8, false, false, 5)
	mmoddatistalle.add(boxmoddatistallev)

	#Combo di scelta stalla

	labelstalla = Gtk::Label.new("Selezona stalla:")
	boxmoddatistalle1.pack_start(labelstalla, false, false, 5)

	listastalle = Gtk::ListStore.new(Integer, String, String, String, String, Integer, Integer, String)
	#listaragsoc.clear
	selstalle = Stalles.find(:all, :order => "cod317")
	selstalle.each do |s|
		iter1 = listastalle.append
		iter1[0] = s.id
		iter1[1] = s.cod317
		iter1[2] = s.via
		iter1[3] = s.comune
		iter1[4] = s.provincia
		iter1[5] = s.region_id.to_i
		iter1[6] = s.ulss.to_i
		iter1[7] = s.citta_ulss
	end
	combostalle = Gtk::ComboBox.new(listastalle)
	renderer1 = Gtk::CellRendererText.new
	combostalle.pack_start(renderer1,false)
	combostalle.set_attributes(renderer1, :text => 1)
	boxmoddatistalle1.pack_start(combostalle, false, false, 0)

	#Via

	labelvia = Gtk::Label.new("Via:")
	boxmoddatistalle2.pack_start(labelvia, false, false, 5)
	via = Gtk::Entry.new
	via.max_length=(50)
	via.width_chars=(50)
	#via.text=("#{selstalle.active_iter[2]}")
	boxmoddatistalle2.pack_start(via, false, false, 5)

	#Comune

	labelcomune = Gtk::Label.new("Comune:")
	boxmoddatistalle3.pack_start(labelcomune, false, false, 5)
	comune = Gtk::Entry.new
	comune.max_length=(50)
	comune.width_chars=(50)
	#comune.text=("#{selstalle.active_iter[3]}")
	boxmoddatistalle3.pack_start(comune, false, false, 5)

	#Provincia

	labelprov = Gtk::Label.new("Provincia (sigla):")
	boxmoddatistalle4.pack_start(labelprov, false, false, 5)
	prov = Gtk::Entry.new
	prov.max_length=(2)
	prov.width_chars=(5)
	#prov.text=("#{selstalle.active_iter[4]}")
	boxmoddatistalle4.pack_start(prov, false, false, 5)
	
	#Regione
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
	labelreg = Gtk::Label.new("Regione:")
	boxmoddatistalle5.pack_start(labelreg, false, false, 5)
	
	#via = Gtk::Entry.new
	#via.max_length=(50)
	#via.text=("#{selstalle.active_iter[2]}")
	boxmoddatistalle5.pack_start(comboreg, false, false, 5)

	#Ulss

	labelulss = Gtk::Label.new("ULSS:")
	boxmoddatistalle6.pack_start(labelulss, false, false, 5)
	ulss = Gtk::Entry.new
	ulss.max_length=(11)
	ulss.width_chars=(5)
	#ulss.text=("#{selstalle.active_iter[3]}")
	boxmoddatistalle6.pack_start(ulss, false, false, 5)

	#Città ULSS

	labelcitta = Gtk::Label.new("Città ULSS:")
	boxmoddatistalle7.pack_start(labelcitta, false, false, 5)
	citta = Gtk::Entry.new
	citta.max_length=(50)
	citta.width_chars=(50)
	#citta.text=("#{selstalle.active_iter[4]}")
	boxmoddatistalle7.pack_start(citta, false, false, 5)

	combostalle.signal_connect( "changed" ) {
		if combostalle.active != -1
			via.text="#{combostalle.active_iter[2]}"
			comune.text="#{combostalle.active_iter[3]}"
			prov.text="#{combostalle.active_iter[4]}"
			if combostalle.active_iter[6] > 0
				ulss.text = "#{combostalle.active_iter[6]}"
			else
				ulss.text = ""
			end
			citta.text = "#{combostalle.active_iter[7]}"
			comboreg.set_active(-1)
			#puts combostalle.active_iter[5]
			if combostalle.active_iter[5] > 0
				comboreg.set_active(0)
				contareg = -1
				while comboreg.active_iter[0] != combostalle.active_iter[5]
					contareg+=1
					comboreg.set_active(contareg)
				end
			end
		end
	}



	#Bottone di inserimento

	moddati = Gtk::Button.new( "Modifica dati" )
	moddati.signal_connect("clicked") {
		if via.text=="" or prov.text=="" or comune.text == "" or ulss.text == "" or citta == "" or comboreg.active == -1
			Errore.avviso(mmoddatistalle, "Servono tutti i dati.")
		else
			Stalles.update(combostalle.active_iter[0], { :via => "#{via.text.upcase}", :comune => "#{comune.text.upcase}", :provincia => "#{prov.text.upcase}", :region_id => "#{comboreg.active_iter[0]}", :ulss => "#{ulss.text.upcase}", :citta_ulss => "#{citta.text.upcase}"})
			via.text=""
			comune.text = ""
			prov.text=""
			comboreg.set_active(-1)
			ulss.text = ""
			citta.text = ""
		end
	}
	boxmoddatistalle8.pack_start(moddati, false, false, 0)

	#Bottone di chiusura finestra

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mmoddatistalle.destroy
	}
	boxmoddatistalle8.pack_start(bottchiudi, false, false, 0)

	mmoddatistalle.show_all
end
