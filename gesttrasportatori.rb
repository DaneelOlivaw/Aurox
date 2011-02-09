# Inserimento trasportatore

def instrasportatori(listatrasp)
	minstrasportatori = Gtk::Window.new("Nuovo trasportatore")
	minstrasportatori.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxinstraspv = Gtk::VBox.new(false, 0)
	boxinstrasp1 = Gtk::HBox.new(false, 5)
	boxinstrasp2 = Gtk::HBox.new(false, 5)
	boxinstraspv.pack_start(boxinstrasp1, false, false, 5)
	boxinstraspv.pack_start(boxinstrasp2, false, false, 5)
	minstrasportatori.add(boxinstraspv)

	# Nome trasportatore

	labelnometrasp = Gtk::Label.new("Nome trasportatore:")
	boxinstrasp1.pack_start(labelnometrasp, false, false, 5)
	nometrasp = Gtk::Entry.new()
	nometrasp.max_length=(50)
	boxinstrasp1.pack_start(nometrasp, false, false, 5)

	#Bottone di inserimento

	inseriscitrasp = Gtk::Button.new( "Inserisci trasportatore" )
	inseriscitrasp.signal_connect("clicked") {
		if nometrasp.text == ""
			Errore.avviso(minstrasportatori, "Servono tutti i dati.")
		else
			Trasportatoris.create(:nometrasp => "#{nometrasp.text.upcase}")
			nometrasp.text=("")
			if listatrasp != nil
				listatrasp.clear
				seltrasp = Trasportatoris.find(:all)
				seltrasp.each do |trasp|
					itertrasp = listatrasp.append
					itertrasp[0] = trasp.id
					itertrasp[1] = trasp.nometrasp
				end
				minstrasportatori.destroy
			end
		end
	}
	boxinstrasp2.pack_start(inseriscitrasp, false, false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		minstrasportatori.destroy
	}
	boxinstrasp2.pack_start(bottchiudi, false, false, 0)
	minstrasportatori.show_all
end

#Modifica trasportatori

def modtrasportatori #(listatrasp)
	mmodtrasportatori = Gtk::Window.new("Modifica trasportatori" )
	mmodtrasportatori.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxmodtraspv = Gtk::VBox.new(false, 0)
	boxmodtrasp1 = Gtk::HBox.new(false, 5)
	boxmodtrasp2 = Gtk::HBox.new(false, 5)
	boxmodtrasp3 = Gtk::HBox.new(false, 5)
	boxmodtrasp4 = Gtk::HBox.new(false, 5)
	boxmodtrasp5 = Gtk::HBox.new(false, 5)
	boxmodtrasp6 = Gtk::HBox.new(false, 5)
	boxmodtraspv.pack_start(boxmodtrasp1, false, false, 5)
	boxmodtraspv.pack_start(boxmodtrasp2, false, false, 5)
	boxmodtraspv.pack_start(boxmodtrasp3, false, false, 5)
	boxmodtraspv.pack_start(boxmodtrasp4, false, false, 5)
	boxmodtraspv.pack_start(boxmodtrasp5, false, false, 5)
	boxmodtraspv.pack_start(boxmodtrasp6, false, false, 5)
	mmodtrasportatori.add(boxmodtraspv)

	#Combo di scelta trasportatore

	labeltrasp = Gtk::Label.new("Selezona trasportatore:")
	boxmodtrasp1.pack_start(labeltrasp, false, false, 5)

	def generalista(listatrasp)
		listatrasp.clear
		#listatrasp = Gtk::ListStore.new(Integer, String)
		seltrasp = Trasportatoris.find(:all, :order => "nometrasp" )
		seltrasp.each do |t|
			iter1 = listatrasp.append
			iter1[0] = t.id.to_i
			iter1[1] = t.nometrasp
		end
	end

	listatrasp = Gtk::ListStore.new(Integer, String)
	generalista(listatrasp)
	combotrasp = Gtk::ComboBox.new(listatrasp)
	renderer1 = Gtk::CellRendererText.new
	combotrasp.pack_start(renderer1,false)
	combotrasp.set_attributes(renderer1, :text => 1)
	boxmodtrasp1.pack_start(combotrasp, false, false, 0)

	#Nome trasportatore

	labelnometrasp = Gtk::Label.new("Nome trasportatore:")
	boxmodtrasp2.pack_start(labelnometrasp, false, false, 5)
	nometrasp = Gtk::Entry.new()
	nometrasp.max_length=(50)
	boxmodtrasp2.pack_start(nometrasp, false, false, 5)

	combotrasp.signal_connect( "changed" ) {
		if combotrasp.active != -1
			nometrasp.text=("#{combotrasp.active_iter[1]}")
		end
	}

	#Bottone di inserimento

	inseriscitrasp = Gtk::Button.new( "Modifica trasportatore" )
	inseriscitrasp.signal_connect("clicked") {
		if nometrasp.text==("")
			Errore.avviso(mmodtrasportatori, "Servono tutti i dati.")
		else
			Trasportatoris.update(combotrasp.active_iter[0], {:nometrasp => "#{nometrasp.text.upcase}"})
			nometrasp.text=("")
			generalista(listatrasp)
			combotrasp.model=(listatrasp)
		end
	}

	boxmodtrasp6.pack_start(inseriscitrasp, false, false, 0)

#	#Bottone di annullamento modifiche

#	annullacampi = Gtk::Button.new( "Annulla modifiche" )
#	annullacampi.signal_connect("clicked") {
#		nometrasp.text=("#{combotrasp.active_iter[1]}")
#	}

#	boxmodtrasp6.pack_start(annullacampi, false, false, 0)

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mmodtrasportatori.destroy
	}
	boxmodtrasp6.pack_start(bottchiudi, false, false, 0)

	mmodtrasportatori.show_all

end
