# Maschera scelta capi da far uscire

def mascuscite(finestra)
	muscite = Gtk::Window.new("Capi da far uscire")
	muscite.set_default_size(800, 600)
	muscite.maximize
	boxuscv = Gtk::VBox.new(false, 0)
	boxusc0 = Gtk::HBox.new(false, 0)
	boxusc1 = Gtk::HBox.new(false, 0)
	boxusc2 = Gtk::HBox.new(false, 0)
	boxusc3 = Gtk::HBox.new(false, 0)
	separator = Gtk::HSeparator.new
	boxusc4 = Gtk::HBox.new(false, 0)
	muscitescroll1 = Gtk::ScrolledWindow.new
	muscitescroll2 = Gtk::ScrolledWindow.new
	labelselezione = Gtk::Label.new #("Capi presenti")
	labelselezionati = Gtk::Label.new
	totcapi = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo = ? and uscito = ?", "#{@stallaoper.id}", "I", "0"]).length
	labeltotcapi = Gtk::Label.new("Totale capi presenti: #{totcapi}")
	boxuscv.pack_start(boxusc0, false, false, 5)
	boxuscv.pack_start(boxusc3, false, false, 5)
	boxuscv.pack_start(boxusc1, true, true, 0)
	boxuscv.pack_start(boxusc2, false, false, 20)
	boxuscv.pack_start(separator, false, true, 5)
	boxuscv.pack_start(boxusc4, false, false, 10)
	muscite.add(boxuscv)
	#relid = @stallaoper.id
	@uscenti = 0
	@contatore = 0
	labelselezione.set_markup("<b>Capi presenti</b>")
	labelselezionati.set_markup("<b>Capi da far uscire: #{@uscenti}</b>")
	lista = Gtk::ListStore.new(Integer, String, String, String, Integer, Date, String, String, String, String, Date, String, String, String, String, String, String)
	tutti = Gtk::Button.new("Elenca tutti")
	tutti.signal_connect( "clicked" ) {
		lista.clear
		selmov = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo = ? and uscito = ?", "#{@stallaoper.id}", "I", "0"], :order => "data_ingr")
		selmov.each do |m|
			itermov = lista.append
			itermov[0] = m.id.to_i
			itermov[1] = m.tipo
			itermov[2] = m.marca
			itermov[3] = m.specie
			itermov[4] = m.razza.id
			itermov[5] = m.data_nas
			itermov[6] = m.stalla_nas
			itermov[7] = m.sesso
			itermov[8] = m.naz_orig
			itermov[9] = m.naz_nasprimimp
			if m.data_applm != nil
				itermov[10] = m.data_applm #.strftime("%d%m%Y")
			else
				itermov[10] = ""
			end
			itermov[11] = m.ilg
			itermov[12] = m.marca_prec
			itermov[13] = m.marca_madre
			itermov[14] = m.marca_padre
			itermov[15] = m.data_nas.strftime("%d/%m/%Y").to_s
			if m.data_ingr != nil
				itermov[16] = m.data_ingr.strftime("%d/%m/%Y").to_s
			else
				itermov[16] = ""
			end
		end
	}

	vista = Gtk::TreeView.new(lista)
	vista.selection.mode = Gtk::SELECTION_SINGLE #BROWSE #SINGLE #MULTIPLE
	cella = Gtk::CellRendererText.new
	colonna1 = Gtk::TreeViewColumn.new("Id", cella)
	colonna2 = Gtk::TreeViewColumn.new("Marca", cella)
	colonna3 = Gtk::TreeViewColumn.new("Data nascita", cella)
	colonna4 = Gtk::TreeViewColumn.new("Data ingresso", cella)
	colonna1.set_attributes(cella, :text => 0)
	colonna2.set_attributes(cella, :text => 2)
	colonna3.set_attributes(cella, :text => 15)
	colonna4.set_attributes(cella, :text => 16)
	vista.append_column(colonna1)
	vista.append_column(colonna2)
	vista.append_column(colonna3)
	vista.append_column(colonna4)
	selezione = vista.selection
	cerca = Gtk::Entry.new
	cerca.max_length=(14)
	bottonecerca = Gtk::Button.new("Cerca")
	bottonecerca.signal_connect("clicked") {
		elenca(lista, cerca.text)
	}
	cerca.signal_connect("activate"){
		elenca(lista, cerca.text)
	}
	listasel = Gtk::ListStore.new(Integer, String, String, String, Integer, Date, String, String, String, String, Date, String, String, String, String)
	vista.signal_connect("row-activated") do |view, path, column|
		trasferisci(muscite, selezione, listasel, lista, labelselezionati)
	end
	def elenca(lista, cerca)
		lista.clear
		selmov = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo = ? and uscito = ? and marca LIKE ?", "#{@stallaoper.id}", "I", "0", "%#{cerca}%"])
		selmov.each do |m|
			itermov = lista.append
			itermov[0] = m.id.to_i
			itermov[1] = m.tipo
			itermov[2] = m.marca
			itermov[3] = m.specie
			itermov[4] = m.razza.id
			itermov[5] = m.data_nas #.strftime("%d%m%Y")
			itermov[6] = m.stalla_nas
			itermov[7] = m.sesso
			itermov[8] = m.naz_orig
			itermov[9] = m.naz_nasprimimp
			if m.data_applm != nil
				itermov[10] = m.data_applm #.strftime("%d%m%Y")
			else
				itermov[10] = ""
			end
			itermov[11] = m.ilg
			itermov[12] = m.marca_prec
			itermov[13] = m.marca_madre
			itermov[14] = m.marca_padre
			itermov[15] = m.data_nas.strftime("%d/%m/%Y").to_s
			if m.data_ingr != nil
				itermov[16] = m.data_ingr.strftime("%d/%m/%Y").to_s
			else
				itermov[16] = ""
			end
		end
	end
	#listasel = Gtk::ListStore.new(Integer, String, String, String, Integer, Date, String, String, String, String, Date, String, String, String, String)
	def trasferisci(finestra, selezione, listasel, lista, labelselezionati)
		#@contatore = 0

		caposel = selezione.selected
		#puts caposel
		if caposel == nil
			Errore.avviso(finestra, "Nessun capo selezionato.")
		else
			path = caposel.path
			if listasel.iter_first == nil
				@contatore+= 1
				itersel = listasel.append
				itersel[0] = caposel[0]
				itersel[1] = caposel[1]
				itersel[2] = caposel[2]
				itersel[3] = caposel[3]
				itersel[4] = caposel[4]
				itersel[5] = caposel[5]
				itersel[6] = caposel[6]
				itersel[7] = caposel[7]
				itersel[8] = caposel[8]
				itersel[9] = caposel[9]
				itersel[10] = caposel[10]
				itersel[11] = caposel[11]
				itersel[12] = caposel[12]
				itersel[13] = caposel[13]
				itersel[14] = caposel[14]
				lista.remove(lista.get_iter(path))
				@uscenti +=1
				labelselezionati.set_markup("<b>Capi da far uscire: #{@uscenti}</b>")
			else
				confronta = 0
				listasel.each { |model,path3,iter3|
				if iter3[0]== caposel[0]
					confronta+= 1 
				else
				end
			}
			end
			if confronta == 0
				@contatore += 1
				path = caposel.path
				itersel = listasel.append
				itersel[0] = caposel[0]
				itersel[1] = caposel[1]
				itersel[2] = caposel[2]
				itersel[3] = caposel[3]
				itersel[4] = caposel[4]
				itersel[5] = caposel[5]
				itersel[6] = caposel[6]
				itersel[7] = caposel[7]
				itersel[8] = caposel[8]
				itersel[9] = caposel[9]
				itersel[10] = caposel[10]
				itersel[11] = caposel[11]
				itersel[12] = caposel[12]
				itersel[13] = caposel[13]
				itersel[14] = caposel[14]
				lista.remove(lista.get_iter(path))
				@uscenti +=1
				labelselezionati.set_markup("<b>Capi da far uscire: #{@uscenti}</b>")
			else
			end
		end
	end
	spostasel = Gtk::Button.new( ">>" )
	#listasel = Gtk::ListStore.new(Integer, String, String, String, Integer, Date, String, String, String, String, Date, String, String, String, String)
	spostasel.signal_connect( "clicked" ) {
		trasferisci(muscite, selezione, listasel, lista, labelselezionati)
	}

	vista2 = Gtk::TreeView.new(listasel)
	cella2 = Gtk::CellRendererText.new
	vista2.selection.mode = Gtk::SELECTION_SINGLE
	colonnasel1 = Gtk::TreeViewColumn.new("Id", cella2)
	colonnasel2 = Gtk::TreeViewColumn.new("Marca", cella2)
	colonnasel1.set_attributes(cella2, :text => 0)
	colonnasel2.set_attributes(cella2, :text => 2)
	vista2.append_column(colonnasel1)
	vista2.append_column(colonnasel2)
	selezione2 = vista2.selection

	spostasel2 = Gtk::Button.new( "<<" )
	spostasel2.signal_connect( "clicked" ) {
		#puts @contatore
		#puts @uscenti
		caposel2 = selezione2.selected
		if caposel2 == nil
			Errore.avviso(muscite, "Nessun capo selezionato.")
		else
			path2 = caposel2.path
			itersel2 = lista.append
			itersel2[0] = caposel2[0]
			itersel2[1] = caposel2[1]
			itersel2[2] = caposel2[2]
			itersel2[3] = caposel2[3]
			itersel2[4] = caposel2[4]
			itersel2[5] = caposel2[5]
			itersel2[6] = caposel2[6]
			itersel2[7] = caposel2[7]
			itersel2[8] = caposel2[8]
			itersel2[9] = caposel2[9]
			itersel2[10] = caposel2[10]
			itersel2[11] = caposel2[11]
			itersel2[12] = caposel2[12]
			itersel2[13] = caposel2[13]
			itersel2[14] = caposel2[14]
			listasel.remove(listasel.get_iter(path2))
			@contatore-=1
			@uscenti -=1
			#puts @contatore
			#puts @uscenti
			labelselezionati.set_markup("<b>Capi da far uscire: #{@uscenti}</b>")
		end
	}

	#Motivo uscita

	labelmotivou = Gtk::Label.new("Motivo uscita:")
	boxusc2.pack_start(labelmotivou, false, false, 5)
	listausc = Gtk::ListStore.new(Integer, String)
	selusc = Uscites.find(:all)
	selusc.each do |usc|
		iteru = listausc.append
		iteru[0] = usc.codice
		iteru[1] = usc.descr
	end

	combousc = Gtk::ComboBox.new(listausc)
	renderusc = Gtk::CellRendererText.new
	combousc.pack_start(renderusc,false)
	combousc.set_attributes(renderusc, :text => 1)
	renderusc = Gtk::CellRendererText.new
	renderusc.visible=(false)
	combousc.pack_start(renderusc,false)
	combousc.set_attributes(renderusc, :text => 0)
	boxusc2.pack_start(combousc, false, false, 5)
	bottdatiusc = Gtk::Button.new( "Inserisci movimento di uscita" )
	bottdatiusc.signal_connect( "clicked" ) {
		#puts @contatore
		if @contatore == 0 or nil
				Errore.avviso(muscite, "Nessun capo selezionato.")
		else
			if combousc.active == -1
				Errore.avviso(muscite, "Seleziona un movimento di uscita.")
			elsif combousc.active_iter[0] == 4
				datimorte(finestra, muscite, listasel, combousc)
			elsif combousc.active_iter[0] == 9
				datimacellazione(finestra, muscite, listasel, combousc)
			elsif combousc.active_iter[0] == 6
				datifurto(finestra, muscite, listasel, combousc)
			elsif combousc.active_iter[0] == 16
				datiestero(finestra, muscite, listasel, combousc)
			else
				datiuscita(finestra, muscite, listasel, combousc)
			end
		end
	}
	muscitescroll1.add(vista)
	muscitescroll2.add(vista2)
	boxusc0.pack_start(tutti, false, false, 50)
	boxusc0.pack_start(cerca, false, false, 5)
	boxusc0.pack_start(bottonecerca, false, false, 5)
	boxusc0.pack_start(labeltotcapi, false, false, 5)
	boxusc3.pack_start(labelselezione, true, true, 5)
	boxusc3.pack_start(labelselezionati, true, true, 5)
	boxusc1.pack_start(muscitescroll1, true, true, 5)
	boxusc1.pack_start(spostasel, false, false, 0)
	boxusc1.pack_start(spostasel2, false, false, 0)
	boxusc1.pack_start(muscitescroll2, true, true, 5)
	boxusc2.pack_start(bottdatiusc, false, false, 0)

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.set_size_request(100, 30)
#	muscite.set_default_size(800, 600)
	bottchiudi.signal_connect("clicked") {
		muscite.destroy
	}
	boxusc4.pack_start(bottchiudi, true, false, 0)

	muscite.show_all
end
