def reinviocapi
	mreinvio = Gtk::Window.new("Selezione dei movimenti da reinviare")
	mreinvio.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
#	mreinvio.resizable=(false)
	mreinvio.set_default_size(400, 650)
	boxreinviov = Gtk::VBox.new(false, 0)
	boxreinvio1 = Gtk::HBox.new(false, 5)
	boxreinvio2 = Gtk::HBox.new(false, 5)
	boxreinvio3 = Gtk::HBox.new(false, 5)
	boxreinvio4 = Gtk::HBox.new(false, 5)
	boxreinvio5 = Gtk::HBox.new(false, 5)
	boxreinvio6 = Gtk::HBox.new(false, 5)
	boxreinvio7 = Gtk::HBox.new(false, 5)
	boxreinviov.pack_start(boxreinvio1, false, false, 5)
	boxreinviov.pack_start(boxreinvio2, false, false, 5)
	boxreinviov.pack_start(boxreinvio3, false, false, 5)
	boxreinviov.pack_start(boxreinvio4, false, false, 5)
	boxreinviov.pack_start(boxreinvio5, false, false, 5)
	boxreinviov.pack_start(boxreinvio6, false, false, 5)
	boxreinviov.pack_start(boxreinvio7, true, true, 5)
	mreinvio.add(boxreinviov)
	labelmarca = Gtk::Label.new("Cerca capo:")
	boxreinvio1.pack_start(labelmarca, false, false, 5)
	marca = Gtk::Entry.new()
	boxreinvio1.pack_start(marca, false, false, 5)
	labelmovimento = Gtk::Label.new("Tipo di movimento:")
	boxreinvio2.pack_start(labelmovimento, false, false, 5)
	movingr = Gtk::RadioButton.new("Ingresso")
	movingr.active=(true)
	tipomov = "I"
	movingr.signal_connect("toggled") {
		if movingr.active?
			tipomov="I"
		end
	}
	boxreinvio2.pack_start(movingr, false, false, 5)
	movusc = Gtk::RadioButton.new(movingr, "Uscita")
	movusc.signal_connect("toggled") {
		if movusc.active?
			tipomov="U"
		end
	}
	boxreinvio2.pack_start(movusc, false, false, 5)
	labeldata = Gtk::Label.new("Data del movimento:")
	boxreinvio3.pack_start(labeldata, false, false, 5)
	data = Gtk::Calendar.new()
	boxreinvio4.pack_start(data, true , false, 0)
	cerca = Gtk::Button.new( "Cerca capo" )
	boxreinvio5.pack_start(cerca, true , false, 0)
	seltutti = Gtk::Button.new( "Seleziona tutti" )
	boxreinvio5.pack_start(seltutti, true , false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mreinvio.destroy
	}
	boxreinvio5.pack_start(bottchiudi, true, false, 0)
	salva = Gtk::Button.new( "Imposta come non inviati" )
	boxreinvio6.pack_start(salva, true , false, 0)
	listareinvio = Gtk::ListStore.new(Integer, String)
	cerca.signal_connect("clicked") {
		listareinvio.clear
		giorno = "#{data.year}" + "-" + "#{data.month+1}" + "-" + "#{data.day}"
		if tipomov == "I"
			capimod = Animals.find(:all, :conditions => ["relaz_id= ? and file = ? and tipo = ? and data_ingr = ? and marca LIKE ?", "#{@stallaoper.id}", "1", "#{tipomov}", "#{giorno}", "%#{marca.text}%"])
		elsif tipomov == "U"
			capimod = Animals.find(:all, :conditions => ["relaz_id= ? and file = ? and tipo = ? and uscita = ? and marca LIKE ?", "#{@stallaoper.id}", "1", "#{tipomov}", "#{giorno}", "%#{marca.text}%"])
		end
		capimod.each do |r|
			iter = listareinvio.append
			iter[0] = r.id
			iter[1] = r.marca
		end
	}
	mreinvioscroll = Gtk::ScrolledWindow.new
	vistareinvio = Gtk::TreeView.new(listareinvio)
	vistareinvio.selection.mode = Gtk::SELECTION_MULTIPLE
	cella = Gtk::CellRendererText.new
	colonna0 = Gtk::TreeViewColumn.new("Id", cella)
	colonna0.resizable = true
	colonna1 = Gtk::TreeViewColumn.new("Marca", cella)
	colonna1.resizable = true
	colonna0.set_attributes(cella, :text => 0)
	colonna1.set_attributes(cella, :text => 1)
	vistareinvio.append_column(colonna0)
	vistareinvio.append_column(colonna1)
	mreinvioscroll.add(vistareinvio)
	seltutti.signal_connect("clicked") {
		vistareinvio.selection.select_all
	}
	salva.signal_connect("clicked") {
		avviso = Gtk::MessageDialog.new(mreinvio, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "I capi selezionati saranno presenti nel prossimo file. Procedo?")
		risposta = avviso.run
		avviso.destroy
		if risposta == Gtk::Dialog::RESPONSE_YES
			cancellare = []
			caposel = vistareinvio.selection
			caposel.selected_each do |model, path, iter|
				cancellare.push(Gtk::TreeRowReference.new(model,path))
				Animals.update(iter[0], {:file => "0"})
			end
			cancellare.each do |c|
				(path = c.path) and listareinvio.remove(listareinvio.get_iter(path))
			end
			Conferma.conferma(mreinvio, "Operazione eseguita.")
		else
			Conferma.conferma(mreinvio, "Operazione annullata.")
		end
	}
	boxreinvio7.pack_start(mreinvioscroll, true, true, 0)
	mreinvio.show_all
end
