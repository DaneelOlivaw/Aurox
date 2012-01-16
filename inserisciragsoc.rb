# Creazione delle ragioni sociali

def crearagsoc(finestra)
	mcrearagsoc = Gtk::Window.new("Inserimento ragione sociale")
	mcrearagsoc.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxcrearagsocv = Gtk::VBox.new(false, 0)
	boxcrearagsoc1 = Gtk::HBox.new(false, 5)
	boxcrearagsoc2 = Gtk::HBox.new(false, 5)
	boxcrearagsoc3 = Gtk::HBox.new(false, 5)
	boxcrearagsoc4 = Gtk::HBox.new(false, 5)
	boxcrearagsocv.pack_start(boxcrearagsoc1, false, false, 5)
	boxcrearagsocv.pack_start(boxcrearagsoc2, false, false, 5)
	boxcrearagsocv.pack_start(boxcrearagsoc3, false, false, 5)
	boxcrearagsocv.pack_start(boxcrearagsoc4, false, false, 5)
	mcrearagsoc.add(boxcrearagsocv)
	labelragsoc = Gtk::Label.new("Ragione sociale:")
	boxcrearagsoc1.pack_start(labelragsoc, false, false, 5)
	codragsoc = Gtk::Entry.new()
	codragsoc.max_length=(50)
	boxcrearagsoc1.pack_start(codragsoc, false, false, 5)
	labeltipoidfisc = Gtk::Label.new("Tipo di identificativo fiscale:")
	boxcrearagsoc2.pack_start(labeltipoidfisc, false, false, 5)
	tipoidfisc1 = Gtk::RadioButton.new("Codice fiscale")
	idfisc = Gtk::Entry.new()
	tipoidfisc1.active=(true)
	tipoidfisc="F"
	idfisc.max_length=(16)
	tipoidfisc1.signal_connect("toggled") {
		if tipoidfisc1.active?
			tipoidfisc="F"
		idfisc.max_length=(16)
		end
	}
	boxcrearagsoc2.pack_start(tipoidfisc1, false, false, 5)
	tipoidfisc2 = Gtk::RadioButton.new(tipoidfisc1, "Partita IVA")
	tipoidfisc2.signal_connect("toggled") {
		if tipoidfisc2.active?
			tipoidfisc="I"
			idfisc.max_length=(11)
		end
	}
	boxcrearagsoc2.pack_start(tipoidfisc2, false, false, 5)
	labelidfisc = Gtk::Label.new("Codice fiscale / Partita IVA:")
	boxcrearagsoc3.pack_start(labelidfisc, false, false, 5)
	boxcrearagsoc3.pack_start(idfisc, false, false, 5)
	bottcrearagsoc = Gtk::Button.new( "Inserisci la ragione sociale" )
	boxcrearagsoc4.pack_start(bottcrearagsoc, false, false, 5)
	bottcrearagsoc.signal_connect("clicked") {
		if codragsoc.text == "" or idfisc.text == ""
			Errore.avviso(mcrearagsoc, "Mancano dei dati.")
		else
			if tipoidfisc == "F"
				controllo = Ragsocs.find(:first, :conditions => ["ragsoc = ? and codfisc = ? and idf = ?", codragsoc.text.upcase, idfisc.text.upcase, tipoidfisc])
				if controllo == nil
					Ragsocs.create(:ragsoc => "#{codragsoc.text.upcase}", :codfisc => "#{idfisc.text.upcase}", :idf => "#{tipoidfisc}")
					Conferma.conferma(mcrearagsoc, "Dati inseriti correttamente")
					mcrearagsoc.destroy
				else
					Errore.avviso(mcrearagsoc, "La ragione sociale è già presente.")
				end
			else
				controllo = Ragsocs.find(:first, :conditions => ["ragsoc = ? and piva = ? and idf = ?", codragsoc.text.upcase, idfisc.text.upcase, tipoidfisc])
				if controllo == nil
					Ragsocs.create(:ragsoc => "#{codragsoc.text.upcase}", :piva => "#{idfisc.text.upcase}", :idf => "#{tipoidfisc}")
					Conferma.conferma(mcrearagsoc, "Dati inseriti correttamente")
					mcrearagsoc.destroy
				else
					Errore.avviso(mcrearagsoc, "La ragione sociale è già presente.")
				end
			end
		end
	}
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mcrearagsoc.destroy
	}
	boxcrearagsoc4.pack_start(bottchiudi, false, false, 0)
	mcrearagsoc.show_all
end
