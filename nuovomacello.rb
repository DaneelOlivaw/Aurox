#Maschera inserimento macelli

def nuovomacello(listamacdest)
	minsmacelli = Gtk::Window.new("Nuovo macello")
	minsmacelli.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxinsmacv = Gtk::VBox.new(false, 0)
	boxinsmac1 = Gtk::HBox.new(false, 5)
	boxinsmac2 = Gtk::HBox.new(false, 5)
	boxinsmac3 = Gtk::HBox.new(false, 5)
	boxinsmac4 = Gtk::HBox.new(false, 5)
	boxinsmac5 = Gtk::HBox.new(false, 5)
	boxinsmac6 = Gtk::HBox.new(false, 5)
	boxinsmac7 = Gtk::HBox.new(false, 5)
#	boxinsmac8 = Gtk::HBox.new(false, 5)
	boxinsmacv.pack_start(boxinsmac1, false, false, 5)
	boxinsmacv.pack_start(boxinsmac2, false, false, 5)
	boxinsmacv.pack_start(boxinsmac3, false, false, 5)
	boxinsmacv.pack_start(boxinsmac4, false, false, 5)
	boxinsmacv.pack_start(boxinsmac5, false, false, 5)
	boxinsmacv.pack_start(boxinsmac6, false, false, 5)
	boxinsmacv.pack_start(boxinsmac7, false, false, 5)
#	boxminsmacv.pack_start(boxinsmac8, false, false, 5)
	minsmacelli.add(boxinsmacv)

	#Nome macello

	labelnomemac = Gtk::Label.new("Nome:")
	boxinsmac1.pack_start(labelnomemac, false, false, 5)
	nomemac = Gtk::Entry.new
	nomemac.max_length=(50)
	nomemac.width_chars=(50)
	boxinsmac1.pack_start(nomemac, false, false, 5)

	#Identificativo fiscale

	labelidfiscmac = Gtk::Label.new("Identificativo fiscale:")
	boxinsmac2.pack_start(labelidfiscmac, false, false, 5)
	idfiscmac = Gtk::Entry.new
	idfiscmac.max_length=(16)
	boxinsmac2.pack_start(idfiscmac, false, false, 5)

	#Bollo CEE macello

	labelbollomac = Gtk::Label.new("Bollo CEE:")
	boxinsmac3.pack_start(labelbollomac, false, false, 5)
	bollomac = Gtk::Entry.new
	bollomac.max_length=(8)
	boxinsmac3.pack_start(bollomac, false, false, 5)

	#Via macello

	labelviamac = Gtk::Label.new("Indirizzo:")
	boxinsmac4.pack_start(labelviamac, false, false, 5)
	viamac = Gtk::Entry.new
	viamac.max_length=(50)
	viamac.width_chars=(50)
	boxinsmac4.pack_start(viamac, false, false, 5)

	#Comune macello

	labelcomunemac = Gtk::Label.new("Comune:")
	boxinsmac5.pack_start(labelcomunemac, false, false, 5)
	comunemac = Gtk::Entry.new
	comunemac.max_length=(50)
	comunemac.width_chars=(50)
	boxinsmac5.pack_start(comunemac, false, false, 5)

	#Provincia macello

	labelprovmac = Gtk::Label.new("Provincia (sigla):")
	boxinsmac6.pack_start(labelprovmac, false, false, 5)
	provmac = Gtk::Entry.new
	provmac.max_length=(2)
	provmac.width_chars=(4)
	boxinsmac6.pack_start(provmac, false, false, 5)

	#Codice regione

	labelcodreg = Gtk::Label.new("Codice regione:")
	boxinsmac6.pack_start(labelcodreg, false, false, 5)
#	@codreg = Gtk::Entry.new()
#	@codreg.max_length=(8)
#	boxinsmac4.pack_start(@codreg, false, false, 5)

		listareg = Gtk::ListStore.new(Integer, String, String)
		selreg = Regions.find(:all, :order => "regione")
		selreg.each do |r|
			iter1 = listareg.append
			iter1[0] = r.id.to_i
			iter1[1] = r.codreg
			iter1[2] = r.regione
		end
#	end

	comboreg = Gtk::ComboBox.new(listareg)
	renderer1 = Gtk::CellRendererText.new
	comboreg.pack_start(renderer1,false)
	comboreg.set_attributes(renderer1, :text => 2)
	boxinsmac6.pack_start(comboreg, false, false, 0)

	#Bottone di inserimento

	inseriscimac = Gtk::Button.new( "Inserisci macello" )
	inseriscimac.signal_connect("clicked") {
	nmac = nomemac.text
	if nomemac.text==("") or idfiscmac.text==("") or bollomac.text==("") or comboreg.active == -1
		Errore.avviso(minsmacelli, "Servono tutti i dati.")
	else
		Macellis.create(:nomemac => "#{nomemac.text.upcase}", :ifmac => "#{idfiscmac.text.upcase}", :bollomac => "#{bollomac.text.upcase}", :via => "#{viamac.text.upcase}", :comune => "#{comunemac.text.upcase}", :provincia => "#{provmac.text.upcase}", :region_id => "#{comboreg.active_iter[0]}")
		nomemac.text=("")
		idfiscmac.text=("")
		bollomac.text=("")
		comboreg.active = -1
		#puts @listamacdest
		if listamacdest != nil
			listamacdest.clear
			selmacdest = Macellis.find(:all)
			selmacdest.each do |macdest|
				itermacdest = listamacdest.append
				itermacdest[0] = macdest.id
				itermacdest[1] = macdest.nomemac
				itermacdest[2] = macdest.bollomac
				itermacdest[3] = macdest.region.regione
			end
			minsmacelli.destroy
		end
	end
	}

	boxinsmac7.pack_start(inseriscimac, false, false, 0)

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		minsmacelli.destroy
	}
	boxinsmac7.pack_start(bottchiudi, false, false, 0)

	minsmacelli.show_all

end

=begin
#Maschera modifica macelli

def modmacelli(idmacello)
	mmodmacelli = Gtk::Window.new("Modifica macelli")
	mmodmacelli.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxmodmacv = Gtk::VBox.new(false, 0)
	boxmodmac1 = Gtk::HBox.new(false, 5)
	boxmodmac2 = Gtk::HBox.new(false, 5)
	boxmodmac3 = Gtk::HBox.new(false, 5)
	boxmodmac4 = Gtk::HBox.new(false, 5)
	boxmodmac5 = Gtk::HBox.new(false, 5)
	boxmodmac6 = Gtk::HBox.new(false, 5)
	boxmodmac7 = Gtk::HBox.new(false, 5)
	boxmodmac8 = Gtk::HBox.new(false, 5)
	boxmodmacv.pack_start(boxmodmac1, false, false, 5)
	boxmodmacv.pack_start(boxmodmac2, false, false, 5)
	boxmodmacv.pack_start(boxmodmac3, false, false, 5)
	boxmodmacv.pack_start(boxmodmac4, false, false, 5)
	boxmodmacv.pack_start(boxmodmac5, false, false, 5)
	boxmodmacv.pack_start(boxmodmac6, false, false, 5)
	boxmodmacv.pack_start(boxmodmac7, false, false, 5)
	boxmodmacv.pack_start(boxmodmac8, false, false, 5)
	mmodmacelli.add(boxmodmacv)

	#Combo di scelta macello

	labelmacello = Gtk::Label.new("Selezona macello:")
	boxmodmac1.pack_start(labelmacello, false, false, 5)

	def generalista(listamacdest)
		listamacdest.clear
		selmac = Macellis.find(:all, :order => "nomemac")
		selmac.each do |m|
			iter1 = listamacdest.append
			iter1[0] = m.id.to_i
			iter1[1] = m.nomemac
			iter1[2] = m.ifmac
			iter1[3] = m.bollomac
			iter1[4] = m.region_id
			iter1[5] = m.via
			iter1[6] = m.comune
			iter1[7] = m.provincia
		end
	end

	listamacdest = Gtk::ListStore.new(Integer, String, String, String, Integer, String, String, String)
	generalista(listamacdest)
	combomac = Gtk::ComboBox.new(listamacdest)
	renderer1 = Gtk::CellRendererText.new
	combomac.pack_start(renderer1,false)
	combomac.set_attributes(renderer1, :text => 1)
	boxmodmac1.pack_start(combomac, false, false, 0)

	#Nome macello

	labelnomemac = Gtk::Label.new("Nome:")
	boxmodmac2.pack_start(labelnomemac, false, false, 5)
	nomemac = Gtk::Entry.new
	nomemac.max_length=(50)
	nomemac.width_chars=(50)
	boxmodmac2.pack_start(nomemac, false, false, 5)

	#Identificativo fiscale

	labelidfiscmac = Gtk::Label.new("Identificativo fiscale:")
	boxmodmac3.pack_start(labelidfiscmac, false, false, 5)
	idfiscmac = Gtk::Entry.new
	idfiscmac.max_length=(16)
	boxmodmac3.pack_start(idfiscmac, false, false, 5)

	#Bollo CEE macello

	labelbollomac = Gtk::Label.new("Bollo CEE:")
	boxmodmac4.pack_start(labelbollomac, false, false, 5)
	bollomac = Gtk::Entry.new
	bollomac.max_length=(8)
	boxmodmac4.pack_start(bollomac, false, false, 5)

	#Via macello

	labelviamac = Gtk::Label.new("Indirizzo:")
	boxmodmac5.pack_start(labelviamac, false, false, 5)
	viamac = Gtk::Entry.new
	viamac.max_length=(50)
	viamac.width_chars=(50)
	boxmodmac5.pack_start(viamac, false, false, 5)

	#Comune macello

	labelcomunemac = Gtk::Label.new("Comune:")
	boxmodmac6.pack_start(labelcomunemac, false, false, 5)
	comunemac = Gtk::Entry.new
	comunemac.max_length=(50)
	comunemac.width_chars=(50)
	boxmodmac6.pack_start(comunemac, false, false, 5)

	#Provincia macello

	labelprovmac = Gtk::Label.new("Provincia (sigla):")
	boxmodmac7.pack_start(labelprovmac, false, false, 5)
	provmac = Gtk::Entry.new
	provmac.max_length=(2)
	provmac.width_chars=(4)
	boxmodmac7.pack_start(provmac, false, false, 5)

	#Codice regione

	labelregmac = Gtk::Label.new("Codice regione:")
	boxmodmac7.pack_start(labelregmac, false, false, 5)
	listaregmac = Gtk::ListStore.new(Integer, String, String)
	selregmac = Regions.find(:all, :order => "regione")
	selregmac.each do |r|
		iter1 = listaregmac.append
		iter1[0] = r.id.to_i
		iter1[1] = r.codreg
		iter1[2] = r.regione
	end

	comboregmac = Gtk::ComboBox.new(listaregmac)
	renderer1 = Gtk::CellRendererText.new
	comboregmac.pack_start(renderer1,false)
	comboregmac.set_attributes(renderer1, :text => 2)

#	comboregmac.set_active(0)
#	contareg = -1
#	while comboregmac.active_iter[0] != combomac.active_iter[4]
#		contareg+=1
#		comboregmac.set_active(contareg)
#	end

	unless idmacello == nil
		combomac.set_active(0)
		z = -1
		while combomac.active_iter[0] != idmacello
			z+=1
			combomac.set_active(z)
		end
		nomemac.text=("#{combomac.active_iter[1]}")
		idfiscmac.text=("#{combomac.active_iter[2]}")
		bollomac.text=("#{combomac.active_iter[3]}")
		viamac.text = "#{combomac.active_iter[5]}"
		comunemac.text = "#{combomac.active_iter[6]}"
		provmac.text = "#{combomac.active_iter[7]}"
		comboregmac.set_active(0)
		contareg = -1
		while comboregmac.active_iter[0] != combomac.active_iter[4]
			contareg+=1
			comboregmac.set_active(contareg)
		end
	end

	boxmodmac7.pack_start(comboregmac, false, false, 5)
	combomac.signal_connect( "changed" ) {
		if combomac.active != -1
			nomemac.text=("#{combomac.active_iter[1]}")
			idfiscmac.text=("#{combomac.active_iter[2]}")
			bollomac.text=("#{combomac.active_iter[3]}")
			viamac.text = "#{combomac.active_iter[5]}"
			comunemac.text = "#{combomac.active_iter[6]}"
			provmac.text = "#{combomac.active_iter[7]}"
			comboregmac.set_active(0)
			contareg = -1
			while comboregmac.active_iter[0] != combomac.active_iter[4]
				contareg+=1
				comboregmac.set_active(contareg)
			end
		end
	}

	#Bottone di inserimento

	inseriscimac = Gtk::Button.new( "Modifica macello" )
	inseriscimac.signal_connect("clicked") {
		if nomemac.text==("") or idfiscmac.text==("") or bollomac.text==("") or comboregmac.active == -1
			Errore.avviso(mmodmacelli, "Servono tutti i dati.")
		else
			Macellis.update(combomac.active_iter[0], {:nomemac => "#{nomemac.text.upcase}", :ifmac => "#{idfiscmac.text.upcase}", :bollomac => "#{bollomac.text.upcase}", :region_id => "#{comboregmac.active_iter[0]}", :via => "#{viamac.text.upcase}", :comune => "#{comunemac.text.upcase}", :provincia => "#{provmac.text.upcase}"})
			nomemac.text=("")
			idfiscmac.text=("")
			bollomac.text=("")
			viamac.text = ""
			comunemac.text = ""
			provmac.text = ""
			comboregmac.active = -1
			generalista(listamacdest)
			combomac.model=(listamacdest)
		end
	}

	boxmodmac8.pack_start(inseriscimac, false, false, 0)

	#Bottone di annullamento modifiche

#	annullacampi = Gtk::Button.new( "Annulla modifiche" )
#	annullacampi.signal_connect("clicked") {
#		nomemac.text=("#{combomac.active_iter[1]}")
#		idfiscmac.text=("#{combomac.active_iter[2]}")
#		bollomac.text=("#{combomac.active_iter[3]}")
##		regmac.text=("#{combomac.active_iter[4]}")

#		comboregmac.set_active(0)
#		contareg = -1
#		while comboregmac.active_iter[0] != combomac.active_iter[4]
#			contareg+=1
#			comboregmac.set_active(contareg)
#		end


##		comboregmac.active = -1
#	}

#	boxmodmac6.pack_start(annullacampi, false, false, 0)

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mmodmacelli.destroy
	}
	boxmodmac8.pack_start(bottchiudi, false, false, 0)

	mmodmacelli.show_all

end
=end
