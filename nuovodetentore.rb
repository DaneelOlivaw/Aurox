#Creazione dei detentori

def nuovodetentore(finestra)
	mcreadet = Gtk::Window.new("Inserimento detentore")
	mcreadet.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxcreadetv = Gtk::VBox.new(false, 0)
	boxcreadet1 = Gtk::HBox.new(false, 5)
	boxcreadet2 = Gtk::HBox.new(false, 5)
	boxcreadet3 = Gtk::HBox.new(false, 5)
	boxcreadet4 = Gtk::HBox.new(false, 5)
	boxcreadetv.pack_start(boxcreadet1, false, false, 5)
	boxcreadetv.pack_start(boxcreadet2, false, false, 5)
	boxcreadetv.pack_start(boxcreadet3, false, false, 5)
	boxcreadetv.pack_start(boxcreadet4, false, false, 5)
	mcreadet.add(boxcreadetv)
	labeldet = Gtk::Label.new("Detentore:")
	boxcreadet1.pack_start(labeldet, false, false, 5)
	coddet = Gtk::Entry.new()
	coddet.max_length=(50)
	boxcreadet1.pack_start(coddet, false, false, 5)
	labeltipoifdet = Gtk::Label.new("Tipo di identificativo fiscale:")
	boxcreadet2.pack_start(labeltipoifdet, false, false, 5)
	tipoifdet1 = Gtk::RadioButton.new("Codice fiscale")
	idfisc = Gtk::Entry.new()
	tipoifdet1.active=(true)
	tipoifdet="F"
	idfisc.max_length=(16)
	tipoifdet1.signal_connect("toggled") {
		if tipoifdet1.active?
			tipoifdet="F"
			idfisc.max_length=(16)
		end
	}
	boxcreadet2.pack_start(tipoifdet1, false, false, 5)
	tipoifdet2 = Gtk::RadioButton.new(tipoifdet1, "Partita IVA")
	tipoifdet2.signal_connect("toggled") {
		if tipoifdet2.active?
			tipoifdet="I"
			idfisc.max_length=(11)
		end
	}
	boxcreadet2.pack_start(tipoifdet2, false, false, 5)
	labelidfisc = Gtk::Label.new("Codice fiscale / Partita IVA:")
	boxcreadet3.pack_start(labelidfisc, false, false, 5)
	boxcreadet3.pack_start(idfisc, false, false, 5)
	bottcreadet = Gtk::Button.new( "Inserisci il detentore" )
	boxcreadet4.pack_start(bottcreadet, false, false, 5)
	bottcreadet.signal_connect("clicked") {
		if coddet.text == "" or idfisc.text == ""
			Errore.avviso(mcreadet, "Mancano dei dati.")
		else
			if tipoifdet == "F"
				controllo = Detentoris.find(:first, :conditions => ["detentore = ? and codfisc = ? and idf = ?", coddet.text.upcase, idfisc.text.upcase, tipoifdet])
				if controllo == nil
					Detentoris.create(:detentore => "#{coddet.text.upcase}", :codfisc => "#{idfisc.text.upcase}", :idf => "#{tipoifdet}")
					Conferma.conferma(mcreadet, "Dati inseriti correttamente")
					mcreadet.destroy
				else
					Errore.avviso(mcreadet, "Il detentore è già presente.")
				end
			else
				controllo = Detentoris.find(:first, :conditions => ["detentore = ? and piva = ? and idf = ?", coddet.text.upcase, idfisc.text.upcase, tipoifdet])
				if controllo == nil
					Detentoris.create(:detentore => "#{coddet.text.upcase}", :piva => "#{idfisc.text.upcase}", :idf => "#{tipoifdet}")
					Conferma.conferma(mcreadet, "Dati inseriti correttamente")
					mcreadet.destroy
				else
					Errore.avviso(mcreadet, "Il detentore è già presente.")
				end
			end
		end
	}
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mcreadet.destroy
	}
	boxcreadet4.pack_start(bottchiudi, false, false, 0)
	mcreadet.show_all
end
