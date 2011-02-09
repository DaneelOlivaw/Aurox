#Quinta beta: nomi a posto, diminuzione variabili, gestione del cambio anno

require 'dipendenze'
#require 'compregzardo'
#prova = Relazs.scoped({})
#puts "prova1 " + "#{prova.class}"
#puts prova.size
#prova2 = Relazs.find(:all)
#puts "prova2 "+ "#{prova2.class}"
#puts Relazs.tutto
#prova.each do |v|
#	puts v.id
#end
#puts prova.id

piattaforma = RUBY_PLATFORM
if piattaforma.include?("linux")
	@sistema = "linux"
else
	@sistema = "win"
	require 'win32ole'
	@shell = WIN32OLE.new('Shell.Application')
end

@giorno = Time.now
@dir = Dir.pwd

def delete_event( widget, event )
	return false
end

def destroy( widget )
	Gtk.main_quit
end

#Inizio con finestra principale

Gtk.init
	window = Gtk::Window.new( Gtk::Window::TOPLEVEL )
	window.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	window.set_default_size(600, 500)
	window.set_title( "AUROX" )
	window.signal_connect( "delete_event" ) {
		delete_event( nil, nil )
	}
	window.signal_connect( "destroy" ) {
		destroy( nil )
	}
	box1 = Gtk::VBox.new(false, 10)
	boxstalla = Gtk::HBox.new(false, 0 )
	boxragsoc = Gtk::HBox.new(false, 0)
	boxprop = Gtk::HBox.new(false, 0)
	listacombo = Gtk::ListStore.new(Integer, String)
	listacombo2 = Gtk::ListStore.new(Integer, String, Integer)
	listacombo3 = Gtk::ListStore.new(Integer, String, Integer, String, String)
	combo = Gtk::ComboBox.new(listacombo)
	combo2 = Gtk::ComboBox.new(listacombo2)
	combo3 = Gtk::ComboBox.new(listacombo3)
	menubar = createMenuBar(window, listacombo, combo, combo2, combo3)
	box1.pack_start(menubar, false, false, 0)
	box1.pack_start(boxstalla, false, false, 5)
	box1.pack_start(boxragsoc, false, false, 5)
	box1.pack_start(boxprop, false, false, 5)
	window.add(box1)
	ingressi = Gtk::Button.new( "INGRESSI" )
	uscite = Gtk::Button.new( "USCITE" )
	bottcreafile = Gtk::Button.new("CREA FILE PER L'INVIO DEI DATI")
	stampareg = Gtk::Button.new("STAMPA REGISTRO")
	stampavidimati = Gtk::Button.new("STAMPA PAGINE VIDIMATE")
	bottcompilaregistro = Gtk::Button.new("COMPILA IL REGISTRO")
	sel1 = Stalles.find(:all)
#	lun = 0
	sel1.each do |r|
		iter1 = listacombo.append
		iter1[0] = r.id
		iter1[1] = r.cod317
#		lun +=1
	end

	#Selezione della stalla

	#combo = Gtk::ComboBox.new(listacombo)
	renderer1 = Gtk::CellRendererText.new
	combo.pack_start(renderer1,false)
	combo.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combo.pack_start(renderer1,false)
	combo.set_attributes(renderer1, :text => 0)
	labelstalle = Gtk::Label.new("Seleziona una stalla:")
	boxstalla.pack_start(labelstalle, false, false, 5)
	boxstalla.pack_start(combo, false, false, 0)

	#Selezione della ragione sociale

	combo.signal_connect( "changed" ) {
	if combo.active != -1
		#@stallascelta = @combo.active_iter[1]
		sel2 = Relazs.find(:all, :from => "relazs", :conditions => ["relazs.stalle_id= ?", "#{combo.active_iter[0]}"], :order => "ragsoc_id")
		listacombo3.clear
		listacombo2.clear
		sel2.each do |t|
			iter = listacombo2.append
			iter[0] = t.id.to_i
			iter[1] = t.ragsoc.ragsoc.to_s
			iter[2] = t.ragsoc.id.to_i #.to_i
		end
		arrconfronto = []
		x = nil
		listacombo2.each do |modello, percorso, iterat|
			(iterat[1] == x) and arrconfronto.push(Gtk::TreeRowReference.new(modello, percorso))
			x = iterat[1]
		end
		arrconfronto.each do |rif|
			(percorso = rif.path) and listacombo2.remove(listacombo2.get_iter(percorso))
		end
	end
	}
	#combo2 = Gtk::ComboBox.new(listacombo2)
	renderer = Gtk::CellRendererText.new
	renderer.visible=(false)
	combo2.pack_start(renderer,false)
	combo2.set_attributes(renderer, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combo2.pack_start(renderer1,false)
	combo2.set_attributes(renderer1, :text => 1)
	render2 = Gtk::CellRendererText.new
	render2.visible=(false)
	combo2.pack_start(render2,false)
	combo2.set_attributes(render2, :text => 2)
	labelragsoc = Gtk::Label.new("Seleziona una ragione sociale:")
	boxragsoc.pack_start(labelragsoc, false, false, 5)
	boxragsoc.pack_start(combo2, false, false, 0)

	#Selezione del proprietario

	combo2.signal_connect( "changed" ) {
		if combo2.active != -1 then
			#@idragsoc = combo2.active
			sel3 = Relazs.find(:all, :from => "relazs", :conditions => ["relazs.stalle_id= ?  and relazs.ragsoc_id= ?", "#{combo.active_iter[0]}", "#{combo2.active_iter[2]}"])
			#sel3 = Relazs.find(:all, :from => "props, relazs", :conditions => ["relazs.stalle_id= ?  and relazs.ragsoc_id= ?", "#{combo.active_iter[0]}", "#{combo2.active_iter[2]}"])
			listacombo3.clear
			sel3.each do |s|
				iter = listacombo3.append
				iter[0] = s.id.to_i
				iter[1] = s.prop.prop.to_s
				iter[2] = s.prop_id.to_i
				iter[3] = s.atp
				iter[4] = "-"
			end
		else
		end
	}
	#combo3 = Gtk::ComboBox.new(listacombo3)
	renderer = Gtk::CellRendererText.new
	renderer.visible=(false)
	combo3.pack_start(renderer,false)
	combo3.set_attributes(renderer, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combo3.pack_start(renderer1,false)
	combo3.set_attributes(renderer1, :text => 1)
	renderer2 = Gtk::CellRendererText.new
	renderer2.visible=(false)
	combo3.pack_start(renderer2,false)
	combo3.set_attributes(renderer2, :text => 2)
	renderer3 = Gtk::CellRendererText.new
	combo3.pack_start(renderer3,false)
	combo3.set_attributes(renderer3, :text => 4)
	renderer4 = Gtk::CellRendererText.new
	combo3.pack_start(renderer4,false)
	combo3.set_attributes(renderer4, :text => 3)
	labelprop = Gtk::Label.new("Seleziona un proprietario:")
	boxprop.pack_start(labelprop, false, false, 5)
	boxprop.pack_start(combo3, false, false, 0)
	combo3.signal_connect( "changed" ) {
		@stallaoper = 0
		if combo3.active != -1
			@stallaoper = Relazs.find(:first, :conditions => ["id= ?", "#{combo3.active_iter[0]}"])
			if @stallaoper.contatori.progreg.split('/')[1] < @giorno.strftime("%y")
				#testo = Pango.parse_markup("<span weight ='bold'>Attenzione: è cambiato l'anno rispetto ai riferimenti in memoria. Per evitare problemi si prega di concludere la movimentazione dei capi dell'anno precedente e di fare le relative stampe PRIMA di inserire i dati dell'anno corrente.</span>")
				#testo = "Attenzione: è cambiato l\'anno rispetto ai riferimenti in memoria. Per evitare problemi si prega di concludere la movimentazione dei capi dell\'anno precedente e di fare le relative stampe PRIMA di inserire i dati dell\'anno corrente."
				#puts testo
				Errore.avviso(window, "Attenzione: è cambiato l'anno rispetto ai riferimenti in memoria.\nPer evitare problemi si prega di concludere la movimentazione dei capi dell'anno precedente e di fare le relative stampe PRIMA di inserire i dati dell'anno corrente.")
			#if @stallaoper.contatori.progreg
			end
		end
	}

	ingressi.signal_connect( "clicked" ) {
		if combo.active == -1 or combo2.active == -1 or combo3.active == -1
			Errore.avviso(window, "Seleziona una stalla, una ragione sociale ed un proprietario.")
		else
			masccontaingr
		end
	}

	uscite.signal_connect( "clicked" ) {
		if combo.active == -1 or combo2.active == -1 or combo3.active == -1
			Errore.avviso(window, "Seleziona una stalla, una ragione sociale ed un proprietario.")
		else
			mascuscite(window)
		end
	}

	bottcreafile.signal_connect("clicked") {
		if combo.active == -1 or combo2.active == -1 or combo3.active == -1
			Errore.avviso(window, "Seleziona una stalla, una ragione sociale ed un proprietario.")
		else
			nmov = Animals.find(:all, :from=> "animals", :conditions => ["relaz_id= ? and file= ?", "#{@stallaoper.id}", "0"]).length
			if nmov != 0
				avviso = Gtk::MessageDialog.new(window, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Ci sono #{nmov} movimenti da inviare. Procedo con la creazione del file?")
				risposta = avviso.run
				avviso.destroy
				if risposta == Gtk::Dialog::RESPONSE_YES
					creafile(window)
				else
					Conferma.conferma(window, "Operazione annullata.")
				end
			else
				Conferma.conferma(window, "Non ci sono movimenti disponibili.")
			end
		end
	}

	stampareg.signal_connect("clicked") {
		if combo.active == -1 or combo2.active == -1 or combo3.active == -1
			Errore.avviso(window, "Seleziona una stalla, una ragione sociale ed un proprietario.")
		else
			mascstamparegistro
		end
	}
	stampavidimati.signal_connect("clicked") {
		if combo.active == -1 or combo2.active == -1 or combo3.active == -1
			Errore.avviso(window, "Seleziona una stalla, una ragione sociale ed un proprietario.")
		else
			mascvidimati
		end
	}
	bottcompilaregistro.signal_connect("clicked") {
		if combo.active == -1 or combo2.active == -1 or combo3.active == -1
			Errore.avviso(window, "Seleziona una stalla, una ragione sociale ed un proprietario.")
		else
#=begin
			registrare = Animals.find(:all, :conditions => ["relaz_id= ? and registro= ?", "#{@stallaoper.id}", "0"]).length
			if registrare == 0
				Conferma.conferma(window, "Nessun capo da spostare nel registro.")
			else
				avviso = Gtk::MessageDialog.new(window, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Ci sono #{registrare} movimenti da inserire nel registro. Procedo?")
				risposta = avviso.run
				avviso.destroy
				if risposta == Gtk::Dialog::RESPONSE_YES
					compilaregistro(window)
				end
			end
#=end
#			compregzardo
		end
	}
	box1.pack_start(ingressi, false, false, 0)
	box1.pack_start(uscite, false, false, 0)
	box1.pack_start(bottcreafile, false, false, 5)
	box1.pack_start(bottcompilaregistro, false, false, 5)
	box1.pack_start(stampavidimati, false, false, 5)
	box1.pack_start(stampareg, false, false, 5)
	bottchiudi = Gtk::Button.new( "ESCI" )
	bottchiudi.signal_connect("clicked") {
		window.destroy
	}
	box1.pack_start(bottchiudi, false, false, 0)
	window.show_all

Gtk.main
