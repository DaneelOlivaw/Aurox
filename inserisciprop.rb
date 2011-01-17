#Creazione dei proprietari

def creaprop(finestra)
	mcreaprop = Gtk::Window.new("Inserimento proprietario")
	mcreaprop.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxcreapropv = Gtk::VBox.new(false, 0)
	boxcreaprop1 = Gtk::HBox.new(false, 5)
	boxcreaprop2 = Gtk::HBox.new(false, 5)
	boxcreaprop3 = Gtk::HBox.new(false, 5)
	boxcreaprop4 = Gtk::HBox.new(false, 5)
	boxcreapropv.pack_start(boxcreaprop1, false, false, 5)
	boxcreapropv.pack_start(boxcreaprop2, false, false, 5)
	boxcreapropv.pack_start(boxcreaprop3, false, false, 5)
	boxcreapropv.pack_start(boxcreaprop4, false, false, 5)
	mcreaprop.add(boxcreapropv)
	labelprop = Gtk::Label.new("Proprietario:")
	boxcreaprop1.pack_start(labelprop, false, false, 5)
	codprop = Gtk::Entry.new()
	codprop.max_length=(50)
	boxcreaprop1.pack_start(codprop, false, false, 5)
	labeltipoifallev = Gtk::Label.new("Tipo di identificativo fiscale:")
	boxcreaprop2.pack_start(labeltipoifallev, false, false, 5)
	tipoifallev1 = Gtk::RadioButton.new("Codice fiscale")
	idfisc = Gtk::Entry.new()
	tipoifallev1.active=(true)
	tipoifallev="F"
	idfisc.max_length=(16)
	tipoifallev1.signal_connect("toggled") {
		if tipoifallev1.active?
			tipoifallev="F"
			idfisc.max_length=(16)
		end
	}
	boxcreaprop2.pack_start(tipoifallev1, false, false, 5)
	tipoifallev2 = Gtk::RadioButton.new(tipoifallev1, "Partita IVA")
	tipoifallev2.signal_connect("toggled") {
		if tipoifallev2.active?
			tipoifallev="I"
			idfisc.max_length=(11)
		end
	}
	boxcreaprop2.pack_start(tipoifallev2, false, false, 5)
	labelidfisc = Gtk::Label.new("Codice fiscale / Partita IVA:")
	boxcreaprop3.pack_start(labelidfisc, false, false, 5)
	boxcreaprop3.pack_start(idfisc, false, false, 5)
	bottcreaprop = Gtk::Button.new( "Inserisci il proprietario" )
	boxcreaprop4.pack_start(bottcreaprop, false, false, 5)
	bottcreaprop.signal_connect("clicked") {
		if codprop.text == "" or idfisc.text == ""
			Errore.avviso(mcreaprop, "Mancano dei dati.")
		else
			if tipoifallev == "F"
				controllo = Props.find(:first, :conditions => "prop = '#{codprop.text.upcase}' and codfisc = '#{idfisc.text.upcase}' and idf = '#{tipoifallev}'")
				if controllo == nil
					Props.create(:prop => "#{codprop.text.upcase}", :codfisc => "#{idfisc.text.upcase}", :idf => "#{tipoifallev}")
					Conferma.conferma(mcreaprop, "Dati inseriti correttamente")
					mcreaprop.destroy
				else
					Errore.avviso(mcreaprop, "Il proprietario è già presente.")
				end
			else
				controllo = Props.find(:first, :conditions => "prop = '#{codprop.text.upcase}' and piva = '#{idfisc.text.upcase}' and idf = '#{tipoifallev}'")
				if controllo == nil
					Props.create(:prop => "#{codprop.text.upcase}", :piva => "#{idfisc.text.upcase}", :idf => "#{tipoifallev}")
					Conferma.conferma(mcreaprop, "Dati inseriti correttamente")
					mcreaprop.destroy
				else
					Errore.avviso(mcreaprop, "Il proprietario è già presente.")
				end
			end
		end
	}
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mcreaprop.destroy
	}
	boxcreaprop4.pack_start(bottchiudi, false, false, 0)
	mcreaprop.show_all
end
