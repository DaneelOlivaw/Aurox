#Modifica proprietari

def moddatiallevam
	mmoddatiallevam = Gtk::Window.new("Modifica dati allevamento")
	mmoddatiallevam.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxmoddatiallevamv = Gtk::VBox.new(false, 0)
	boxmoddatiallevam1 = Gtk::HBox.new(false, 5)
	boxmoddatiallevam2 = Gtk::HBox.new(false, 5)
	boxmoddatiallevam3 = Gtk::HBox.new(false, 5)
	boxmoddatiallevam4 = Gtk::HBox.new(false, 5)
	boxmoddatiallevam5 = Gtk::HBox.new(false, 5)
	boxmoddatiallevamv.pack_start(boxmoddatiallevam1, false, false, 5)
	boxmoddatiallevamv.pack_start(boxmoddatiallevam2, false, false, 5)
	boxmoddatiallevamv.pack_start(boxmoddatiallevam3, false, false, 5)
	boxmoddatiallevamv.pack_start(boxmoddatiallevam4, false, false, 5)
	boxmoddatiallevamv.pack_start(boxmoddatiallevam5, false, false, 5)
	mmoddatiallevam.add(boxmoddatiallevamv)

#	#Combo di scelta proprietario

#	labelproprietario = Gtk::Label.new("Selezona proprietario:")
#	boxmoddatiallevam1.pack_start(labelproprietario, false, false, 5)

#	def caricaprop
#		@listaprop = Gtk::ListStore.new(Integer, String, String, String, String)
#		@listaprop.clear
#		selprop = Props.find(:all, :order => "prop")
#		selprop.each do |p|
#			iter1 = @listaprop.append
#			iter1[0] = p.id
#			iter1[1] = p.prop
#			iter1[2] = p.codfisc
#			iter1[3] = p.piva
#			iter1[4] = p.idf
#		end
#	end

#	caricaprop
#	@comboprop = Gtk::ComboBox.new(@listaprop)
#	renderer1 = Gtk::CellRendererText.new
#	@comboprop.pack_start(renderer1,false)
#	@comboprop.set_attributes(renderer1, :text => 1)
#	boxmoddatiallevam1.pack_start(@comboprop.popdown, false, false, 0)

	#Modello 4 uscita

	labelmo4usc = Gtk::Label.new("Ultimo modello 4 uscita:")
	boxmoddatiallevam2.pack_start(labelmo4usc, false, false, 5)
	@mod4usc = Gtk::Entry.new()
	@mod4usc.max_length=(50)
	@mod4usc.text=("#{@stallaoper.mod4usc}")
	boxmoddatiallevam2.pack_start(@mod4usc, false, false, 5)

	#Numero progressivo dei capi nel registro

	labelprogrcapi = Gtk::Label.new("Numero progressivo dei capi nel registro:")
	boxmoddatiallevam3.pack_start(labelprogrcapi, false, false, 5)
	@progrcapi = Gtk::Entry.new()
	@progrcapi.max_length=(50)
	@progrcapi.text=("#{@stallaoper.progreg}")
	boxmoddatiallevam3.pack_start(@progrcapi, false, false, 5)

	#Numero di registro

	labelultimoreg = Gtk::Label.new("Numero ultimo registro:")
	boxmoddatiallevam4.pack_start(labelultimoreg, false, false, 5)
	@ultimoreg = Gtk::Entry.new()
	@ultimoreg.text=("#{@stallaoper.ultimoreg}")
#	@ultimoreg.max_length=(16)
	boxmoddatiallevam4.pack_start(@ultimoreg, false, false, 5)

	#Bottone di inserimento

	moddati = Gtk::Button.new( "Modifica dati" )
	moddati.signal_connect("clicked") {
		if @mod4usc.text==("") or @ultimoreg.text==("") or @progrcapi.text == ""
			Errore.avviso(mmoddatiallevam, "Servono tutti i dati.")
		else
			Relazs.update(@stallaoper.id, { :mod4usc => "#{@mod4usc.text.upcase}", :progreg => "#{@progrcapi.text.upcase}", :ultimoreg => "#{@ultimoreg.text.upcase}"})
			#puts @stallaoper.inspect
			@stallaoper = Relazs.find(:first, :conditions => ["id = ?", @stallaoper.id])
			#puts @stallaoper.inspect
			@mod4usc.text=("")
			@progrcapi.text = ""
			@ultimoreg.text=("")
		end
	}
	boxmoddatiallevam5.pack_start(moddati, false, false, 0)

	#Bottone di chiusura finestra

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mmoddatiallevam.destroy
	}
	boxmoddatiallevam5.pack_start(bottchiudi, false, false, 0)

	mmoddatiallevam.show_all
end
