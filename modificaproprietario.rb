#Modifica proprietari

def modificaproprietario
	mmodprop = Gtk::Window.new("Modifica proprietario")
	mmodprop.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxmodpropv = Gtk::VBox.new(false, 0)
	boxmodprop1 = Gtk::HBox.new(false, 5)
	boxmodprop2 = Gtk::HBox.new(false, 5)
	boxmodprop3 = Gtk::HBox.new(false, 5)
	boxmodprop4 = Gtk::HBox.new(false, 5)
	boxmodprop5 = Gtk::HBox.new(false, 5)
	boxmodpropv.pack_start(boxmodprop1, false, false, 5)
	boxmodpropv.pack_start(boxmodprop2, false, false, 5)
	boxmodpropv.pack_start(boxmodprop3, false, false, 5)
	boxmodpropv.pack_start(boxmodprop4, false, false, 5)
	boxmodpropv.pack_start(boxmodprop5, false, false, 5)
	mmodprop.add(boxmodpropv)

	#Combo di scelta proprietario

	labelproprietario = Gtk::Label.new("Selezona proprietario:")
	boxmodprop1.pack_start(labelproprietario, false, false, 5)

	def caricaprop
		@listaprop = Gtk::ListStore.new(Integer, String, String, String, String)
		@listaprop.clear
		selprop = Props.find(:all, :order => "prop")
		selprop.each do |p|
			iter1 = @listaprop.append
			iter1[0] = p.id
			iter1[1] = p.prop
			iter1[2] = p.codfisc
			iter1[3] = p.piva
			iter1[4] = p.idf
		end
	end

	caricaprop
	@comboprop = Gtk::ComboBox.new(@listaprop)
	renderer1 = Gtk::CellRendererText.new
	@comboprop.pack_start(renderer1,false)
	@comboprop.set_attributes(renderer1, :text => 1)
	boxmodprop1.pack_start(@comboprop.popdown, false, false, 0)

	#Nome proprietario

	labelnomeprop = Gtk::Label.new("Nome proprietario:")
	boxmodprop2.pack_start(labelnomeprop, false, false, 5)
	@nomeprop = Gtk::Entry.new()
	@nomeprop.max_length=(50)
	boxmodprop2.pack_start(@nomeprop, false, false, 5)

	#Tipo di identificativo fiscale

	labeltipoif = Gtk::Label.new("Tipo di identificativo fiscale:")
	boxmodprop3.pack_start(labeltipoif, false, false, 5)
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
	boxmodprop3.pack_start(tipoif1, false, false, 5)
	tipoif2 = Gtk::RadioButton.new(tipoif1, "Partita IVA")
	tipoif2.signal_connect("toggled") {
		if tipoif2.active?
			tipoif="I"
			#puts tipoif
			@idfisc.max_length=(11)
		end
	}
	boxmodprop3.pack_start(tipoif2, false, false, 5)

	#Identificativo fiscale

	labelidfisc = Gtk::Label.new("Identificativo fiscale:")
	boxmodprop4.pack_start(labelidfisc, false, false, 5)
	@idfisc = Gtk::Entry.new()
#	@idfisc.max_length=(16)
	boxmodprop4.pack_start(@idfisc, false, false, 5)

	@comboprop.signal_connect( "changed" ) {
		@nomeprop.text=("#{@comboprop.active_iter[1]}")
		@idfisc.text=("#{@comboprop.active_iter[2]}")
#		tipoif1.active=("#{@comboprop.active_iter[4]}")
		tipoif = @comboprop.active_iter[4]
		if @comboprop.active_iter[4] == "F"
			tipoif1.active=(true)
			@idfisc.max_length=(16)
			@idfisc.text=("#{@comboprop.active_iter[2]}")
		else
			tipoif2.active=(true)
			@idfisc.max_length=(11)
			@idfisc.text=("#{@comboprop.active_iter[3]}")
		end
	}

	#Bottone di inserimento

	inserisciprop = Gtk::Button.new( "Modifica proprietario" )
	inserisciprop.signal_connect("clicked") {
		if @nomeprop.text==("") or @idfisc.text==("")
			Errore.avviso(mmodprop, "Servono tutti i dati.")
		else
			if tipoif == "F"
				Props.update(@comboprop.active_iter[0], { :prop => "#{@nomeprop.text.upcase}", :codfisc => "#{@idfisc.text.upcase}", :idf => "#{tipoif}"})
				@nomeprop.text=("")
				@idfisc.text=("")
				caricaprop
				@comboprop.model=(@listaprop)
			else
				Props.update(@comboprop.active_iter[0], { :prop => "#{@nomeprop.text.upcase}", :piva => "#{@idfisc.text.upcase}", :idf => "#{tipoif}"})
				@nomeprop.text=("")
				@idfisc.text=("")
				caricaprop
				@comboprop.model=(@listaprop)
			end
		end
	}
	boxmodprop5.pack_start(inserisciprop, false, false, 0)

	#Bottone di chiusura finestra

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mmodprop.destroy
	}
	boxmodprop5.pack_start(bottchiudi, false, false, 0)

	mmodprop.show_all
end
