#Maschera inserimento allevamenti nuovi

def mascallevam(listall)
	mallevam = Gtk::Window.new("Nuovo allevamento")
	mallevam.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxmallv = Gtk::VBox.new(false, 0)
	boxmall2 = Gtk::HBox.new(false, 5)
	boxmall3 = Gtk::HBox.new(false, 5)
	boxmall4 = Gtk::HBox.new(false, 5)
	boxmall5 = Gtk::HBox.new(false, 5)
	boxmall6 = Gtk::HBox.new(false, 5)
	boxmall7 = Gtk::HBox.new(false, 5)
	boxmall8 = Gtk::HBox.new(false, 5)
	boxmallv.pack_start(boxmall2, false, false, 5)
	boxmallv.pack_start(boxmall3, false, false, 5)
	boxmallv.pack_start(boxmall4, false, false, 5)
	boxmallv.pack_start(boxmall5, false, false, 5)
	boxmallv.pack_start(boxmall6, false, false, 5)
	boxmallv.pack_start(boxmall7, false, false, 5)
	boxmallv.pack_start(boxmall8, false, false, 5)
	mallevam.add(boxmallv)

	#Nome allevamento

	labelnomeallev = Gtk::Label.new("Nome:")
	boxmall2.pack_start(labelnomeallev, false, false, 5)
	nomeallev = Gtk::Entry.new
	nomeallev.max_length=(50)
	nomeallev.width_chars=(50)
	boxmall2.pack_start(nomeallev, false, false, 5)

	#Identificativo fiscale

	labelidfisc = Gtk::Label.new("Identificativo fiscale:")
	boxmall3.pack_start(labelidfisc, false, false, 5)
	idfisc = Gtk::Entry.new()
	idfisc.max_length=(16)
	idfisc.width_chars=(16)
	boxmall3.pack_start(idfisc, false, false, 5)

	#Codice 317 stalla

	labelcod317 = Gtk::Label.new("Codice 317 stalla:")
	boxmall4.pack_start(labelcod317, false, false, 5)
	cod317 = Gtk::Entry.new()
	cod317.max_length=(8)
	cod317.width_chars=(8)
	boxmall4.pack_start(cod317, false, false, 5)

	#Via allevamento

	labelviaall = Gtk::Label.new("Indirizzo:")
	boxmall5.pack_start(labelviaall, false, false, 5)
	viaall = Gtk::Entry.new
	viaall.max_length=(50)
	viaall.width_chars=(50)
	boxmall5.pack_start(viaall, false, false, 5)

	#Comune allevamento

	labelcomuneall = Gtk::Label.new("Comune:")
	boxmall6.pack_start(labelcomuneall, false, false, 5)
	comuneall = Gtk::Entry.new
	comuneall.max_length=(50)
	comuneall.width_chars=(50)
	boxmall6.pack_start(comuneall, false, false, 5)

	#Provincia allevamento

	labelprovall = Gtk::Label.new("Provincia (sigla):")
	boxmall7.pack_start(labelprovall, false, false, 5)
	provall = Gtk::Entry.new
	provall.max_length=(2)
	provall.width_chars=(4)
	boxmall7.pack_start(provall, false, false, 5)




	#Bottone di inserimento

	inserisciall = Gtk::Button.new( "Inserisci allevamento" )
	inserisciall.signal_connect("clicked") {
		#nome=("#{nomeallev.text}")
		if nomeallev.text==("") or idfisc.text==("") or cod317.text==("")

			Errore.avviso(mallevam, "Servono tutti i dati.")
		else
			Allevamentis.create(:ragsoc => "#{nomeallev.text.upcase}", :idfisc => "#{idfisc.text.upcase}", :cod317 => "#{cod317.text.upcase}", :via => "#{viaall.text.upcase}", :comune => "#{comuneall.text.upcase}", :provincia => "#{provall.text.upcase}")
			nomeallev.text= ""
			idfisc.text= ""
			cod317.text= ""
			viaall.text = ""
			comuneall.text = ""
			provall.text = ""
			if listall != nil
				listall.clear
				selall = Allevamentis.find(:all)
				selall.each do |all|
				iterall = listall.append
					iterall[0] = all.id
					iterall[1] = all.ragsoc
					iterall[2] = all.idfisc
					iterall[3] = all.cod317
				end
				mallevam.destroy
			end
		end
	}
	boxmall8.pack_start(inserisciall, false, false, 0)

	#Bottone di chiusura finestra

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mallevam.destroy
	}
	boxmall8.pack_start(bottchiudi, false, false, 0)

	mallevam.show_all

end

#Modifica allevamenti

def modallevamenti(idallev)
	mmodallevam = Gtk::Window.new("Modifica allevamento")
	mmodallevam.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxmodallevamv = Gtk::VBox.new(false, 0)
	boxmodallev1 = Gtk::HBox.new(false, 5)
	boxmodallev2 = Gtk::HBox.new(false, 5)
	boxmodallev3 = Gtk::HBox.new(false, 5)
	boxmodallev4 = Gtk::HBox.new(false, 5)
	boxmodallev5 = Gtk::HBox.new(false, 5)
	boxmodallev6 = Gtk::HBox.new(false, 5)
	boxmodallev7 = Gtk::HBox.new(false, 5)
	boxmodallev8 = Gtk::HBox.new(false, 5)
	boxmodallevamv.pack_start(boxmodallev1, false, false, 5)
	boxmodallevamv.pack_start(boxmodallev2, false, false, 5)
	boxmodallevamv.pack_start(boxmodallev3, false, false, 5)
	boxmodallevamv.pack_start(boxmodallev4, false, false, 5)
	boxmodallevamv.pack_start(boxmodallev5, false, false, 5)
	boxmodallevamv.pack_start(boxmodallev6, false, false, 5)
	boxmodallevamv.pack_start(boxmodallev7, false, false, 5)
	boxmodallevamv.pack_start(boxmodallev8, false, false, 5)
	mmodallevam.add(boxmodallevamv)

	#Combo di scelta allevamento

	labelallevamento = Gtk::Label.new("Selezona allevamento:")
	boxmodallev1.pack_start(labelallevamento, false, false, 5)

	def caricalista(listallev)
		listallev.clear
		selallev = Allevamentis.find(:all, :order => "ragsoc")
		selallev.each do |a|
			iter1 = listallev.append
			iter1[0] = a.id.to_i
			iter1[1] = a.ragsoc
			iter1[2] = a.idfisc
			iter1[3] = a.cod317
			iter1[4] = a.via
			iter1[5] = a.comune
			iter1[6] = a.provincia
		end
	end

	listallev = Gtk::ListStore.new(Integer, String, String, String, String, String, String)
	caricalista(listallev)
	comboallev = Gtk::ComboBox.new(listallev)
	renderer1 = Gtk::CellRendererText.new
	comboallev.pack_start(renderer1,false)
	comboallev.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	comboallev.pack_start(renderer1,false)
	comboallev.set_attributes(renderer1, :text => 3)
	boxmodallev1.pack_start(comboallev.popdown, false, false, 0)

	#Nome allevamento

	labelnomeallev = Gtk::Label.new("Nome:")
	boxmodallev2.pack_start(labelnomeallev, false, false, 5)
	nomeallev = Gtk::Entry.new
	nomeallev.max_length=(50)
	nomeallev.width_chars=(50)
	boxmodallev2.pack_start(nomeallev, false, false, 5)

	#Identificativo fiscale

	labelidfisc = Gtk::Label.new("Identificativo fiscale:")
	boxmodallev3.pack_start(labelidfisc, false, false, 5)
	idfisc = Gtk::Entry.new
	idfisc.max_length=(16)
	boxmodallev3.pack_start(idfisc, false, false, 5)

	#Codice 317 stalla

	labelcod317 = Gtk::Label.new("Codice 317 stalla:")
	boxmodallev4.pack_start(labelcod317, false, false, 5)
	cod317 = Gtk::Entry.new
	cod317.max_length=(8)
	boxmodallev4.pack_start(cod317, false, false, 5)

	#Via allevamento

	labelviaall = Gtk::Label.new("Indirizzo:")
	boxmodallev5.pack_start(labelviaall, false, false, 5)
	viaall = Gtk::Entry.new
	viaall.max_length=(50)
	viaall.width_chars=(50)
	boxmodallev5.pack_start(viaall, false, false, 5)

	#Comune allevamento

	labelcomuneall = Gtk::Label.new("Comune:")
	boxmodallev6.pack_start(labelcomuneall, false, false, 5)
	comuneall = Gtk::Entry.new
	comuneall.max_length=(50)
	comuneall.width_chars=(50)
	boxmodallev6.pack_start(comuneall, false, false, 5)

	#Provincia allevamento

	labelprovall = Gtk::Label.new("Provincia (sigla):")
	boxmodallev7.pack_start(labelprovall, false, false, 5)
	provall = Gtk::Entry.new
	provall.max_length=(2)
	provall.width_chars=(4)
	boxmodallev7.pack_start(provall, false, false, 5)

	unless idallev == nil
		comboallev.set_active(0)
		z = -1
		while comboallev.active_iter[0] != idallev
			z+=1
			comboallev.set_active(z)
		end
		nomeallev.text=("#{comboallev.active_iter[1]}")
		idfisc.text=("#{comboallev.active_iter[2]}")
		cod317.text=("#{comboallev.active_iter[3]}")
		viaall.text = "#{comboallev.active_iter[4]}"
		comuneall.text = "#{comboallev.active_iter[5]}"
		provall.text = "#{comboallev.active_iter[6]}"
	end

	comboallev.signal_connect( "changed" ) {
		if comboallev.active != -1
			nomeallev.text=("#{comboallev.active_iter[1]}")
			idfisc.text=("#{comboallev.active_iter[2]}")
			cod317.text=("#{comboallev.active_iter[3]}")
			viaall.text = "#{comboallev.active_iter[4]}"
			comuneall.text = "#{comboallev.active_iter[5]}"
			provall.text = "#{comboallev.active_iter[6]}"
		end
	}

	#Bottone di inserimento

	inserisciall = Gtk::Button.new( "Modifica allevamento" )
	inserisciall.signal_connect("clicked") {
		if nomeallev.text==("") or idfisc.text==("") or cod317.text==("")
			Errore.avviso(mmodallevam, "Servono tutti i dati.")
		else
			Allevamentis.update(comboallev.active_iter[0], { :ragsoc => "#{nomeallev.text.upcase}", :idfisc => "#{idfisc.text.upcase}", :cod317 => "#{cod317.text.upcase}", :via => "#{viaall.text.upcase}", :comune => "#{comuneall.text.upcase}", :provincia => "#{provall.text.upcase}"})
			nomeallev.text= ""
			idfisc.text= ""
			cod317.text= ""
			viaall.text = ""
			comuneall.text = ""
			provall.text = ""
			caricalista(listallev)
			comboallev.model=(listallev)
		end
	}
	boxmodallev8.pack_start(inserisciall, false, false, 0)

#	#Bottone di annullamento modifiche

#	annullacampi = Gtk::Button.new( "Annulla modifiche" )
#	annullacampi.signal_connect("clicked") {
#		@nomeallev.text=("#{@comboallev.active_iter[1]}")
#		@idfisc.text=("#{@comboallev.active_iter[2]}")
#		@cod317.text=("#{@comboallev.active_iter[3]}")
#	}
#	boxmodallev5.pack_start(annullacampi, false, false, 0)

	#Bottone di chiusura finestra

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mmodallevam.destroy
	}
	boxmodallev8.pack_start(bottchiudi, false, false, 0)

	mmodallevam.show_all
end
