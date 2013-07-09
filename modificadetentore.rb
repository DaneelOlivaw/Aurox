#Modifica detentori

def modificadetentore
	mmoddetentori = Gtk::Window.new("Modifica detentore")
	mmoddetentori.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxmoddetentoriv = Gtk::VBox.new(false, 0)
	boxmoddetentori1 = Gtk::HBox.new(false, 5)
	boxmoddetentori2 = Gtk::HBox.new(false, 5)
	boxmoddetentori3 = Gtk::HBox.new(false, 5)
	boxmoddetentori4 = Gtk::HBox.new(false, 5)
	boxmoddetentori5 = Gtk::HBox.new(false, 5)
	boxmoddetentoriv.pack_start(boxmoddetentori1, false, false, 5)
	boxmoddetentoriv.pack_start(boxmoddetentori2, false, false, 5)
	boxmoddetentoriv.pack_start(boxmoddetentori3, false, false, 5)
	boxmoddetentoriv.pack_start(boxmoddetentori4, false, false, 5)
	boxmoddetentoriv.pack_start(boxmoddetentori5, false, false, 5)
	mmoddetentori.add(boxmoddetentoriv)

	#Combo di scelta detentore

	labeldetentore = Gtk::Label.new("Selezona detentore:")
	boxmoddetentori1.pack_start(labeldetentore, false, false, 5)

	def caricadet
		@listadet = Gtk::ListStore.new(Integer, String, String, String, String)
		@listadet.clear
		seldet = Detentoris.find(:all, :order => "detentore")
		seldet.each do |p|
			iter1 = @listadet.append
			iter1[0] = p.id
			iter1[1] = p.detentore
			iter1[2] = p.codfisc
			iter1[3] = p.piva
			iter1[4] = p.idf
		end
	end

	caricadet
	@combodet = Gtk::ComboBox.new(@listadet)
	renderer1 = Gtk::CellRendererText.new
	@combodet.pack_start(renderer1,false)
	@combodet.set_attributes(renderer1, :text => 1)
	boxmoddetentori1.pack_start(@combodet.popdown, false, false, 0)

	#Nome detentore

	labelnomedet = Gtk::Label.new("Nome detentore:")
	boxmoddetentori2.pack_start(labelnomedet, false, false, 5)
	@nomedet = Gtk::Entry.new()
	@nomedet.max_length=(50)
	boxmoddetentori2.pack_start(@nomedet, false, false, 5)

	#Tipo di identificativo fiscale

	labeltipoif = Gtk::Label.new("Tipo di identificativo fiscale:")
	boxmoddetentori3.pack_start(labeltipoif, false, false, 5)
	tipoif1 = Gtk::RadioButton.new("Codice fiscale")
	idfisc = Gtk::Entry.new()
	@idfisc = Gtk::Entry.new()
	tipoif1.active=(true)
	tipoif="F"
	@idfisc.max_length=(16)
	tipoif1.signal_connect("toggled") {
		if tipoif1.active?
			tipoif="F"
			#puts tipoif
			@idfisc.max_length=(16)
		end
	}
	boxmoddetentori3.pack_start(tipoif1, false, false, 5)
	tipoif2 = Gtk::RadioButton.new(tipoif1, "Partita IVA")
	tipoif2.signal_connect("toggled") {
		if tipoif2.active?
			tipoif="I"
			#puts tipoif
			@idfisc.max_length=(11)
		end
	}
	boxmoddetentori3.pack_start(tipoif2, false, false, 5)

	#Identificativo fiscale

	labelidfisc = Gtk::Label.new("Identificativo fiscale:")
	boxmoddetentori4.pack_start(labelidfisc, false, false, 5)
	@idfisc = Gtk::Entry.new()
#	@idfisc.max_length=(16)
	boxmoddetentori4.pack_start(@idfisc, false, false, 5)

	@combodet.signal_connect( "changed" ) {
		@nomedet.text=("#{@combodet.active_iter[1]}")
		@idfisc.text=("#{@combodet.active_iter[2]}")
#		tipoif1.active=("#{@combodet.active_iter[4]}")
		tipoif = @combodet.active_iter[4]
		if @combodet.active_iter[4] == "F"
			tipoif1.active=(true)
			@idfisc.max_length=(16)
			@idfisc.text=("#{@combodet.active_iter[2]}")
		else
			tipoif2.active=(true)
			@idfisc.max_length=(11)
			@idfisc.text=("#{@combodet.active_iter[3]}")
		end
	}

	#Bottone di inserimento

	inserisciprop = Gtk::Button.new( "Modifica detentore" )
	inserisciprop.signal_connect("clicked") {
		if @nomedet.text==("") or @idfisc.text==("")
			Errore.avviso(mmoddetentori, "Servono tutti i dati.")
		else
			if tipoif == "F"
				Detentoris.update(@combodet.active_iter[0], { :detentore => "#{@nomedet.text.upcase}", :codfisc => "#{@idfisc.text.upcase}", :idf => "#{tipoif}"})
				@nomedet.text=("")
				@idfisc.text=("")
				caricadet
				@combodet.model=(@listadet)
			else
				Detentoris.update(@combodet.active_iter[0], { :detentore => "#{@nomedet.text.upcase}", :piva => "#{@idfisc.text.upcase}", :idf => "#{tipoif}"})
				@nomedet.text=("")
				@idfisc.text=("")
				caricadet
				@combodet.model=(@listadet)
			end
		end
	}
	boxmoddetentori5.pack_start(inserisciprop, false, false, 0)

	#Bottone di chiusura finestra

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mmoddetentori.destroy
	}
	boxmoddetentori5.pack_start(bottchiudi, false, false, 0)

	mmoddetentori.show_all
end
