#Modifica ragioni sociali

def modragsoc
	mmodragsoc = Gtk::Window.new("Modifica ragione sociale")
	mmodragsoc.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxmodragsocv = Gtk::VBox.new(false, 0)
	boxmodragsoc1 = Gtk::HBox.new(false, 5)
	boxmodragsoc2 = Gtk::HBox.new(false, 5)
	boxmodragsoc3 = Gtk::HBox.new(false, 5)
	boxmodragsoc4 = Gtk::HBox.new(false, 5)
	boxmodragsoc5 = Gtk::HBox.new(false, 5)
	boxmodragsocv.pack_start(boxmodragsoc1, false, false, 5)
	boxmodragsocv.pack_start(boxmodragsoc2, false, false, 5)
	boxmodragsocv.pack_start(boxmodragsoc3, false, false, 5)
	boxmodragsocv.pack_start(boxmodragsoc4, false, false, 5)
	boxmodragsocv.pack_start(boxmodragsoc5, false, false, 5)
	mmodragsoc.add(boxmodragsocv)

	#Combo di scelta ragione sociale

	labelragsoc = Gtk::Label.new("Selezona ragsocrietario:")
	boxmodragsoc1.pack_start(labelragsoc, false, false, 5)

	def caricaragsoc
		@listaragsoc = Gtk::ListStore.new(Integer, String, String, String, String)
		@listaragsoc.clear
		selragsoc = Ragsocs.find(:all, :order => "ragsoc")
		selragsoc.each do |p|
			iter1 = @listaragsoc.append
			iter1[0] = p.id
			iter1[1] = p.ragsoc
			iter1[2] = p.codfisc
			iter1[3] = p.piva
			iter1[4] = p.idf
		end
	end

	caricaragsoc
	@comboragsoc = Gtk::ComboBox.new(@listaragsoc)
	renderer1 = Gtk::CellRendererText.new
	@comboragsoc.pack_start(renderer1,false)
	@comboragsoc.set_attributes(renderer1, :text => 1)
	boxmodragsoc1.pack_start(@comboragsoc.popdown, false, false, 0)

	#Nome ragione sociale

	labelnomeragsoc = Gtk::Label.new("Nome ragione sociale:")
	boxmodragsoc2.pack_start(labelnomeragsoc, false, false, 5)
	@nomeragsoc = Gtk::Entry.new()
	@nomeragsoc.max_length=(50)
	boxmodragsoc2.pack_start(@nomeragsoc, false, false, 5)

	#Tipo di identificativo fiscale

	labeltipoif = Gtk::Label.new("Tipo di identificativo fiscale:")
	boxmodragsoc3.pack_start(labeltipoif, false, false, 5)
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
	boxmodragsoc3.pack_start(tipoif1, false, false, 5)
	tipoif2 = Gtk::RadioButton.new(tipoif1, "Partita IVA")
	tipoif2.signal_connect("toggled") {
		if tipoif2.active?
			tipoif="I"
			#puts tipoif
			@idfisc.max_length=(11)
		end
	}
	boxmodragsoc3.pack_start(tipoif2, false, false, 5)

	#Identificativo fiscale

	labelidfisc = Gtk::Label.new("Identificativo fiscale:")
	boxmodragsoc4.pack_start(labelidfisc, false, false, 5)
	@idfisc = Gtk::Entry.new()
#	@idfisc.max_length=(16)
	boxmodragsoc4.pack_start(@idfisc, false, false, 5)

	@comboragsoc.signal_connect( "changed" ) {
		@nomeragsoc.text=("#{@comboragsoc.active_iter[1]}")
		@idfisc.text=("#{@comboragsoc.active_iter[2]}")
#		tipoif1.active=("#{@comboragsoc.active_iter[4]}")
		tipoif = @comboragsoc.active_iter[4]
		if @comboragsoc.active_iter[4] == "F"
			tipoif1.active=(true)
			@idfisc.max_length=(16)
			@idfisc.text=("#{@comboragsoc.active_iter[2]}")
		else
			tipoif2.active=(true)
			@idfisc.max_length=(11)
			@idfisc.text=("#{@comboragsoc.active_iter[3]}")
		end
	}

	#Bottone di inserimento

	inserisciragsoc = Gtk::Button.new( "Modifica ragione sociale" )
	inserisciragsoc.signal_connect("clicked") {
		if @nomeragsoc.text==("") or @idfisc.text==("")
			Errore.avviso(mmodragsoc, "Servono tutti i dati.")
		else
			if tipoif == "F"
				Ragsocs.update(@comboragsoc.active_iter[0], { :ragsoc => "#{@nomeragsoc.text.upcase}", :codfisc => "#{@idfisc.text.upcase}", :idf => "#{tipoif}"})
				@nomeragsoc.text=("")
				@idfisc.text=("")
				caricaragsoc
				@comboragsoc.model=(@listaragsoc)
			else
				Ragsocs.update(@comboragsoc.active_iter[0], { :ragsoc => "#{@nomeragsoc.text.upcase}", :piva => "#{@idfisc.text.upcase}", :idf => "#{tipoif}"})
				@nomeragsoc.text=("")
				@idfisc.text=("")
				caricaragsoc
				@comboragsoc.model=(@listaragsoc)
			end
		end
	}
	boxmodragsoc5.pack_start(inserisciragsoc, false, false, 0)

	#Bottone di chiusura finestra

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mmodragsoc.destroy
	}
	boxmodragsoc5.pack_start(bottchiudi, false, false, 0)

	mmodragsoc.show_all
end

