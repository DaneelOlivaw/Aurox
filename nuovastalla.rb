# Crerazione della stalla

def nuovastalla
	mcreastalla = Gtk::Window.new("Creazione della stalla")
	mcreastalla.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxcreastallav = Gtk::VBox.new(false, 0)
	boxcreastalla1 = Gtk::HBox.new(false, 5)
	boxcreastalla2 = Gtk::HBox.new(false, 5)
	boxcreastalla3 = Gtk::HBox.new(false, 5)
	boxcreastalla4 = Gtk::HBox.new(false, 5)
	boxcreastalla5 = Gtk::HBox.new(false, 5)
	boxcreastalla6 = Gtk::HBox.new(false, 5)
	boxcreastallav.pack_start(boxcreastalla1, false, false, 5)
	boxcreastallav.pack_start(boxcreastalla2, false, false, 5)
	boxcreastallav.pack_start(boxcreastalla3, false, false, 5)
	boxcreastallav.pack_start(boxcreastalla4, false, false, 5)
	boxcreastallav.pack_start(boxcreastalla5, false, false, 5)
	boxcreastallav.pack_start(boxcreastalla6, false, false, 5)
	mcreastalla.add(boxcreastallav)

	#Selezione della stalla
	labelstalle = Gtk::Label.new("Seleziona una stalla:") 
	boxcreastalla1.pack_start(labelstalle, false, false, 5)
	lista317 = Gtk::ListStore.new(String, Integer, String, String, String)
	sel317 = Stalles.find(:all)
	sel317.each do |cod|
		iter317 = lista317.append
		iter317[0] = cod.cod317
		iter317[1] = cod.id
		iter317[2] = cod.via
		iter317[3] = cod.comune
		iter317[4] = cod.provincia

	end
	combo317 = Gtk::ComboBox.new(lista317)
	renderer1 = Gtk::CellRendererText.new
	combo317.pack_start(renderer1,false)
	combo317.set_attributes(renderer1, :text => 0)
	boxcreastalla1.pack_start(combo317, false, false, 0)

	# Selezione della ragione sociale

	labelragsoc = Gtk::Label.new("Seleziona una ragione sociale:")
	boxcreastalla2.pack_start(labelragsoc, false, false, 5)
	listaragsoc = Gtk::ListStore.new(String, Integer, String)
	selragsoc = Ragsocs.find(:all)
	selragsoc.each do |rsoc|
		iterragsoc = listaragsoc.append
		iterragsoc[0] = rsoc.ragsoc
		iterragsoc[1] = rsoc.id
		if rsoc.idf == "I"
			iterragsoc[2] = rsoc.piva
		else
			iterragsoc[2] = rsoc.codfisc
		end
	end
	comboragsoc = Gtk::ComboBox.new(listaragsoc)
	renderer1 = Gtk::CellRendererText.new
	comboragsoc.pack_start(renderer1,false)
	comboragsoc.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	comboragsoc.pack_start(renderer1,false)
	comboragsoc.set_attributes(renderer1, :text => 1)
	boxcreastalla2.pack_start(comboragsoc, false, false, 0)

	# Selezione del detentore

	labeldet = Gtk::Label.new("Seleziona un detentore:")
	boxcreastalla3.pack_start(labeldet, false, false, 5)
	listadet = Gtk::ListStore.new(String, Integer)
	seldet = Detentoris.find(:all)
	seldet.each do |d|
		iterdet = listadet.append
		iterdet[0] = d.detentore
		iterdet[1] = d.id
	end
	combodet = Gtk::ComboBox.new(listadet)
	renderer1 = Gtk::CellRendererText.new
	combodet.pack_start(renderer1,false)
	combodet.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combodet.pack_start(renderer1,false)
	combodet.set_attributes(renderer1, :text => 1)
	boxcreastalla3.pack_start(combodet, false, false, 0)

	# Selezione del proprietario

	labelprop = Gtk::Label.new("Seleziona un proprietario:")
	boxcreastalla4.pack_start(labelprop, false, false, 5)
	listaprop = Gtk::ListStore.new(String, Integer)
	selprop = Props.find(:all)
	selprop.each do |pr|
		iterprop = listaprop.append
		iterprop[0] = pr.prop
		iterprop[1] = pr.id
	end
	comboprop = Gtk::ComboBox.new(listaprop)
	renderer1 = Gtk::CellRendererText.new
	comboprop.pack_start(renderer1,false)
	comboprop.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	comboprop.pack_start(renderer1,false)
	comboprop.set_attributes(renderer1, :text => 1)
	boxcreastalla4.pack_start(comboprop, false, false, 0)

	labeltipoallev = Gtk::Label.new("Tipo di allevamento:")
	boxcreastalla5.pack_start(labeltipoallev, false, false, 5)
	tipoallev1 = Gtk::RadioButton.new("Riproduzione (BRI)")
	tipoallev1.active=(true)
	tipoallev="BRI"
	tipoallev1.signal_connect("toggled") {
		if tipoallev1.active?
			tipoallev="BRI"
		end
	}
	boxcreastalla5.pack_start(tipoallev1, false, false, 5)
	tipoallev2 = Gtk::RadioButton.new(tipoallev1, "Ingrasso (BCR)")
	tipoallev2.signal_connect("toggled") {
		if tipoallev2.active?
			tipoallev="BCR"
		end
	}
	boxcreastalla5.pack_start(tipoallev2, false, false, 5)
	tipoallev3 = Gtk::RadioButton.new(tipoallev1, "Stalla di sosta (SST)")
	tipoallev3.signal_connect("toggled") {
		if tipoallev3.active?
			tipoallev="SST"
		end
	}
	boxcreastalla5.pack_start(tipoallev3, false, false, 5)
	bottcreastalla = Gtk::Button.new( "Crea la stalla" )
	boxcreastalla6.pack_start(bottcreastalla, false, false, 5)
	bottcreastalla.signal_connect("clicked") {
#		puts comboragsoc.active_iter[0]
#		puts comboragsoc.active_iter[2]
#		puts combo317.active_iter[0]
		if combo317.active == -1 or comboragsoc.active == -1 or combodet.active == -1 or comboprop.active == -1
			Errore.avviso(mcreastalla, "Mancano dei dati.")
		else
			controllo = Relazs.find(:all, :conditions => ["stalle_id= ? and ragsoc_id= ? and detentori_id = ? and prop_id = ? and atp = ?", "#{combo317.active_iter[1]}", "#{comboragsoc.active_iter[1]}", "#{combodet.active_iter[1]}", "#{comboprop.active_iter[1]}", "#{tipoallev}"])
			#puts controllo.inspect
			if controllo.length == 0
				#puts "Niente"
				Relazs.create(:stalle_id => "#{combo317.active_iter[1]}", :ragsoc_id => "#{comboragsoc.active_iter[1]}", :detentori_id => "#{combodet.active_iter[1]}", :prop_id => "#{comboprop.active_iter[1]}", :atp => "#{tipoallev}", :mod4usc => "0/#{@giorno.strftime("%y")}", :progreg => "0/#{@giorno.strftime("%y")}", :ultimoreg => "0")
				allev = Allevamentis.find(:all, :conditions => ["ragsoc= ? and idfisc= ? and cod317= ?", "#{comboragsoc.active_iter[0]}", "#{comboragsoc.active_iter[2]}", "#{combo317.active_iter[0]}"])
#				puts allev.length
				if allev.length == 0
					Allevamentis.create(:ragsoc => "#{comboragsoc.active_iter[0]}", :idfisc => "#{comboragsoc.active_iter[2]}", :cod317 => "#{combo317.active_iter[0]}", :via => "#{combo317.active_iter[2]}", :comune => "#{combo317.active_iter[3]}", :provincia => "#{combo317.active_iter[4]}")
#					puts "bau"
				end
				Conferma.conferma(mcreastalla, "Dati inseriti correttamente")
			else
				#puts "Già presente"
				Conferma.conferma(mcreastalla, "Il profilo è già presente")
			end


#			cont = Relazs.find(:all, :conditions => ["stalle_id= ? and ragsoc_id= ?", "#{combo317.active_iter[1]}", "#{comboragsoc.active_iter[1]}"])
#			if cont.length == 0
#				Contatoris.create(:mod4usc => "0/#{@giorno.strftime("%y")}", :pagregcar => "0/#{@giorno.strftime("%y")}", :pagregscar => "0/#{@giorno.strftime("%y")}", :pagreg => "0/#{@giorno.strftime("%y")}", :progreg => "0/#{@giorno.strftime("%y")}")
#				ultimocont = Contatoris.find(:last)
#				Relazs.create(:stalle_id => "#{combo317.active_iter[1]}", :ragsoc_id => "#{comboragsoc.active_iter[1]}", :contatori_id => "#{ultimocont.id}", :prop_id => "#{comboprop.active_iter[1]}", :atp => "#{tipoallev}")
#				allev = Allevamentis.find(:all, :conditions => ["ragsoc= ? and idfisc= ? and cod317= ?", "#{comboragsoc.active_iter[0]}", "#{comboragsoc.active_iter[2]}", "#{combo317.active_iter[0]}"])
##				puts allev.length
#				if allev.length == 0
#					Allevamentis.create(:ragsoc => "#{comboragsoc.active_iter[0]}", :idfisc => "#{comboragsoc.active_iter[2]}", :cod317 => "#{combo317.active_iter[0]}")
##					puts "bau"
#				end
#			Conferma.conferma(mcreastalla, "Dati inseriti correttamente")
#			else
#				n = cont.length
#				n -=1
#				esiste = 0
#				while n >= 0
#					if cont[n].prop_id == comboprop.active_iter[1] and cont[n].atp == tipoallev
#						esiste = 1
#						break
#					else
#					end
#					n -=1
#				end
				#if esiste == 0
#					ultimocont = Contatoris.find(:last)
#					Relazs.create(:stalle_id => "#{combo317.active_iter[1]}", :ragsoc_id => "#{comboragsoc.active_iter[1]}", :contatori_id => "#{cont[0].contatori_id}", :prop_id => "#{comboprop.active_iter[1]}", :atp => "#{tipoallev}")
#					Conferma.conferma(mcreastalla, "Dati inseriti correttamente")
#				else
#					Conferma.conferma(mcreastalla, "Il profilo è già presente")
#				end
#			end
		end
	}
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mcreastalla.destroy
	}
	boxcreastalla6.pack_start(bottchiudi, false, false, 0)
	mcreastalla.show_all
end
