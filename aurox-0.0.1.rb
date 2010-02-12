#Prima alpha

require 'gtk2'
require 'rubygems'
require 'active_record'
require "database"
require 'pdf/writer'
require 'pdf/simpletable'
require 'ftools'

piattaforma = RUBY_PLATFORM
if piattaforma.include?("linux")
	@sistema = "linux"
else
	@sistema = "win"
	require 'win32ole'
	@shell = WIN32OLE.new('Shell.Application')
end

@giorno = Time.now

def delete_event( widget, event )
	return false
end

def destroy( widget )
	Gtk.main_quit
end

def createMenuBar
	topmen = Gtk::MenuItem.new( "Visualizza" )
	menu = Gtk::Menu.new
	menu2 = Gtk::Menu.new
	item = Gtk::MenuItem.new( "Movimenti" )
	item.signal_connect("activate") {
		if @combo.active == -1 or @combo2.active == -1 or @combo3.active == -1
			Avvisoprova.avviso(@window, "Seleziona una stalla, una ragione sociale ed un proprietario.")
		else
			vismovimenti
		end
	}
	menu.append( item )
	item = Gtk::MenuItem.new( "Registro" )
	item.signal_connect("activate") { 
		if @combo.active == -1 or @combo2.active == -1 or @combo3.active == -1
			Avvisoprova.avviso(@window, "Seleziona una stalla, una ragione sociale ed un proprietario.")
		else
			visregistro
		end
	}
	menu.append( item )

	topmen.set_submenu( menu )

	modifica = Gtk::MenuItem.new( "Modifica" )
	menumod = Gtk::Menu.new
	itemmod = Gtk::MenuItem.new( "Allevamenti" )
	itemmod.signal_connect("activate") { modallevamenti }
	menumod.append( itemmod )
	itemmod = Gtk::MenuItem.new( "Macelli" )
	itemmod.signal_connect("activate") {modmacelli}
	menumod.append( itemmod )
	itemmod = Gtk::MenuItem.new( "Trasportatori" )
	itemmod.signal_connect("activate") {modtrasportatori}
	menumod.append( itemmod )
	itemmod = Gtk::MenuItem.new( "Reinvio capi" )
	itemmod.signal_connect("activate") {
		if @combo.active == -1 or @combo2.active == -1 or @combo3.active == -1
			Avvisoprova.avviso(@window, "Seleziona una stalla, una ragione sociale ed un proprietario.")
		else
			reinvio
		end
}
	menumod.append( itemmod )

	modifica.set_submenu( menumod )

	prova = Gtk::MenuItem.new( "Inserimento" )
	menuprova = Gtk::Menu.new
	itemprova = Gtk::MenuItem.new("Allevamenti")
	itemprova.signal_connect("activate") {mascallevam}
	menuprova.append(itemprova)
	itemprova = Gtk::MenuItem.new("Macelli")
	itemprova.signal_connect("activate") {insmacelli}
	menuprova.append(itemprova)
	itemprova = Gtk::MenuItem.new("Trasportatori")
	itemprova.signal_connect("activate") {instrasportatori}
	menuprova.append( itemprova )
	itemprova = Gtk::MenuItem.new("Codice stalla")
	itemprova.signal_connect("activate") {codstalla}
	menuprova.append( itemprova )
	itemprova = Gtk::MenuItem.new("Ragioni sociali")
	itemprova.signal_connect("activate") {crearagsoc}
	menuprova.append( itemprova )
	itemprova = Gtk::MenuItem.new("Proprietari")
	itemprova.signal_connect("activate") {creaprop}
	menuprova.append( itemprova )
	itemprova = Gtk::MenuItem.new("Crea una stalla")
	itemprova.signal_connect("activate") {creastalla}
	menuprova.append( itemprova )
	prova.set_submenu( menuprova )

	stampe = Gtk::MenuItem.new( "Altre stampe" )
	menustampe = Gtk::Menu.new
	itemstampe = Gtk::MenuItem.new("Registro non vidimato")
		itemstampe.signal_connect("activate") {
		if @combo.active == -1 or @combo2.active == -1 or @combo3.active == -1
			Avvisoprova.avviso(@window, "Seleziona una stalla, una ragione sociale ed un proprietario.")
		else
			mascregnonvidim
		end
	}
	menustampe.append(itemstampe)
	itemstampe = Gtk::MenuItem.new("Presenti in stalla")
	itemstampe.signal_connect("activate") {
		if @combo.active == -1 or @combo2.active == -1 or @combo3.active == -1
			Avvisoprova.avviso(@window, "Seleziona una stalla, una ragione sociale ed un proprietario.")
		else
			stampapres
		end
	}
	menustampe.append(itemstampe)
	itemstampe = Gtk::MenuItem.new("Allegato MOD. 4")
	itemstampe.signal_connect("activate") {
		if @combo.active == -1 or @combo2.active == -1 or @combo3.active == -1
			Avvisoprova.avviso(@window, "Seleziona una stalla, una ragione sociale ed un proprietario.")
		else
			mascallmod4
		end
	}
	menustampe.append(itemstampe)
	stampe.set_submenu( menustampe )
	menubar = Gtk::MenuBar.new
	menubar.append( topmen )
	menubar.append( modifica )
	menubar.append( prova )
	menubar.append( stampe )
	return menubar
end

#Avvisi

class Avvisoprova
	def initialize(a,e="Servono tutti i dati.", b=Gtk::Dialog::DESTROY_WITH_PARENT, c=Gtk::MessageDialog::WARNING, d=Gtk::MessageDialog::BUTTONS_CLOSE)
		@avviso = Gtk::MessageDialog.new(a,b,c,d,e)
	end
	def avvia
		@avviso.run
		@avviso.destroy
	end
	def self.avviso(a,b)
		Avvisoprova.new(a, b).avvia
	end
end

class Conferma
	def initialize(a, e="", b=Gtk::Dialog::DESTROY_WITH_PARENT, c=Gtk::MessageDialog::INFO, d=Gtk::MessageDialog::BUTTONS_OK)
		@conferma = Gtk::MessageDialog.new(a,b,c,d,e)
	end
	def avvia
		@conferma.run
		@conferma.destroy
	end
	def self.conferma(a,b)
		Conferma.new(a, b).avvia
	end
end

#class Domanda
#	def initialize(a, e="Domanda", b=Gtk::Dialog::DESTROY_WITH_PARENT, c=Gtk::MessageDialog::QUESTION, d=Gtk::MessageDialog::BUTTONS_YES_NO)
#		@domanda = Gtk::MessageDialog.new(a,b,c,d,e)
#	end
#	def avvia
#		@domanda.run
##		@risposta = @domanda.run
##		puts @domanda.run
##		puts @domanda.run.class
#		@domanda.destroy
#	end
#	def self.domanda(a,b)
#		Domanda.new(a, b).avvia
#	end
#end

#Finestre di programma

#Ingressi

#Maschera dati del capo in ingresso

def inscapo

	@finestraingr = Gtk::Window.new("Dati del capo")
	@finestraingr.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxingrvert = Gtk::VBox.new(false, 0)
	boxingr1 = Gtk::HBox.new(false, 0)
	boxingr2 = Gtk::HBox.new(false, 0)
	boxingr3 = Gtk::HBox.new(false, 0)
	boxingr4 = Gtk::HBox.new(false, 0)
	boxingr5 = Gtk::HBox.new(false, 0)
	boxingr6 = Gtk::HBox.new(false, 0)
	boxingr7 = Gtk::HBox.new(false, 0)
	boxingr8 = Gtk::HBox.new(false, 0)
	boxingr9 = Gtk::HBox.new(false, 0)
	boxingr10 = Gtk::HBox.new(false, 0)
	boxingrvert.pack_start(boxingr1, false, false, 5)
	boxingrvert.pack_start(boxingr2, false, false, 5)
	boxingrvert.pack_start(boxingr3, false, false, 5)
	boxingrvert.pack_start(boxingr4, false, false, 5)
	boxingrvert.pack_start(boxingr5, false, false, 5)
	boxingrvert.pack_start(boxingr6, false, false, 5)
	boxingrvert.pack_start(boxingr7, false, false, 5)
	boxingrvert.pack_start(boxingr8, false, false, 5)
	boxingrvert.pack_start(boxingr9, false, false, 5)
	boxingrvert.pack_start(boxingr10, false, false, 5)
	@finestraingr.add(boxingrvert)

	@labelingr = Gtk::Label.new("Totale capi da inserire: #{@containgressi}")
	boxingr1.pack_start(@labelingr, true, false, 0)

	#Generazione array coi capi presenti
	presenti = Animals.find(:all, :from => "animals", :conditions => "relaz_id='#{@stallaoper}' and tipo='I' and uscito='0'")
	@arraypres = Array.new
	if presenti.length != 0
		presenti.each do |pres|
			@arraypres << pres.marca
		end
	end

	#Inserimento marca

	labelmarca = Gtk::Label.new("Marca:")
	boxingr2.pack_start(labelmarca, false, false, 5)
	@marca = Gtk::Entry.new()
	@marca.max_length=(14)
	boxingr2.pack_start(@marca, false, false, 5)
	i = 0
	@marca.signal_connect("changed") {
	if @arraypres.include?(@marca.text.upcase) == true
		Avvisoprova.avviso(@finestraingr, "La marca è già presente.")
	end
	}

	#Specie

	labelspecie = Gtk::Label.new("Specie:")
	boxingr3.pack_start(labelspecie, false, false, 5)
	specie1 = Gtk::RadioButton.new("Bovini")
	specie1.active=(true)
	@valspecie="BOV"
	specie1.signal_connect("toggled") {
		if specie1.active?
			@valspecie="BOV"
		end
	}
	boxingr3.pack_start(specie1, false, false, 5)
	specie2 = Gtk::RadioButton.new(specie1, "Bufalini")
	specie2.signal_connect("toggled") {
		if specie2.active?
			@valspecie="BUF"
		end
	}
	boxingr3.pack_start(specie2, false, false, 5)

	#Inserimento razza

	labelrazza = Gtk::Label.new("Razza:")
	@listarazze = Gtk::ListStore.new(Integer, String, String)
	selrazze = Razzas.find(:all, :order => "razza")
	selrazze.each do |@r|
		iter1 = @listarazze.append
		iter1[0] = @r.id.to_i
		iter1[1] = @r.razza
		iter1[2] = @r.cod_razza
	end
	@comborazze = Gtk::ComboBox.new(@listarazze)
	renderer1 = Gtk::CellRendererText.new
	@comborazze.pack_start(renderer1,false)
	@comborazze.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	@comborazze.pack_start(renderer1,false)
	@comborazze.set_attributes(renderer1, :text => 2)
	boxingr3.pack_end(@comborazze.popdown, false, false, 0)
	boxingr3.pack_end(labelrazza, false, false, 5)

	#Inserimento data di nascita

	labelnascita = Gtk::Label.new("Data di nascita (GGMMAA):")
	boxingr4.pack_start(labelnascita, false, false, 5)
	@nascita = Gtk::Entry.new()
	@nascita.max_length=(6)
	boxingr4.pack_start(@nascita, false , false, 0)

	#Inserimento stalla di nascita / prima importazione

	labelstallanas = Gtk::Label.new("Stalla nascita / prima importazione:")
	@stallanas = Gtk::Entry.new()
	@stallanas.max_length=(8)
	@stallanas.add_events(Gdk::Event::KEY_PRESS)
	@stallanas.signal_connect("key-press-event") do |w, e|
		tasto = Gdk::Keyval.to_name(e.keyval)
		if tasto == "F3"
			@stallanas.text = "#{@stallascelta.to_s}"
		end
	end

#	@lista = Gtk::ListStore.new(String)
#	iter = @lista.append
#	iter[0] = "#{@stallascelta.to_s}"
#	complet = Gtk::EntryCompletion.new
#	complet.model=(@lista)
#	complet.set_text_column(0)
#	@stallanas.completion=(complet)
	boxingr4.pack_end(@stallanas, false, false, 5)
	boxingr4.pack_end(labelstallanas, false, false, 5)

	#Inserimento sesso

	labelsesso = Gtk::Label.new("Sesso:") 
	boxingr5.pack_start(labelsesso, false, false, 5)
	@sesso1 = Gtk::RadioButton.new("M")
	@sesso1.active=(true)
	@valsesso="M"
	@sesso1.signal_connect("toggled") {
		if @sesso1.active?
			@valsesso="M"
		end
	}
	boxingr5.pack_start(@sesso1, false, false, 5)
	sesso2 = Gtk::RadioButton.new(@sesso1, "F")
	sesso2.signal_connect("toggled") {
		if sesso2.active?
			@valsesso="F"
		end
	}
	boxingr5.pack_start(sesso2, false, false, 5)

	#Nazione origine

	labelnazorig = Gtk::Label.new("Nazione di origine:")
	listanazorig = Gtk::ListStore.new(Integer, String, String, Integer)
	listanazorig.clear
	selnazorig = Nations.find(:all)
	selnazorig.each do |no|
		iter1 = listanazorig.append
		iter1[0] = no.id
		iter1[1] = no.nome
		iter1[2] = no.codice
		iter1[3] = no.tipo
	end
	@combonazorig = Gtk::ComboBox.new(listanazorig)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	@combonazorig.pack_start(renderer1,false)
	@combonazorig.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	@combonazorig.pack_start(renderer1,false)
	@combonazorig.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	@combonazorig.pack_start(renderer1,false)
	@combonazorig.set_attributes(renderer1, :text => 2)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	@combonazorig.pack_start(renderer1,false)
	@combonazorig.set_attributes(renderer1, :text => 3)
	boxingr5.pack_end(@combonazorig.popdown, false, false, 0)
	boxingr5.pack_end(labelnazorig, false, false, 5)

	#Nazione nascita / prima importazione

	labelnaznas = Gtk::Label.new("Nazione nascita / prima importazione:")
	boxingr6.pack_start(labelnaznas, false, false, 5)
	listanaznas = Gtk::ListStore.new(Integer, String, String)
	listanaznas.clear
	selnaznas = Nations.find(:all)
	selnaznas.each do |n|
		iter1 = listanaznas.append
		iter1[0] = n.id
		iter1[1] = n.nome
		iter1[2] = n.codice
	end
	@combonaznas = Gtk::ComboBox.new(listanaznas)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	@combonaznas.pack_start(renderer1,false)
	@combonaznas.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	@combonaznas.pack_start(renderer1,false)
	@combonaznas.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	@combonaznas.pack_start(renderer1,false)
	@combonaznas.set_attributes(renderer1, :text => 2)
	boxingr6.pack_start(@combonaznas.popdown, false, false, 0)

	#Data applicazione marca

	labelmarcatura = Gtk::Label.new("Data applicazione marca (GGMMAA):")
	boxingr6.pack_start(labelmarcatura, false, false, 5)
	@marcatura = Gtk::Entry.new()
	@marcatura.max_length=(6)
	boxingr6.pack_start(@marcatura, false, false, 0)

	#Iscrizione libro genealogico

	labelgen = Gtk::Label.new("Iscrizione libro genealogico:")
	boxingr7.pack_start(labelgen, false, false, 5)
	gen1 = Gtk::RadioButton.new("S")
	@valgen="N"
	gen1.signal_connect("toggled") {
		if gen1.active?
			@valgen="S"
		end
	}
	boxingr7.pack_start(gen1, false, false, 5)
	gen2 = Gtk::RadioButton.new(gen1, "N")
	gen2.active=(true)
	gen2.signal_connect("toggled") {
		if gen2.active?
			@valgen="N"
		end
	}
	boxingr7.pack_start(gen2, false, false, 5)
	gen3 = Gtk::RadioButton.new(gen1, "NULLO")
	gen3.signal_connect("toggled") {
		if gen3.active?
			@valgen="NULLO"
		end
	}
	boxingr7.pack_start(gen3, false, false, 5)

	#Embryo transer

	labelembryo = Gtk::Label.new("Embryo transfer:")
	boxingr7.pack_start(labelembryo, false, false, 5)
	embryo1 = Gtk::RadioButton.new("S")
	@valembryo = "N"
	embryo1.signal_connect("toggled") {
		if embryo1.active?
			@valembryo="S"
		end
	}
	boxingr7.pack_start(embryo1, false, false, 5)
	embryo2 = Gtk::RadioButton.new(embryo1, "N")
	embryo2.active=(true)
	embryo2.signal_connect("toggled") {
		if embryo2.active?
			@valembryo="N"
		end
	}
	boxingr7.pack_start(embryo2, false, false, 5)

	#Marca precedente

	labelprec = Gtk::Label.new("Marca precedente:")
	boxingr8.pack_start(labelprec, false, false, 5)
	@prec = Gtk::Entry.new()
	@prec.max_length=(14)
	boxingr8.pack_start(@prec, false, false, 5)

	#Marca madre

	labelmadre = Gtk::Label.new("Marca madre:")
	boxingr8.pack_start(labelmadre, false, false, 5)
	@madre = Gtk::Entry.new()
	@madre.max_length=(14)
	boxingr8.pack_start(@madre, false, false, 5)

	#Marca padre

	labelpadre = Gtk::Label.new("Marca padre:")
	boxingr8.pack_start(labelpadre, false, false, 5)
	@padre = Gtk::Entry.new()
	@padre.max_length=(14)
	boxingr8.pack_start(@padre, false, false, 5)

	#Marca donatrice

	labeldon = Gtk::Label.new("Marca donatrice:")
	boxingr9.pack_start(labeldon, false, false, 5)
	@don = Gtk::Entry.new()
	@don.max_length=(14)
	boxingr9.pack_start(@don, false, false, 5)

	#Codice libro genealogico

	labellibgen = Gtk::Label.new("Codice libro genealogico:")
	boxingr9.pack_start(labellibgen, false, false, 5)
	@libgen = Gtk::Entry.new()
	@libgen.max_length=(50)
	boxingr9.pack_start(@libgen, false, false, 5)

	#Motivo ingresso
	
	labelmotivoi = Gtk::Label.new("Motivo ingresso:")
	boxingr10.pack_start(labelmotivoi, false, false, 5)
	listaing = Gtk::ListStore.new(Integer, String)
	comboing = Gtk::ComboBox.new

	seling = Ingressos.find(:all)
	seling.each do |@ing|
		iteri = listaing.append
		iteri[0] = @ing.codice
		iteri[1] = @ing.descr
	end

	@comboing = Gtk::ComboBox.new(listaing)
	rendering = Gtk::CellRendererText.new
	@comboing.pack_start(rendering,false)
	@comboing.set_attributes(rendering, :text => 1)
	rendering = Gtk::CellRendererText.new
	rendering.visible=(false)
	@comboing.pack_start(rendering,false)
	@comboing.set_attributes(rendering, :text => 0)

	boxingr10.pack_start(@comboing, false, false, 5)

	#Controlli e altro
	primoins = 0
	@stallanas.signal_connect("changed") {
	if primoins == 0
	begin
		if @marca.text[0,2].upcase == "IT"
			@combonazorig.set_active(0)
			@combonaznas.set_active(0)
			contanaz = -1
			while @combonazorig.active_iter[0] != 24
				contanaz+=1
				@combonazorig.set_active(contanaz)
				@combonaznas.set_active(contanaz)
			end
		elsif @marca.text[0,2].upcase != "IT"
			@combonazorig.set_active(0)
			@combonaznas.set_active(0)
			contanaz = -1
			while @combonazorig.active_iter[2] != @marca.text[0,2].upcase
				contanaz+=1
				@combonazorig.set_active(contanaz)
			end
			if @combonazorig.active_iter[3] == 1
				@combonazorig.set_active(contanaz)
				@combonaznas.set_active(contanaz)
			else
				@combonazorig.set_active(contanaz)
				@combonaznas.set_active(21)
			end
		end
		if @marca.text[0,2].upcase == "IT" and @stallanas.text.upcase == @combo.active_iter[1].upcase #nascita
			x = -1
			@comboing.set_active(0)
			while @comboing.active_iter[0] != 1
				x+=1
				@comboing.set_active(x)
			end
	elsif @marca.text[0,2].upcase != "IT" and @stallanas.text.upcase == @combo.active_iter[1].upcase #prima importazione
		@comboing.set_active(0)
		x = -1
		while @comboing.active_iter[0] != 13
			x+=1
			@comboing.set_active(x)
		end
	else #gli altri casi
		@comboing.set_active(0)
		x = -1
		while @comboing.active_iter[0] != 2
			x+=1
			@comboing.set_active(x)
		end
	end

	rescue Exception => errore
		Avvisoprova.avviso(@finestraingr, "Controllare la marca")
	end
	else
	end
	}

	#Passaggio ai dati del movimento

	bottmoving = Gtk::Button.new("Dati ingresso")
	bottmoving.signal_connect("clicked") {
	begin
	if @nascita.text != nil
		@datanasingl = "20" + @nascita.text[4,2] + @nascita.text[2,2] + @nascita.text[0,2]
	else
	end

	errore = nil

	if @arraypres.include?(@marca.text.upcase) == true
		errore = 1
	else
		@arraypres << @marca.text.upcase
	end

	@nnaz = @combonaznas.active
	if @marca.text == nil or @comborazze.active == -1 or @nascita.text == nil or @combonazorig.active == -1 or @combonaznas.active == -1 or @comboing.active == -1
		Avvisoprova.avviso(@finestraingr, "Mancano dei dati obbligatori.")
		errore = 1
	elsif @marca.text[0,2].upcase == "IT" and @marca.text.length < 14
		Avvisoprova.avviso(@finestraingr, "Marca corta.")
		errore = 1
	elsif @nascita.text.to_i == 0
		Avvisoprova.avviso(@finestraingr, "Data di nascita errata.")
		errore = 1
	elsif Time.parse("#{@datanasingl}") > @giorno
			Avvisoprova.avviso(@finestraingr, "La data di nascita non può essere successiva al giorno odierno.")
			errore = 1
	elsif @marcatura.text != "" and @marcatura.text.to_i != 0
		@datamarcingl = "20" + @marcatura.text[4,2] + @marcatura.text[2,2] + @marcatura.text[0,2]
		if Time.parse("#{@datamarcingl}") < Time.parse("#{@datanasingl}")
			Avvisoprova.avviso(@finestraingr, "La data di marcatura non può essere minore della data di nascita.")
			errore = 1
		else
		end
	elsif @marcatura.text != "" and @marcatura.text.to_i == 0
		Avvisoprova.avviso(@finestraingr, "lettere.")
		errore = 1
	elsif @marcatura.text == "" #or @marcatura.text == 0 	#	elsif @datamod4.text != "" and @datamod4.text.to_i != 0
		@datamarcingl = ""
	end
	rescue Exception => errore
		Avvisoprova.avviso(@finestraingr, "Controllare le date")
	end

	if errore == nil
		@depositoingr = Hash["marca" => @marca.text.upcase, "specie" => @valspecie, "razza" => @comborazze.active_iter[0], "datanascita" => @nascita.text, "stallanascita" => @stallanas.text.upcase, "sesso" => @valsesso, "nazorig" => @combonazorig.active_iter[0], "naznasprimimp" => @combonaznas.active_iter[0], "datamarca" => @marcatura.text, "marcaprec" => @prec.text.upcase, "madre" => @madre.text.upcase, "padre" => @padre.text.upcase, "donatrice" => @don.text.upcase, "libgen" => @libgen.text.upcase, "iscrlibgen" => @valgen, "embryo" => @valembryo, "ingresso" => @comboing.active_iter[0]]
		if @comboing.active_iter[0] == 1
			mascnascita
		elsif	@comboing.active_iter[0] == 13
			mascprimimp
		else
			mascingressi
		end
	end
	}
	boxingrvert.pack_start(bottmoving, false, false, 0)

	# Bottone inserimento consecutivo

	bottinscons = Gtk::Button.new("Inserimento consecutivo")
	bottinscons.signal_connect("clicked") {
	primoins = 1
	errore = 0
	if @primocapo == 1
		labelultima = Gtk::Label.new
		labelultima.set_markup("<b>Ultima marca inserita: #{@depositoingr["marca"]}</b>")
		boxingr2.pack_start(labelultima, false, false, 20)
		bottprossimo = Gtk::Button.new("Inserisci")
		boxingr2.pack_start(bottprossimo, false, false, 5)
		@finestraingr.show_all

		#Bottone inserimento dati del capo in inserimento consecutivo

		bottprossimo.signal_connect("clicked") {
			begin
				errore = 0
				if @arraypres.include?(@marca.text.upcase) == true
					errore = 1
				else
					@arraypres << @marca.text.upcase
				end

				if @nascita.text != nil
					@datanasingl = "20" + @nascita.text[4,2] + @nascita.text[2,2] + @nascita.text[0,2]
				else
				end

				if @marca.text == nil or @marca.text == "" or @comborazze.active == -1 or @nascita.text == nil or @combonazorig.active == -1 or @combonaznas.active == -1 or @comboing.active == -1
					Avvisoprova.avviso(@finestraingr, "Mancano dei dati obbligatori.")
					errore = 1
				elsif @marca.text[0,2].upcase == "IT" and @marca.text.length < 14
					Avvisoprova.avviso(@finestraingr, "Marca corta.")
					errore = 1
				elsif @nascita.text.to_i == 0
					Avvisoprova.avviso(@finestraingr, "Data di nascita errata.")
					errore = 1
				elsif Time.parse("#{@datanasingl}") > @giorno
					Avvisoprova.avviso(@finestraingr, "La data di nascita non può essere successiva al giorno odierno.")
					errore = 1
				elsif Time.parse("#{@datanasingl}") > Time.parse("#{@depositoingr["dataingr"]}")
					Avvisoprova.avviso(@finestraingr, "La data di nascita non può essere successiva alla data di ingresso.")
					errore = 1
				elsif @marcatura.text != "" and @marcatura.text.to_i != 0
					@datamarcingl = "20" + @marcatura.text[4,2] + @marcatura.text[2,2] + @marcatura.text[0,2]
					if Time.parse("#{@datamarcingl}") < Time.parse("#{@datanasingl}")
						Avvisoprova.avviso(@finestraingr, "La data di marcatura non può essere minore della data di nascita.")
						errore = 1
					else
					end
				elsif @marcatura.text != "" and @marcatura.text.to_i == 0
					Avvisoprova.avviso(@finestraingr, "lettere.")
					errore = 1
				elsif @marcatura.text == ""
					@datamarcingl = ""
				end

				if errore == 0
					@depositoingr["marca"] = @marca.text.upcase
					@depositoingr["specie"] = @valspecie
					@depositoingr["razza"] = @comborazze.active_iter[0]
					@depositoingr["datanascita"] = @nascita.text
					@depositoingr["stallanascita"] = @stallanas.text.upcase
					@depositoingr["sesso"] = @valsesso
					@depositoingr["nazorig"] = @combonazorig.active_iter[0]
					@depositoingr["naznasprimimp"] = @combonaznas.active_iter[0]
					@depositoingr["datamarca"] = @marcatura.text
					@depositoingr["marcaprec"] = @prec.text.upcase
					@depositoingr["madre"] = @madre.text.upcase
					@depositoingr["padre"] = @padre.text.upcase
					@depositoingr["donatrice"] = @don.text.upcase
					@depositoingr["libgen"] = @libgen.text.upcase
					@depositoingr["iscrlibgen"] = @valgen
					@depositoingr["embryo"] = @valembryo

					Animals.create(:relaz_id => "#{@stallaoper.to_i}", :tipo => "I", :cm_ing => "#{@depositoingr["ingresso"]}", :marca => "#{@marca.text.upcase}", :specie=> "#{@valspecie}", :razza_id => "#{@comborazze.active_iter[0]}", :data_nas => "#{@datanasingl.to_i}", :stalla_nas => "#{@stallanas.text.upcase}", :sesso => "#{@valsesso}", :naz_orig => "#{@combonazorig.active_iter[2]}", :naz_nasprimimp => "#{@combonaznas.active_iter[2]}", :data_applm => "#{@datamarcingl.to_i}", :ilg => "#{@valgen}", :embryo => "#{@valembryo}", :marca_prec => "#{@prec.text.upcase}", :marca_madre => "#{@madre.text.upcase}", :marca_padre => "#{@padre.text.upcase}", :donatrice => "#{@don.text.upcase}", :clg => "#{@libgen.text.upcase}", :data_ingr => "#{@depositoingr["dataingr"]}", :naz_prov => "#{@depositoingr["nazprov"]}", :certsan => "#{@depositoingr["certsan"]}", :rifloc => "#{@depositoingr["rifloc"]}", :allevamenti_id => "#{@depositoingr["idallprov"]}", :stalla_prov => "#{@depositoingr["stallaprov"]}", :idfiscprov => "#{@depositoingr["idfiscprov"]}", :cod317prov => "#{@depositoingr["cod317prov"]}", :mod4 => "#{@depositoingr["mod4"]}", :data_mod4 => "#{@depositoingr["datamod4"]}")
					labelultima.set_markup("<b>Ultima marca inserita: #{@depositoingr["marca"]}</b>")
					@marca.text = ""
					@containgressi -=1
					@labelingr.text = ("Totale capi da inserire: #{@containgressi}")

				end
			rescue Exception => errore
			Avvisoprova.avviso(@finestraingr, "Controllare le date")
		end
		}

		@comborazze.set_active(0)
		contarazze = -1
		while @comborazze.active_iter[0] != @depositoingr["razza"]
			contarazze+=1
			@comborazze.set_active(contarazze)
		end
		@nascita.text = @depositoingr["datanascita"]
		@stallanas.text = @depositoingr["stallanascita"]
		@combonazorig.set_active(0)
		contanazorig = -1
		while @combonazorig.active_iter[0] != @depositoingr["nazorig"] #and @combonaznas.active_iter[0] != 24
			contanazorig+=1
			@combonazorig.set_active(contanazorig)
		end
		@combonaznas.set_active(0)
		contanaznas = -1
		while @combonaznas.active_iter[0] != @depositoingr["naznasprimimp"] #and @combonaznas.active_iter[0] != 24
			contanaznas+=1
			@combonaznas.set_active(contanaznas)
		end

		@marcatura.text = @depositoingr["datamarca"]
		bottinscons.hide
		bottmoving.hide
		@comboing.hide
	else
		Avvisoprova.avviso(@finestraingr, "Bisogna inserire il primo capo della partita prima di procedere con l'inserimento consecutivo.")
	end
	}

	boxingrvert.pack_start(bottinscons, false, false, 0)
	bottchiudi = Gtk::Button.new("Chiudi finestra")
	bottchiudi.signal_connect("clicked") {
		@primocapo = 0
		@finestraingr.destroy
	}
	boxingrvert.pack_start(bottchiudi, false, false, 0)
	@finestraingr.show_all
end

# Inserimento nascite

def mascnascita
#	begin
	mnascita = Gtk::Window.new("Nascita")
	mnascita.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxingnas1 = Gtk::VBox.new(false, 0)
	boxingnas2 = Gtk::HBox.new(false, 5)
	boxingnas3 = Gtk::HBox.new(false, 5)
	boxingnas4 = Gtk::HBox.new(false, 5)
	boxingnas5 = Gtk::HBox.new(false, 5)
	boxingnas6 = Gtk::HBox.new(false, 5)
	boxingnas7 = Gtk::HBox.new(false, 5)
	boxingnas8 = Gtk::HBox.new(false, 5)
	boxingnas9 = Gtk::HBox.new(false, 5)
	boxingnas1.pack_start(boxingnas2, false, false, 5)
	boxingnas1.pack_start(boxingnas3, false, false, 5)
	boxingnas1.pack_start(boxingnas4, false, false, 5)
	boxingnas1.pack_start(boxingnas5, false, false, 5)
	boxingnas1.pack_start(boxingnas6, false, false, 5)
	boxingnas1.pack_start(boxingnas7, false, false, 5)
	boxingnas1.pack_start(boxingnas8, false, false, 5)
	boxingnas1.pack_start(boxingnas9, false, false, 5)
	mnascita.add(boxingnas1)

	#Data ingresso

	labeldataing = Gtk::Label.new("Data ingresso (GGMMAA):")
	boxingnas3.pack_start(labeldataing, false, false, 5)
	@dataing = Gtk::Entry.new()
	@dataing.max_length=(6)
	boxingnas3.pack_start(@dataing, false, false, 5)

	#Nazione provenienza

	labelnazprov = Gtk::Label.new("Nazione di provenienza:")
	boxingnas5.pack_start(labelnazprov, false, false, 5)
	listanazprov = Gtk::ListStore.new(Integer, String, String)
	selnazprov = Nations.find(:all)
	selnazprov.each do |np|
		iter1 = listanazprov.append
		iter1[0] = np.id.to_i
		iter1[1] = np.nome
		iter1[2] = np.codice
	end

	@combonazprov = Gtk::ComboBox.new(listanazprov)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	@combonazprov.pack_start(renderer1,false)
	@combonazprov.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	@combonazprov.pack_start(renderer1,false)
	@combonazprov.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	@combonazprov.pack_start(renderer1,false)
	@combonazprov.set_attributes(renderer1, :text => 2)
	boxingnas5.pack_start(@combonazprov, false, false, 0)

	@dataing.text = @nascita.text
	@combonazprov.set_active(@nnaz) #sensitive=(false)

	#Bottone di inserimento ingressi

	bottinserisci = Gtk::Button.new( "Inserisci" )
	bottinserisci.signal_connect("clicked") {
		begin
		errore = nil
		@dataingingl = "20" + @dataing.text[4,2] + @dataing.text[2,2] + @dataing.text[0,2]
		if @dataing.text.to_i == 0 #and 
			Avvisoprova.avviso(mnascita, "Data di ingresso sbagliata.")
			errore = 1
		elsif Time.parse("#{@dataingingl}") < Time.parse("#{@datanasingl}")
			Avvisoprova.avviso(mnascita, "La data di ingresso non può essere inferiore alla data di nascita.")
			errore = 1
		else
		end

		rescue Exception => errore

			Avvisoprova.avviso(mnascita, "Controllare le date.")
		end
		if errore == nil
			@depositoingr["dataingr"] = @datanasingl.to_i
			@depositoingr["nazprov"] = @combonazprov.active_iter[2]
			allprov = Allevamentis.find(:first, :conditions => "cod317 = '#{@s.stalle.cod317}'")
			@depositoingr["idallprov"] = allprov.id
			Animals.create(:relaz_id => "#{@t.id.to_i}", :tipo => "I", :cm_ing => "#{@comboing.active_iter[0]}", :marca => "#{@marca.text.upcase}", :specie=> "#{@valspecie}", :razza_id => "#{@comborazze.active_iter[0]}", :data_nas => "#{@datanasingl.to_i}", :stalla_nas => "#{@stallanas.text.upcase}", :sesso => "#{@valsesso}", :naz_orig => "#{@combonazorig.active_iter[2]}", :naz_nasprimimp => "#{@combonaznas.active_iter[2]}", :data_applm => "#{@datamarcingl.to_i}", :ilg => "#{@valgen}", :embryo => "#{@valembryo}", :marca_prec => "#{@prec.text.upcase}", :marca_madre => "#{@madre.text.upcase}", :marca_padre => "#{@padre.text.upcase}", :donatrice => "#{@don.text.upcase}", :clg => "#{@libgen.text.upcase}", :data_ingr => "#{@dataingingl.to_i}", :naz_prov => "#{@combonazprov.active_iter[2]}", :allevamenti_id => "#{@depositoingr["idallprov"]}")
			@containgressi -=1
			@labelingr.text = ("Totale capi da inserire: #{@containgressi}")
			mnascita.destroy
			@comborazze.active = -1
			@nascita.text = ""
			@stallanas.text = ""
			@combonazorig.active = -1
			@combonaznas.active = -1
			@marcatura.text = ""
			@prec.text = ""
			@madre.text = ""
			@padre.text = ""
			@don.text = ""
			@libgen.text = ""
			@marca.text = ""
			@primocapo = 1
			@finestraingr.present
		else
		end
	}

	boxingnas1.pack_start(bottinserisci, false, false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi senza salvare" )
	bottchiudi.signal_connect("clicked") {
		mnascita.destroy
		@finestraingr.present
	}
	boxingnas1.pack_start(bottchiudi, false, false, 0)
	mnascita.show_all
end

# Inserimento prima importazione

def mascprimimp
#	begin
	mprimimp = Gtk::Window.new("Prima importazione")
	mprimimp.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxprimimp1 = Gtk::VBox.new(false, 0)
	boxprimimp2 = Gtk::HBox.new(false, 5)
	boxprimimp3 = Gtk::HBox.new(false, 5)
	boxprimimp4 = Gtk::HBox.new(false, 5)
	boxprimimp5 = Gtk::HBox.new(false, 5)
	boxprimimp6 = Gtk::HBox.new(false, 5)
	boxprimimp7 = Gtk::HBox.new(false, 5)
	boxprimimp8 = Gtk::HBox.new(false, 5)
	boxprimimp9 = Gtk::HBox.new(false, 5)
	boxprimimp1.pack_start(boxprimimp2, false, false, 5)
	boxprimimp1.pack_start(boxprimimp3, false, false, 5)
	boxprimimp1.pack_start(boxprimimp4, false, false, 5)
	boxprimimp1.pack_start(boxprimimp5, false, false, 5)
	boxprimimp1.pack_start(boxprimimp6, false, false, 5)
	boxprimimp1.pack_start(boxprimimp7, false, false, 5)
	boxprimimp1.pack_start(boxprimimp8, false, false, 5)
	boxprimimp1.pack_start(boxprimimp9, false, false, 5)
	mprimimp.add(boxprimimp1)

	#Data ingresso

	labeldataing = Gtk::Label.new("Data ingresso (GGMMAA):")
	boxprimimp3.pack_start(labeldataing, false, false, 5)
	@dataing = Gtk::Entry.new()
	@dataing.max_length=(6)
	boxprimimp3.pack_start(@dataing, false, false, 5)

	#Nazione provenienza

	labelnazprov = Gtk::Label.new("Nazione di provenienza:")
	boxprimimp5.pack_start(labelnazprov, false, false, 5)
	listanazprov = Gtk::ListStore.new(Integer, String, String, Integer)
	selnazprov = Nations.find(:all)
	selnazprov.each do |np|
		iter1 = listanazprov.append
		iter1[0] = np.id.to_i
		iter1[1] = np.nome
		iter1[2] = np.codice
		iter1[3] = np.tipo.to_i
	end

	@combonazprov = Gtk::ComboBox.new(listanazprov)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	@combonazprov.pack_start(renderer1,false)
	@combonazprov.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	@combonazprov.pack_start(renderer1,false)
	@combonazprov.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	@combonazprov.pack_start(renderer1,false)
	@combonazprov.set_attributes(renderer1, :text => 2)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	@combonazprov.pack_start(renderer1,false)
	@combonazprov.set_attributes(renderer1, :text => 3)
	boxprimimp5.pack_start(@combonazprov, false, false, 0)

	#Certificato sanitario

	labelcertsan = Gtk::Label.new("Certificato sanitario:")
	boxprimimp7.pack_start(labelcertsan, false, false, 5)
	@certsan = Gtk::Entry.new()
	@certsan.max_length=(7)
	@certsan.width_chars=(7)
	boxprimimp7.pack_start(@certsan, false, false, 5)
	@testocertsan = Gtk::Entry.new
	@testocertsan.width_chars=(21)
	boxprimimp7.pack_start(@testocertsan, false, false, 5)
	@certsan.signal_connect("changed") {
		if @combonazprov.active_iter[3] == 1
			annoing = "20" + @dataing.text[4,2]
			@testocertsan.text=("INTRA." + "#{@combonazprov.active_iter[2]}" + "." + "#{annoing}" + "." + "#{@certsan.text}")
		else
			annoing = "20" + @dataing.text[4,2]
			@testocertsan.text=("CVEDA." + "#{@combonazprov.active_iter[2]}" + "." + "#{annoing}" + "." + "#{@certsan.text}")
		end
	}

	#Numero riferimento locale

	labelrifloc = Gtk::Label.new("Numero riferimento locale:")
	boxprimimp7.pack_start(labelrifloc, false, false, 5)
	@rifloc = Gtk::Entry.new()
	@rifloc.max_length=(20)
	boxprimimp7.pack_start(@rifloc, false, false, 5)

	# Nazione di provenienza

	if @comboing.active_iter[0] == 13
		@combonazprov.set_active(0)
		x = -1
		while @combonazprov.active_iter[2] != @marca.text[0,2].upcase
			x+=1
			@combonazprov.set_active(x)
		end
	end

	#Bottone di inserimento ingressi

	bottinserisci = Gtk::Button.new( "Inserisci" )
	bottinserisci.signal_connect("clicked") {
		begin
		errore = nil
		@dataingingl = "20" + @dataing.text[4,2] + @dataing.text[2,2] + @dataing.text[0,2]
		if @dataing.text.to_i == 0 
			Avvisoprova.avviso(mprimimp, "Data di ingresso sbagliata.")
			errore = 1
		elsif Time.parse("#{@dataingingl}") < Time.parse("#{@datanasingl}")
			Avvisoprova.avviso(mprimimp, "La data di ingresso non può essere inferiore alla data di nascita.")
			errore = 1
		end

		rescue Exception => errore
#			avvisodate
			Avvisoprova.avviso(mprimimp, "Controllare le date.")
		end
		if errore == nil
			@depositoingr["dataingr"] = @dataingingl.to_i
			@depositoingr["nazprov"] = @combonazprov.active_iter[2]
			@depositoingr["certsan"] = @testocertsan.text.upcase
			@depositoingr["rifloc"] = @rifloc.text.upcase
			Animals.create(:relaz_id => "#{@stallaoper.to_i}", :tipo => "I", :cm_ing => "#{@comboing.active_iter[0]}", :marca => "#{@marca.text.upcase}", :specie=> "#{@valspecie}", :razza_id => "#{@comborazze.active_iter[0]}", :data_nas => "#{@datanasingl.to_i}", :stalla_nas => "#{@stallanas.text.upcase}", :sesso => "#{@valsesso}", :naz_orig => "#{@combonazorig.active_iter[2]}", :naz_nasprimimp => "#{@combonaznas.active_iter[2]}", :data_applm => "#{@datamarcingl.to_i}", :ilg => "#{@valgen}", :embryo => "#{@valembryo}", :marca_prec => "#{@prec.text.upcase}", :marca_madre => "#{@madre.text.upcase}", :marca_padre => "#{@padre.text.upcase}", :donatrice => "#{@don.text.upcase}", :clg => "#{@libgen.text.upcase}", :data_ingr => "#{@dataingingl.to_i}", :naz_prov => "#{@combonazprov.active_iter[2]}", :certsan => "#{@testocertsan.text.upcase}", :rifloc => "#{@rifloc.text.upcase}")
			@containgressi -=1
			@labelingr.text = ("Totale capi da inserire: #{@containgressi}")
			mprimimp.destroy
			@comborazze.active = -1
			@nascita.text = ""
			@stallanas.text = ""
			@combonazorig.active = -1
			@combonaznas.active = -1
			@marcatura.text = ""
			@prec.text = ""
			@madre.text = ""
			@padre.text = ""
			@don.text = ""
			@libgen.text = ""
			@marca.text = ""
			@primocapo = 1
			@finestraingr.present
			@sesso1.active=(true)
			@valsesso="M"
		else
		end
	}

	boxprimimp1.pack_start(bottinserisci, false, false, 0)

	bottchiudi = Gtk::Button.new( "Chiudi senza salvare" )
	bottchiudi.signal_connect("clicked") {
		mprimimp.destroy
		@finestraingr.present
	}
	boxprimimp1.pack_start(bottchiudi, false, false, 0)

	mprimimp.show_all
end

#Maschera dati movimento d'ingresso generica

def mascingressi
#	begin
	mingressi = Gtk::Window.new("Compravendita e altro")
	mingressi.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxing1 = Gtk::VBox.new(false, 0)
	boxing2 = Gtk::HBox.new(false, 5)
	boxing3 = Gtk::HBox.new(false, 5)
	boxing4 = Gtk::HBox.new(false, 5)
	boxing5 = Gtk::HBox.new(false, 5)
	boxing6 = Gtk::HBox.new(false, 5)
	boxing7 = Gtk::HBox.new(false, 5)
	boxing8 = Gtk::HBox.new(false, 5)
	boxing9 = Gtk::HBox.new(false, 5)
	boxing1.pack_start(boxing2, false, false, 5)
	boxing1.pack_start(boxing3, false, false, 5)
	boxing1.pack_start(boxing4, false, false, 5)
	boxing1.pack_start(boxing5, false, false, 5)
	boxing1.pack_start(boxing6, false, false, 5)
	boxing1.pack_start(boxing7, false, false, 5)
	boxing1.pack_start(boxing8, false, false, 5)
	boxing1.pack_start(boxing9, false, false, 5)
	mingressi.add(boxing1)

	#Data ingresso

	labeldataing = Gtk::Label.new("Data ingresso (GGMMAA):")
	boxing3.pack_start(labeldataing, false, false, 5)
	@dataing = Gtk::Entry.new()
	@dataing.max_length=(6)
	boxing3.pack_start(@dataing, false, false, 5)

	#Allevamento / mercato di provenienza

	labelallevprov = Gtk::Label.new("Codice allevamento / mercato di provenienza:")
	boxing4.pack_start(labelallevprov, false, false, 5)
	listallprov = Gtk::ListStore.new(Integer, String, String, String)
	selallprov = Allevamentis.find(:all)
	selallprov.each do |allprov|
		iterallprov = listallprov.append
		iterallprov[0] = allprov.id
		iterallprov[1] = allprov.ragsoc
		iterallprov[2] = allprov.if
		iterallprov[3] = allprov.cod317
	end

	@comboallprov = Gtk::ComboBox.new(listallprov)

	@comboallprov.signal_connect("changed") {
		if @comboallprov.active != -1
			@idfiscp.text = ("#{@comboallprov.active_iter[2]}")
		else
			@idfiscp.text = ("")
		end
	}

	rendering = Gtk::CellRendererText.new
	rendering.visible=(false)
	@comboallprov.pack_start(rendering,false)
	@comboallprov.set_attributes(rendering, :text => 0)
	rendering = Gtk::CellRendererText.new
	@comboallprov.pack_start(rendering,false)
	@comboallprov.set_attributes(rendering, :text => 1)
	rendering = Gtk::CellRendererText.new
	rendering.visible=(false)
	@comboallprov.pack_start(rendering,false)
	@comboallprov.set_attributes(rendering, :text => 2)
	rendering = Gtk::CellRendererText.new
	@comboallprov.pack_start(rendering,false)
	@comboallprov.set_attributes(rendering, :text => 3)
	boxing4.pack_start(@comboallprov, false, false, 5)

	#Inserimento nuovo allevamento
	
	nallev = Gtk::Button.new("Nuovo allevamento")
	nallev.signal_connect( "released" ) { mascallevam }
	boxing4.pack_start(nallev, false, false, 5)

	#Nazione provenienza

	labelnazprov = Gtk::Label.new("Nazione di provenienza:")
	boxing5.pack_start(labelnazprov, false, false, 5)
	listanazprov = Gtk::ListStore.new(Integer, String, String)
	selnazprov = Nations.find(:all)
	selnazprov.each do |np|
	iter1 = listanazprov.append
	iter1[0] = np.id.to_i
	iter1[1] = np.nome
	iter1[2] = np.codice
	end

	@combonazprov = Gtk::ComboBox.new(listanazprov)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	@combonazprov.pack_start(renderer1,false)
	@combonazprov.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	@combonazprov.pack_start(renderer1,false)
	@combonazprov.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	@combonazprov.pack_start(renderer1,false)
	@combonazprov.set_attributes(renderer1, :text => 2)
	boxing5.pack_start(@combonazprov, false, false, 0)
	@combonazprov.set_active(@nnaz)

	#Modello 4

	labelmod4 = Gtk::Label.new("Modello 4:")
	boxing6.pack_start(labelmod4, false, false, 5)
	@mod4 = Gtk::Entry.new()
	@mod4.max_length=(30)
	boxing6.pack_start(@mod4, false, false, 5)

	#Data modello 4

	labeldatamod4 = Gtk::Label.new("Data Modello 4 (GGMMAA):")
	boxing6.pack_start(labeldatamod4, false, false, 5)
	@datamod4 = Gtk::Entry.new()
	@datamod4.max_length=(6)
	boxing6.pack_start(@datamod4, false, false, 5)

	#Certificato sanitario

	labelcertsan = Gtk::Label.new("Certificato sanitario:")
	boxing7.pack_start(labelcertsan, false, false, 5)
	@certsan = Gtk::Entry.new()
	@certsan.max_length=(7)
	@certsan.width_chars=(7)
	boxing7.pack_start(@certsan, false, false, 5)
	@testocertsan = Gtk::Entry.new
	@testocertsan.width_chars=(21)
	boxing7.pack_start(@testocertsan, false, false, 5)
	@certsan.signal_connect("changed") {
		annoing = "20" + @dataing.text[4,2]
		@testocertsan.text=("INTRA." + "#{@combonazprov.active_iter[2]}" + "." + "#{annoing}" + "." + "#{@certsan.text}")
	}

	#Numero riferimento locale

	labelrifloc = Gtk::Label.new("Numero riferimento locale:")
	boxing7.pack_start(labelrifloc, false, false, 5)
	@rifloc = Gtk::Entry.new()
	@rifloc.max_length=(20)
	boxing7.pack_start(@rifloc, false, false, 5)

	# Identificativo fiscale provenienza

	labelidfiscp = Gtk::Label.new("Identificativo fiscale privenienza:")
	boxing8.pack_start(labelidfiscp, false, false, 5)
	@idfiscp = Gtk::Entry.new()
	@idfiscp.editable=(false)
	boxing8.pack_start(@idfiscp, false, false, 5)

	#Bottone di inserimento ingressi

	bottinserisci = Gtk::Button.new( "Inserisci" )
	bottinserisci.signal_connect("clicked") {
		begin
		errore = nil
		@dataingingl = "20" + @dataing.text[4,2] + @dataing.text[2,2] + @dataing.text[0,2]
		if @dataing.text.to_i == 0 #and 
			Avvisoprova.avviso(mingressi, "Data di ingresso sbagliata.")
			errore = 1
		elsif Time.parse("#{@dataingingl}") < Time.parse("#{@datanasingl}")
			Avvisoprova.avviso(mingressi, "La data di ingresso non può essere inferiore alla data di nascita.")
			errore = 1
		elsif @datamod4.text.to_i == 0 #@datamod4.text != "" and @datamod4.text.to_i == 0 or @datamod4.text == "" #and @datamod4.text.to_i != 0
			Avvisoprova.avviso(mingressi, "Data mod.4 sbagliata.")
			errore = 1
		elsif @datamod4.text != "" and @datamod4.text.to_i != 0
			@datamod4ingl = "20" + @datamod4.text[4,2] + @datamod4.text[2,2] + @datamod4.text[0,2]
				if Time.parse("#{@datamod4ingl}") < Time.parse("#{@dataingingl}")
					Avvisoprova.avviso(mingressi, "La data del mod.4 non può essere inferiore alla data di ingresso.")
					errore = 1
				else
				end
		else
		end
		if @comboallprov.active == -1
			@idallprov = ""
		else
			@idallprov = @comboallprov.active_iter[0]
		end
		rescue Exception => errore
			Avvisoprova.avviso(mingressi, "Controllare le date.")
		end
		if errore == nil
			@depositoingr["dataingr"] = @dataingingl.to_i
			@depositoingr["idallprov"] = @idallprov
			@depositoingr["nazprov"] = @combonazprov.active_iter[2]
			@depositoingr["mod4"] = @mod4.text
			@depositoingr["datamod4"] = @datamod4ingl.to_i
			@depositoingr["certsan"] = @testocertsan.text.upcase
			@depositoingr["rifloc"] = @rifloc.text.upcase

			Animals.create(:relaz_id => "#{@stallaoper.to_i}", :tipo => "I", :cm_ing => "#{@comboing.active_iter[0]}", :marca => "#{@marca.text.upcase}", :specie=> "#{@valspecie}", :razza_id => "#{@comborazze.active_iter[0]}", :data_nas => "#{@datanasingl.to_i}", :stalla_nas => "#{@stallanas.text.upcase}", :sesso => "#{@valsesso}", :naz_orig => "#{@combonazorig.active_iter[2]}", :naz_nasprimimp => "#{@combonaznas.active_iter[2]}", :data_applm => "#{@datamarcingl.to_i}", :ilg => "#{@valgen}", :embryo => "#{@valembryo}", :marca_prec => "#{@prec.text.upcase}", :marca_madre => "#{@madre.text.upcase}", :marca_padre => "#{@padre.text.upcase}", :donatrice => "#{@don.text.upcase}", :clg => "#{@libgen.text.upcase}", :data_ingr => "#{@dataingingl.to_i}", :allevamenti_id => "#{@idallprov}", :naz_prov => "#{@combonazprov.active_iter[2]}", :mod4 => "#{@mod4.text}", :data_mod4 => "#{@datamod4ingl.to_i}", :certsan => "#{@testocertsan.text.upcase}", :rifloc => "#{@rifloc.text.upcase}")

			@containgressi -=1
			@labelingr.text = ("Totale capi da inserire: #{@containgressi}")
			mingressi.destroy
			@comborazze.active = -1
			@nascita.text = ""
			@stallanas.text = ""
			@combonazorig.active = -1
			@combonaznas.active = -1
			@marcatura.text = ""
			@prec.text = ""
			@madre.text = ""
			@padre.text = ""
			@don.text = ""
			@libgen.text = ""
			@marca.text = ""
			@primocapo = 1
			@finestraingr.present
		else
		end
	}

	boxing1.pack_start(bottinserisci, false, false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi senza salvare" )
	bottchiudi.signal_connect("clicked") {
		mingressi.destroy
		@finestraingr.present
	}
	boxing1.pack_start(bottchiudi, false, false, 0)
	mingressi.show_all
end

#Maschera inserimento allevamenti nuovi

def mascallevam
	mallevam = Gtk::Window.new("Nuovo allevamento")
	mallevam.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxmallv = Gtk::VBox.new(false, 0)
	boxmall2 = Gtk::HBox.new(false, 5)
	boxmall3 = Gtk::HBox.new(false, 5)
	boxmall4 = Gtk::HBox.new(false, 5)
	boxmall5 = Gtk::HBox.new(false, 5)
	boxmallv.pack_start(boxmall2, false, false, 5)
	boxmallv.pack_start(boxmall3, false, false, 5)
	boxmallv.pack_start(boxmall4, false, false, 5)
	boxmallv.pack_start(boxmall5, false, false, 5)
	mallevam.add(boxmallv)

	#Nome allevamento

	labelnomeallev = Gtk::Label.new("Nome allevamento:")
	boxmall2.pack_start(labelnomeallev, false, false, 5)
	@nomeallev = Gtk::Entry.new()
	@nomeallev.max_length=(50)
	@nomeallev.width_chars=(50)
	boxmall2.pack_start(@nomeallev, false, false, 5)

	#Identificativo fiscale

	labelidfisc = Gtk::Label.new("Identificativo fiscale:")
	boxmall3.pack_start(labelidfisc, false, false, 5)
	@idfisc = Gtk::Entry.new()
	@idfisc.max_length=(12)
	@idfisc.width_chars=(12)
	boxmall3.pack_start(@idfisc, false, false, 5)

	#Codice 317 stalla

	labelcod317 = Gtk::Label.new("Codice 317 stalla:")
	boxmall4.pack_start(labelcod317, false, false, 5)
	@cod317 = Gtk::Entry.new()
	@cod317.max_length=(8)
	@cod317.width_chars=(8)
	boxmall4.pack_start(@cod317, false, false, 5)

	#Bottone di inserimento

	inserisciall = Gtk::Button.new( "Inserisci allevamento" )
	inserisciall.signal_connect("clicked") {
		@nome=("#{@nomeallev.text}")
		if @nomeallev.text==("") or @idfisc.text==("") or @cod317.text==("")

			Avvisoprova.avviso(mallevam, "Servono tutti i dati.")
		else
			Allevamentis.create(:ragsoc => "#{@nomeallev.text.upcase}", :if => "#{@idfisc.text.upcase}", :cod317 => "#{@cod317.text.upcase}")
			@nomeallev.text=("")
			@idfisc.text=("")
			@cod317.text=("")
		end
	}
	boxmall5.pack_start(inserisciall, false, false, 0)

	#Bottone di chiusura finestra

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mallevam.destroy
	}
	boxmall5.pack_start(bottchiudi, false, false, 0)

	mallevam.show_all

end

#Modifica allevamenti

def modallevamenti
	mmodallevam = Gtk::Window.new("Modifica allevamento")
	mmodallevam.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxmodallevamv = Gtk::VBox.new(false, 0)
	boxmodallev1 = Gtk::HBox.new(false, 5)
	boxmodallev2 = Gtk::HBox.new(false, 5)
	boxmodallev3 = Gtk::HBox.new(false, 5)
	boxmodallev4 = Gtk::HBox.new(false, 5)
	boxmodallev5 = Gtk::HBox.new(false, 5)
	boxmodallevamv.pack_start(boxmodallev1, false, false, 5)
	boxmodallevamv.pack_start(boxmodallev2, false, false, 5)
	boxmodallevamv.pack_start(boxmodallev3, false, false, 5)
	boxmodallevamv.pack_start(boxmodallev4, false, false, 5)
	boxmodallevamv.pack_start(boxmodallev5, false, false, 5)
	mmodallevam.add(boxmodallevamv)

	#Combo di scelta allevamento

	labelallevamento = Gtk::Label.new("Selezona allevamento:")
	boxmodallev1.pack_start(labelallevamento, false, false, 5)

	def caricalista
		@listallev = Gtk::ListStore.new(Integer, String, String, String)
		@listallev.clear
		selallev = Allevamentis.find(:all)
		selallev.each do |a|
			iter1 = @listallev.append
			iter1[0] = a.id.to_i
			iter1[1] = a.ragsoc
			iter1[2] = a.if
			iter1[3] = a.cod317
		end
	end

	caricalista
	@comboallev = Gtk::ComboBox.new(@listallev)
	renderer1 = Gtk::CellRendererText.new
	@comboallev.pack_start(renderer1,false)
	@comboallev.set_attributes(renderer1, :text => 1)
	boxmodallev1.pack_start(@comboallev.popdown, false, false, 0)

	#Nome allevamento

	labelnomeallev = Gtk::Label.new("Nome allevamento:")
	boxmodallev2.pack_start(labelnomeallev, false, false, 5)
	@nomeallev = Gtk::Entry.new()
	@nomeallev.max_length=(50)
	boxmodallev2.pack_start(@nomeallev, false, false, 5)

	#Identificativo fiscale

	labelidfisc = Gtk::Label.new("Identificativo fiscale:")
	boxmodallev3.pack_start(labelidfisc, false, false, 5)
	@idfisc = Gtk::Entry.new()
	@idfisc.max_length=(12)
	boxmodallev3.pack_start(@idfisc, false, false, 5)

	#Codice 317 stalla

	labelcod317 = Gtk::Label.new("Codice 317 stalla:")
	boxmodallev4.pack_start(labelcod317, false, false, 5)
	@cod317 = Gtk::Entry.new()
	@cod317.max_length=(8)
	boxmodallev4.pack_start(@cod317, false, false, 5)

	@comboallev.signal_connect( "changed" ) {
		@nomeallev.text=("#{@comboallev.active_iter[1]}")
		@idfisc.text=("#{@comboallev.active_iter[2]}")
		@cod317.text=("#{@comboallev.active_iter[3]}")
	}

	#Bottone di inserimento

	inserisciall = Gtk::Button.new( "Modifica allevamento" )
	inserisciall.signal_connect("clicked") {
		if @nomeallev.text==("") or @idfisc.text==("") or @cod317.text==("")
			Avvisoprova.avviso(mmodallevam, "Servono tutti i dati.")
		else
			Allevamentis.update(@comboallev.active_iter[0], { :ragsoc => "#{@nomeallev.text.upcase}", :if => "#{@idfisc.text.upcase}", :cod317 => "#{@cod317.text.upcase}"})
			@nomeallev.text=("")
			@idfisc.text=("")
			@cod317.text=("")
			caricalista
			@comboallev.model=(@listallev)
		end
	}
	boxmodallev5.pack_start(inserisciall, false, false, 0)

	#Bottone di annullamento modifiche

	annullacampi = Gtk::Button.new( "Annulla modifiche" )
	annullacampi.signal_connect("clicked") {
		@nomeallev.text=("#{@comboallev.active_iter[1]}")
		@idfisc.text=("#{@comboallev.active_iter[2]}")
		@cod317.text=("#{@comboallev.active_iter[3]}")
	}
	boxmodallev5.pack_start(annullacampi, false, false, 0)

	#Bottone di chiusura finestra

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mmodallevam.destroy
	}
	boxmodallev5.pack_start(bottchiudi, false, false, 0)

	mmodallevam.show_all
end

#Maschera inserimento macelli

def insmacelli
	minsmacelli = Gtk::Window.new("Nuovo macello")
	minsmacelli.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxinsmacv = Gtk::VBox.new(false, 0)
	boxinsmac1 = Gtk::HBox.new(false, 5)
	boxinsmac2 = Gtk::HBox.new(false, 5)
	boxinsmac3 = Gtk::HBox.new(false, 5)
	boxinsmac4 = Gtk::HBox.new(false, 5)
	boxinsmac5 = Gtk::HBox.new(false, 5)
	boxinsmacv.pack_start(boxinsmac1, false, false, 5)
	boxinsmacv.pack_start(boxinsmac2, false, false, 5)
	boxinsmacv.pack_start(boxinsmac3, false, false, 5)
	boxinsmacv.pack_start(boxinsmac4, false, false, 5)
	boxinsmacv.pack_start(boxinsmac5, false, false, 5)
	minsmacelli.add(boxinsmacv)

	#Nome macello

	labelnomemac = Gtk::Label.new("Nome macello:")
	boxinsmac1.pack_start(labelnomemac, false, false, 5)
	@nomemac = Gtk::Entry.new()
	@nomemac.max_length=(50)
	@nomemac.width_chars=(50)
	boxinsmac1.pack_start(@nomemac, false, false, 5)

	#Identificativo fiscale

	labelidfiscmac = Gtk::Label.new("Identificativo fiscale:")
	boxinsmac2.pack_start(labelidfiscmac, false, false, 5)
	@idfiscmac = Gtk::Entry.new()
	@idfiscmac.max_length=(12)
	boxinsmac2.pack_start(@idfiscmac, false, false, 5)

	#Bollo CEE macello

	labelbollomac = Gtk::Label.new("Bollo CEE macello:")
	boxinsmac3.pack_start(labelbollomac, false, false, 5)
	@bollomac = Gtk::Entry.new()
	@bollomac.max_length=(8)
	boxinsmac3.pack_start(@bollomac, false, false, 5)

	#Codice regione

	labelcodreg = Gtk::Label.new("Codice regione macello:")
	boxinsmac4.pack_start(labelcodreg, false, false, 5)
#	@codreg = Gtk::Entry.new()
#	@codreg.max_length=(8)
#	boxinsmac4.pack_start(@codreg, false, false, 5)

		listareg = Gtk::ListStore.new(Integer, String, String)
		selreg = Regions.find(:all)
		selreg.each do |r|
			iter1 = listareg.append
			iter1[0] = r.id.to_i
			iter1[1] = r.codreg
			iter1[2] = r.regione
		end
#	end

	comboreg = Gtk::ComboBox.new(listareg)
	renderer1 = Gtk::CellRendererText.new
	comboreg.pack_start(renderer1,false)
	comboreg.set_attributes(renderer1, :text => 2)
	boxinsmac4.pack_start(comboreg, false, false, 0)

	#Bottone di inserimento

	inseriscimac = Gtk::Button.new( "Inserisci macello" )
	inseriscimac.signal_connect("clicked") {
	@nmac = @nomemac.text
	if @nomemac.text==("") or @idfiscmac.text==("") or @bollomac.text==("") or comboreg.active == -1 # @codreg.text==("")
		Avvisoprova.avviso(minsmacelli, "Servono tutti i dati.")
	else
		Macellis.create(:nomemac => "#{@nomemac.text.upcase}", :ifmac => "#{@idfiscmac.text.upcase}", :bollomac => "#{@bollomac.text.upcase}", :region_id => "#{comboreg.active_iter[0]}")
		@nomemac.text=("")
		@idfiscmac.text=("")
		@bollomac.text=("")
#		@codreg.text=("")
		comboreg.active = -1
	end
	}

	boxinsmac5.pack_start(inseriscimac, false, false, 0)

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		minsmacelli.destroy
	}
	boxinsmac5.pack_start(bottchiudi, false, false, 0)

	minsmacelli.show_all

end

#Maschera modifica macelli

def modmacelli
	mmodmacelli = Gtk::Window.new("Modifica macelli")
	mmodmacelli.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxmodmacv = Gtk::VBox.new(false, 0)
	boxmodmac1 = Gtk::HBox.new(false, 5)
	boxmodmac2 = Gtk::HBox.new(false, 5)
	boxmodmac3 = Gtk::HBox.new(false, 5)
	boxmodmac4 = Gtk::HBox.new(false, 5)
	boxmodmac5 = Gtk::HBox.new(false, 5)
	boxmodmac6 = Gtk::HBox.new(false, 5)
	boxmodmacv.pack_start(boxmodmac1, false, false, 5)
	boxmodmacv.pack_start(boxmodmac2, false, false, 5)
	boxmodmacv.pack_start(boxmodmac3, false, false, 5)
	boxmodmacv.pack_start(boxmodmac4, false, false, 5)
	boxmodmacv.pack_start(boxmodmac5, false, false, 5)
	boxmodmacv.pack_start(boxmodmac6, false, false, 5)
	mmodmacelli.add(boxmodmacv)

	#Combo di scelta macello

	labelmacello = Gtk::Label.new("Selezona macello:")
	boxmodmac1.pack_start(labelmacello, false, false, 5)

	def generalista
		@listamac = Gtk::ListStore.new(Integer, String, String, String, Integer)
		selmac = Macellis.find(:all)
		selmac.each do |m|
			iter1 = @listamac.append
			iter1[0] = m.id.to_i
			iter1[1] = m.nomemac
			iter1[2] = m.ifmac
			iter1[3] = m.bollomac
			iter1[4] = m.region_id
		end
	end

	generalista
	combomac = Gtk::ComboBox.new(@listamac)
	renderer1 = Gtk::CellRendererText.new
	combomac.pack_start(renderer1,false)
	combomac.set_attributes(renderer1, :text => 1)
	boxmodmac1.pack_start(combomac, false, false, 0)

	#Nome macello

	labelnomemac = Gtk::Label.new("Nome macello:")
	boxmodmac2.pack_start(labelnomemac, false, false, 5)
	nomemac = Gtk::Entry.new()
	nomemac.max_length=(50)
	nomemac.width_chars=(50)
	boxmodmac2.pack_start(nomemac, false, false, 5)

	#Identificativo fiscale

	labelidfiscmac = Gtk::Label.new("Identificativo fiscale:")
	boxmodmac3.pack_start(labelidfiscmac, false, false, 5)
	idfiscmac = Gtk::Entry.new()
	idfiscmac.max_length=(12)
	boxmodmac3.pack_start(idfiscmac, false, false, 5)

	#Bollo CEE macello

	labelbollomac = Gtk::Label.new("Bollo CEE macello:")
	boxmodmac4.pack_start(labelbollomac, false, false, 5)
	bollomac = Gtk::Entry.new()
	bollomac.max_length=(8)
	boxmodmac4.pack_start(bollomac, false, false, 5)

	#Codice regione

	labelregmac = Gtk::Label.new("Codice regione macello:")
	boxmodmac5.pack_start(labelregmac, false, false, 5)
#	regmac = Gtk::Entry.new()
#	regmac.max_length=(8)
#	boxmodmac5.pack_start(regmac, false, false, 5)

		listaregmac = Gtk::ListStore.new(Integer, String, String)
		selregmac = Regions.find(:all)
		selregmac.each do |r|
			iter1 = listaregmac.append
			iter1[0] = r.id.to_i
			iter1[1] = r.codreg
			iter1[2] = r.regione
		end
#	end

	comboregmac = Gtk::ComboBox.new(listaregmac)
	renderer1 = Gtk::CellRendererText.new
	comboregmac.pack_start(renderer1,false)
	comboregmac.set_attributes(renderer1, :text => 2)

#	comboregmac.set_active(0)
#	contareg = -1
#	while comboregmac.active_iter[0] != combomac.active_iter[4]
#		contareg+=1
#		comboregmac.set_active(contareg)
#	end


	boxmodmac5.pack_start(comboregmac, false, false, 5)


	combomac.signal_connect( "changed" ) {
		nomemac.text=("#{combomac.active_iter[1]}")
		idfiscmac.text=("#{combomac.active_iter[2]}")
		bollomac.text=("#{combomac.active_iter[3]}")
#		regmac.text=("#{combomac.active_iter[4]}")

	comboregmac.set_active(0)
	contareg = -1
	while comboregmac.active_iter[0] != combomac.active_iter[4]
		contareg+=1
		comboregmac.set_active(contareg)
	end
	}

	#Bottone di inserimento

	inseriscimac = Gtk::Button.new( "Modifica macello" )
	inseriscimac.signal_connect("clicked") {
		if nomemac.text==("") or idfiscmac.text==("") or bollomac.text==("") or comboregmac.active == -1
			Avvisoprova.avviso(mmodmacelli, "Servono tutti i dati.")
		else
			Macellis.update(combomac.active_iter[0], {:nomemac => "#{nomemac.text.upcase}", :ifmac => "#{idfiscmac.text.upcase}", :bollomac => "#{bollomac.text.upcase}", :region_id => "#{comboregmac.active_iter[0]}"})
			nomemac.text=("")
			idfiscmac.text=("")
			bollomac.text=("")
#			regmac.text=("")
			comboregmac.active = -1
			generalista
#			comboregmac.active = -1
			combomac.model=(@listamac)
		end
	}

	boxmodmac6.pack_start(inseriscimac, false, false, 0)

	#Bottone di annullamento modifiche

#	annullacampi = Gtk::Button.new( "Annulla modifiche" )
#	annullacampi.signal_connect("clicked") {
#		nomemac.text=("#{combomac.active_iter[1]}")
#		idfiscmac.text=("#{combomac.active_iter[2]}")
#		bollomac.text=("#{combomac.active_iter[3]}")
##		regmac.text=("#{combomac.active_iter[4]}")

#		comboregmac.set_active(0)
#		contareg = -1
#		while comboregmac.active_iter[0] != combomac.active_iter[4]
#			contareg+=1
#			comboregmac.set_active(contareg)
#		end


##		comboregmac.active = -1
#	}

#	boxmodmac6.pack_start(annullacampi, false, false, 0)

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mmodmacelli.destroy
	}
	boxmodmac6.pack_start(bottchiudi, false, false, 0)

	mmodmacelli.show_all

end

# Inserimento trasportatore

def instrasportatori
	minstrasportatori = Gtk::Window.new("Nuovo traportatore")
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
			Avvisoprova.avviso(minstrasportatori, "Servono tutti i dati.")
		else
			Trasportatoris.create(:nometrasp => "#{nometrasp.text.upcase}")
			nometrasp.text=("")
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

def modtrasportatori
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

	def generalista
		@listatrasp = Gtk::ListStore.new(Integer, String)
		seltrasp = Trasportatoris.find(:all)
		seltrasp.each do |t|
			iter1 = @listatrasp.append
			iter1[0] = t.id.to_i
			iter1[1] = t.nometrasp
		end
	end

	generalista
	combotrasp = Gtk::ComboBox.new(@listatrasp)
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
		nometrasp.text=("#{combotrasp.active_iter[1]}")
	}

	#Bottone di inserimento

	inseriscitrasp = Gtk::Button.new( "Modifica trasportatore" )
	inseriscitrasp.signal_connect("clicked") {
		if nometrasp.text==("")
			Avvisoprova.avviso(mmodtrasportatori, "Servono tutti i dati.")
		else
			Trasportatoris.update(combotrasp.active_iter[0], {:nometrasp => "#{nometrasp.text.upcase}"})
			nometrasp.text=("")
			generalista
			combotrasp.model=(@listatrasp)
		end
	}

	boxmodtrasp6.pack_start(inseriscitrasp, false, false, 0)

	#Bottone di annullamento modifiche

	annullacampi = Gtk::Button.new( "Annulla modifiche" )
	annullacampi.signal_connect("clicked") {
		nometrasp.text=("#{combotrasp.active_iter[1]}")
	}

	boxmodtrasp6.pack_start(annullacampi, false, false, 0)

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mmodtrasportatori.destroy
	}
	boxmodtrasp6.pack_start(bottchiudi, false, false, 0)

	mmodtrasportatori.show_all

end

# Maschera scelta capi da far uscire

def mascuscite
	@muscite = Gtk::Window.new("Capi da far uscire")
	@muscite.set_default_size(800, 600)
	@muscite.maximize
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
	@labelselezionati = Gtk::Label.new
	boxuscv.pack_start(boxusc0, false, false, 5)
	boxuscv.pack_start(boxusc3, false, false, 5)
	boxuscv.pack_start(boxusc1, true, true, 0)
	boxuscv.pack_start(boxusc2, false, false, 20)
	boxuscv.pack_start(separator, false, true, 5)
	boxuscv.pack_start(boxusc4, false, false, 10)
	@muscite.add(boxuscv)
	relid = @s.id
	@uscenti = 0
	labelselezione.set_markup("<b>Capi presenti</b>")
	@labelselezionati.set_markup("<b>Capi da far uscire: #{@uscenti}</b>")
	@lista = Gtk::ListStore.new(Integer, String, String, String, Integer, Date, String, String, String, String, Date, String, String, String, String, String, String)
	tutti = Gtk::Button.new("Elenca tutti")
	tutti.signal_connect( "clicked" ) {
		@lista.clear
		selmov = Animals.find(:all, :from => "animals", :conditions => "relaz_id='#{relid}' and tipo = 'I' and uscito = '0'", :order => "data_ingr")
		selmov.each do |m|
			itermov = @lista.append
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

	vista = Gtk::TreeView.new(@lista)
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
	@selezione = vista.selection
	@cerca = Gtk::Entry.new
	@cerca.max_length=(14)
	bottonecerca = Gtk::Button.new("Cerca")
	bottonecerca.signal_connect("clicked") {
		elenca
	}

	vista.signal_connect("row-activated") do |view, path, column|
		trasferisci
	end

	def elenca
		@lista.clear
		selmov = Animals.find(:all, :from => "animals", :conditions => "relaz_id='#{@stallaoper}' and tipo = 'I' and uscito = '0' and marca LIKE '%#{@cerca.text}%'")
		selmov.each do |m|
			itermov = @lista.append
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

	def trasferisci
		@contatore = 0
		caposel = @selezione.selected
		if caposel == nil
			Avvisoprova.avviso(@muscite, "Nessun capo selezionato.")
		else
			path = caposel.path
			if @listasel.iter_first == nil
				@contatore+= 1
				itersel = @listasel.append
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
				@lista.remove(@lista.get_iter(path))
				@uscenti +=1
				@labelselezionati.set_markup("<b>Capi da far uscire: #{@uscenti}</b>")
			else
				confronta = 0
				@listasel.each { |model,path3,iter3|
				if iter3[0]== caposel[0]
					confronta+= 1 
				else
				end
			}
			end
			if confronta == 0
				@contatore += 1
				path = caposel.path
				itersel = @listasel.append
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
				@lista.remove(@lista.get_iter(path))
				@uscenti +=1
				@labelselezionati.set_markup("<b>Capi da far uscire: #{@uscenti}</b>")
			else
			end
		end
	end
	spostasel = Gtk::Button.new( ">>" )
	@listasel = Gtk::ListStore.new(Integer, String, String, String, Integer, Date, String, String, String, String, Date, String, String, String, String)
	spostasel.signal_connect( "clicked" ) {
		trasferisci
	}

	vista2 = Gtk::TreeView.new(@listasel)
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
		caposel2 = selezione2.selected
		if caposel2 == nil
			Avvisoprova.avviso(@muscite, "Nessun capo selezionato.")
		else
			path2 = caposel2.path
			itersel2 = @lista.append
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
			@listasel.remove(@listasel.get_iter(path2))
			@contatore-=1
			@uscenti -=1
			@labelselezionati.set_markup("<b>Capi da far uscire: #{@uscenti}</b>")
		end
	}

	#Motivo uscita

	labelmotivou = Gtk::Label.new("Motivo uscita:")
	boxusc2.pack_start(labelmotivou, false, false, 5)
	listausc = Gtk::ListStore.new(Integer, String)
	selusc = Uscites.find(:all)
	selusc.each do |@usc|
		iteru = listausc.append
		iteru[0] = @usc.codice
		iteru[1] = @usc.descr
	end

	@combousc = Gtk::ComboBox.new(listausc)
	renderusc = Gtk::CellRendererText.new
	@combousc.pack_start(renderusc,false)
	@combousc.set_attributes(renderusc, :text => 1)
	renderusc = Gtk::CellRendererText.new
	renderusc.visible=(false)
	@combousc.pack_start(renderusc,false)
	@combousc.set_attributes(renderusc, :text => 0)
	boxusc2.pack_start(@combousc, false, false, 5)
	bottdatiusc = Gtk::Button.new( "Inserisci movimento di uscita" )
	bottdatiusc.signal_connect( "clicked" ) {
	if @contatore == 0 or nil
			Avvisoprova.avviso(@muscite, "Nessun capo selezionato.")
	else
		if @combousc.active == -1
			Avvisoprova.avviso(@muscite, "Seleziona un movimento di uscita.")
		elsif @combousc.active_iter[0] == 4
			datimorte
		elsif @combousc.active_iter[0] == 9
			datimacellazione
		elsif @combousc.active_iter[0] == 6
			datifurto
		else
			datiuscita
		end
	end
	}
	muscitescroll1.add(vista)
	muscitescroll2.add(vista2)
	boxusc0.pack_start(tutti, false, false, 50)
	boxusc0.pack_start(@cerca, false, false, 5)
	boxusc0.pack_start(bottonecerca, false, false, 5)
	boxusc3.pack_start(labelselezione, true, true, 5)
	boxusc3.pack_start(@labelselezionati, true, true, 5)
	boxusc1.pack_start(muscitescroll1, true, true, 5)
	boxusc1.pack_start(spostasel, false, false, 0)
	boxusc1.pack_start(spostasel2, false, false, 0)
	boxusc1.pack_start(muscitescroll2, true, true, 5)
	boxusc2.pack_start(bottdatiusc, false, false, 0)

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.set_size_request(100, 30)
#	@muscite.set_default_size(800, 600)
	bottchiudi.signal_connect("clicked") {
		@muscite.destroy
	}
	boxusc4.pack_start(bottchiudi, true, false, 0)

	@muscite.show_all
end

def datimorte
	mdatimorte = Gtk::Window.new("Morte")
	mdatimorte.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxuscv = Gtk::VBox.new(false, 0)
	boxusc1 = Gtk::HBox.new(false, 5)
	boxusc2 = Gtk::HBox.new(false, 5)
	boxusc3 = Gtk::HBox.new(false, 5)
	boxusc4 = Gtk::HBox.new(false, 5)
	boxuscv.pack_start(boxusc1, false, false, 5)
	boxuscv.pack_start(boxusc2, false, false, 5)
	boxuscv.pack_start(boxusc3, false, false, 5)
	boxuscv.pack_start(boxusc4, false, false, 5)
	mdatimorte.add(boxuscv)

	#Data uscita

	labeldatausc = Gtk::Label.new("Data uscita (GGMMAA):")
	boxusc1.pack_start(labeldatausc, false, false, 5)
	@datausc = Gtk::Entry.new()
	@datausc.max_length =(6)
	boxusc1.pack_end(@datausc, false, false, 5)

	# Certificato sanitario uscita

	labelcertsanusc = Gtk::Label.new("Certificato sanitario:")
	boxusc2.pack_start(labelcertsanusc, false, false, 5)
	@certsanusc = Gtk::Entry.new()
	boxusc2.pack_end(@certsanusc, false, false, 5)

	# Data certificato sanitario

	labeldatacertsanusc = Gtk::Label.new("Data Certificato Sanitario (GGMMAA):")
	boxusc3.pack_start(labeldatacertsanusc, false, false, 5)
	@datacertsanusc = Gtk::Entry.new()
	@datacertsanusc.max_length=(6)
	boxusc3.pack_end(@datacertsanusc, false, false, 5)

	#Bottone di inserimento uscite

	bottmovusc = Gtk::Button.new( "Inserisci" )
	bottmovusc.signal_connect("clicked") {
		begin
		errore = nil
		if @datausc.text == "" or @certsanusc.text == "" or @datacertsanusc.text == ""
			Avvisoprova.avviso(mdatimorte, "Mancano dati: morte.")
			errore = 1
		elsif @datausc.text.to_i == 0
			Avvisoprova.avviso(mdatimorte, "Data uscita errata.")
			errore = 1
		elsif @datacertsanusc.text.to_i == 0
			Avvisoprova.avviso(mdatimorte, "Data certificato sanitario errata.")
			errore = 1
		else
			@datauscingl = "20" + @datausc.text[4,2] + @datausc.text[2,2] + @datausc.text[0,2]
			Time.parse("#{@datauscingl}")
			@datacertsanuscingl = "20" + @datacertsanusc.text[4,2] + @datacertsanusc.text[2,2] + @datacertsanusc.text[0,2]
			Time.parse("#{@datacertsanuscingl}")
			if Time.parse("#{@datacertsanuscingl}") < Time.parse("#{@datauscingl}")
				Avvisoprova.avviso(mdatimorte, "La data del certificato sanitario non può essere inferiore a quella di uscita.")
				errore = 1
			else
			end
		end
		rescue Exception => errore
			Avvisoprova.avviso(mdatimorte, "Controllare le date")
		end
	if errore == nil
		@listasel.each do |model,path,iter|
			marcauscid = iter[0]
			marcausc = iter[2]
			specieusc = iter[3]
			razzausc = iter[4]
			nascitausc = iter[5]
			cod317nasusc = iter[6]
			sessousc = iter[7]
			nazorigusc = iter[8]
			nazprimimpusc = iter[9]
			datamarcausc = iter[10]
			ilgusc = iter[11]
			marcaprecedenteusc = iter[12]
			madreusc = iter[13]
			padreusc = iter[14]
			Animals.create(:relaz_id => "#{@stallaoper.to_i}", :tipo => "U", :cm_usc => "#{@combousc.active_iter[0]}", :marca => "#{marcausc}", :specie => "#{specieusc}", :razza_id => "#{razzausc}", :data_nas => "#{nascitausc}", :stalla_nas => "#{cod317nasusc}", :sesso => "#{sessousc}", :naz_orig => "#{nazorigusc}", :naz_nasprimimp => "#{nazprimimpusc}", :data_applm => "#{datamarcausc}", :ilg => "#{ilgusc}", :marca_prec => "#{marcaprecedenteusc}", :marca_madre => "#{madreusc}", :marca_padre => "#{padreusc}", :uscita => "#{@datauscingl}", :certsanusc => "#{@certsanusc.text}", :data_certsanusc => "#{@datacertsanuscingl.to_i}")
			Animals.update(marcauscid, { :uscito => "1"})
		end
		Conferma.conferma(mdatimorte, "Capi usciti correttamente.")
		mdatimorte.destroy
		@muscite.destroy
		@window.present
	else
	end
	}

	boxusc4.pack_start(bottmovusc, false, false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mdatimorte.destroy
	}
	boxusc4.pack_start(bottchiudi, false, false, 0)
	mdatimorte.show_all
end

# Uscita per macellazione

def datimacellazione
	mdatimacellazione = Gtk::Window.new("Macellazione")
	mdatimacellazione.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxuscv = Gtk::VBox.new(false, 0)
	boxusc1 = Gtk::HBox.new(false, 5)
	boxusc2 = Gtk::HBox.new(false, 5)
	boxusc3 = Gtk::HBox.new(false, 5)
	boxusc4 = Gtk::HBox.new(false, 5)
	boxusc5 = Gtk::HBox.new(false, 5)
	boxusc6 = Gtk::HBox.new(false, 5)
	boxusc7 = Gtk::HBox.new(false, 5)
	boxusc8 = Gtk::HBox.new(false, 5)
	boxusc9 = Gtk::HBox.new(false, 5)
	boxusc10 = Gtk::HBox.new(false, 5)
	boxuscv.pack_start(boxusc1, false, false, 5)
	boxuscv.pack_start(boxusc2, false, false, 5)
	boxuscv.pack_start(boxusc3, false, false, 5)
	boxuscv.pack_start(boxusc4, false, false, 5)
	boxuscv.pack_start(boxusc5, false, false, 5)
	boxuscv.pack_start(boxusc6, false, false, 5)
	boxuscv.pack_start(boxusc7, false, false, 5)
	boxuscv.pack_start(boxusc8, false, false, 5)
	boxuscv.pack_start(boxusc9, false, false, 5)
	boxuscv.pack_start(boxusc10, false, false, 5)
	mdatimacellazione.add(boxuscv)

	#Data uscita

	labeldatausc = Gtk::Label.new("Data uscita (GGMMAA):")
	boxusc2.pack_start(labeldatausc, false, false, 5)
	@datausc = Gtk::Entry.new()
	@datausc.max_length =(6)
	boxusc2.pack_start(@datausc, false, false, 5)

	#Nazione destinazione

	labelnazdest = Gtk::Label.new("Nazione di destinazione:")
	boxusc4.pack_start(labelnazdest, false, false, 5)
	listanazdest = Gtk::ListStore.new(Integer, String, String)
	selnazdest = Nations.find(:all)
	selnazdest.each do |nd|
		iter1 = listanazdest.append
		iter1[0] = nd.id.to_i
		iter1[1] = nd.nome
		iter1[2] = nd.codice
	end

	@combonazdest = Gtk::ComboBox.new(listanazdest)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	@combonazdest.pack_start(renderer1,false)
	@combonazdest.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	@combonazdest.pack_start(renderer1,false)
	@combonazdest.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	@combonazdest.pack_start(renderer1,false)
	@combonazdest.set_attributes(renderer1, :text => 2)
	boxusc4.pack_start(@combonazdest, false, false, 0)

	#Macello di destinazione

	labelmacdest = Gtk::Label.new("Codice macello di destinazione:")
	boxusc5.pack_start(labelmacdest, false, false, 5)
	listamacdest = Gtk::ListStore.new(Integer, String, String, String)
	selmacdest = Macellis.find(:all)
	selmacdest.each do |macdest|
		itermacdest = listamacdest.append
		itermacdest[0] = macdest.id
		itermacdest[1] = macdest.nomemac
		itermacdest[2] = macdest.bollomac
		itermacdest[3] = macdest.region.regione
	end

	@combomacdest = Gtk::ComboBox.new(listamacdest)
	rendermac = Gtk::CellRendererText.new
	rendermac.visible=(false)
	@combomacdest.pack_start(rendermac,false)
	@combomacdest.set_attributes(rendermac, :text => 0)
	rendermac = Gtk::CellRendererText.new
	@combomacdest.pack_start(rendermac,false)
	@combomacdest.set_attributes(rendermac, :text => 1)
	rendermac = Gtk::CellRendererText.new
	@combomacdest.pack_start(rendermac,false)
	@combomacdest.set_attributes(rendermac, :text => 2)
	rendermac = Gtk::CellRendererText.new
	@combomacdest.pack_start(rendermac,false)
	@combomacdest.set_attributes(rendermac, :text => 3)
	boxusc5.pack_start(@combomacdest, false, false, 5)

	# Inserimento nuovo macello

	nmac = Gtk::Button.new("Nuovo macello")
	nmac.signal_connect( "released" ) { insmacelli }
	boxusc5.pack_start(nmac, false, false, 5)

	# Nome trasportatore

	labeltrasp = Gtk::Label.new("Nome trasportatore:")
	boxusc6.pack_start(labeltrasp, false, false, 5)
	listatrasp = Gtk::ListStore.new(Integer, String)
	seltrasp = Trasportatoris.find(:all)
	seltrasp.each do |trasp|
		itertrasp = listatrasp.append
		itertrasp[0] = trasp.id
		itertrasp[1] = trasp.nometrasp
	end

	@combotrasp = Gtk::ComboBox.new(listatrasp)
	rendertrasp = Gtk::CellRendererText.new
	rendertrasp.visible=(false)
	@combotrasp.pack_start(rendertrasp,false)
	@combotrasp.set_attributes(rendertrasp, :text => 0)
	rendertrasp = Gtk::CellRendererText.new
	@combotrasp.pack_start(rendertrasp,false)
	@combotrasp.set_attributes(rendertrasp, :text => 1)
	boxusc6.pack_start(@combotrasp, false, false, 5)

	#Inserimento nuovo trasportatore

	ntrasp = Gtk::Button.new("Nuovo trasportatore")
	ntrasp.signal_connect( "released" ) { instrasportatori }
	boxusc6.pack_start(ntrasp, false, false, 5)

	# Modello 4

	labelmod4usc = Gtk::Label.new("Modello 4:")
	boxusc8.pack_start(labelmod4usc, false, false, 5)
	@mod4usc = Gtk::Entry.new()
	progmod4 = @s.contatori.mod4usc.split("/")
	progmod41 = progmod4[0].to_i
	anno = @giorno.strftime("%y")
		if progmod4[1].to_i == anno.to_i
			progmod41 += 1
			annoreg = progmod4[1]
		else
			progmod41 = 1
			annoreg = anno
		end
	@mod4usc.text = ("#{progmod41}")
	boxusc8.pack_start(@mod4usc, false, false, 5)

	# Data modello 4

	labeldatamod4usc = Gtk::Label.new("Data Modello 4 (GGMMAA):")
	boxusc8.pack_start(labeldatamod4usc, false, false, 5)
	@datamod4usc = Gtk::Entry.new()
	@datamod4usc.max_length=(6)
	boxusc8.pack_start(@datamod4usc, false, false, 5)

	@combonazdest.set_active(0)
	@z = -1
	while @combonazdest.active_iter[0] != 24
		@z+=1
		@combonazdest.set_active(@z)
	end

	#Bottone di inserimento uscite

	bottmovusc = Gtk::Button.new( "Inserisci" )
	bottmovusc.signal_connect("clicked") {
		begin
			errore = nil
			if @datausc.text == "" or @combomacdest.active_iter == -1 or @combotrasp.active_iter == -1 or @mod4usc.text == "" or @datamod4usc.text == ""
				Avvisoprova.avviso(mdatimacellazione, "Mancano dati.")
				errore = 1
			elsif @datausc.text.to_i == 0 or @datamod4usc.text.to_i == 0
				Avvisoprova.avviso(mdatimacellazione, "Date errate.")
				errore = 1
			else
				@datauscingl = "20" + @datausc.text[4,2] + @datausc.text[2,2] + @datausc.text[0,2]
				Time.parse("#{@datauscingl}")
				@datamod4uscingl = "20" + @datamod4usc.text[4,2] + @datamod4usc.text[2,2] + @datamod4usc.text[0,2]
				Time.parse("#{@datamod4uscingl}")
				if Time.parse("#{@datamod4uscingl}") < Time.parse("#{@datauscingl}")
					Avvisoprova.avviso(mdatimacellazione, "La data del modello 4 non può essere inferiore a quella di uscita.")
					errore = 1
				else
				end
			end
		rescue Exception => errore
			Avvisoprova.avviso(mdatimacellazione, "Controllare le date")
		end
	if errore == nil
		@valcombonazdest = @combonazdest.active_iter[2]
		@valcombomacdest = @combomacdest.active_iter[0]
		@valcombotrasp = @combotrasp.active_iter[1]
		@listasel.each do |model,path,iter|

			marcauscid = iter[0]
			marcausc = iter[2]
			specieusc = iter[3]
			razzausc = iter[4]
			nascitausc = iter[5]
			cod317nasusc = iter[6]
			sessousc = iter[7]
			nazorigusc = iter[8]
			nazprimimpusc = iter[9]
			datamarcausc = iter[10]
			ilgusc = iter[11]
			marcaprecedenteusc = iter[12]
			madreusc = iter[13]
			padreusc = iter[14]

			Animals.create(:relaz_id => "#{@stallaoper.to_i}", :tipo => "U", :cm_usc => "#{@combousc.active_iter[0]}", :marca => "#{marcausc}", :specie => "#{specieusc}", :razza_id => "#{razzausc}", :data_nas => "#{nascitausc}", :stalla_nas => "#{cod317nasusc}", :sesso => "#{sessousc}", :naz_orig => "#{nazorigusc}", :naz_nasprimimp => "#{nazprimimpusc}", :data_applm => "#{datamarcausc}", :ilg => "#{ilgusc}", :marca_prec => "#{marcaprecedenteusc}", :marca_madre => "#{madreusc}", :marca_padre => "#{padreusc}", :uscita => "#{@datauscingl}", :naz_dest => "#{@valcombonazdest}", :macelli_id => "#{@valcombomacdest}", :trasp => "#{@valcombotrasp}", :mod4 => "#{@s.stalle.cod317}/#{@giorno.strftime("%Y")}/#{@mod4usc.text}", :data_mod4 => "#{@datamod4uscingl.to_i}")
			Animals.update(marcauscid, { :uscito => "1"})
		end
		Contatoris.update(@s.contatori.id, { :mod4usc => "#{@mod4usc.text}/#{annoreg}"})
		Conferma.conferma(mdatimacellazione, "Capi usciti correttamente.")
		mdatimacellazione.destroy
		@muscite.destroy
		@window.present
	else
	end
	}
	boxusc10.pack_start(bottmovusc, false, false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mdatimacellazione.destroy
		@muscite.present
	}
	boxusc10.pack_start(bottchiudi, false, false, 0)
	mdatimacellazione.show_all
end

# Uscita per furto

def datifurto
	mdatifurto = Gtk::Window.new("Furto")
	mdatifurto.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxuscv = Gtk::VBox.new(false, 0)
	boxusc1 = Gtk::HBox.new(false, 5)
	boxusc2 = Gtk::HBox.new(false, 5)
	boxuscv.pack_start(boxusc1, false, false, 5)
	boxuscv.pack_start(boxusc2, false, false, 5)
	mdatifurto.add(boxuscv)

	#Data uscita

	labeldatausc = Gtk::Label.new("Data uscita (GGMMAA):")
	boxusc1.pack_start(labeldatausc, false, false, 5)
	@datausc = Gtk::Entry.new()
	@datausc.max_length =(6)
	boxusc1.pack_start(@datausc, false, false, 5)

	#Bottone di inserimento uscite

	bottmovusc = Gtk::Button.new( "Inserisci" )
	bottmovusc.signal_connect("clicked") {
		begin
			errore = nil
			if @datausc.text == ""
				Avvisoprova.avviso(mdatifurto, "Mancano dati.")
				errore = 1
			elsif @datausc.text.to_i == 0
				Avvisoprova.avviso(mdatifurto, "Data uscita errata.")
				errore = 1
			else
				@datauscingl = "20" + @datausc.text[4,2] + @datausc.text[2,2] + @datausc.text[0,2]
				Time.parse("#{@datauscingl}")
			end
		rescue Exception => errore
			Avvisoprova.avviso(mdatifurto, "Controllare le date")
		end
		if errore == nil
			@listasel.each do |model,path,iter|
				marcauscid = iter[0]
				marcausc = iter[2]
				specieusc = iter[3]
				razzausc = iter[4]
				nascitausc = iter[5]
				cod317nasusc = iter[6]
				sessousc = iter[7]
				nazorigusc = iter[8]
				nazprimimpusc = iter[9]
				datamarcausc = iter[10]
				ilgusc = iter[11]
				marcaprecedenteusc = iter[12]
				madreusc = iter[13]
				padreusc = iter[14]
				Animals.create(:relaz_id => "#{@stallaoper.to_i}", :tipo => "U", :cm_usc => "#{@combousc.active_iter[0]}", :marca => "#{marcausc}", :specie => "#{specieusc}", :razza_id => "#{razzausc}", :data_nas => "#{nascitausc}", :stalla_nas => "#{cod317nasusc}", :sesso => "#{sessousc}", :naz_orig => "#{nazorigusc}", :naz_nasprimimp => "#{nazprimimpusc}", :data_applm => "#{datamarcausc}", :ilg => "#{ilgusc}", :marca_prec => "#{marcaprecedenteusc}", :marca_madre => "#{madreusc}", :marca_padre => "#{padreusc}", :uscita => "#{@datauscingl}")
				Animals.update(marcauscid, { :uscito => "1"})
			end
		Conferma.conferma(mdatifurto, "Capi usciti correttamente.")
			mdatifurto.destroy
			@muscite.destroy
			@window.present
		else
		end
	}
	boxusc2.pack_start(bottmovusc, false, false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mdatifurto.destroy
		@muscite.present
	}
	boxusc2.pack_start(bottchiudi, false, false, 0)

	mdatifurto.show_all

end

# Inserimento dei dati di uscita dei capi

def datiuscita
	mdatiuscita = Gtk::Window.new("Compravendita o altro")
	mdatiuscita.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxuscv = Gtk::VBox.new(false, 0)
	boxusc1 = Gtk::HBox.new(false, 5)
	boxusc2 = Gtk::HBox.new(false, 5)
	boxusc3 = Gtk::HBox.new(false, 5)
	boxusc4 = Gtk::HBox.new(false, 5)
	boxusc5 = Gtk::HBox.new(false, 5)
	boxusc6 = Gtk::HBox.new(false, 5)
	boxusc7 = Gtk::HBox.new(false, 5)
	boxusc8 = Gtk::HBox.new(false, 5)
	boxusc9 = Gtk::HBox.new(false, 5)
	boxusc10 = Gtk::HBox.new(false, 5)
	boxuscv.pack_start(boxusc1, false, false, 5)
	boxuscv.pack_start(boxusc2, false, false, 5)
	boxuscv.pack_start(boxusc3, false, false, 5)
	boxuscv.pack_start(boxusc4, false, false, 5)
	boxuscv.pack_start(boxusc5, false, false, 5)
	boxuscv.pack_start(boxusc6, false, false, 5)
	boxuscv.pack_start(boxusc7, false, false, 5)
	boxuscv.pack_start(boxusc8, false, false, 5)
	boxuscv.pack_start(boxusc9, false, false, 5)
	boxuscv.pack_start(boxusc10, false, false, 5)
	mdatiuscita.add(boxuscv)

	#Data uscita

	labeldatausc = Gtk::Label.new("Data uscita (GGMMAA):")
	boxusc2.pack_start(labeldatausc, false, false, 5)
	@datausc = Gtk::Entry.new()
	@datausc.max_length =(6)
	boxusc2.pack_start(@datausc, false, false, 5)

	#Allevamento / mercato di destinazione

	labelallevdest = Gtk::Label.new("Codice allevamento / mercato di destinazione:")
	boxusc3.pack_start(labelallevdest, false, false, 5)
	listalldest = Gtk::ListStore.new(Integer, String, String, String)
	selalldest = Allevamentis.find(:all)
	selalldest.each do |alldest|
		iteralldest = listalldest.append
		iteralldest[0] = alldest.id
		iteralldest[1] = alldest.ragsoc
		iteralldest[2] = alldest.if
		iteralldest[3] = alldest.cod317
	end
	@comboalldest = Gtk::ComboBox.new(listalldest)
	renderusc = Gtk::CellRendererText.new
	renderusc.visible=(false)
	@comboalldest.pack_start(renderusc,false)
	@comboalldest.set_attributes(renderusc, :text => 0)
	renderusc = Gtk::CellRendererText.new
	@comboalldest.pack_start(renderusc,false)
	@comboalldest.set_attributes(renderusc, :text => 1)
	renderusc = Gtk::CellRendererText.new
	renderusc.visible=(false)
	@comboalldest.pack_start(renderusc,false)
	@comboalldest.set_attributes(renderusc, :text => 2)
	renderusc = Gtk::CellRendererText.new
	@comboalldest.pack_start(renderusc,false)
	@comboalldest.set_attributes(renderusc, :text => 3)
	boxusc3.pack_start(@comboalldest, false, false, 5)

	#Inserimento nuovo allevamento

	nallev = Gtk::Button.new("Nuovo allevamento")
	nallev.signal_connect( "released" ) { mascallevam }
	boxusc3.pack_start(nallev, false, false, 5)

	#Nazione destinazione

	labelnazdest = Gtk::Label.new("Nazione di destinazione:")
	boxusc4.pack_start(labelnazdest, false, false, 5)
	listanazdest = Gtk::ListStore.new(Integer, String, String)
	selnazdest = Nations.find(:all)
	selnazdest.each do |nd|
	iter1 = listanazdest.append
	iter1[0] = nd.id.to_i
	iter1[1] = nd.nome
	iter1[2] = nd.codice
	end
	@combonazdest = Gtk::ComboBox.new(listanazdest)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	@combonazdest.pack_start(renderer1,false)
	@combonazdest.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	@combonazdest.pack_start(renderer1,false)
	@combonazdest.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	@combonazdest.pack_start(renderer1,false)
	@combonazdest.set_attributes(renderer1, :text => 2)
	boxusc4.pack_start(@combonazdest, false, false, 0)
	@combonazdest.set_active(0)
	@z = -1
	while @combonazdest.active_iter[0] != 24
		@z+=1
		@combonazdest.set_active(@z)
	end

	# Nome trasportatore

	labeltrasp = Gtk::Label.new("Nome trasportatore:")
	boxusc6.pack_start(labeltrasp, false, false, 5)
	listatrasp = Gtk::ListStore.new(Integer, String)
	seltrasp = Trasportatoris.find(:all)
	seltrasp.each do |trasp|
		itertrasp = listatrasp.append
		itertrasp[0] = trasp.id
		itertrasp[1] = trasp.nometrasp
	end
	@combotrasp = Gtk::ComboBox.new(listatrasp)
	rendertrasp = Gtk::CellRendererText.new
	rendertrasp.visible=(false)
	@combotrasp.pack_start(rendertrasp,false)
	@combotrasp.set_attributes(rendertrasp, :text => 0)
	rendertrasp = Gtk::CellRendererText.new
	@combotrasp.pack_start(rendertrasp,false)
	@combotrasp.set_attributes(rendertrasp, :text => 1)
	boxusc6.pack_start(@combotrasp, false, false, 5)

	#Inserimento nuovo trasportatore

	ntrasp = Gtk::Button.new("Nuovo trasportatore")
	ntrasp.signal_connect( "released" ) { instrasportatori }
	boxusc6.pack_start(ntrasp, false, false, 5)


	#Marca sostitutiva

	labelmarcasost = Gtk::Label.new("Marca sostitutiva:")
	boxusc7.pack_start(labelmarcasost, false, false, 5)
	@marcasost = Gtk::Entry.new()
	boxusc7.pack_start(@marcasost, false, false, 5)

	# Modello 4

	labelmod4usc = Gtk::Label.new("Modello 4:")
	boxusc8.pack_start(labelmod4usc, false, false, 5)
	@mod4usc = Gtk::Entry.new()
	progmod4 = @s.contatori.mod4usc.split("/")
	progmod41 = progmod4[0].to_i
	anno = @giorno.strftime("%y")
		if progmod4[1].to_i == anno.to_i
			progmod41 += 1
			annoreg = progmod4[1]
		else
			progmod41 = 1
			annoreg = anno
		end
	@mod4usc.text = ("#{progmod41}")
	boxusc8.pack_start(@mod4usc, false, false, 5)

	# Data modello 4

	labeldatamod4usc = Gtk::Label.new("Data Modello 4 (GGMMAA):")
	boxusc8.pack_start(labeldatamod4usc, false, false, 5)
	@datamod4usc = Gtk::Entry.new()
	@datamod4usc.max_length=(6)
	boxusc8.pack_start(@datamod4usc, false, false, 5)

	#Bottone di inserimento uscite

	bottmovusc = Gtk::Button.new( "Inserisci" )
	bottmovusc.signal_connect("clicked") {
		errore = nil
			if @datausc.text == ""
				Avvisoprova.avviso(mdatiuscita, "Mancano dati.")
				errore = 1
			elsif @combousc.active_iter[0] == 3 or 10 or 11 or 16 or 20 or 28 or 29 or 30	# and @comboalldest.active == -1 or @combotrasp.active == -1 or @combonazdest.active == -1 or @mod4usc.text == nil or @datamod4usc.text == nil
				if @comboalldest.active == -1 or @combotrasp.active == -1 or @combonazdest.active == -1 or @mod4usc.text == "" or @datamod4usc.text == ""
					Avvisoprova.avviso(mdatiuscita, "Mancano dati: altri casi.")
					errore = 1
				else
				end
			else
			end
		if errore == nil
			begin
				if @datausc.text.to_i != 0
					@datauscingl = "20" + @datausc.text[4,2] + @datausc.text[2,2] + @datausc.text[0,2]
					Time.parse("#{@datauscingl}")
				else
					Avvisoprova.avviso(mdatiuscita, "Data uscita errata.")
					errore = 1
				end
				if @datamod4usc.text != ""
					if @datamod4usc.text.to_i != 0
						@datamod4uscingl = "20" + @datamod4usc.text[4,2] + @datamod4usc.text[2,2] + @datamod4usc.text[0,2]
						Time.parse("#{@datamod4uscingl}")
					else
						Avvisoprova.avviso(mdatiuscita, "Data mod4 errata.")
						errore = 1
					end
				else
				end
			rescue Exception => errore
				Avvisoprova.avviso(mdatiuscita, "Controllare le date")
			end
		end
	if errore == nil
		if @comboalldest.active == -1 or @comboalldest.sensitive? == false
			@valcomboalldest = ""
		else
			@idalldest = @comboalldest.active_iter[0]
			@valcomboalldest = @comboalldest.active_iter[1]
			@alldestidfisc = @comboalldest.active_iter[2]
			@alldest317 = @comboalldest.active_iter[3]
		end
		if @combonazdest.active == -1 or @combonazdest.sensitive? == false
			@valcombonazdest = ""
		else
			@valcombonazdest = @combonazdest.active_iter[2]
		end
		if @combotrasp.active == -1 or @combotrasp.sensitive? == false
			@valcombotrasp = ""
		else
			@valcombotrasp = @combotrasp.active_iter[1]
		end
		@listasel.each do |model,path,iter|
			marcauscid = iter[0]
			marcausc = iter[2]
			specieusc = iter[3]
			razzausc = iter[4]
			nascitausc = iter[5]
			cod317nasusc = iter[6]
			sessousc = iter[7]
			nazorigusc = iter[8]
			nazprimimpusc = iter[9]
			datamarcausc = iter[10]
			ilgusc = iter[11]
			marcaprecedenteusc = iter[12]
			madreusc = iter[13]
			padreusc = iter[14]
			Animals.create(:relaz_id => "#{@stallaoper.to_i}", :tipo => "U", :cm_usc => "#{@combousc.active_iter[0]}", :marca => "#{marcausc}", :specie => "#{specieusc}", :razza_id => "#{razzausc}", :data_nas => "#{nascitausc}", :stalla_nas => "#{cod317nasusc}", :sesso => "#{sessousc}", :naz_orig => "#{nazorigusc}", :naz_nasprimimp => "#{nazprimimpusc}", :data_applm => "#{datamarcausc}", :ilg => "#{ilgusc}", :marca_prec => "#{marcaprecedenteusc}", :marca_madre => "#{madreusc}", :marca_padre => "#{padreusc}", :uscita => "#{@datauscingl}", :allevamenti_id => "#{@idalldest}", :naz_dest => "#{@valcombonazdest}", :trasp => "#{@valcombotrasp}", :mod4 => "#{@s.stalle.cod317}/#{@giorno.strftime("%Y")}/#{@mod4usc.text}", :data_mod4 => "#{@datamod4uscingl.to_i}", :marcasost => "#{@marcasost.text}")
			Animals.update(marcauscid, { :uscito => "1"})
		end
#		Relazs.update(@s.id, { :mod4usc => "#{@mod4usc.text}/#{annoreg}"})
		Contatoris.update(@s.contatori.id, { :mod4usc => "#{@mod4usc.text}/#{annoreg}"})
		Conferma.conferma(mdatiuscita, "Capi usciti correttamente.")
		mdatiuscita.destroy
		@muscite.destroy
		@window.present
		else
	end
	}
	boxusc10.pack_start(bottmovusc, false, false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mdatiuscita.destroy
		@muscite.present
	}
	boxusc10.pack_start(bottchiudi, false, false, 0)
	mdatiuscita.show_all
end

# Visualizza movimenti

def vismovimenti
	mvismov = Gtk::Window.new("Vista movimenti")
	#mvismov.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	mvismov.set_default_size(800, 600)
	mvismov.maximize
	mvismovscroll = Gtk::ScrolledWindow.new #(hadjustment = nil, vadjustment = nil)
	boxmovv = Gtk::VBox.new(false, 0)
	boxmov1 = Gtk::HBox.new(false, 0)
	boxmov2 = Gtk::HBox.new(false, 0)
	boxmovv.pack_start(boxmov1, false, false, 5)
	boxmovv.pack_start(boxmov2, true, true, 5)
	@labelconto = Gtk::Label.new("Movimenti trovati: 0")
	mvismov.add(boxmovv)

	def riempimento
		@selmov.each do |m|
			itermov = @lista.append
			itermov[0] = m.id.to_i
			itermov[1] = m.tipo
			itermov[2] = m.relaz.ragsoc.ragsoc
			itermov[3] = m.marca
			itermov[4] = m.specie
			itermov[5] = m.razza.razza
			itermov[6] = m.data_nas.strftime("%d/%m/%Y")
			itermov[7] = m.stalla_nas
			itermov[8] = m.sesso
			itermov[9] = m.naz_orig
			itermov[10] = m.naz_nasprimimp
			if m.data_applm !=nil
				itermov[11] = m.data_applm.strftime("%d/%m/%Y")
			else
				itermov[11] = ""
			end
			itermov[12] = m.ilg
			itermov[13] = m.marca_prec
			itermov[14] = m.marca_madre
			itermov[15] = m.marca_padre
			itermov[16] = m.donatrice
			itermov[17] = m.cm_ing.to_s
			if m.data_ingr != nil
				itermov[18] = m.data_ingr.strftime("%d/%m/%Y")
			else
				itermov[18] = ""
			end
			if m.tipo == "I"
				if m.allevamenti_id != nil
					itermov[19] = m.allevamenti.cod317
					itermov[20] = m.allevamenti.ragsoc
					itermov[21] = m.allevamenti.if
				else
					itermov[19] = ""
					itermov[20] = ""
					itermov[21] = ""
				end
			elsif m.tipo == "U"
				if m.allevamenti_id != nil
					itermov[30] = m.allevamenti.cod317
					itermov[32] = m.allevamenti.ragsoc
					itermov[33] = m.allevamenti.if
				else
					itermov[30] = ""
					itermov[32] = ""
					itermov[33] = ""
				end
			end
			itermov[22] = m.naz_prov
			itermov[23] = m.certsan
			itermov[24] = m.rifloc
			if m.data_certsan != nil
				itermov[25] = m.data_certsan.strftime("%d/%m/%Y")
			else
				itermov[25] = ""
			end
			itermov[26] = m.mod4
			if m.data_mod4 != nil
				itermov[27] = m.data_mod4.strftime("%d/%m/%Y")
			else
				itermov[27] = ""
			end
			itermov[28] = m.cm_usc.to_s
				if m.uscita != nil
				itermov[29] = m.uscita.strftime("%d/%m/%Y")
			else
				itermov[29] = ""
			end
			itermov[31] = m.naz_dest
			if m.macelli_id != nil
				itermov[34] = m.macelli.nomemac
				itermov[35] = m.macelli.ifmac
				itermov[36] = m.macelli.bollomac
				itermov[37] = m.macelli.region.regione
			else
				itermov[34] = ""
				itermov[35] = ""
				itermov[36] = ""
				itermov[37] = ""
			end
			itermov[38] = m.certsanusc
			if m.data_certsanusc != nil
				itermov[39] = m.data_certsanusc.strftime("%d/%m/%Y")
			else
				itermov[39] = ""
			end
			itermov[40] = m.trasp
			itermov[41] = m.marcasost
			itermov[42] = m.ditta_racc
			itermov[43] = m.clg
			itermov[44] = m.uscito.to_s
			if m.registro == true
				itermov[45] = "SI"
			else
				itermov[45] = "NO"
			end
#			itermov[45] = m.registro.to_s
#			puts itermov[45]
		end
	@labelconto.text = ("Movimenti trovati: #{@selmov.length}")
	end

	visingressi = Gtk::Button.new( "Visualizza ingressi" )
	visuscite = Gtk::Button.new( "Visualizza uscite" )
	vispresenti = Gtk::Button.new( "Visualizza presenti in stalla" )
	vistutti = Gtk::Button.new( "Visualizza tutti" )
	visricerca = Gtk::Button.new( "Cerca capo" )
	visricercaentry = Gtk::Entry.new
	@lista = Gtk::ListStore.new(Integer, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String)
	@vista = Gtk::TreeView.new(@lista)
	@vista.selection.mode = Gtk::SELECTION_SINGLE #BROWSE #SINGLE #MULTIPLE
#	@vista.show_expanders = (true)
	@vista.rules_hint = true
#	@vista.set_enable_grid_lines(true)
#	@relid = @combo3.active_iter[0]
	visingressi.signal_connect("clicked") {
		@lista.clear
		@selmov = Animals.find(:all, :from => "animals", :conditions => "relaz_id='#{@stallaoper}' and tipo='I'")
		riempimento
	}
	visuscite.signal_connect("clicked") {
		@lista.clear
		@selmov = Animals.find(:all, :from => "animals", :conditions => "relaz_id='#{@stallaoper}' and tipo='U'")
		riempimento
	}
	vispresenti.signal_connect("clicked") {
		@lista.clear
		@selmov = Animals.find(:all, :from => "animals", :conditions => "relaz_id='#{@stallaoper}' and tipo='I' and uscito='0'")
		riempimento
	}
	vistutti.signal_connect("clicked") {
		@lista.clear
		@selmov = Animals.find(:all, :from => "animals", :conditions => "relaz_id='#{@stallaoper}'")
		riempimento
	}
	visricerca.signal_connect("clicked") {
		@lista.clear
		@selmov = Animals.find(:all, :from => "animals", :conditions => "relaz_id='#{@stallaoper}' and marca LIKE '%#{visricercaentry.text}%'")
		riempimento
	}
		cella = Gtk::CellRendererText.new
		colonna1 = Gtk::TreeViewColumn.new("Tipo movimento", cella)
		colonna1.resizable = true
		colonna2 = Gtk::TreeViewColumn.new("Ragione sociale", cella)
		colonna2.resizable = true
		colonna3 = Gtk::TreeViewColumn.new("Marca", cella)
		colonna4 = Gtk::TreeViewColumn.new("Specie", cella)
		colonna5 = Gtk::TreeViewColumn.new("Razza", cella)
		colonna5.resizable = true
		colonna6 = Gtk::TreeViewColumn.new("Data di nascita", cella)
		colonna7 = Gtk::TreeViewColumn.new("Stalla di nascita", cella)
		colonna8 = Gtk::TreeViewColumn.new("Sesso", cella)
		colonna9 = Gtk::TreeViewColumn.new("Nazione origine", cella)
		colonna10 = Gtk::TreeViewColumn.new("Nazione prima importazione", cella)
		colonna11 = Gtk::TreeViewColumn.new("Data applicazione marca", cella)
		colonna12 = Gtk::TreeViewColumn.new("ILG", cella)
		colonna13 = Gtk::TreeViewColumn.new("Marca precedente", cella)
		colonna14 = Gtk::TreeViewColumn.new("Marca madre", cella)
		colonna15 = Gtk::TreeViewColumn.new("Marca padre", cella)
		colonna16 = Gtk::TreeViewColumn.new("Marca donatrice", cella)
		colonna17 = Gtk::TreeViewColumn.new("Codice movimento ingresso", cella)
		colonna18 = Gtk::TreeViewColumn.new("Data ingresso", cella)
		colonna19 = Gtk::TreeViewColumn.new("Cod. stalla provenienza", cella)
		colonna20 = Gtk::TreeViewColumn.new("Stalla provenienza", cella)
		colonna21 = Gtk::TreeViewColumn.new("Id. fisc. provenienza", cella)
		colonna22 = Gtk::TreeViewColumn.new("Nazione provenienza", cella)
		colonna23 = Gtk::TreeViewColumn.new("Certificato sanitario", cella)
		colonna24 = Gtk::TreeViewColumn.new("Riferimento locale", cella)
		colonna25 = Gtk::TreeViewColumn.new("Data certificato sanitario", cella)
		colonna26 = Gtk::TreeViewColumn.new("Modello 4", cella)
		colonna27 = Gtk::TreeViewColumn.new("Data modello 4", cella)
		colonna28 = Gtk::TreeViewColumn.new("Movimento uscita", cella)
		colonna29 = Gtk::TreeViewColumn.new("Data uscita", cella)
		colonna30 = Gtk::TreeViewColumn.new("Stalla destinazione", cella)
		colonna31 = Gtk::TreeViewColumn.new("Nazione destinazione", cella)
		colonna32 = Gtk::TreeViewColumn.new("Allevamento destinazione", cella)
		colonna33 = Gtk::TreeViewColumn.new("Id. fisc. allevamento destinazione", cella)
		colonna34 = Gtk::TreeViewColumn.new("Macello destinazione", cella)
		colonna35 = Gtk::TreeViewColumn.new("Id. fisc. macello", cella)
		colonna36 = Gtk::TreeViewColumn.new("Bollo macello", cella)
		colonna37 = Gtk::TreeViewColumn.new("Regione macello", cella)
		colonna38 = Gtk::TreeViewColumn.new("Cert. san. uscita", cella)
		colonna39 = Gtk::TreeViewColumn.new("Data cert. san. uscita", cella)
		colonna40 = Gtk::TreeViewColumn.new("Trasportatore", cella)
		colonna41 = Gtk::TreeViewColumn.new("Marca sostitutiva", cella)
		colonna42 = Gtk::TreeViewColumn.new("Ditta raccoglitrice", cella)
		colonna43 = Gtk::TreeViewColumn.new("Registro", cella)
		colonna1.set_attributes(cella, :text => 1)
		colonna2.set_attributes(cella, :text => 2)
		colonna3.set_attributes(cella, :text => 3)
		colonna4.set_attributes(cella, :text => 4)
		colonna5.set_attributes(cella, :text => 5)
		colonna6.set_attributes(cella, :text => 6)
		colonna7.set_attributes(cella, :text => 7)
		colonna8.set_attributes(cella, :text => 8)
		colonna9.set_attributes(cella, :text => 9)
		colonna10.set_attributes(cella, :text => 10)
		colonna11.set_attributes(cella, :text => 11)
		colonna12.set_attributes(cella, :text => 12)
		colonna13.set_attributes(cella, :text => 13)
		colonna14.set_attributes(cella, :text => 14)
		colonna15.set_attributes(cella, :text => 15)
		colonna16.set_attributes(cella, :text => 16)
		colonna17.set_attributes(cella, :text => 17)
		colonna18.set_attributes(cella, :text => 18)
		colonna19.set_attributes(cella, :text => 19)
		colonna20.set_attributes(cella, :text => 20)
		colonna21.set_attributes(cella, :text => 21)
		colonna22.set_attributes(cella, :text => 22)
		colonna23.set_attributes(cella, :text => 23)
		colonna24.set_attributes(cella, :text => 24)
		colonna25.set_attributes(cella, :text => 25)
		colonna26.set_attributes(cella, :text => 26)
		colonna27.set_attributes(cella, :text => 27)
		colonna28.set_attributes(cella, :text => 28)
		colonna29.set_attributes(cella, :text => 29)
		colonna30.set_attributes(cella, :text => 30)
		colonna31.set_attributes(cella, :text => 31)
		colonna32.set_attributes(cella, :text => 32)
		colonna33.set_attributes(cella, :text => 33)
		colonna34.set_attributes(cella, :text => 34)
		colonna35.set_attributes(cella, :text => 35)
		colonna36.set_attributes(cella, :text => 36)
		colonna37.set_attributes(cella, :text => 37)
		colonna38.set_attributes(cella, :text => 38)
		colonna39.set_attributes(cella, :text => 39)
		colonna40.set_attributes(cella, :text => 40)
		colonna41.set_attributes(cella, :text => 41)
		colonna42.set_attributes(cella, :text => 42)
		colonna43.set_attributes(cella, :text => 45)
		@vista.append_column(colonna1)
		@vista.append_column(colonna2)
		@vista.append_column(colonna3)
		@vista.append_column(colonna4)
		@vista.append_column(colonna5)
		@vista.append_column(colonna6)
		@vista.append_column(colonna7)
		@vista.append_column(colonna8)
		@vista.append_column(colonna9)
		@vista.append_column(colonna10)
		@vista.append_column(colonna11)
		@vista.append_column(colonna12)
		@vista.append_column(colonna13)
		@vista.append_column(colonna14)
		@vista.append_column(colonna15)
		@vista.append_column(colonna16)
		@vista.append_column(colonna17)
		@vista.append_column(colonna18)
		@vista.append_column(colonna19)
		@vista.append_column(colonna20)
		@vista.append_column(colonna21)
		@vista.append_column(colonna22)
		@vista.append_column(colonna23)
		@vista.append_column(colonna24)
		@vista.append_column(colonna25)
		@vista.append_column(colonna26)
		@vista.append_column(colonna27)
		@vista.append_column(colonna28)
		@vista.append_column(colonna29)
		@vista.append_column(colonna30)
		@vista.append_column(colonna31)
		@vista.append_column(colonna32)
		@vista.append_column(colonna33)
		@vista.append_column(colonna34)
		@vista.append_column(colonna35)
		@vista.append_column(colonna36)
		@vista.append_column(colonna37)
		@vista.append_column(colonna38)
		@vista.append_column(colonna39)
		@vista.append_column(colonna40)
		@vista.append_column(colonna41)
		@vista.append_column(colonna42)
		@vista.append_column(colonna43)
	mvismovscroll.add(@vista)
	boxmov2.pack_start(mvismovscroll, true, true, 0)
	boxmov1.pack_start(visingressi, false, false, 0)
	boxmov1.pack_start(visuscite, false, false, 0)
	boxmov1.pack_start(vispresenti, false, false, 0)
	boxmov1.pack_start(vistutti, false, false, 0)
	boxmov1.pack_start(visricerca, false, false, 5)
	boxmov1.pack_start(visricercaentry, false, false, 0)
	boxmov1.pack_start(@labelconto, false, false, 5)

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mvismov.destroy
	}
	boxmovv.pack_start(bottchiudi, false, false, 0)

	@vista.signal_connect("row-activated") do |view, path, column|
		@selcapo = @vista.selection
		if @selcapo.selected[1] == "I" and @selcapo.selected[45] == "NO"
			modificacapo
		elsif @selcapo.selected[1] == "U" and @selcapo.selected[45] == "NO"
			modificacapousc
		else
			Avvisoprova.avviso(mvismov, "Il movimento è stato inserito nel registro, per cui non è più possibile modificarlo.")
		end
	end
	mvismov.show_all
end

# modifica capo

def modificacapo
	modcapo = Gtk::Window.new("Modifica movimento di ingresso")
	#modcapo.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	modcapo.set_default_size(800, 600)
	modcapo.maximize
	boxgen = Gtk::VBox.new(false, 0)
	boxgrande = Gtk::HBox.new(false, 0)
	boxmodcv1 = Gtk::HBox.new(false, 0)
	boxmodcv11 = Gtk::VBox.new(true, 0)
	boxmodcv12 = Gtk::VBox.new(true, 0)
	boxmodcv2 = Gtk::HBox.new(false, 0)
	boxmodcv21 = Gtk::VBox.new(true, 0)
	boxmodcv22 = Gtk::VBox.new(true, 0)
	boxmodc1 = Gtk::HBox.new(false, 0)
	boxmodc2 = Gtk::HBox.new(false, 0)
	boxmodc3 = Gtk::HBox.new(false, 0)
	boxmodc4 = Gtk::HBox.new(false, 0)
	boxmodc5 = Gtk::HBox.new(false, 0)
	boxmodc6 = Gtk::HBox.new(false, 0)
	boxmodc7 = Gtk::HBox.new(false, 0)
	boxmodc8 = Gtk::HBox.new(false, 0)
	boxmodc9 = Gtk::HBox.new(false, 0)
	boxmodc10 = Gtk::HBox.new(false, 0)
	boxmodc11 = Gtk::HBox.new(false, 0)
	boxmodc12 = Gtk::HBox.new(false, 0)
	boxmodc13 = Gtk::HBox.new(false, 0)
	boxmodc14 = Gtk::HBox.new(false, 0)
	boxmodc15 = Gtk::HBox.new(false, 0)
	boxmodc16 = Gtk::HBox.new(false, 0)
	boxmodc17 = Gtk::HBox.new(false, 0)
	boxmodc18 = Gtk::HBox.new(false, 0)
	boxmodc19 = Gtk::HBox.new(false, 0)
	boxmodc20 = Gtk::HBox.new(false, 0)
	boxmodc21 = Gtk::HBox.new(false, 0)
	boxmodc22 = Gtk::HBox.new(false, 0)
	boxmodc23 = Gtk::HBox.new(false, 0)
	boxmodc24 = Gtk::HBox.new(false, 0)
	boxmodc25 = Gtk::HBox.new(false, 0)
	boxmodc26 = Gtk::HBox.new(false, 0)
	boxmodc27 = Gtk::HBox.new(false, 0)
	boxmodc28 = Gtk::HBox.new(false, 0)
	boxmodc29 = Gtk::HBox.new(false, 0)
	boxmodc30 = Gtk::HBox.new(false, 0)
	boxmodc31 = Gtk::HBox.new(false, 0)
	boxmodc32 = Gtk::HBox.new(false, 0)
	boxmodc33 = Gtk::HBox.new(false, 0)
	boxmodc34 = Gtk::HBox.new(false, 0)
	boxmodc35 = Gtk::HBox.new(false, 0)
	boxmodc36 = Gtk::HBox.new(false, 0)
	boxmodc37 = Gtk::HBox.new(false, 0)
	boxmodc38 = Gtk::HBox.new(false, 0)
	boxmodc39 = Gtk::HBox.new(false, 0)
	boxmodc40 = Gtk::HBox.new(false, 0)
	boxmodc41 = Gtk::HBox.new(false, 0)
	boxmodc42 = Gtk::HBox.new(false, 0)
	boxmodc43 = Gtk::HBox.new(false, 0)
	boxmodc44 = Gtk::HBox.new(false, 0)
	boxmodc45 = Gtk::HBox.new(false, 0)
	boxmodc46 = Gtk::HBox.new(false, 0)
	boxmodc47 = Gtk::HBox.new(false, 0)
	boxmodc48 = Gtk::HBox.new(false, 0)
	boxmodc100 = Gtk::HBox.new(true, 0)
	boxmodcv11.pack_start(boxmodc1, false, false, 0)
	boxmodcv12.pack_start(boxmodc2, false, false, 0)
	boxmodcv11.pack_start(boxmodc3, false, false, 0)
	boxmodcv12.pack_start(boxmodc4, false, false, 0)
	boxmodcv11.pack_start(boxmodc5, false, false, 0)
	boxmodcv12.pack_start(boxmodc6, false, false, 0)
	boxmodcv11.pack_start(boxmodc7, false, false, 0)
	boxmodcv12.pack_start(boxmodc8, false, false, 0)
	boxmodcv11.pack_start(boxmodc9, false, false, 0)
	boxmodcv12.pack_start(boxmodc10, false, false, 0)
	boxmodcv11.pack_start(boxmodc11, false, false, 0)
	boxmodcv12.pack_start(boxmodc12, false, false, 0)
	boxmodcv11.pack_start(boxmodc13, false, false, 0)
	boxmodcv12.pack_start(boxmodc14, false, false, 0)
	boxmodcv11.pack_start(boxmodc15, false, false, 0)
	boxmodcv12.pack_start(boxmodc16, false, false, 0)
	boxmodcv11.pack_start(boxmodc17, false, false, 0)
	boxmodcv12.pack_start(boxmodc18, false, false, 0)
	boxmodcv11.pack_start(boxmodc19, false, false, 0)
	boxmodcv12.pack_start(boxmodc20, false, false, 0)
	boxmodcv11.pack_start(boxmodc21, false, false, 0)
	boxmodcv12.pack_start(boxmodc22, false, false, 0)
	boxmodcv11.pack_start(boxmodc23, false, false, 0)
	boxmodcv12.pack_start(boxmodc24, false, false, 0)
	boxmodcv21.pack_start(boxmodc25, false, false, 0)
	boxmodcv22.pack_start(boxmodc26, false, false, 0)
	boxmodcv21.pack_start(boxmodc27, false, false, 0)
	boxmodcv22.pack_start(boxmodc28, false, false, 0)
	boxmodcv21.pack_start(boxmodc29, false, false, 0)
	boxmodcv22.pack_start(boxmodc30, false, false, 0)
	boxmodcv21.pack_start(boxmodc31, false, false, 0)
	boxmodcv22.pack_start(boxmodc32, false, false, 0)
	boxmodcv21.pack_start(boxmodc33, false, false, 0)
	boxmodcv22.pack_start(boxmodc34, false, false, 0)
	boxmodcv21.pack_start(boxmodc35, false, false, 0)
	boxmodcv22.pack_start(boxmodc36, false, false, 0)
	boxmodcv21.pack_start(boxmodc37, false, false, 0)
	boxmodcv22.pack_start(boxmodc38, false, false, 0)
	boxmodcv21.pack_start(boxmodc39, false, false, 0)
	boxmodcv22.pack_start(boxmodc40, false, false, 0)
	boxmodcv21.pack_start(boxmodc41, false, false, 0)
	boxmodcv22.pack_start(boxmodc42, false, false, 0)
	boxmodcv21.pack_start(boxmodc43, false, false, 0)
	boxmodcv22.pack_start(boxmodc44, false, false, 0)
	boxmodcv21.pack_start(boxmodc45, false, false, 0)
	boxmodcv22.pack_start(boxmodc46, false, false, 0)
	boxmodcv21.pack_start(boxmodc47, false, false, 0)
	boxmodcv22.pack_start(boxmodc48, false, false, 0)
	boxmodcv1.pack_start(boxmodcv11, false, false, 0)
	boxmodcv1.pack_start(boxmodcv12, false, false, 0)
	boxmodcv2.pack_start(boxmodcv21, false, false, 0)
	boxmodcv2.pack_start(boxmodcv22, false, false, 0)
	boxgrande.pack_start(boxmodcv1, true, true)
	boxgrande.pack_start(boxmodcv2, true, true)
	boxgen.pack_start(boxgrande, true, true)
	boxgen.pack_start(boxmodc100, false, false)
	modcapo.add(boxgen)
	#Modifica marca

	capomod = @selcapo.selected
	labelmarca = Gtk::Label.new("Marca:")
	boxmodc1.pack_end(labelmarca, false, false, 5)
	marca = Gtk::Entry.new()
	marca.max_length=(14)
	marca.text = ("#{capomod[3]}")
	boxmodc2.pack_start(marca, false, false, 5)

	#Specie

	labelspecie = Gtk::Label.new("Specie:")
	boxmodc3.pack_end(labelspecie, false, false, 5)
	specie1 = Gtk::RadioButton.new("Bovini")
	boxmodc4.pack_start(specie1, false, false, 5)
	specie2 = Gtk::RadioButton.new(specie1, "Bufalini")
	boxmodc4.pack_start(specie2, false, false, 5)
	valspecie = capomod[4]
	if capomod[4] == "BOV"
		specie1.active=(true)
	else
		specie2.active=(true)
	end

	specie1.signal_connect("toggled") {
		if specie1.active?
			valspecie = "BOV" 
		end
	}
	specie2.signal_connect("toggled") {
		if specie2.active?
			valspecie = "BUF"
		end
	}

	#Modifica razza

	labelrazza = Gtk::Label.new("Razza:")
	listarazze = Gtk::ListStore.new(Integer, String, String)
	selrazze = Razzas.find(:all)
	selrazze.each do |r|
		iter1 = listarazze.append
		iter1[0] = r.id.to_i
		iter1[1] = r.razza
		iter1[2] = r.cod_razza
	end
	comborazze = Gtk::ComboBox.new(listarazze)
	renderer1 = Gtk::CellRendererText.new
	comborazze.pack_start(renderer1,false)
	comborazze.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	comborazze.pack_end(renderer1,false)
	comborazze.set_attributes(renderer1, :text => 2)
	boxmodc5.pack_end(labelrazza, false, false, 5)
	boxmodc6.pack_start(comborazze.popdown, false, false, 0)

	comborazze.set_active(0)
	contarazze = -1
	while comborazze.active_iter[1] != capomod[5]
		contarazze+=1
		comborazze.set_active(contarazze)
	end

	#Modifica data di nascita

	labelnascita = Gtk::Label.new("Data di nascita (GGMMAA):")
	boxmodc7.pack_end(labelnascita, false, false, 5)
	nascita = Gtk::Entry.new()
	nascita.max_length=(6)
	nascita.text = ("#{capomod[6][0,2]}#{capomod[6][3,2]}#{capomod[6][8,2]}")
	boxmodc8.pack_start(nascita, false , false, 0)

	#Modifica sesso

	labelsesso = Gtk::Label.new("Sesso:")
	boxmodc9.pack_end(labelsesso, false, false, 5)
	sesso1 = Gtk::RadioButton.new("M")
	boxmodc10.pack_start(sesso1, false, false, 5)
	sesso2 = Gtk::RadioButton.new(sesso1, "F")
	boxmodc10.pack_start(sesso2, false, false, 5)
	valsesso = capomod[8]
	if capomod[8] == "M"
		sesso1.active=(true)
	else
		sesso2.active=(true)
	end

	sesso1.signal_connect("toggled") {
		if sesso1.active?
			valsesso="M"
		end
	}
	sesso2.signal_connect("toggled") {
		if sesso2.active?
			valsesso="F"
		end
	}

	#Modifica stalla di nascita / prima importazione

	labelstallanas = Gtk::Label.new("Stalla nascita / prima importazione:")
	stallanas = Gtk::Entry.new()
	stallanas.max_length=(8)
	stallanas.text = ("#{capomod[7]}")
	boxmodc11.pack_end(labelstallanas, false, false, 5)
	boxmodc12.pack_start(stallanas, false, false, 5)

	#Nazione origine

	labelnazorig = Gtk::Label.new("Nazione di origine:")
	boxmodc13.pack_end(labelnazorig, false, false, 5)
	listanazorig = Gtk::ListStore.new(Integer, String, String, Integer)
	listanazorig.clear
	selnazorig = Nations.find(:all)
	selnazorig.each do |no|
		iter1 = listanazorig.append
		iter1[0] = no.id
		iter1[1] = no.nome
		iter1[2] = no.codice
		iter1[3] = no.tipo
	end
	combonazorig = Gtk::ComboBox.new(listanazorig)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combonazorig.pack_start(renderer1,false)
	combonazorig.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combonazorig.pack_start(renderer1,false)
	combonazorig.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combonazorig.pack_start(renderer1,false)
	combonazorig.set_attributes(renderer1, :text => 2)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combonazorig.pack_start(renderer1,false)
	combonazorig.set_attributes(renderer1, :text => 3)
	boxmodc14.pack_start(combonazorig.popdown, false, false, 0)

	combonazorig.set_active(0)
	contanazorig = -1
	while combonazorig.active_iter[2] != capomod[9]
		contanazorig+=1
		combonazorig.set_active(contanazorig)
	end

	#Nazione nascita / prima importazione

	labelnaznas = Gtk::Label.new("Nazione nascita / prima importazione:")
	boxmodc15.pack_end(labelnaznas, false, false, 5)
	listanaznas = Gtk::ListStore.new(Integer, String, String)
	listanaznas.clear
	selnaznas = Nations.find(:all)
	selnaznas.each do |n|
		iter1 = listanaznas.append
		iter1[0] = n.id
		iter1[1] = n.nome
		iter1[2] = n.codice
	end
	combonaznas = Gtk::ComboBox.new(listanaznas)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combonaznas.pack_start(renderer1,false)
	combonaznas.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combonaznas.pack_start(renderer1,false)
	combonaznas.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combonaznas.pack_start(renderer1,false)
	combonaznas.set_attributes(renderer1, :text => 2)
	boxmodc16.pack_start(combonaznas.popdown, false, false, 0)

	combonaznas.set_active(0)
	contanaznas = -1
	while combonaznas.active_iter[2] != capomod[10]
		contanaznas+=1
		combonaznas.set_active(contanaznas)
	end

	#Data applicazione marca

	labelmarcatura = Gtk::Label.new("Data applicazione marca (GGMMAA):")
	boxmodc17.pack_end(labelmarcatura, false, false, 5)
	marcatura = Gtk::Entry.new()
	if capomod[11] != nil
		marcatura.text = ("#{capomod[11][0,2]}#{capomod[11][3,2]}#{capomod[11][8,2]}")
	end
	boxmodc18.pack_start(marcatura, false, false, 0)

	#Iscrizione libro genealogico

	labelgen = Gtk::Label.new("Iscrizione libro genealogico:")
	boxmodc19.pack_end(labelgen, false, false, 5)
	gen1 = Gtk::RadioButton.new("S")
	boxmodc20.pack_start(gen1, false, false, 5)
	gen2 = Gtk::RadioButton.new(gen1, "N")
	boxmodc20.pack_start(gen2, false, false, 5)
	gen3 = Gtk::RadioButton.new(gen1, "NULLO")
	boxmodc20.pack_start(gen3, false, false, 5)
	valgen = capomod[12]
	if capomod[12] == "S"
		gen1.active=(true)
	elsif capomod[12] == "N"
		gen2.active=(true)
	else
		gen3.active=(true)
	end

	gen1.signal_connect("toggled") {
		if gen1.active?
			valgen="S"
		end
	}
	gen2.active=(true)
	gen2.signal_connect("toggled") {
		if gen2.active?
			valgen="N"
		end
	}
	gen3.signal_connect("toggled") {
		if gen3.active?
			valgen="NULLO"
		end
	}

	#Embryo transer

	labelembryo = Gtk::Label.new("Embryo transfer:")
	boxmodc21.pack_end(labelembryo, false, false, 5)
	embryo1 = Gtk::RadioButton.new("S")
	boxmodc22.pack_start(embryo1, false, false, 5)
	embryo2 = Gtk::RadioButton.new(embryo1, "N")
	boxmodc22.pack_start(embryo2, false, false, 5)
	valembryo = capomod[12]
	if capomod[12] == "S"
		embryo1.active=(true)
	else
		embryo2.active=(true)
	end

	embryo1.signal_connect("toggled") {
		if embryo1.active?
			valembryo="S"
		end
	}
	embryo2.signal_connect("toggled") {
		if embryo2.active?
			valembryo="N"
		end
	}

	#Marca precedente

	labelprec = Gtk::Label.new("Marca precedente:")
	boxmodc23.pack_end(labelprec, false, false, 5)
	prec = Gtk::Entry.new()
	prec.max_length=(14)
	prec.text = ("#{capomod[13]}")
	boxmodc24.pack_start(prec, false, false, 5)

	#Marca madre

	labelmadre = Gtk::Label.new("Marca madre:")
	boxmodc25.pack_end(labelmadre, false, false, 5)
	madre = Gtk::Entry.new()
	madre.max_length=(14)
	madre.text = ("#{capomod[14]}")
	boxmodc26.pack_start(madre, false, false, 5)

	#Marca padre

	labelpadre = Gtk::Label.new("Marca padre:")
	boxmodc27.pack_end(labelpadre, false, false, 5)
	padre = Gtk::Entry.new()
	padre.max_length=(14)
	padre.text = ("#{capomod[15]}")
	boxmodc28.pack_start(padre, false, false, 5)

	#Marca donatrice

	labeldon = Gtk::Label.new("Marca donatrice:")
	boxmodc29.pack_end(labeldon, false, false, 5)
	don = Gtk::Entry.new()
	don.max_length=(14)
	don.text = ("#{capomod[16]}")
	boxmodc30.pack_start(don, false, false, 5)

	#Codice libro genealogico

	labellibgen = Gtk::Label.new("Codice libro genealogico:")
	boxmodc31.pack_end(labellibgen, false, false, 5)
	libgen = Gtk::Entry.new()
	libgen.max_length=(50)
	libgen.text = ("#{capomod[43]}")
	boxmodc32.pack_start(libgen, false, false, 5)

	#Modifica motivo ingresso

	labelmovingr = Gtk::Label.new("Motivo ingresso:")
	listamovingr = Gtk::ListStore.new(Integer, String)
	selmovingr = Ingressos.find(:all)
	selmovingr.each do |i|
		iter1 = listamovingr.append
		iter1[0] = i.codice.to_i
		iter1[1] = i.descr
	end
	combomovingr = Gtk::ComboBox.new(listamovingr)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combomovingr.pack_start(renderer1,false)
	combomovingr.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combomovingr.pack_start(renderer1,false)
	combomovingr.set_attributes(renderer1, :text => 1)
	boxmodc33.pack_end(labelmovingr, false, false, 5)
	boxmodc34.pack_start(combomovingr.popdown, false, false, 0)
	combomovingr.set_active(0)
	contamovingr = -1
	while combomovingr.active_iter[0].to_i != capomod[17].to_i
		contamovingr+=1
		combomovingr.set_active(contamovingr)
	end

	#Modifica data ingresso

	labeldataingr = Gtk::Label.new("Data di ingresso (GGMMAA):")
	boxmodc35.pack_end(labeldataingr, false, false, 5)
	dataingr = Gtk::Entry.new()
	dataingr.text = ("#{capomod[18][0,2]}#{capomod[18][3,2]}#{capomod[18][8,2]}")
	boxmodc36.pack_start(dataingr, false , false, 0)

	#Nazione di provenienza

	labelnazprov = Gtk::Label.new("Nazione di provenienza:")
	boxmodc37.pack_end(labelnazprov, false, false, 5)
	listanazprov = Gtk::ListStore.new(Integer, String, String)
	listanazprov.clear
	selnazprov = Nations.find(:all)
	selnazprov.each do |n|
		iter1 = listanazprov.append
		iter1[0] = n.id
		iter1[1] = n.nome
		iter1[2] = n.codice
	end
	combonazprov = Gtk::ComboBox.new(listanazprov)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combonazprov.pack_start(renderer1,false)
	combonazprov.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combonazprov.pack_start(renderer1,false)
	combonazprov.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combonazprov.pack_start(renderer1,false)
	combonazprov.set_attributes(renderer1, :text => 2)
	boxmodc38.pack_start(combonazprov.popdown, false, false, 0)
	combonazprov.set_active(0)
	contanazprov = -1
	while combonazprov.active_iter[2] != capomod[22]
		contanazprov+=1
		combonazprov.set_active(contanazprov)
	end

	#Certificato sanitario

	labelcertsan = Gtk::Label.new("Certificato sanitario:")
	boxmodc39.pack_end(labelcertsan, false, false, 5)
	certsan = Gtk::Entry.new()
	certsan.max_length=(21)
	certsan.width_chars=(21)
	certsan.text = ("#{capomod[23]}")
	boxmodc40.pack_start(certsan, false, false, 5)

	#Riferimento locale

	labelrifloc = Gtk::Label.new("Riferimento locale:")
	boxmodc41.pack_end(labelrifloc, false, false, 5)
	rifloc = Gtk::Entry.new()
	rifloc.max_length=(21)
	rifloc.width_chars=(21)
	rifloc.text = ("#{capomod[24]}")
	boxmodc42.pack_start(rifloc, false, false, 5)

	#Allevamento provenienza
	labelallprov = Gtk::Label.new("Allevamento di provenienza:")
	boxmodc43.pack_end(labelallprov, false, false, 5)
	listaallprov = Gtk::ListStore.new(Integer, String, String, String)
	listaallprov.clear
	selallprov = Allevamentis.find(:all)
	selallprov.each do |a|
		iter1 = listaallprov.append
		iter1[0] = a.id
		iter1[1] = a.ragsoc
		iter1[2] = a.if
		iter1[3] = a.cod317
	end
	comboallprov = Gtk::ComboBox.new(listaallprov)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	comboallprov.pack_start(renderer1,false)
	comboallprov.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	comboallprov.pack_start(renderer1,false)
	comboallprov.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	comboallprov.pack_start(renderer1,false)
	comboallprov.set_attributes(renderer1, :text => 2)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	comboallprov.pack_start(renderer1,false)
	comboallprov.set_attributes(renderer1, :text => 3)
	boxmodc44.pack_start(comboallprov.popdown, false, false, 5)
	if capomod[19] != ""
		comboallprov.set_active(0)
		contaallprov = -1
		while comboallprov.active_iter[3] != capomod[19]
			contaallprov+=1
			comboallprov.set_active(contaallprov)
		end
		else
		comboallprov.set_active(-1)
	end

	#Modello 4

	labelmod4 = Gtk::Label.new("Modello 4:")
	boxmodc45.pack_end(labelmod4, false, false, 5)
	mod4 = Gtk::Entry.new()
	mod4.text = ("#{capomod[26]}")
	boxmodc46.pack_start(mod4, false, false, 5)

	#Data modello 4

	labeldatamod4 = Gtk::Label.new("Data modello 4 (GGMMAA):")
	boxmodc47.pack_end(labeldatamod4, false, false, 5)
	datamod4 = Gtk::Entry.new()
	datamod4.max_length=(6)
	#dataingr.text = ("#{capomod[18]}")
	if capomod[27] != nil
		datamod4.text = ("#{capomod[27][0,2]}#{capomod[27][3,2]}#{capomod[27][8,2]}")
	end
	boxmodc48.pack_start(datamod4, false , false, 0)

	#Bottone di inserimento

	bottmodcapo = Gtk::Button.new( "Modifica capo" )
	bottmodcapo.signal_connect("clicked") {
		errore = nil
		begin
		datanasingl = "20" + nascita.text[4,2] + nascita.text[2,2] + nascita.text[0,2]
		Time.parse("#{datanasingl}")
		if marca.text == "" or comborazze.active == -1 or nascita.text == "" or combonazorig.active == -1 or combonaznas.active == -1 or combomovingr.active == -1
			Avvisoprova.avviso(modcapo, "Mancano dei dati obbligatori.")
			errore = 1
		elsif marca.text[0,2].upcase == "IT" and marca.text.length < 14
			Avvisoprova.avviso(modcapo, "Marca corta.")
			errore = 1
		elsif nascita.text.to_i == 0
			Avvisoprova.avviso(modcapo, "Data di nascita errata.")
			errore = 1
		elsif dataingr.text.to_i == 0
			Avvisoprova.avviso(modcapo, "Data di ingresso errata.")
			errore = 1
		elsif marcatura.text != "" and marcatura.text.to_i == 0
			Avvisoprova.avviso(modcapo, "lettere.")
			errore = 1
		elsif marcatura.text == "" #or @marcatura.text == 0 	#	elsif @datamod4.text != "" and @datamod4.text.to_i != 0
			datamarcingl = ""
		end
		if Time.parse("#{datanasingl}") > @giorno
				Avvisoprova.avviso(modcapo, "La data di nascita non può essere successiva al giorno odierno.")
				errore = 1
		end
		rescue Exception => errore
			Avvisoprova.avviso(modcapo, "Errore generico")
			errore = 1
		end

		if errore == nil
		dataingingl = "20" + dataingr.text[4,2] + dataingr.text[2,2] + dataingr.text[0,2]
		if marcatura.text != ""
			datamarcingl = "20" + marcatura.text[4,2] + marcatura.text[2,2] + marcatura.text[0,2]
		else
			datamarcingl = ""
		end
		if datamod4.text != ""
			datamod4ingl = "20" + datamod4.text[4,2] + datamod4.text[2,2] + datamod4.text[0,2]
		else
			datamod4ingl = nil
		end

		if comboallprov.active == -1
			allprov = ""
		else
			allprov = comboallprov.active_iter[0]
		end
			Animals.update(capomod[0], {:marca => "#{marca.text.upcase}", :specie => "#{valspecie}", :razza_id => "#{comborazze.active_iter[0]}", :data_nas => "#{datanasingl.to_i}", :sesso => "#{valsesso}", :stalla_nas => "#{stallanas.text.upcase}", :naz_orig => "#{combonazorig.active_iter[2]}", :naz_nasprimimp => "#{combonaznas.active_iter[2]}", :data_applm => "#{datamarcingl}", :ilg => "#{valgen}", :embryo => "#{valembryo}", :marca_prec => "#{prec.text.upcase}", :marca_madre => "#{madre.text.upcase}", :marca_padre => "#{padre.text.upcase}", :donatrice => "#{don.text.upcase}", :clg => "#{libgen.text.upcase}", :cm_ing => "#{combomovingr.active_iter[0]}", :data_ingr => "#{dataingingl.to_i}", :naz_prov => "#{combonazprov.active_iter[2]}", :certsan => "#{certsan.text.upcase}", :rifloc => "#{rifloc.text.upcase}", :allevamenti_id => "#{allprov}", :mod4 => "#{mod4.text}", :data_mod4 => "#{datamod4ingl.to_i}"})
			Conferma.conferma(modcapo, "Movimento modificato.")
			modcapo.destroy
		end
	}
	boxmodc100.pack_start(bottmodcapo, false, false, 5)

# Bottone di eliminazione del movimento

	bottelimina = Gtk::Button.new( "Elimina capo" )
	bottelimina.signal_connect("clicked") {
		if capomod[44].to_i == 1
			Avvisoprova.avviso(modcapo, "Prima di poter eliminare il movimento di ingresso bisogna eliminare l'uscita.")
		else
			avviso = Gtk::MessageDialog.new(modcapo, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Elimino il movimento di ingresso del capo #{capomod[3]} ?")
			risposta = avviso.run
			avviso.destroy
			if risposta == Gtk::Dialog::RESPONSE_YES
				Animals.delete(capomod[0])
				Conferma.conferma(modcapo, "Movimento eliminato.")
				modcapo.destroy
			else
				Conferma.conferma(modcapo, "Movimento non eliminato.")
			end
		end
	}
	boxmodc100.pack_start(bottelimina, false, false, 5)

# Bottone di chiusura finestra

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		modcapo.destroy
	}
	boxmodc100.pack_start(bottchiudi, false, false, 5)
	modcapo.show_all
end

# modifica capo uscita

def modificacapousc
	modcapousc = Gtk::Window.new("Modifica movimento di uscita")
	#modcapousc.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	modcapousc.set_default_size(800, 600)
	modcapousc.maximize
	boxgen = Gtk::VBox.new(false, 0)
	boxgrande = Gtk::HBox.new(false, 0)
	boxmodcv1 = Gtk::HBox.new(false, 0)
	boxmodcv11 = Gtk::VBox.new(true, 0)
	boxmodcv12 = Gtk::VBox.new(true, 0)
	boxmodcv2 = Gtk::HBox.new(false, 0)
	boxmodcv21 = Gtk::VBox.new(true, 0)
	boxmodcv22 = Gtk::VBox.new(true, 0)
	boxmodc1 = Gtk::HBox.new(false, 0)
	boxmodc2 = Gtk::HBox.new(false, 0)
	boxmodc3 = Gtk::HBox.new(false, 0)
	boxmodc4 = Gtk::HBox.new(false, 0)
	boxmodc5 = Gtk::HBox.new(false, 0)
	boxmodc6 = Gtk::HBox.new(false, 0)
	boxmodc7 = Gtk::HBox.new(false, 0)
	boxmodc8 = Gtk::HBox.new(false, 0)
	boxmodc9 = Gtk::HBox.new(false, 0)
	boxmodc10 = Gtk::HBox.new(false, 0)
	boxmodc11 = Gtk::HBox.new(false, 0)
	boxmodc12 = Gtk::HBox.new(false, 0)
	boxmodc13 = Gtk::HBox.new(false, 0)
	boxmodc14 = Gtk::HBox.new(false, 0)
	boxmodc15 = Gtk::HBox.new(false, 0)
	boxmodc16 = Gtk::HBox.new(false, 0)
	boxmodc17 = Gtk::HBox.new(false, 0)
	boxmodc18 = Gtk::HBox.new(false, 0)
	boxmodc19 = Gtk::HBox.new(false, 0)
	boxmodc20 = Gtk::HBox.new(false, 0)
	boxmodc21 = Gtk::HBox.new(false, 0)
	boxmodc22 = Gtk::HBox.new(false, 0)
	boxmodc23 = Gtk::HBox.new(false, 0)
	boxmodc24 = Gtk::HBox.new(false, 0)
	boxmodc25 = Gtk::HBox.new(false, 0)
	boxmodc26 = Gtk::HBox.new(false, 0)
	boxmodc27 = Gtk::HBox.new(false, 0)
	boxmodc28 = Gtk::HBox.new(false, 0)
	boxmodc29 = Gtk::HBox.new(false, 0)
	boxmodc30 = Gtk::HBox.new(false, 0)
	boxmodc31 = Gtk::HBox.new(false, 0)
	boxmodc32 = Gtk::HBox.new(false, 0)
	boxmodc33 = Gtk::HBox.new(false, 0)
	boxmodc34 = Gtk::HBox.new(false, 0)
	boxmodc35 = Gtk::HBox.new(false, 0)
	boxmodc36 = Gtk::HBox.new(false, 0)
	boxmodc37 = Gtk::HBox.new(false, 0)
	boxmodc38 = Gtk::HBox.new(false, 0)
	boxmodc39 = Gtk::HBox.new(false, 0)
	boxmodc40 = Gtk::HBox.new(false, 0)
	boxmodc41 = Gtk::HBox.new(false, 0)
	boxmodc42 = Gtk::HBox.new(false, 0)
	boxmodc43 = Gtk::HBox.new(false, 0)
	boxmodc44 = Gtk::HBox.new(false, 0)
	boxmodc45 = Gtk::HBox.new(false, 0)
	boxmodc46 = Gtk::HBox.new(false, 0)
	boxmodc47 = Gtk::HBox.new(false, 0)
	boxmodc48 = Gtk::HBox.new(false, 0)
	boxmodc100 = Gtk::HBox.new(true, 0)
	boxmodcv11.pack_start(boxmodc1, false, false, 0)
	boxmodcv12.pack_start(boxmodc2, false, false, 0)
	boxmodcv11.pack_start(boxmodc3, false, false, 0)
	boxmodcv12.pack_start(boxmodc4, false, false, 0)
	boxmodcv11.pack_start(boxmodc5, false, false, 0)
	boxmodcv12.pack_start(boxmodc6, false, false, 0)
	boxmodcv11.pack_start(boxmodc7, false, false, 0)
	boxmodcv12.pack_start(boxmodc8, false, false, 0)
	boxmodcv11.pack_start(boxmodc9, false, false, 0)
	boxmodcv12.pack_start(boxmodc10, false, false, 0)
	boxmodcv11.pack_start(boxmodc11, false, false, 0)
	boxmodcv12.pack_start(boxmodc12, false, false, 0)
	boxmodcv11.pack_start(boxmodc13, false, false, 0)
	boxmodcv12.pack_start(boxmodc14, false, false, 0)
	boxmodcv11.pack_start(boxmodc15, false, false, 0)
	boxmodcv12.pack_start(boxmodc16, false, false, 0)
	boxmodcv11.pack_start(boxmodc17, false, false, 0)
	boxmodcv12.pack_start(boxmodc18, false, false, 0)
	boxmodcv11.pack_start(boxmodc19, false, false, 0)
	boxmodcv12.pack_start(boxmodc20, false, false, 0)
	boxmodcv11.pack_start(boxmodc21, false, false, 0)
	boxmodcv12.pack_start(boxmodc22, false, false, 0)
	boxmodcv11.pack_start(boxmodc23, false, false, 0)
	boxmodcv12.pack_start(boxmodc24, false, false, 0)
	boxmodcv21.pack_start(boxmodc25, false, false, 0)
	boxmodcv22.pack_start(boxmodc26, false, false, 0)
	boxmodcv21.pack_start(boxmodc27, false, false, 0)
	boxmodcv22.pack_start(boxmodc28, false, false, 0)
	boxmodcv21.pack_start(boxmodc29, false, false, 0)
	boxmodcv22.pack_start(boxmodc30, false, false, 0)
	boxmodcv21.pack_start(boxmodc31, false, false, 0)
	boxmodcv22.pack_start(boxmodc32, false, false, 0)
	boxmodcv21.pack_start(boxmodc33, false, false, 0)
	boxmodcv22.pack_start(boxmodc34, false, false, 0)
	boxmodcv21.pack_start(boxmodc35, false, false, 0)
	boxmodcv22.pack_start(boxmodc36, false, false, 0)
	boxmodcv21.pack_start(boxmodc37, false, false, 0)
	boxmodcv22.pack_start(boxmodc38, false, false, 0)
	boxmodcv21.pack_start(boxmodc39, false, false, 0)
	boxmodcv22.pack_start(boxmodc40, false, false, 0)
	boxmodcv21.pack_start(boxmodc41, false, false, 0)
	boxmodcv22.pack_start(boxmodc42, false, false, 0)
	boxmodcv21.pack_start(boxmodc43, false, false, 0)
	boxmodcv22.pack_start(boxmodc44, false, false, 0)
	boxmodcv21.pack_start(boxmodc45, false, false, 0)
	boxmodcv22.pack_start(boxmodc46, false, false, 0)
	boxmodcv21.pack_start(boxmodc47, false, false, 0)
	boxmodcv22.pack_start(boxmodc48, false, false, 0)
	boxmodcv1.pack_start(boxmodcv11, false, false, 0)
	boxmodcv1.pack_start(boxmodcv12, false, false, 0)
	boxmodcv2.pack_start(boxmodcv21, false, false, 0)
	boxmodcv2.pack_start(boxmodcv22, false, false, 0)
	boxgrande.pack_start(boxmodcv1, true, true)
	boxgrande.pack_start(boxmodcv2, true, true)
	boxgen.pack_start(boxgrande, true, true)
	boxgen.pack_start(boxmodc100, false, false)
	modcapousc.add(boxgen)

	#Modifica marca

	capomod = @selcapo.selected
	labelmarca = Gtk::Label.new("Marca:")
	boxmodc1.pack_end(labelmarca, false, false, 5)
	marca = Gtk::Entry.new()
	marca.max_length=(14)
	marca.text = ("#{capomod[3]}")
	boxmodc2.pack_start(marca, false, false, 5)

	#Specie

	labelspecie = Gtk::Label.new("Specie:")
	boxmodc3.pack_end(labelspecie, false, false, 5)
	specie1 = Gtk::RadioButton.new("Bovini")
	boxmodc4.pack_start(specie1, false, false, 5)
	specie2 = Gtk::RadioButton.new(specie1, "Bufalini")
	boxmodc4.pack_start(specie2, false, false, 5)
	valspecie = capomod[4]
	if capomod[4] == "BOV"
		specie1.active=(true)
	else
		specie2.active=(true)
	end

	specie1.signal_connect("toggled") {
		if specie1.active?
			valspecie = "BOV" 
		end
	}
	specie2.signal_connect("toggled") {
		if specie2.active?
			valspecie = "BUF"
		end
	}

	#Modifica razza

	labelrazza = Gtk::Label.new("Razza:")
	listarazze = Gtk::ListStore.new(Integer, String, String)
	selrazze = Razzas.find(:all)
	selrazze.each do |r|
		iter1 = listarazze.append
		iter1[0] = r.id.to_i
		iter1[1] = r.razza
		iter1[2] = r.cod_razza
	end
	comborazze = Gtk::ComboBox.new(listarazze)
	renderer1 = Gtk::CellRendererText.new
	comborazze.pack_start(renderer1,false)
	comborazze.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	comborazze.pack_end(renderer1,false)
	comborazze.set_attributes(renderer1, :text => 2)
	boxmodc5.pack_end(labelrazza, false, false, 5)
	boxmodc6.pack_start(comborazze.popdown, false, false, 0)

	comborazze.set_active(0)
	contarazze = -1
	while comborazze.active_iter[1] != capomod[5]
		contarazze+=1
		comborazze.set_active(contarazze)
	end

	#Modifica data di nascita

	labelnascita = Gtk::Label.new("Data di nascita (GGMMAA):")
	boxmodc7.pack_end(labelnascita, false, false, 5)
	nascita = Gtk::Entry.new()
	nascita.text = ("#{capomod[6][0,2]}#{capomod[6][3,2]}#{capomod[6][8,2]}")
	boxmodc8.pack_start(nascita, false , false, 0)

	#Modifica sesso

	labelsesso = Gtk::Label.new("Sesso:")
	boxmodc9.pack_end(labelsesso, false, false, 5)
	sesso1 = Gtk::RadioButton.new("M")
	boxmodc10.pack_start(sesso1, false, false, 5)
	sesso2 = Gtk::RadioButton.new(sesso1, "F")
	boxmodc10.pack_start(sesso2, false, false, 5)
	valsesso = capomod[8]
	if capomod[8] == "M"
		sesso1.active=(true)
	else
		sesso2.active=(true)
	end

	sesso1.signal_connect("toggled") {
		if sesso1.active?
			valsesso="M"
		end
	}
	sesso2.signal_connect("toggled") {
		if sesso2.active?
			valsesso="F"
		end
	}

	#Modifica stalla di nascita / prima importazione

	labelstallanas = Gtk::Label.new("Stalla nascita / prima importazione:")
	stallanas = Gtk::Entry.new()
	stallanas.max_length=(8)
	stallanas.text = ("#{capomod[7]}")
	boxmodc11.pack_end(labelstallanas, false, false, 5)
	boxmodc12.pack_start(stallanas, false, false, 5)

	#Nazione origine

	labelnazorig = Gtk::Label.new("Nazione di origine:")
	boxmodc13.pack_end(labelnazorig, false, false, 5)
	listanazorig = Gtk::ListStore.new(Integer, String, String, Integer)
	listanazorig.clear
	selnazorig = Nations.find(:all)
	selnazorig.each do |no|
		iter1 = listanazorig.append
		iter1[0] = no.id
		iter1[1] = no.nome
		iter1[2] = no.codice
		iter1[3] = no.tipo
	end
	combonazorig = Gtk::ComboBox.new(listanazorig)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combonazorig.pack_start(renderer1,false)
	combonazorig.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combonazorig.pack_start(renderer1,false)
	combonazorig.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combonazorig.pack_start(renderer1,false)
	combonazorig.set_attributes(renderer1, :text => 2)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combonazorig.pack_start(renderer1,false)
	combonazorig.set_attributes(renderer1, :text => 3)
	boxmodc14.pack_start(combonazorig.popdown, false, false, 0)

	combonazorig.set_active(0)
	contanazorig = -1
	while combonazorig.active_iter[2] != capomod[9]
		contanazorig+=1
		combonazorig.set_active(contanazorig)
	end

	#Nazione nascita / prima importazione

	labelnaznas = Gtk::Label.new("Nazione nascita / prima importazione:")
	boxmodc15.pack_end(labelnaznas, false, false, 5)
	listanaznas = Gtk::ListStore.new(Integer, String, String)
	listanaznas.clear
	selnaznas = Nations.find(:all)
	selnaznas.each do |n|
		iter1 = listanaznas.append
		iter1[0] = n.id
		iter1[1] = n.nome
		iter1[2] = n.codice
	end
	combonaznas = Gtk::ComboBox.new(listanaznas)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combonaznas.pack_start(renderer1,false)
	combonaznas.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combonaznas.pack_start(renderer1,false)
	combonaznas.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combonaznas.pack_start(renderer1,false)
	combonaznas.set_attributes(renderer1, :text => 2)
	boxmodc16.pack_start(combonaznas.popdown, false, false, 0)
	combonaznas.set_active(0)
	contanaznas = -1
	while combonaznas.active_iter[2] != capomod[10]
		contanaznas+=1
		combonaznas.set_active(contanaznas)
	end

	#Data applicazione marca

	labelmarcatura = Gtk::Label.new("Data applicazione marca (GGMMAA):")
	boxmodc17.pack_end(labelmarcatura, false, false, 5)
	marcatura = Gtk::Entry.new()
#	marcatura.max_length=(6)
	if capomod[11] != nil
		marcatura.text = ("#{capomod[11][0,2]}#{capomod[11][3,2]}#{capomod[11][8,2]}")
	end
	boxmodc18.pack_start(marcatura, false, false, 0)

	#Iscrizione libro genealogico

	labelgen = Gtk::Label.new("Iscrizione libro genealogico:")
	boxmodc19.pack_end(labelgen, false, false, 5)
	gen1 = Gtk::RadioButton.new("S")
	boxmodc20.pack_start(gen1, false, false, 5)
	gen2 = Gtk::RadioButton.new(gen1, "N")
	boxmodc20.pack_start(gen2, false, false, 5)
	gen3 = Gtk::RadioButton.new(gen1, "NULLO")
	boxmodc20.pack_start(gen3, false, false, 5)
	valgen = capomod[12]
	if capomod[12] == "S"
		gen1.active=(true)
	elsif capomod[12] == "N"
		gen2.active=(true)
	else
		gen3.active=(true)
	end

	gen1.signal_connect("toggled") {
		if gen1.active?
			valgen="S"
		end
	}
	gen2.active=(true)
	gen2.signal_connect("toggled") {
		if gen2.active?
			valgen="N"
		end
	}
	gen3.signal_connect("toggled") {
		if gen3.active?
			valgen="NULLO"
		end
	}

	#Marca precedente

	labelprec = Gtk::Label.new("Marca precedente:")
	boxmodc21.pack_end(labelprec, false, false, 5)
	prec = Gtk::Entry.new()
	prec.max_length=(14)
	prec.text = ("#{capomod[13]}")
	boxmodc22.pack_start(prec, false, false, 5)

	#Marca madre

	labelmadre = Gtk::Label.new("Marca madre:")
	boxmodc23.pack_end(labelmadre, false, false, 5)
	madre = Gtk::Entry.new()
	madre.max_length=(14)
	madre.text = ("#{capomod[14]}")
	boxmodc24.pack_start(madre, false, false, 5)

	#Modifica motivo uscita

	labelmovusc = Gtk::Label.new("Motivo uscita:")
	listamovusc = Gtk::ListStore.new(Integer, String)
	selmovusc = Uscites.find(:all)
	selmovusc.each do |u|
		iter1 = listamovusc.append
		iter1[0] = u.codice.to_i
		iter1[1] = u.descr
	end

	combomovusc = Gtk::ComboBox.new(listamovusc)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combomovusc.pack_start(renderer1,false)
	combomovusc.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combomovusc.pack_start(renderer1,false)
	combomovusc.set_attributes(renderer1, :text => 1)
	boxmodc25.pack_end(labelmovusc, false, false, 5)
	boxmodc26.pack_start(combomovusc.popdown, false, false, 0)
	combomovusc.set_active(0)
	contamovusc = -1
	while combomovusc.active_iter[0].to_i != capomod[28].to_i
		contamovusc+=1
		combomovusc.set_active(contamovusc)
	end

	#Modifica data uscita

	labeldatausc = Gtk::Label.new("Data di uscita (GGMMAA):")
	boxmodc27.pack_end(labeldatausc, false, false, 5)
	datausc = Gtk::Entry.new()
#	nascita.max_length=(6)
	datausc.text = ("#{capomod[29][0,2]}#{capomod[29][3,2]}#{capomod[29][8,2]}")
	boxmodc28.pack_start(datausc, false , false, 0)

	#Nazione di destinazione

	labelnazdest = Gtk::Label.new("Nazione di destinazione:")
	boxmodc29.pack_end(labelnazdest, false, false, 5)
	listanazdest = Gtk::ListStore.new(Integer, String, String)
	listanazdest.clear
	selnazdest = Nations.find(:all)
	selnazdest.each do |n|
		iter1 = listanazdest.append
		iter1[0] = n.id
		iter1[1] = n.nome
		iter1[2] = n.codice
	end
	combonazdest = Gtk::ComboBox.new(listanazdest)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combonazdest.pack_start(renderer1,false)
	combonazdest.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combonazdest.pack_start(renderer1,false)
	combonazdest.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combonazdest.pack_start(renderer1,false)
	combonazdest.set_attributes(renderer1, :text => 2)
	boxmodc30.pack_start(combonazdest.popdown, false, false, 0)
	if capomod[31].to_s != ""
		combonazdest.set_active(0)
		contanazdest = -1
		while combonazdest.active_iter[2] != capomod[31]
			contanazdest+=1
			combonazdest.set_active(contanazdest)
		end
	else
	combonazdest.set_active(-1)
	end

	#Certificato sanitario

	labelcertsan = Gtk::Label.new("Certificato sanitario:")
	boxmodc31.pack_end(labelcertsan, false, false, 5)
	certsan = Gtk::Entry.new()
	certsan.max_length=(21)
	certsan.width_chars=(21)
	certsan.text = ("#{capomod[38]}")
	boxmodc32.pack_start(certsan, false, false, 5)

	#Allevamento destinazione

	labelalldest = Gtk::Label.new("Allevamento di destinazione:")
	boxmodc33.pack_end(labelalldest, false, false, 5)
	listaalldest = Gtk::ListStore.new(Integer, String, String, String)
	listaalldest.clear
	selalldest = Allevamentis.find(:all)
	selalldest.each do |a|
		iter1 = listaalldest.append
		iter1[0] = a.id
		iter1[1] = a.ragsoc
		iter1[2] = a.if
		iter1[3] = a.cod317
	end
	comboalldest = Gtk::ComboBox.new(listaalldest)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	comboalldest.pack_start(renderer1,false)
	comboalldest.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	comboalldest.pack_start(renderer1,false)
	comboalldest.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	comboalldest.pack_start(renderer1,false)
	comboalldest.set_attributes(renderer1, :text => 2)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	comboalldest.pack_start(renderer1,false)
	comboalldest.set_attributes(renderer1, :text => 3)
	boxmodc34.pack_start(comboalldest.popdown, false, false, 5)
	if capomod[30] != ""
		comboalldest.set_active(0)
		contaalldest = -1
		while comboalldest.active_iter[3] != capomod[30]
			contaalldest+=1
			comboalldest.set_active(contaalldest)
		end
		else
		comboalldest.set_active(-1)
	end

	#Macello destinazione

	labelmacdest = Gtk::Label.new("Macello di destinazione:")
	boxmodc35.pack_end(labelmacdest, false, false, 5)
	listamacdest = Gtk::ListStore.new(Integer, String, String, String, String)
	listamacdest.clear
	selmacdest = Macellis.find(:all)
	selmacdest.each do |a|
		iter1 = listamacdest.append
		iter1[0] = a.id
		iter1[1] = a.nomemac
		iter1[2] = a.ifmac
		iter1[3] = a.bollomac
		iter1[4] = a.region.regione
	end
	combomacdest = Gtk::ComboBox.new(listamacdest)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combomacdest.pack_start(renderer1,false)
	combomacdest.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combomacdest.pack_start(renderer1,false)
	combomacdest.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combomacdest.pack_start(renderer1,false)
	combomacdest.set_attributes(renderer1, :text => 2)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combomacdest.pack_start(renderer1,false)
	combomacdest.set_attributes(renderer1, :text => 3)
#	renderer1 = Gtk::CellRendererText.new
#	renderer1.visible=(false)
#	combomacdest.pack_start(renderer1,false)
#	combomacdest.set_attributes(renderer1, :text => 4)
	boxmodc36.pack_start(combomacdest.popdown, false, false, 5)
	if capomod[36] != ""
		combomacdest.set_active(0)
		contamacdest = -1
		while combomacdest.active_iter[3] != capomod[36]
			contamacdest+=1
			combomacdest.set_active(contamacdest)
		end
		else
		combomacdest.set_active(-1)
	end

	#Modello 4

	labelmod4 = Gtk::Label.new("Modello 4:")
	boxmodc37.pack_end(labelmod4, false, false, 5)
	mod4 = Gtk::Entry.new()
	mod4.text = ("#{capomod[26]}")
	boxmodc38.pack_start(mod4, false, false, 5)

	#Data modello 4

	labeldatamod4 = Gtk::Label.new("Data modello 4 (GGMMAA):")
	boxmodc39.pack_end(labeldatamod4, false, false, 5)
	datamod4 = Gtk::Entry.new()
	datamod4.max_length=(6)
	if capomod[27] != nil
		datamod4.text = ("#{capomod[27][0,2]}#{capomod[27][3,2]}#{capomod[27][8,2]}")
	end
	boxmodc40.pack_start(datamod4, false , false, 0)

	#Marca sostitutiva

	labelsost = Gtk::Label.new("Marca sostitutiva:")
	boxmodc41.pack_end(labelsost, false, false, 5)
	sost = Gtk::Entry.new()
	sost.max_length=(14)
	sost.text = ("#{capomod[41]}")
	boxmodc42.pack_start(sost, false, false, 5)

	#Bottone di inserimento

	bottmodcapousc = Gtk::Button.new( "Modifica capo" )
	bottmodcapousc.signal_connect("clicked") {
	errore = nil
	begin
		datanasingl = "20" + nascita.text[4,2] + nascita.text[2,2] + nascita.text[0,2]
		Time.parse("#{datanasingl}")
		datauscingl = "20" + datausc.text[4,2] + datausc.text[2,2] + datausc.text[0,2]
		Time.parse("#{datauscingl}")
		if marca.text == "" or comborazze.active == -1 or nascita.text == "" or combonazorig.active == -1 or combonaznas.active == -1 or combomovusc.active == -1 or stallanas.text == ""
			Avvisoprova.avviso(modcapousc, "Mancano dei dati obbligatori.")
			errore = 1
		elsif marca.text[0,2].upcase == "IT" and marca.text.length < 14
			Avvisoprova.avviso(modcapousc, "Marca corta.")
			errore = 1
		elsif nascita.text.to_i == 0
			Avvisoprova.avviso(modcapousc, "Data di nascita errata.")
			errore = 1
		elsif datausc.text.to_i == 0
			Avvisoprova.avviso(modcapousc, "Data di uscita errata.")
			errore = 1
		elsif marcatura.text != "" and marcatura.text.to_i == 0
			Avvisoprova.avviso(modcapousc, "lettere.")
			errore = 1
		elsif marcatura.text == "" #or @marcatura.text == 0 	#	elsif @datamod4.text != "" and @datamod4.text.to_i != 0
			datamarcingl = ""
		end
		if Time.parse("#{datanasingl}") > @giorno
				Avvisoprova.avviso(modcapousc, "La data di nascita non può essere successiva al giorno odierno.")
				errore = 1
		end
	rescue Exception => errore
		Avvisoprova.avviso(modcapousc, "Errore generico")
		errore = 1
	end
	if errore == nil
	dataingingl = "20" + datausc.text[4,2] + datausc.text[2,2] + datausc.text[0,2]
	if marcatura.text != ""
		datamarcingl = "20" + marcatura.text[4,2] + marcatura.text[2,2] + marcatura.text[0,2]
	else
		datamarcingl = ""
	end
	if datamod4.text != ""
		datamod4ingl = "20" + datamod4.text[4,2] + datamod4.text[2,2] + datamod4.text[0,2]
	else
		datamod4ingl = nil
	end
	if combomacdest.active == -1
		macdest = ""
	else
		macdest = combomacdest.active_iter[0]
	end
	if comboalldest.active == -1
		alldest = ""
	else
		alldest = comboalldest.active_iter[0]
	end
	if combonazdest.active == -1
		nazdest = ""
	else
		nazdest = combonazdest.active_iter[2]
	end

		Animals.update(capomod[0], {:marca => "#{marca.text.upcase}", :specie => "#{valspecie}", :razza_id => "#{comborazze.active_iter[0]}", :data_nas => "#{datanasingl.to_i}", :sesso => "#{valsesso}", :stalla_nas => "#{stallanas.text.upcase}", :naz_orig => "#{combonazorig.active_iter[2]}", :naz_nasprimimp => "#{combonaznas.active_iter[2]}", :data_applm => "#{datamarcingl}", :ilg => "#{valgen}", :marca_prec => "#{prec.text.upcase}", :marca_madre => "#{madre.text.upcase}", :cm_usc => "#{combomovusc.active_iter[0]}", :uscita => "#{datauscingl.to_i}", :naz_dest => "#{nazdest}", :certsanusc => "#{certsan.text.upcase}", :allevamenti_id => "#{alldest}", :macelli_id => "#{macdest}", :mod4 => "#{mod4.text}", :data_mod4 => "#{datamod4ingl.to_i}"})
		Conferma.conferma(modcapousc, "Movimento modificato.")
		modcapousc.destroy
	end
	}
	boxmodc100.pack_start(bottmodcapousc, false, false, 5)

# Bottone di eliminazione del movimento

	bottelimina = Gtk::Button.new( "Elimina capo" )
	bottelimina.signal_connect("clicked") {
		avviso = Gtk::MessageDialog.new(modcapousc, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Elimino il movimento di uscita del capo #{capomod[3]} ?")
		risposta = avviso.run
		avviso.destroy
		if risposta == Gtk::Dialog::RESPONSE_YES
			Animals.delete(capomod[0])
			ingrcapo = Animals.find(:last, :conditions => "relaz_id='#{@stallaoper}' and tipo='I' and marca = '#{capomod[3]}' and uscito = '1'")
			Animals.update(ingrcapo.id, {:uscito => "0"})
			Conferma.conferma(modcapousc, "Movimento eliminato.")
			modcapousc.destroy
		else
			Conferma.conferma(modcapousc, "Movimento non eliminato.")
		end
	}
	boxmodc100.pack_start(bottelimina, false, false, 5)

# Bottone di chiusura finestra

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		modcapousc.destroy
	}
	boxmodc100.pack_start(bottchiudi, false, false, 5)
	modcapousc.show_all

end

# Visualizza registro

def visregistro
	mvisreg = Gtk::Window.new("Vista registro")
	#mvisreg.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	mvisreg.set_default_size(800, 600)
	mvisreg.maximize
	mvisregscroll = Gtk::ScrolledWindow.new #(hadjustment = nil, vadjustment = nil)
	boxregv = Gtk::VBox.new(false, 0)
	boxreg1 = Gtk::HBox.new(false, 0)
	boxreg2 = Gtk::HBox.new(false, 0)
	boxregv.pack_start(boxreg1, false, false, 5)
	boxregv.pack_start(boxreg2, true, true, 5)
	mvisreg.add(boxregv)

	def ricercareg
		@selreg.each do |m|
			iterreg = @listareg.append
			iterreg[0] = m.id.to_i
			iterreg[1] = m.progressivo
			iterreg[2] = m.marca
			iterreg[3] = m.razza
			iterreg[4] = m.sesso
			iterreg[5] = m.madre
			iterreg[6] = m.tipoingresso
			iterreg[7] = m.datanascita.strftime("%d/%m/%Y")
			iterreg[8] = m.dataingresso.strftime("%d/%m/%Y")
			iterreg[9] = m.provenienza
			iterreg[10] = m.tipouscita
			if m.datauscita != nil
				iterreg[11] = m.datauscita.strftime("%d/%m/%Y")
			else
				iterreg[11] = ""
			end
			iterreg[12] = m.destinazione
			iterreg[13] = m.marcaprec
			iterreg[14] = m.mod4ingr
			iterreg[15] = m.mod4usc
			iterreg[16] = m.certsaningr
			iterreg[17] = m.certsanusc
			iterreg[18] = m.ragsoc
		end
	end

	regingressi = Gtk::Button.new( "Visualizza ingressi" )
	reguscite = Gtk::Button.new( "Visualizza uscite" )
	regpresenti = Gtk::Button.new( "Visualizza presenti in stalla" )
	regricerca = Gtk::Button.new( "Cerca capo" )
	regricercaentry = Gtk::Entry.new
	@listareg = Gtk::ListStore.new(Integer, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String)
	@vistareg = Gtk::TreeView.new(@listareg)
	@vistareg.selection.mode = Gtk::SELECTION_SINGLE #BROWSE #SINGLE #MULTIPLE
#	@vistareg.show_expanders = (true)
	@vistareg.rules_hint = true
#	@vistareg.set_enable_grid_lines(true)
	regingressi.signal_connect("clicked") {
		@listareg.clear
		@selreg = Registros.find(:all, :conditions => "relaz_id='#{@stallaoper}'") # and tipouscita='null'")
		ricercareg
	}
	reguscite.signal_connect("clicked") {
		@listareg.clear
		@selreg = Registros.find(:all, :conditions => "relaz_id='#{@stallaoper}' and tipouscita IS NOT NULL")
		ricercareg
	}

	regpresenti.signal_connect("clicked") {
		@listareg.clear
		@selreg = Registros.find(:all, :from => 'registros', :conditions => "relaz_id='#{@stallaoper}' and tipouscita IS NULL") # and uscito='0'")
		ricercareg
	}
	regricerca.signal_connect("clicked") {
		@listareg.clear
		@selreg = Registros.find(:all, :conditions => "relaz_id='#{@stallaoper}' and marca LIKE '%#{regricercaentry.text}%'")
		ricercareg
	}
		cella = Gtk::CellRendererText.new
		colonna0 = Gtk::TreeViewColumn.new("Id", cella)
		colonna0.resizable = true
		colonna1 = Gtk::TreeViewColumn.new("Progressivo", cella)
		colonna1.resizable = true
		colonna2 = Gtk::TreeViewColumn.new("Marca", cella)
		colonna2.resizable = true
		colonna3 = Gtk::TreeViewColumn.new("Razza", cella)
		colonna4 = Gtk::TreeViewColumn.new("Sesso", cella)
		colonna5 = Gtk::TreeViewColumn.new("Madre", cella)
		colonna5.resizable = true
		colonna6 = Gtk::TreeViewColumn.new("Tipo ingresso", cella)
		colonna7 = Gtk::TreeViewColumn.new("Data di nascita", cella)
		colonna8 = Gtk::TreeViewColumn.new("Data ingresso", cella)
		colonna9 = Gtk::TreeViewColumn.new("Provenienza", cella)
		colonna10 = Gtk::TreeViewColumn.new("Tipo uscita", cella)
		colonna11 = Gtk::TreeViewColumn.new("Data uscita", cella)
		colonna12 = Gtk::TreeViewColumn.new("Destinazione", cella)
		colonna13 = Gtk::TreeViewColumn.new("Marca precedente", cella)
		colonna14 = Gtk::TreeViewColumn.new("Mod. 4 ingresso", cella)
		colonna15 = Gtk::TreeViewColumn.new("Mod. 4 uscita", cella)
		colonna16 = Gtk::TreeViewColumn.new("Cert. san. ingresso", cella)
		colonna17 = Gtk::TreeViewColumn.new("Cert. san. uscita", cella)
		colonna18 = Gtk::TreeViewColumn.new("Ragione sociale", cella)
		colonna0.set_attributes(cella, :text => 0)
		colonna1.set_attributes(cella, :text => 1)
		colonna2.set_attributes(cella, :text => 2)
		colonna3.set_attributes(cella, :text => 3)
		colonna4.set_attributes(cella, :text => 4)
		colonna5.set_attributes(cella, :text => 5)
		colonna6.set_attributes(cella, :text => 6)
		colonna7.set_attributes(cella, :text => 7)
		colonna8.set_attributes(cella, :text => 8)
		colonna9.set_attributes(cella, :text => 9)
		colonna10.set_attributes(cella, :text => 10)
		colonna11.set_attributes(cella, :text => 11)
		colonna12.set_attributes(cella, :text => 12)
		colonna13.set_attributes(cella, :text => 13)
		colonna14.set_attributes(cella, :text => 14)
		colonna15.set_attributes(cella, :text => 15)
		colonna16.set_attributes(cella, :text => 16)
		colonna17.set_attributes(cella, :text => 17)
		colonna18.set_attributes(cella, :text => 18)
		@vistareg.append_column(colonna0)
		@vistareg.append_column(colonna1)
		@vistareg.append_column(colonna2)
		@vistareg.append_column(colonna3)
		@vistareg.append_column(colonna4)
		@vistareg.append_column(colonna5)
		@vistareg.append_column(colonna6)
		@vistareg.append_column(colonna7)
		@vistareg.append_column(colonna8)
		@vistareg.append_column(colonna9)
		@vistareg.append_column(colonna10)
		@vistareg.append_column(colonna11)
		@vistareg.append_column(colonna12)
		@vistareg.append_column(colonna13)
		@vistareg.append_column(colonna14)
		@vistareg.append_column(colonna15)
		@vistareg.append_column(colonna16)
		@vistareg.append_column(colonna17)
		@vistareg.append_column(colonna18)
	mvisregscroll.add(@vistareg)
	boxreg2.pack_start(mvisregscroll, true, true, 0)
	boxreg1.pack_start(regingressi, false, false, 0)
	boxreg1.pack_start(reguscite, false, false, 0)
	boxreg1.pack_start(regpresenti, false, false, 0)
	boxreg1.pack_start(regricerca, false, false, 5)
	boxreg1.pack_start(regricercaentry, false, false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mvisreg.destroy
	}
	boxregv.pack_start(bottchiudi, false, false, 0)
	mvisreg.show_all
end

#Creazione del file da inviare all'ULSS

def creafile
		nomefile = Time.now.strftime("#{@t.ragsoc.ragsoc.gsub(/[ ]/, "")}""%m%d_%H%M.asc")
	if @sistema == "linux"
		fileulss = File.new("./file/#{nomefile}", "w+")
	else
		fileulss = File.new(".\\file\\#{nomefile}", "w+")
	end
	selmov = Animals.find(:all, :from=> "animals", :conditions => "relaz_id='#{@stallaoper}' and file='0'")

	if selmov.length != 0
		selluncampi = Luncampis.find(:all)
		itercampi = Array.new
		selluncampi.each do |campi|
			itercampi[0] = campi.id
			itercampi[1] = campi.tipo
			itercampi[2] = campi.operazione
			itercampi[3] = campi.cod317
			itercampi[4] = campi.ragsoc
			itercampi[5] = campi.tifragsoc
			itercampi[6] = campi.ifragsoc
			itercampi[7] = campi.atp
			itercampi[8] = campi.prop
			itercampi[9] = campi.tifprop
			itercampi[10] = campi.ifprop
			itercampi[11] = campi.marca
			itercampi[12] = campi.specie
			itercampi[13] = campi.razza
			itercampi[14] = campi.nascita
			itercampi[15] = campi.cod317nascita
			itercampi[16] = campi.sesso
			itercampi[17] = campi.nazorig
			itercampi[18] = campi.nazprimimp
			itercampi[19] = campi.applmarca
			itercampi[20] = campi.ilg
			itercampi[21] = campi.marcaprec
			itercampi[22] = campi.madre
			itercampi[23] = campi.padre
			itercampi[24] = campi.datapass
			itercampi[25] = campi.codmoving
			itercampi[26] = campi.dataing
			itercampi[27] = campi.cod317prov
			itercampi[28] = campi.comuneprov
			itercampi[29] = campi.nazprov
			itercampi[30] = campi.codmovusc
			itercampi[31] = campi.datausc
			itercampi[32] = campi.cod317dest
			itercampi[33] = campi.comunedest
			itercampi[34] = campi.nazdest
			itercampi[35] = campi.ragsocdest
			itercampi[36] = campi.trasportatore
			itercampi[37] = campi.comunetrasp
			itercampi[38] = campi.targatrasp
			itercampi[39] = campi.mod4
			itercampi[40] = campi.marcasost
			itercampi[41] = campi.idfiscall
			itercampi[42] = campi.datamod4
			itercampi[43] = campi.codlibgen
			itercampi[44] = campi.regmac
			itercampi[45] = campi.idfiscmac
			itercampi[46] = campi.bollomac
			itercampi[47] = campi.embryo
			itercampi[48] = campi.idfisc317nasc
			itercampi[49] = campi.dataprimoingr
			itercampi[50] = campi.madreembryotransf
			itercampi[51] = campi.rifloc
			itercampi[52] = campi.certsan
			itercampi[53] = campi.crlf
		end
		itermov = Array.new
		selmov.each do |mov|
			itermov[0] = mov.id
			itermov[1] = mov.relaz_id
			itermov[2] = mov.tipo
			itermov[3] = 0 #mov.movimenti_id
			itermov[4] = mov.marca
			itermov[6] = mov.razza_id
			itermov[8] = mov.specie
			itermov[9] = mov.data_nas
			itermov[10] = mov.stalla_nas
			itermov[11] = mov.naz_nasprimimp
			itermov[12] = mov.naz_orig
			itermov[13] = mov.data_applm
			itermov[14] = mov.ilg
			itermov[15] = mov.clg
			itermov[16] = mov.embryo
			itermov[17] = mov.marca_prec
			itermov[18] = mov.marca_madre
			itermov[19] = mov.marca_padre
			itermov[20] = mov.donatrice
			itermov[22] = mov.sesso
			itermov[23] = mov.cm_ing
			itermov[24] = mov.data_ingr
			if mov. allevamenti_id != nil
				itermov[25] = mov.allevamenti.ragsoc
				itermov[28] = mov.allevamenti.if
				itermov[29] = mov.allevamenti.cod317
			else
				itermov[25] = ""
				itermov[28] = ""
				itermov[29] = ""
			end
			itermov[26] = mov.mod4
			itermov[27] = mov.data_mod4
			itermov[32] = mov.naz_prov
			itermov[34] = mov.cm_usc
			itermov[35] = mov.uscita
			itermov[36] = mov.ditta_racc
			itermov[37] = mov.trasp
			itermov[38] = mov.marcasost
			itermov[39] = mov.certsan
			itermov[40] = mov.rifloc
			itermov[41] = mov.data_certsan
			itermov[44] = mov.naz_dest
			if mov.allevamentiusc_id != nil
				itermov[43] = mov.allevamentiusc.cod317
				itermov[45] = mov.allevamentiusc.ragsoc
				itermov[47] = mov.allevamentiusc.if
			else
				itermov[43] = ""
				itermov[45] = ""
				itermov[47] = ""
			end
			if mov.macelli_id != nil
				itermov[46] = mov.macelli.nomemac
				itermov[48] = mov.macelli.region.codreg
				itermov[49] = mov.macelli.ifmac
				itermov[50] = mov.macelli.bollomac
			else
				itermov[46] = ""
				itermov[48] = ""
				itermov[49] = ""
				itermov[50] = ""
			end
			itermov[51] = mov.uscito
			itermov[52] = mov.certsanusc
			itermov[53] = mov.data_certsanusc
			itermov[54] = mov.file

			#creazione tipofile

			tipofile = itermov[2].ljust(itercampi[1])

			#creazione 317 prop

			file317 = mov.relaz.stalle.cod317.ljust(itercampi[3])

			#creazione ragsoc

			ragsocfile = mov.relaz.ragsoc.ragsoc.ljust(itercampi[4])

			#creazione tipo idfisc ragsoc

			tifragsocfile = mov.relaz.ragsoc.if.ljust(itercampi[5])

			#creazione idfisc ragsoc
			if mov.relaz.ragsoc.if == 'I'
				ifragsoc = mov.relaz.ragsoc.piva
			else
				ifragsoc = mov.relaz.ragsoc.codfisc
			end
			ifragsocfile= ifragsoc.ljust(itercampi[6])

			#creazione atp

			atpfile = mov.relaz.atp.ljust(itercampi[7])

			#creazione prop

			propfile = mov.relaz.prop.prop.ljust(itercampi[8])

			#creazione tipo idfisc prop

			tifpropfile = mov.relaz.prop.if.ljust(itercampi[9])

			#creazione idfisc prop
			if mov.relaz.prop.if == 'I'
				ifprop = mov.relaz.prop.piva
			else
				ifprop = mov.relaz.prop.codfisc
			end
			contaspazi = itercampi[10] - ifprop.to_s.length
			spaziifprop = " " * contaspazi
			ifpropfile = "#{ifprop}" + "#{spaziifprop}"

			ifpropfile = ifprop.ljust(itercampi[10])

			#creazione marca

			marcafile = itermov[4].ljust(itercampi[11])

			#creazione specie

			speciefile = itermov[8].ljust(itercampi[12])

			#Creazione razza
			if itermov[6] != nil
				razzafile = mov.razza.cod_razza.ljust(itercampi[13])
			else
				razzafile = itermov[6].ljust(itercampi[13])
			end

			#creazione data nascita
			if itermov[9] != nil
				datait = itermov[9].strftime("%d%m%Y")
			else
				datait = ""
			end
			datafile = datait.ljust(itercampi[14])

			#creazione cod. 317 nascita / prima importazione

			file317nas = itermov[10].ljust(itercampi[15])

			#creazione sesso

			sessofile = itermov[22].ljust(itercampi[16])

			#creazione nazione origine

			nazorigfile = itermov[12].ljust(itercampi[17])

			#creazione nazione prima importazione

			nazprimimpfile = itermov[11].ljust(itercampi[18])

			#creazione data applicazione marca
			if itermov[13] != nil
				dataapplmarcait = itermov[13].strftime("%d%m%Y")
			else
				dataapplmarcait = ""
			end

			dataapplmarcafile = dataapplmarcait.ljust(itercampi[19])

			#creazione ilg

			ilgfile = itermov[14].ljust(itercampi[20])

			#creazione marca precedente

			marcaprecfile = itermov[17].ljust(itercampi[21])

			#creazione marca madre

			madrefile = itermov[18].ljust(itercampi[22])

			#creazione marca padre

			padrefile = itermov[19].ljust(itercampi[23])

			#creazione data passaporto (campo non presente nella tabella)

			datapassfile = "".ljust(itercampi[24])

			#creazione codice movimento ingresso

			movingfile = "#{itermov[23]}".ljust(itercampi[25])

			#creazione data ingresso
			if itermov[24] != nil
				dataingit = itermov[24].strftime("%d%m%Y")
			else
				dataingit = ""
			end
			dataingfile = dataingit.ljust(itercampi[26])

			#creazione cod. 317 provenienza

			file317prov = itermov[29].ljust(itercampi[27])

			#creazione comune provenienza (campo non presente nella tabella)

			comunefile = "".ljust(itercampi[28])

			#creazione nazione provenienza

			nazprovfile = "#{itermov[32]}".ljust(itercampi[29])

			#creazione codice movimento uscita

			movuscfile = itermov[34].to_s.ljust(itercampi[30])

			#creazione data uscita
			if itermov[35] != nil
				datauscit = itermov[35].strftime("%d%m%Y")
			else
				datauscit = ""
			end

			datauscfile = "#{datauscit}".ljust(itercampi[31])

			#creazione codice 317 allevamento destinazione

			file317dest = itermov[43].ljust(itercampi[32])

			#creazione comune destinazione (campo non presente nella tabella)

			comunedestfile = "".ljust(itercampi[33])

			#creazione nazione destinazione

			nazdestfile = "#{itermov[44]}".ljust(itercampi[34])

			#creazione rag. soc. destinazione

			ragsocdestfile = itermov[45].ljust(itercampi[35])

			#creazione trasportatore

			traspfile = "#{itermov[37]}".ljust(itercampi[36])

			#creazione comune trasportatore (campo non presente nella tabella)

			comtraspfile = "".ljust(itercampi[37])

			#creazione targa trasportatore (campo non presente nella tabella)

			targatraspfile = "".ljust(itercampi[38])

			#creazione mod. 4
			if itermov[34] != 4
				mod4file = "#{itermov[26]}".ljust(itercampi[39])
			else
				mod4file = itermov[52].ljust(itercampi[39])
			end

			#creazione marca sostitutiva

			marcasostfile = "#{itermov[38]}".ljust(itercampi[40])

			#creazione identificativo fiscale allevamento provenienza o destinazione

			idfiscallfile = "#{itermov[28]}".ljust(itercampi[41])

			#creazione data mod. 4
			if itermov[27] != nil
				datamod4it = itermov[27].strftime("%d%m%Y")
			elsif itermov[53] != nil
				datamod4it = itermov[53].strftime("%d%m%Y")
			else
				datamod4it =""
			end

			datamod4file = datamod4it.ljust(itercampi[42])

			#creazione libro genealogico

			clgfile = "#{itermov[15]}".ljust(itercampi[43])

			#creazione regione macello

			regmacfile = itermov[48].ljust(itercampi[44])

			#creazione identificativo fiscale macello

			idfiscmacfile = itermov[49].ljust(itercampi[45])

			#creazione bollo CEE macello

			bollomacfile = itermov[50].ljust(itercampi[46])

			#creazione embryo transfer

			embryofile = "#{itermov[16]}".ljust(itercampi[47])

			#creazione identificativo fiscale stalla di nascita o prima importazione
			#ATTENZIONE: creare tabella con scelta allevamenti anche qua.

			ifragsocnasfile = "".ljust(itercampi[48])

			#creazione data primo ingresso (campo non presente nella tabella)

			primoingrfile = "".ljust(itercampi[49])

			#creazione madre donatrice

			donatricefile = "#{itermov[20]}".ljust(itercampi[50])

			#creazione riferimento locale

			riflocfile = "#{itermov[40]}".ljust(itercampi[51])

			#creazione certificato sanitario

			certsanfile = "#{itermov[39]}".ljust(itercampi[52])

			fileulss.puts("RC" + "#{tipofile}" + "I" + "#{file317}" + "#{ragsocfile}" + "#{tifragsocfile}" + "#{ifragsocfile}" + "#{atpfile}" + "#{propfile}" + "#{tifpropfile}" + "#{ifpropfile}" + "#{marcafile}" + "#{speciefile}" + "#{razzafile}" + "#{datafile}" + "#{file317nas}" + "#{sessofile}" + "#{nazorigfile}" + "#{nazprimimpfile}" + "#{dataapplmarcafile}" + "#{ilgfile}" + "#{marcaprecfile}" + "#{madrefile}" + "#{padrefile}" + "#{datapassfile}" + "#{movingfile}" +"#{dataingfile}" + "#{file317prov}" + "#{comunefile}" + "#{nazprovfile}" + "#{movuscfile}" + "#{datauscfile}" + "#{file317dest}" + "#{comunedestfile}" + "#{nazdestfile}" + "#{ragsocdestfile}" + "#{traspfile}" + "#{comtraspfile}" + "#{targatraspfile}" + "#{mod4file}" + "#{marcasostfile}" + "#{idfiscallfile}" + "#{datamod4file}" + "#{clgfile}" + "#{regmacfile}" + "#{idfiscmacfile}" + "#{bollomacfile}" + "#{embryofile}" + "#{ifragsocnasfile}" + "#{primoingrfile}" + "#{donatricefile}" + "#{riflocfile}" + "#{certsanfile}")
			Animals.update(itermov[0], {:file => "1"})
		end

		filler1 = "".ljust(441)
		filler2 = "".ljust(94)

		fileulss.rewind
		righe = fileulss.readlines.length + 1
		righefile = "#{righe}".ljust(6)
		fileulss.write("RCT" + "#{filler1}" + "#{righefile}")
		fileulss.rewind
		checksum = 0
		fileulss.each_byte do |ch|
			checksum+=ch
		end
		checksumfile = "#{checksum}".ljust(12)
		fileulss.puts("#{checksumfile}" + "#{filler2}")
		fileulss.puts("")
		fileulss.close

		if @sistema == "linux"
			Dir.foreach("./invio") do |f|
				File.delete("./invio/#{f}") if f.include?(".asc")
			end
			File.copy("./file/#{nomefile}", "./invio")
		else
			Dir.foreach(".\\invio") do |f|
				File.delete(".\\invio\\#{f}") if f.include?(".asc")
			end
			File.copy(".\\file\\#{nomefile}", ".\\invio")
		end

		Conferma.conferma(@mcreaprop, "File generato correttamente.")
	else
		Conferma.conferma(@mcreaprop, "Nessun capo da inviare.")
	end
end

# Maschera stampa registro

def mascstamparegistro
	@mstamparegistro = Gtk::Window.new("Stampa registro")
	@mstamparegistro.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxsregv = Gtk::VBox.new(false, 0)
	boxsreg1 = Gtk::HButtonBox.new #(false, 5)
	boxsreg2 = Gtk::HButtonBox.new #(false, 5)
	boxsreg3 = Gtk::HBox.new(false, 5)
	boxsreg4 = Gtk::HBox.new(false, 5)
	boxsreg5 = Gtk::HBox.new(false, 5)
	boxsreg6 = Gtk::HBox.new(false, 5)
	boxsreg7 = Gtk::HBox.new(false, 5)
	boxsreg8 = Gtk::HBox.new(false, 5)
	boxsreg9 = Gtk::HBox.new(false, 5)
	boxsreg10 = Gtk::HBox.new(false, 5)
	boxsregv.pack_start(boxsreg1, false, false, 5)
	boxsregv.pack_start(boxsreg2, false, false, 5)
	boxsregv.pack_start(boxsreg3, false, false, 5)
	boxsregv.pack_start(boxsreg4, false, false, 5)
	boxsregv.pack_start(boxsreg5, false, false, 5)
	boxsregv.pack_start(boxsreg6, false, false, 5)
	boxsregv.pack_start(boxsreg7, false, false, 5)
	boxsregv.pack_start(boxsreg8, false, false, 5)
	boxsregv.pack_start(boxsreg9, false, false, 5)
	boxsregv.pack_start(boxsreg10, false, false, 5)
	@mstamparegistro.add(boxsregv)
	stampaingr = Gtk::Button.new("Stampa registro di carico")
	boxsreg1.pack_start(stampaingr, false, false, 5)
	stampausc = Gtk::Button.new("Stampa registro di scarico")
	boxsreg2.pack_start(stampausc, false, false, 5)
	stampaingr.signal_connect("clicked") {
		registroingr
	}
	stampausc.signal_connect("clicked") {
		registrousc
	}
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		@mstamparegistro.destroy
	}
	boxsregv.pack_start(bottchiudi, false, false, 0)
	@mstamparegistro.show_all
end

def registroingr
	foglio = PDF::Writer.new(:paper => "A4") # , :font_size => 5)
	foglio.margins_mm(20, 10, 7)
	foglio.select_font("Helvetica")
#	foglio.start_page_numbering(10, 10, 6, :center, "<PAGENUM>/08", 1)
	foglio.open_object do |piede|
		foglio.save_state
		dimcar = 6
#		x = 500 #spostamento orizzontale
		y = foglio.absolute_bottom_margin
		z = foglio.absolute_left_margin
		w = foglio.absolute_right_margin
		testo = "Stampato in data #{@giorno.strftime("%d/%m/%Y")}"
		boh = foglio.text_width(testo, dimcar) #/ 2.0
		q = foglio.absolute_bottom_margin + (dimcar * 1.01)
		m = w - boh
		#foglio.line(z, q, w, q).stroke
		foglio.add_text(m, y, testo, dimcar)
		foglio.restore_state
		foglio.close_object
		foglio.add_object(piede, :all_pages)
	end
	@tabella = PDF::SimpleTable.new
#	@tabella.title = "PDF dati"
	@tabella.show_lines = :all
	@tabella.show_headings = true
	@tabella.orientation = :right
	@tabella.position = :left
	@tabella.shade_rows = :none
	@tabella.split_rows = true
	@tabella.font_size = 8
	@tabella.heading_font_size = 8
	@tabella.width = 550
	@tabella.minimum_space = 10
	@tabella.column_order.push(*%w(prog marca razza sesso madre nc nascita ingresso prov))
	@tabella.columns["prog"] = PDF::SimpleTable::Column.new("prog") { |col|
		col.heading = "Numero ordine"
		col.width = 40
	}
	@tabella.columns["marca"] = PDF::SimpleTable::Column.new("marca") { |col|
		col.heading = "Marchio di identificazione"
		col.width = 90
	}
	@tabella.columns["razza"] = PDF::SimpleTable::Column.new("razza") { |col|
		col.heading = "Razza"
		col.width = 35
	}
	@tabella.columns["sesso"] = PDF::SimpleTable::Column.new("sesso") { |col|
		col.heading = "Sesso"
		col.width = 35
	}
	@tabella.columns["madre"] = PDF::SimpleTable::Column.new("madre") { |col|
		col.heading = "Codice della madre"
		col.width = 90
	}
	@tabella.columns["nc"] = PDF::SimpleTable::Column.new("nc") { |col|
		col.heading = "Nato / acquisto"
		col.width = 40
	}
	@tabella.columns["nascita"] = PDF::SimpleTable::Column.new("nascita") { |col|
		col.heading = "Data di nascita"
		col.width = 55
	}
	@tabella.columns["ingresso"] = PDF::SimpleTable::Column.new("ingresso") { |col|
		col.heading = "Data di ingresso"
		col.width = 55
	}
	@tabella.columns["prov"] = PDF::SimpleTable::Column.new("prov") { |col|
		col.heading = "Provenienza"
	}
	data = Array.new
	#selcapi = Registros.find(:all, :conditions => "relaz_id='#{@stallaoper}' and stampacarico='0'")

	contid = Relazs.find(:first, :conditions => "id = '#{@stallaoper}'")
	selcapi = Registros.find(:all, :conditions => "contatori_id = '#{contid.contatori_id}' and stampacarico='0'", :order => ["dataingresso, id"])
	selcapi.each do |i, index|
		data << {"prog" => "#{i.progressivo.to_s}", "marca" => "#{i.marca}", "razza" => "#{i.razza}", "sesso" => "#{i.sesso}", "madre" => "#{i.madre}",	"nc" => "#{i.tipoingresso}", "nascita" => "#{i.datanascita.strftime("%d/%m/%Y")}", "ingresso" => "#{i.dataingresso.strftime("%d/%m/%Y")}", "prov" => "#{i.provenienza}"}
	end
	if data.length != 0
		@tabella.data.replace data
		@tabella.render_on(foglio)
		if @sistema == "linux"
			foglio.save_as('./registro/registro_ingresso.pdf')
			system("evince ./registro/registro_ingresso.pdf")
		else
			foglio.save_as('.\registro\registro_ingresso.pdf')
			@shell.ShellExecute('.\registro\registro_ingresso.pdf', '', '', 'open', 3)
		end
		avviso = Gtk::MessageDialog.new(@mstamparegistro, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "La stampa è stata eseguita correttamente?")
		risposta = avviso.run
		avviso.destroy
		if risposta == Gtk::Dialog::RESPONSE_YES
			avviso2 = Gtk::MessageDialog.new(@mstamparegistro, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Aggiorno il registro?")
			risposta2 = avviso2.run
			avviso2.destroy
			if risposta2 == Gtk::Dialog::RESPONSE_YES
				selcapi.each do |d|
					Registros.update(d.id, { :stampacarico => "1"})
				end
				Conferma.conferma(@mstamparegistro, "Il registro è stato aggiornato.")
			else
				Conferma.conferma(@mstamparegistro, "Il registro non è stato aggiornato.")
			end
		else
			Conferma.conferma(@mstamparegistro, "Si dovrà rilanciare la stampa.")
		end
	else
		Conferma.conferma(@mstamparegistro, "Non ci sono dati da stampare.")
	end
end

def registrousc
	fogliousc = PDF::Writer.new(:paper => "A4", :orientation => :landscape) # , :font_size => 5)
	fogliousc.margins_mm(20, 6, 12)
	fogliousc.select_font("Helvetica")
#	fogliousc.start_page_numbering(10, 10, 6, :center, "<PAGENUM>/08", 1)
	fogliousc.open_object do |piede|
		fogliousc.save_state
		dimcar = 6
#		x = 500 #spostamento orizzontale
		y = fogliousc.absolute_bottom_margin
		z = fogliousc.absolute_left_margin
		w = fogliousc.absolute_right_margin
		testo = "Stampato in data #{@giorno.strftime("%d/%m/%Y")}"
		boh = fogliousc.text_width(testo, dimcar) #/ 2.0
		q = fogliousc.absolute_bottom_margin + (dimcar * 1.01)
		m = w - boh
		#fogliousc.line(z, q, w, q).stroke
		fogliousc.add_text(m, y, testo, dimcar)
		fogliousc.restore_state
		fogliousc.close_object
		fogliousc.add_object(piede, :all_pages)
	end
	@tabellausc = PDF::SimpleTable.new
	@tabellausc.show_lines = :all
	@tabellausc.show_headings = true
	@tabellausc.orientation = :right
	@tabellausc.position = :left
	@tabellausc.shade_rows = :none
	@tabellausc.split_rows = true
	@tabellausc.font_size = 8
	@tabellausc.heading_font_size = 8
	@tabellausc.minimum_space = 10
	@tabellausc.column_order.push(*%w(prog marca razza sesso madre nc nascita ingresso prov motusc datausc destinazione marcaprec mod4))
	@tabellausc.columns["prog"] = PDF::SimpleTable::Column.new("prog") { |col|
		col.heading = "Numero ordine"
		col.width = 40
	}
	@tabellausc.columns["marca"] = PDF::SimpleTable::Column.new("marca") { |col|
		col.heading = "Marchio di identificazione"
		col.width = 76 #80
	}
	@tabellausc.columns["razza"] = PDF::SimpleTable::Column.new("razza") { |col|
		col.heading = "Razza"
		col.width = 33 #35
	}
	@tabellausc.columns["sesso"] = PDF::SimpleTable::Column.new("sesso") { |col|
		col.heading = "Sesso"
		col.width = 33 #35
	}
	@tabellausc.columns["madre"] = PDF::SimpleTable::Column.new("madre") { |col|
		col.heading = "Codice madre"
		col.width = 76 #80
	}
	@tabellausc.columns["nc"] = PDF::SimpleTable::Column.new("nc") { |col|
		#col.heading = "Nato / acquisto"
		col.heading = "N/A"
		col.width = 25 #40
	}
	@tabellausc.columns["nascita"] = PDF::SimpleTable::Column.new("nascita") { |col|
		col.heading = "Data nascita"
		col.width = 52 #53 #55
	}
	@tabellausc.columns["ingresso"] = PDF::SimpleTable::Column.new("ingresso") { |col|
		col.heading = "Data ingresso"
		col.width = 52 #53 #55
	}
	@tabellausc.columns["prov"] = PDF::SimpleTable::Column.new("prov") { |col|
		col.heading = "Provenienza"
		col.width = 101 #90
	}
	@tabellausc.columns["motusc"] = PDF::SimpleTable::Column.new("motusc") { |col|
		col.heading = "Motivo uscita"
		col.width = 34
	}
	@tabellausc.columns["datausc"] = PDF::SimpleTable::Column.new("datausc") { |col|
		col.heading = "Data uscita"
		col.width = 52 #53 #55
	}
	@tabellausc.columns["destinazione"] = PDF::SimpleTable::Column.new("destinazione") { |col|
		col.heading = "Destinazione"
		col.width = 111 #111
	}
	@tabellausc.columns["marcaprec"] = PDF::SimpleTable::Column.new("marcaprec") { |col|
		col.heading = "Marca precedente"
		col.width = 76 #80
	}
	@tabellausc.columns["mod4"] = PDF::SimpleTable::Column.new("mod4") { |col|
		col.heading = "Mod. 4 / Cert. san."
		col.width = 50 #35
	}
	data = Array.new
	contid = Relazs.find(:first, :conditions => "id = '#{@stallaoper}'")
	selcapi = Registros.find(:all, :conditions => "contatori_id='#{contid.contatori_id}' and stampascarico='0' and tipouscita != 'null'", :order => ["datauscita, mod4usc, id"])
	selcapi.each do |i, index|
		if i.tipouscita != "M"
			mod4 = i.mod4usc.split("/")
			mod4anno = mod4[1]
			mod4num = mod4[2]
			mod4pul = mod4num + "/" + mod4anno.to_s[2,2]
		else
			mod4pul = i.certsanusc
		end

		if i.destinazione.length > 19
			destinazione = i.destinazione[0..19] + "..."
		else
			destinazione = i.destinazione
		end

		data << {"prog" => "#{i.progressivo.to_s}", "marca" => "#{i.marca}", "razza" => "#{i.razza}", "sesso" => "#{i.sesso}", "madre" => "#{i.madre}", "nc" => "#{i.tipoingresso}", "nascita" => "#{i.datanascita.strftime("%d/%m/%Y")}", "ingresso" => "#{i.dataingresso.strftime("%d/%m/%Y")}", "prov" => "#{i.provenienza}", "motusc" => "#{i.tipouscita}", "datausc" => "#{i.datauscita.strftime("%d/%m/%Y")}", "destinazione" => "#{destinazione}",	"marcaprec" => "#{i.marcaprec}", "mod4" => "#{mod4pul}"}
	end
	if data.length != 0
		@tabellausc.data.replace data
		@tabellausc.render_on(fogliousc)
		if @sistema == "linux"
			fogliousc.save_as('./registro/registro_uscita.pdf')
			system("evince ./registro/registro_uscita.pdf")
			else
			fogliousc.save_as('.\registro\registro_uscita.pdf')
			@shell.ShellExecute('.\registro\registro_uscita.pdf', '', '', 'open', 3)
		end

		avviso = Gtk::MessageDialog.new(@mstamparegistro, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "La stampa è stata eseguita correttamente?")
		risposta = avviso.run
		avviso.destroy
		if risposta == Gtk::Dialog::RESPONSE_YES
			avviso2 = Gtk::MessageDialog.new(@mstamparegistro, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Aggiorno il registro?")
			risposta2 = avviso2.run
			avviso2.destroy
			if risposta2 == Gtk::Dialog::RESPONSE_YES
				selcapi.each do |d|
					Registros.update(d.id, { :stampascarico => "1"})
				end
				Conferma.conferma(@mstamparegistro, "Il registro è stato aggiornato.")
			else
				Conferma.conferma(@mstamparegistro, "Il registro non è stato aggiornato.")
			end
		else
			Conferma.conferma(@mstamparegistro, "Si dovrà rilanciare la stampa.")
		end
	else
		Conferma.conferma(@mstamparegistro, "Non ci sono dati da stampare.")
	end
end

# Finestra di stampa vidimati

def mascvidimati
	@mvidimati = Gtk::Window.new("Stampa fogli da vidimare")
	@mvidimati.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxvidimv = Gtk::VBox.new(false, 0)
	boxvidim1 = Gtk::HBox.new(false, 5)
	boxvidim2 = Gtk::HBox.new(false, 5)
	boxvidim3 = Gtk::HBox.new(false, 5)
	boxvidim4 = Gtk::HBox.new(false, 5)
	boxvidimv.pack_start(boxvidim1, false, false, 5)
	boxvidimv.pack_start(boxvidim2, false, false, 5)
	boxvidimv.pack_start(boxvidim3, false, false, 5)
	boxvidimv.pack_start(boxvidim4, false, false, 5)
	@mvidimati.add(boxvidimv)

	pagregcar = @s.contatori.pagregcar.split("/")
	pagregscar = @s.contatori.pagregscar.split("/")
	if pagregcar[1].to_i == @giorno.strftime("%y").to_i
		npagc = pagregcar[0].to_i
		annopagc = pagregcar[1]
	else
		npagc = 0
		annopagc = @giorno.strftime("%y")
	end
	if pagregscar[1].to_i == @giorno.strftime("%y").to_i
		npags = pagregscar[0].to_i
		annopags = pagregscar[1]
	else
		npags = 0
		annopags = @giorno.strftime("%y")
	end
	labelnpagine = Gtk::Label.new("Numero pagine da stampare:")
	boxvidim1.pack_start(labelnpagine, false, false, 5)
	npagine = Gtk::Entry.new()
	boxvidim1.pack_start(npagine, false, false, 5)
	labelultimo = Gtk::Label.new("Ultimo numero stampato:")
	boxvidim3.pack_start(labelultimo, false, false, 5)
	nultimo = Gtk::Entry.new()
	boxvidim3.pack_start(nultimo, false, false, 5)
	labeltiporeg = Gtk::Label.new("Tipo di registro:")
	boxvidim2.pack_start(labeltiporeg, false, false, 5)
	tiporeg1 = Gtk::RadioButton.new("Carico")
	tiporeg1.active=(true)
	tiporeg="C"
	nultimo.text = "#{npagc}/#{annopagc}"
	tiporeg1.signal_connect("toggled") {
		if tiporeg1.active?
			tiporeg="C"
			nultimo.text = "#{npagc}/#{annopagc}"
		end
	}
	boxvidim2.pack_start(tiporeg1, false, false, 5)
	tiporeg2 = Gtk::RadioButton.new(tiporeg1, "Scarico")
	tiporeg2.signal_connect("toggled") {
		if tiporeg2.active?
			tiporeg="S"
			nultimo.text = "#{npags}/#{annopags}"
		end
	}
	boxvidim2.pack_start(tiporeg2, false, false, 5)
	stampavidim = Gtk::Button.new( "STAMPA" )
	boxvidim4.pack_start(stampavidim, true, false, 5)
	stampavidim.signal_connect("clicked") {
		if npagine.text == "" or nultimo.text == ""
			Avvisoprova.avviso(@mvidimati, "Mancano dei dati.")
		else
		if tiporeg == "S"
			orientation = :landscape
			testotiporeg = "SCARICO"
		else
			orientation = :portrait
			testotiporeg = "CARICO"
		end
		registro = PDF::Writer.new(:paper => "A4", :orientation => orientation) # , :font_size => 5)
		registro.select_font("Helvetica")
		registro.margins_mm(10, 10)
		prog = nultimo.text.split('/')
		prpagina = prog[0].to_i
		prpagina += 1
		registro.open_object do |testa|
			registro.save_state
			dimcar = 8
			x = registro.margin_x_middle
			y = registro.absolute_top_margin
			z = registro.absolute_left_margin
			w = registro.absolute_right_margin
			testo = "REGISTRO AZIENDALE DI #{testotiporeg} BOVINI - PAG.                     - STALLA #{@combo.active_iter[1]}"
			boh = registro.text_width(testo, dimcar) / 2.0
			q = registro.absolute_top_margin - (dimcar * 1.5)
			m = x - boh
			registro.add_text(m, y, testo, dimcar)
			testo2 = "DI #{@combo2.active_iter[1]}"
			ltesto2 = registro.text_width(testo2, dimcar) / 2.0
			oriztesto2 = x - ltesto2
			registro.add_text(oriztesto2, q, testo2, dimcar)
			vertlinea = q -(dimcar * 0.5)
			registro.line(z, vertlinea, w, vertlinea).stroke
			spostapagina = x + 36
			registro.start_page_numbering(spostapagina, y, 8, nil, "<PAGENUM>/#{prog[1]}", prpagina)
			registro.restore_state
			registro.close_object
			registro.add_object(testa, :all_pages)
			cont = npagine.text.to_i
			cont -= 1
			while cont != 0
				registro.start_new_page
				cont -= 1
			end
		end
#		if File.exist?('./vidim/vidimati_ingresso.pdf')
#			puts "sì"
#		else
#			puts "no"
		end
		if @sistema == "linux"
			registro.save_as('./vidim/vidimati_ingresso.pdf')
			system("evince ./vidim/vidimati_ingresso.pdf")
		else
			registro.save_as('.\vidim\vidimati_ingresso.pdf')
			@shell.ShellExecute('.\vidim\vidimati_ingresso.pdf', '', '', 'open', 3)
		end

		avviso = Gtk::MessageDialog.new(@mvidimati, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "La stampa è stata eseguita correttamente?")
		risposta = avviso.run
		avviso.destroy
		if risposta == Gtk::Dialog::RESPONSE_YES
			avviso2 = Gtk::MessageDialog.new(@mvidimati, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Procedo con l'aggiornamento dei dati?")
			risposta2 = avviso2.run
			avviso2.destroy
			if risposta2 == Gtk::Dialog::RESPONSE_YES
				somma = npagine.text.to_i + prog[0].to_i
				if tiporeg == "C"
					Contatoris.update(@s.contatori.id, { :pagregcar => "#{somma}/#{prog[1]}"})
				elsif tiporeg == "S"
					Contatoris.update(@s.contatori.id, { :pagregscar => "#{somma}/#{prog[1]}"})
				end
			else
				Conferma.conferma(@mvidimati, "I dati non sono stati aggiornati.")
			end
		else
			Conferma.conferma(@mvidimati, "Si dovrà rilanciare la stampa.")
		end
#		end
	}
	bottchiudi = Gtk::Button.new( "CHIUDI" )
	bottchiudi.signal_connect("clicked") {
		@mvidimati.destroy
	}
	boxvidim4.pack_start(bottchiudi, true, false, 0)
	@mvidimati.show_all
end

# Compilazione registro

def compilaregistro
	compingr = Animals.find(:all, :from => "animals", :conditions => "relaz_id='#{@stallaoper}' and tipo='I' and registro= '0'")
	compusc = Animals.find(:all, :conditions => "relaz_id='#{@stallaoper}' and tipo='U' and registro= '0'")
	if "#{compingr}" == "" and "#{compusc}" == ""
		Conferma.conferma(@window, "Nessun capo da spostare nel registro.")
	else
		arrayreg = Array.new
		pr = Relazs.find(:first, :conditions => "id = '#{@s.id}'")
		contid = pr.contatori.id
		nprog = pr.contatori.progreg.split('/')
		prog1 = nprog[0].to_i
		anno = @giorno.strftime("%y")
		if nprog[1].to_i == anno.to_i
			annoreg = nprog[1]
		else
			prog1 = 0
			annoreg = anno.to_i
		end
		compingr.each do |iter|
			arrayreg[0] = iter.id
			arrayreg[1] = iter.marca
			arrayreg[2] = iter.razza.cod_razza
			arrayreg[3] = iter.sesso
			arrayreg[4] = iter.marca_madre
			if iter.cm_ing == 1
				arrayreg[5] = "N"
			elsif iter.cm_ing == 19
				arrayreg[5] = "C"
			else
				arrayreg[5] = "A"
			end
			arrayreg[6] = iter.data_nas
			arrayreg[7] = iter.data_ingr
			if iter.cm_ing == 2 or iter.cm_ing == 1 or iter.cm_ing == 19 or iter.cm_ing == 24 or iter.cm_ing == 25 or iter.cm_ing == 26
				arrayreg[8] = iter.allevamenti.cod317
			elsif iter.cm_ing == 13 or iter.cm_ing == 23 or iter.cm_ing == 32
				if iter.certsan != "" or iter.certsan != nil
					arrayreg[8] = iter.certsan
				else
					arrayreg[8] = iter.rifloc
				end
			end
			arrayreg[9] = iter.mod4
			arrayreg[10] = iter.certsan
			arrayreg[11] = iter.relaz.ragsoc.ragsoc
			arrayreg[12] = iter.relaz_id
			prog1 += 1
			Registros.create(:progressivo => "#{prog1}/#{annoreg}", :marca => "#{arrayreg[1]}", :razza => "#{arrayreg[2]}", :sesso => "#{arrayreg[3]}", :madre => "#{arrayreg[4]}", :tipoingresso => "#{arrayreg[5]}", :datanascita => "#{arrayreg[6]}", :dataingresso => "#{arrayreg[7]}", :provenienza => "#{arrayreg[8]}", :mod4ingr => "#{arrayreg[9]}", :certsaningr => "#{arrayreg[10]}", :ragsoc => "#{arrayreg[11]}", :relaz_id => "#{arrayreg[12]}", :contatori_id => "#{contid}")
			Animals.update(arrayreg[0], { :registro => "1"})

		end
		Contatoris.update(@s.contatori.id, { :progreg => "#{prog1}/#{annoreg}"})

		arrayusc = Array.new
		compusc.each do |iterusc|
			arrayusc[0] = iterusc.id
			arrayusc[1] = iterusc.marca
			if iterusc.cm_usc == 4
				arrayusc[2] = "M"
			elsif iterusc.cm_usc == 6
				arrayusc[2] = "F"
			elsif iterusc.cm_usc == 20
				arrayusc[2] = "C"
			else
				arrayusc[2] = "V"
			end
			arrayusc[3] = iterusc.uscita
			if iterusc.cm_usc == 4 or iterusc.cm_usc == 6 or iterusc.cm_usc == 10 or iterusc.cm_usc == 11
				arrayusc[4] = ""
			elsif iterusc.cm_usc == 9
				arrayusc[4] = iterusc.macelli.nomemac
			else
				arrayusc[4] = iterusc.allevamenti.cod317
			end
			arrayusc[5] = iterusc.mod4
			arrayusc[6] = iterusc.certsanusc
			Registros.update_all({:tipouscita => "#{arrayusc[2]}", :datauscita => "#{arrayusc[3]}", :destinazione => "#{arrayusc[4]}", :mod4usc => "#{arrayusc[5]}", :certsanusc => "#{arrayusc[6]}"}, "marca = '#{arrayusc[1]}'")
			Animals.update(arrayusc[0], { :registro => "1"})
		end
		Conferma.conferma(@window, "Registro compilato correttamente.")
	end
end

# Inserisci stalla
def codstalla
	@mcodstalla = Gtk::Window.new("Inserimento codice di stalla")
	@mcodstalla.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxcodstallav = Gtk::VBox.new(false, 0)
	boxcodstalla1 = Gtk::HBox.new(false, 5)
	boxcodstalla2 = Gtk::HBox.new(false, 5)
	boxcodstallav.pack_start(boxcodstalla1, false, false, 5)
	boxcodstallav.pack_start(boxcodstalla2, false, false, 5)
	@mcodstalla.add(boxcodstallav)
	labelstalla = Gtk::Label.new("Codice 317 stalla:")
	boxcodstalla1.pack_start(labelstalla, false, false, 5)
	codstalla = Gtk::Entry.new()
	codstalla.max_length=(8)
	boxcodstalla1.pack_start(codstalla, false, false, 5)
	bottcodstalla = Gtk::Button.new( "Inserisci la stalla" )
	boxcodstalla2.pack_start(bottcodstalla, false, false, 5)
	bottcodstalla.signal_connect("clicked") {
		if codstalla.text == ""
			Avvisoprova.avviso(@mcodstalla, "Mancano dei dati.")
		else
			Stalles.create(:cod317 => "#{codstalla.text.upcase}")
			Conferma.conferma(@codstalla, "Dati inseriti correttamente")
			@mcodstalla.destroy
		end
	}
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		@mcodstalla.destroy
	}
	boxcodstallav.pack_start(bottchiudi, false, false, 0)
	@mcodstalla.show_all
end

# Creazione delle ragioni sociali

def crearagsoc
	@mcrearagsoc = Gtk::Window.new("Inserimento ragione sociale")
	@mcrearagsoc.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxcrearagsocv = Gtk::VBox.new(false, 0)
	boxcrearagsoc1 = Gtk::HBox.new(false, 5)
	boxcrearagsoc2 = Gtk::HBox.new(false, 5)
	boxcrearagsoc3 = Gtk::HBox.new(false, 5)
	boxcrearagsoc4 = Gtk::HBox.new(false, 5)
	boxcrearagsocv.pack_start(boxcrearagsoc1, false, false, 5)
	boxcrearagsocv.pack_start(boxcrearagsoc2, false, false, 5)
	boxcrearagsocv.pack_start(boxcrearagsoc3, false, false, 5)
	boxcrearagsocv.pack_start(boxcrearagsoc4, false, false, 5)
	@mcrearagsoc.add(boxcrearagsocv)
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
			Avvisoprova.avviso(@mcrearagsoc, "Mancano dei dati.")
		else
			if tipoidfisc == "F"
				Ragsocs.create(:ragsoc => "#{codragsoc.text.upcase}", :codfisc => "#{idfisc.text.upcase}", :if => "#{tipoidfisc}")
			else
				Ragsocs.create(:ragsoc => "#{codragsoc.text.upcase}", :piva => "#{idfisc.text.upcase}", :if => "#{tipoidfisc}")
			end
			Conferma.conferma(@mcrearagsoc, "Dati inseriti correttamente")
			@mcrearagsoc.destroy
		end
	}
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		@mcrearagsoc.destroy
	}
	boxcrearagsoc4.pack_start(bottchiudi, false, false, 0)
	@mcrearagsoc.show_all
end

#Creazione dei proprietari

def creaprop
	@mcreaprop = Gtk::Window.new("Inserimento proprietario")
	@mcreaprop.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxcreapropv = Gtk::VBox.new(false, 0)
	boxcreaprop1 = Gtk::HBox.new(false, 5)
	boxcreaprop2 = Gtk::HBox.new(false, 5)
	boxcreaprop3 = Gtk::HBox.new(false, 5)
	boxcreaprop4 = Gtk::HBox.new(false, 5)
	boxcreapropv.pack_start(boxcreaprop1, false, false, 5)
	boxcreapropv.pack_start(boxcreaprop2, false, false, 5)
	boxcreapropv.pack_start(boxcreaprop3, false, false, 5)
	boxcreapropv.pack_start(boxcreaprop4, false, false, 5)
	@mcreaprop.add(boxcreapropv)
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
			Avvisoprova.avviso(@mcreaprop, "Mancano dei dati.")
		else
			if tipoifallev == "F"
				Props.create(:prop => "#{codprop.text.upcase}", :codfisc => "#{idfisc.text.upcase}", :if => "#{tipoifallev}")
			else
				Props.create(:prop => "#{codprop.text.upcase}", :piva => "#{idfisc.text.upcase}", :if => "#{tipoifallev}")
			end
			Conferma.conferma(@mcreaprop, "Dati inseriti correttamente")
			@mcreaprop.destroy
		end
	}
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		@mcreaprop.destroy
	}
	boxcreaprop4.pack_start(bottchiudi, false, false, 0)
	@mcreaprop.show_all
end

# Crerazione della stalla

def creastalla
	@mcreastalla = Gtk::Window.new("Creazione della stalla")
	@mcreastalla.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxcreastallav = Gtk::VBox.new(false, 0)
	boxcreastalla1 = Gtk::HBox.new(false, 5)
	boxcreastalla2 = Gtk::HBox.new(false, 5)
	boxcreastalla3 = Gtk::HBox.new(false, 5)
	boxcreastalla4 = Gtk::HBox.new(false, 5)
	boxcreastalla5 = Gtk::HBox.new(false, 5)
	boxcreastallav.pack_start(boxcreastalla1, false, false, 5)
	boxcreastallav.pack_start(boxcreastalla2, false, false, 5)
	boxcreastallav.pack_start(boxcreastalla3, false, false, 5)
	boxcreastallav.pack_start(boxcreastalla4, false, false, 5)
	boxcreastallav.pack_start(boxcreastalla5, false, false, 5)
	@mcreastalla.add(boxcreastallav)

	#Selezione della stalla
	labelstalle = Gtk::Label.new("Seleziona una stalla:") 
	boxcreastalla1.pack_start(labelstalle, false, false, 5)
	lista317 = Gtk::ListStore.new(String, Integer)
	sel317 = Stalles.find(:all)
	sel317.each do |cod|
		iter317 = lista317.append
		iter317[0] = cod.cod317
		iter317[1] = cod.id
	end
	combo317 = Gtk::ComboBox.new(lista317)
	renderer1 = Gtk::CellRendererText.new
	combo317.pack_start(renderer1,false)
	combo317.set_attributes(renderer1, :text => 0)
	boxcreastalla1.pack_start(combo317, false, false, 0)

	# Selezione della ragione sociale

	labelragsoc = Gtk::Label.new("Seleziona una ragione sociale:")
	boxcreastalla2.pack_start(labelragsoc, false, false, 5)
	listaragsoc = Gtk::ListStore.new(String, Integer)
	selragsoc = Ragsocs.find(:all)
	selragsoc.each do |rsoc|
		iterragsoc = listaragsoc.append
		iterragsoc[0] = rsoc.ragsoc
		iterragsoc[1] = rsoc.id
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

	# Selezione del proprietario

	labelprop = Gtk::Label.new("Seleziona un proprietario:")
	boxcreastalla3.pack_start(labelprop, false, false, 5)
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
	boxcreastalla3.pack_start(comboprop, false, false, 0)

	labeltipoallev = Gtk::Label.new("Tipo di allevamento:")
	boxcreastalla4.pack_start(labeltipoallev, false, false, 5)
	tipoallev1 = Gtk::RadioButton.new("Ingrasso (BRI)")
	tipoallev1.active=(true)
	tipoallev="BRI"
	tipoallev1.signal_connect("toggled") {
		if tipoallev1.active?
			tipoallev="BRI"
		end
	}
	boxcreastalla4.pack_start(tipoallev1, false, false, 5)
	tipoallev2 = Gtk::RadioButton.new(tipoallev1, "Riproduzione (BCR)")
	tipoallev2.signal_connect("toggled") {
		if tipoallev2.active?
			tipoallev="BCR"
		end
	}
	boxcreastalla4.pack_start(tipoallev2, false, false, 5)
	tipoallev3 = Gtk::RadioButton.new(tipoallev1, "Stalla di sosta (SST)")
	tipoallev3.signal_connect("toggled") {
		if tipoallev3.active?
			tipoallev="SST"
		end
	}
	boxcreastalla4.pack_start(tipoallev3, false, false, 5)
	bottcreastalla = Gtk::Button.new( "Crea la stalla" )
	boxcreastalla5.pack_start(bottcreastalla, false, false, 5)
	bottcreastalla.signal_connect("clicked") {
		if combo317.active == -1 or comboragsoc.active == -1 or comboprop.active == -1
			Avvisoprova.avviso(@mcreastalla, "Mancano dei dati.")
		else
			cont = Relazs.find(:all, :conditions => "stalle_id='#{combo317.active_iter[1]}' and ragsoc_id='#{comboragsoc.active_iter[1]}'")
			if cont.length == 0
				Contatoris.create(:mod4usc => "0/#{@giorno.strftime("%y")}", :pagregcar => "0/#{@giorno.strftime("%y")}", :pagregscar => "0/#{@giorno.strftime("%y")}", :progreg => "0/#{@giorno.strftime("%y")}")
				ultimocont = Contatoris.find(:last)
				Relazs.create(:stalle_id => "#{combo317.active_iter[1]}", :ragsoc_id => "#{comboragsoc.active_iter[1]}", :contatori_id => "#{ultimocont.id}", :prop_id => "#{comboprop.active_iter[1]}", :atp => "#{tipoallev}")
			Conferma.conferma(@mcreastalla, "Dati inseriti correttamente")
			else
				n = cont.length
				n -=1
				esiste = 0
				while n >= 0
					if cont[n].prop_id == comboprop.active_iter[1] and cont[n].atp == tipoallev
						esiste = 1
						break
					else
					end
					 n -=1
				end
				if esiste == 0
					ultimocont = Contatoris.find(:last)
					Relazs.create(:stalle_id => "#{combo317.active_iter[1]}", :ragsoc_id => "#{comboragsoc.active_iter[1]}", :contatori_id => "#{cont[0].contatori_id}", :prop_id => "#{comboprop.active_iter[1]}", :atp => "#{tipoallev}")
#					Conferma.conferma(@mcreastalla, "Dati inseriti correttamente")
				else
					Conferma.conferma(@mcreastalla, "Il profilo è già presente")
				end
			end
		end
	}
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		@mcreastalla.destroy
	}
	boxcreastalla5.pack_start(bottchiudi, false, false, 0)
	@mcreastalla.show_all
end

# Maschera stampa registro non vidimato

def mascregnonvidim
	mregnonvidim = Gtk::Window.new("Stampa registro non vidimato")
	mregnonvidim.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxregnvv = Gtk::VBox.new(false, 0)
	boxregnv1 = Gtk::HBox.new(false, 5)
	boxregnv2 = Gtk::HBox.new(false, 5)
	boxregnv3 = Gtk::HBox.new(false, 5)
	boxregnvv.pack_start(boxregnv1, false, false, 5)
	boxregnvv.pack_start(boxregnv2, false, false, 5)
	boxregnvv.pack_start(boxregnv3, false, false, 5)
	mregnonvidim.add(boxregnvv)

	anni = Gtk::ListStore.new(Integer)
	arranni = [(@giorno.strftime("%Y").to_i), (@giorno.strftime("%Y").to_i) -1, (@giorno.strftime("%Y").to_i) -2]

	arranni.each do |a|
		iter = anni.append
		iter[0] = a
	end

	@comboanno = Gtk::ComboBox.new(anni)

	renderer1 = Gtk::CellRendererText.new
	@comboanno.pack_start(renderer1,false)
	@comboanno.set_attributes(renderer1, :text => 0)
	@comboanno.active=(0)
	labelanno = Gtk::Label.new("Seleziona l'anno:")
	boxregnv1.pack_start(labelanno, false, false, 5)
	boxregnv1.pack_start(@comboanno, false, false, 0)

	stampaingrnv = Gtk::Button.new("Stampa registro di carico")
	boxregnvv.pack_start(stampaingrnv, false, false, 5)
	stampauscnv = Gtk::Button.new("Stampa registro di scarico")
	boxregnvv.pack_start(stampauscnv, false, false, 5)
	stampaingrnv.signal_connect("clicked") {
		rel = Relazs.find(:first, :conditions => "id = '#{@stallaoper}'")
		if Registros.find(:all, :conditions => "contatori_id='#{rel.contatori_id}' and YEAR(dataingresso) = '#{@comboanno.active_iter[0]}'", :order => ["dataingresso, id"]).length == 0
			Conferma.conferma(mregnonvidim, "Nessun capo presente.")
		else
			registroingrnv
		end
	}
	stampauscnv.signal_connect("clicked") {
		rel = Relazs.find(:first, :conditions => "id = '#{@stallaoper}'")
		if Registros.find(:all, :conditions => "contatori_id='#{rel.contatori_id}' and tipouscita != 'null' and YEAR(datauscita) = '#{@comboanno.active_iter[0]}'", :order => ["datauscita, id"]).length == 0
			Conferma.conferma(mregnonvidim, "Nessun capo presente.")
		else
			regiustrouscnv
		end
	}
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
	mregnonvidim.destroy
	}
	boxregnvv.pack_start(bottchiudi, false, false, 0)
	mregnonvidim.show_all
end

def registroingrnv
	foglio = PDF::Writer.new(:paper => "A4") # , :font_size => 5)
	foglio.select_font("Helvetica")
	foglio.open_object do |testa|
		foglio.save_state
		dimcar = 8
		x = foglio.margin_x_middle
		y = foglio.absolute_top_margin
		z = foglio.absolute_left_margin
		w = foglio.absolute_right_margin
		testo = "<b>Registro non vidimato di carico della stalla #{@combo.active_iter[1]}</b>"
		boh = foglio.text_width(testo, dimcar) / 2.0
		q = foglio.absolute_top_margin - (dimcar * 1.5)
		m = x - boh
		foglio.add_text(m, y, testo, dimcar)
		spostapagina = x + 36
		foglio.start_page_numbering(w-20, foglio.absolute_bottom_margin, 8, nil, "pag. <PAGENUM> di <TOTALPAGENUM>")
		foglio.restore_state
		foglio.close_object
		foglio.add_object(testa, :all_pages)
	end
	foglio.margins_mm(15, 10, 10)
	tabella = PDF::SimpleTable.new
	tabella.show_lines = :all
	tabella.show_headings = true
	tabella.orientation = :right
	tabella.position = :left
	tabella.shade_rows = :none
	tabella.split_rows = true
	tabella.font_size = 8
	tabella.heading_font_size = 8
	tabella.width = 550
	tabella.minimum_space = 10
	tabella.column_order.push(*%w(prog marca razza sesso madre nc nascita ingresso prov))
	tabella.columns["prog"] = PDF::SimpleTable::Column.new("prog") { |col|
		col.heading = "Numero ordine"
		col.width = 40
	}
	tabella.columns["marca"] = PDF::SimpleTable::Column.new("marca") { |col|
		col.heading = "Marchio di identificazione"
		col.width = 90
	}
	tabella.columns["razza"] = PDF::SimpleTable::Column.new("razza") { |col|
		col.heading = "Razza"
		col.width = 35
	}
	tabella.columns["sesso"] = PDF::SimpleTable::Column.new("sesso") { |col|
		col.heading = "Sesso"
		col.width = 35
	}
	tabella.columns["madre"] = PDF::SimpleTable::Column.new("madre") { |col|
		col.heading = "Codice della madre"
		col.width = 90
	}
	tabella.columns["nc"] = PDF::SimpleTable::Column.new("nc") { |col|
		col.heading = "Nato / acquisto"
		col.width = 40
	}
	tabella.columns["nascita"] = PDF::SimpleTable::Column.new("nascita") { |col|
		col.heading = "Data di nascita"
		col.width = 55
	}
	tabella.columns["ingresso"] = PDF::SimpleTable::Column.new("ingresso") { |col|
		col.heading = "Data di ingresso"
		col.width = 55
	}
	tabella.columns["prov"] = PDF::SimpleTable::Column.new("prov") { |col|
		col.heading = "Provenienza"
	}
	data = Array.new

		rel = Relazs.find(:first, :conditions => "id = '#{@stallaoper}'")
		selcapi = Registros.find(:all, :conditions => "contatori_id='#{rel.contatori_id}' and YEAR(dataingresso) = '#{@comboanno.active_iter[0]}'", :order => ["dataingresso, id"])
	selcapi.each do |i, index|
		data << {"prog" => "#{i.progressivo.to_s}", "marca" => "#{i.marca}", "razza" => "#{i.razza}", "sesso" => "#{i.sesso}", "madre" => "#{i.madre}",	"nc" => "#{i.tipoingresso}", "nascita" => "#{i.datanascita.strftime("%d/%m/%Y")}", "ingresso" => "#{i.dataingresso.strftime("%d/%m/%Y")}", "prov" => "#{i.provenienza}"}
	end
	tabella.data.replace data
	tabella.render_on(foglio)
	if @sistema == "linux"
		foglio.save_as('./regnv/registro_ingressonv.pdf')
		system("evince ./regnv/registro_ingressonv.pdf")
	else
		foglio.save_as('.\regnv\registro_ingressonv.pdf')
		@shell.ShellExecute('.\regnv\registro_ingressonv.pdf', '', '', 'open', 3)
	end
end

def regiustrouscnv
	fogliousc = PDF::Writer.new(:paper => "A4", :orientation => :landscape) # , :font_size => 5)
	fogliousc.select_font("Helvetica")
	fogliousc.open_object do |testa|
		fogliousc.save_state
		dimcar = 8
		x = fogliousc.margin_x_middle
		y = fogliousc.absolute_top_margin
		z = fogliousc.absolute_left_margin
		w = fogliousc.absolute_right_margin
		testo = "<b>Registro non vidimato di scarico della stalla #{@combo.active_iter[1]}</b>"
		boh = fogliousc.text_width(testo, dimcar) / 2.0
		q = fogliousc.absolute_top_margin - (dimcar * 1.5)
		m = x - boh
		fogliousc.add_text(m, y, testo, dimcar)
		spostapagina = x + 36
		fogliousc.start_page_numbering(w-20, fogliousc.absolute_bottom_margin, 8, nil, "pag. <PAGENUM> di <TOTALPAGENUM>")
		fogliousc.restore_state
		fogliousc.close_object
		fogliousc.add_object(testa, :all_pages)
	end
	fogliousc.margins_mm(15, 5, 15)
	tabellausc = PDF::SimpleTable.new
	tabellausc.show_lines = :all
	tabellausc.show_headings = true
	tabellausc.orientation = :right
	tabellausc.position = :left
	tabellausc.shade_rows = :none
	tabellausc.split_rows = true
	tabellausc.font_size = 8
	tabellausc.heading_font_size = 8
	tabellausc.minimum_space = 10
	tabellausc.column_order.push(*%w(prog marca razza sesso madre nc nascita ingresso prov motusc datausc destinazione marcaprec mod4))
	tabellausc.columns["prog"] = PDF::SimpleTable::Column.new("prog") { |col|
		col.heading = "N. ordine"
		col.width = 39 #40
	}
	tabellausc.columns["marca"] = PDF::SimpleTable::Column.new("marca") { |col|
		col.heading = "Marchio di identificazione"
		col.width = 76 #80
	}
	tabellausc.columns["razza"] = PDF::SimpleTable::Column.new("razza") { |col|
		col.heading = "Razza"
		col.width = 33 #35
	}
	tabellausc.columns["sesso"] = PDF::SimpleTable::Column.new("sesso") { |col|
		col.heading = "Sesso"
		col.width = 33 #35
	}
	tabellausc.columns["madre"] = PDF::SimpleTable::Column.new("madre") { |col|
		col.heading = "Codice della madre"
		col.width = 76 #80
	}
	tabellausc.columns["nc"] = PDF::SimpleTable::Column.new("nc") { |col|
		col.heading = "N/A"
		col.width = 25 #40
	}
	tabellausc.columns["nascita"] = PDF::SimpleTable::Column.new("nascita") { |col|
		col.heading = "Data di nascita"
		col.width = 52 #53 #55
	}
	tabellausc.columns["ingresso"] = PDF::SimpleTable::Column.new("ingresso") { |col|
		col.heading = "Data di ingresso"
		col.width = 52 #53 #55
	}
	tabellausc.columns["prov"] = PDF::SimpleTable::Column.new("prov") { |col|
		col.heading = "Provenienza"
		col.width = 101 #90
	}
	tabellausc.columns["motusc"] = PDF::SimpleTable::Column.new("motusc") { |col|
		col.heading = "Motivo uscita"
		col.width = 34 #35
	}
	tabellausc.columns["datausc"] = PDF::SimpleTable::Column.new("datausc") { |col|
		col.heading = "Data uscita"
		col.width = 52 #53 #55
	}
	tabellausc.columns["destinazione"] = PDF::SimpleTable::Column.new("destinazione") { |col|
		col.heading = "Destinazione"
		col.width = 111 #90
	}
	tabellausc.columns["marcaprec"] = PDF::SimpleTable::Column.new("marcaprec") { |col|
		col.heading = "Marca precedente"
		col.width = 76 #80
	}
	tabellausc.columns["mod4"] = PDF::SimpleTable::Column.new("mod4") { |col|
		col.heading = "Mod. 4"
		col.width = 55 #35
	}
	data = Array.new
	rel = Relazs.find(:first, :conditions => "id = '#{@stallaoper}'")
	selcapi = Registros.find(:all, :conditions => "contatori_id='#{rel.contatori_id}' and tipouscita != 'null' and YEAR(datauscita) = '#{@comboanno.active_iter[0]}'", :order => ["datauscita, mod4usc, id"])
	selcapi.each do |i, index|
		if i.tipouscita != "M"
			mod4 = i.mod4usc.split("/")
			mod4anno = mod4[1]
			mod4num = mod4[2]
			mod4pul = mod4num + "/" + mod4anno.to_s[2,2]
		else
			mod4pul = i.certsanusc
		end
		if i.destinazione.length > 19
			destinazione = i.destinazione[0..19] + "..."
		else
			destinazione = i.destinazione
		end
		data << {"prog" => "#{i.progressivo.to_s}", "marca" => "#{i.marca}", "razza" => "#{i.razza}", "sesso" => "#{i.sesso}", "madre" => "#{i.madre}",	"nc" => "#{i.tipoingresso}", "nascita" => "#{i.datanascita.strftime("%d/%m/%Y")}", "ingresso" => "#{i.dataingresso.strftime("%d/%m/%Y")}", "prov" => "#{i.provenienza}", "motusc" => "#{i.tipouscita}", "datausc" => "#{i.datauscita.strftime("%d/%m/%Y")}", "destinazione" => "#{destinazione}",	"marcaprec" => "#{i.marcaprec}", "mod4" => "#{mod4pul}"}
	end
	tabellausc.data.replace data
	tabellausc.render_on(fogliousc)
		if @sistema == "linux"
			fogliousc.save_as('./regnv/registro_uscitanv.pdf')
			system("evince ./regnv/registro_uscitanv.pdf")
		else
			fogliousc.save_as('.\regnv\registro_uscitanv.pdf')
			@shell.ShellExecute('.\regnv\registro_uscitanv.pdf', '', '', 'open', 3)
		end
end

def stampapres
	selcapi = Registros.find(:all, :conditions => "relaz_id='#{@stallaoper}' and tipouscita IS NULL", :order => ["dataingresso, id"])
	foglio = PDF::Writer.new(:paper => "A4")
	foglio.select_font("Helvetica")
	foglio.open_object do |testa|
		foglio.save_state
		dimcar = 9
		x = foglio.margin_x_middle
		y = foglio.absolute_top_margin
		z = foglio.absolute_left_margin
		w = foglio.absolute_right_margin
		testo = "<b>Capi presenti nella stalla #{@combo.active_iter[1]} in data #{@giorno.strftime("%d/%m/%Y")}: #{selcapi.length}</b>"
		boh = foglio.text_width(testo, dimcar) / 2.0
		q = foglio.absolute_top_margin - (dimcar * 1.5)
		m = x - boh
		foglio.add_text(m, y, testo, dimcar)
		spostapagina = x + 36
		foglio.start_page_numbering(w-20, foglio.absolute_bottom_margin, 8, nil, "pag. <PAGENUM> di <TOTALPAGENUM>")
		foglio.restore_state
		foglio.close_object
		foglio.add_object(testa, :all_pages)
	end
	tabella = PDF::SimpleTable.new
	tabella.show_lines = :all
	tabella.show_headings = true
	tabella.orientation = :right
	tabella.position = :left
	tabella.shade_rows = :none
	tabella.split_rows = true
	tabella.font_size = 8
	tabella.heading_font_size = 8
	tabella.width = 550
	tabella.minimum_space = 10
	tabella.column_order.push(*%w(prog marca razza sesso madre nc nascita ingresso prov))
	tabella.columns["prog"] = PDF::SimpleTable::Column.new("prog") { |col|
		col.heading = "Numero ordine"
		col.width = 40
	}
	tabella.columns["marca"] = PDF::SimpleTable::Column.new("marca") { |col|
		col.heading = "Marchio di identificazione"
		col.width = 90
	}
	tabella.columns["razza"] = PDF::SimpleTable::Column.new("razza") { |col|
		col.heading = "Razza"
		col.width = 35
	}
	tabella.columns["sesso"] = PDF::SimpleTable::Column.new("sesso") { |col|
		col.heading = "Sesso"
		col.width = 35
	}
	tabella.columns["madre"] = PDF::SimpleTable::Column.new("madre") { |col|
		col.heading = "Codice della madre"
		col.width = 90
	}
	tabella.columns["nc"] = PDF::SimpleTable::Column.new("nc") { |col|
		col.heading = "Nato / acquisto"
		col.width = 40
	}
	tabella.columns["nascita"] = PDF::SimpleTable::Column.new("nascita") { |col|
		col.heading = "Data di nascita"
		col.width = 55
	}
	tabella.columns["ingresso"] = PDF::SimpleTable::Column.new("ingresso") { |col|
		col.heading = "Data di ingresso"
		col.width = 55
	}
	tabella.columns["prov"] = PDF::SimpleTable::Column.new("prov") { |col|
		col.heading = "Provenienza"
	}
	data = Array.new
	selcapi.each do |i, index|
		data << {"prog" => "#{i.progressivo.to_s}", "marca" => "#{i.marca}", "razza" => "#{i.razza}", "sesso" => "#{i.sesso}", "madre" => "#{i.madre}",	"nc" => "#{i.tipoingresso}", "nascita" => "#{i.datanascita.strftime("%d/%m/%Y")}", "ingresso" => "#{i.dataingresso.strftime("%d/%m/%Y")}", "prov" => "#{i.provenienza}"}
	end
foglio.margins_mm(15, 10, 10)
	if data.length != 0
		tabella.data.replace data
		tabella.render_on(foglio)
		if @sistema == "linux"
			foglio.save_as('./altro/presenze.pdf')
			system("evince ./altro/presenze.pdf")
		else
			foglio.save_as('.\altro\presenze.pdf')
			@shell.ShellExecute('.\altro\presenze.pdf', '', '', 'open', 3)
		end
	else
		Conferma.conferma(@window, "Non ci sono dati da stampare.")
	end
end

def mascallmod4
	@mallmod4 = Gtk::Window.new("Stampa dell'allegato al Modello 4")
	@mallmod4.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxallmod4v = Gtk::VBox.new(false, 0)
	boxallmod41 = Gtk::HBox.new(false, 5)
	boxallmod42 = Gtk::HBox.new(false, 5)
	boxallmod4v.pack_start(boxallmod41, false, false, 5)
	boxallmod4v.pack_start(boxallmod42, false, false, 5)
	@mallmod4.add(boxallmod4v)
	labelmod4 = Gtk::Label.new("Numero modello 4:")
	boxallmod41.pack_start(labelmod4, false, false, 5)
	@m4 = Gtk::Entry.new()
	boxallmod41.pack_start(@m4, false, false, 5)
	stampa = Gtk::Button.new("Stampa l'allegato")
	boxallmod42.pack_start(stampa, false, false, 5)
	stampa.signal_connect("clicked") {
		@capi = Animals.find(:all, :from => "animals", :conditions => "relaz_id='#{@stallaoper}' and tipo='U' and mod4= '#{@s.stalle.cod317}/#{@giorno.strftime("%Y")}/#{@m4.text}'")
		if @capi.length == 0
			Avvisoprova.avviso(@mallmod4, "Questo modello 4 non esiste.") #.avvia
		else
			stampaallegato
		end
	}
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		@mallmod4.destroy
	}
	boxallmod4v.pack_start(bottchiudi, false, false, 0)
	@mallmod4.show_all
end

def stampaallegato
	foglio = PDF::Writer.new(:paper => "A4")
	foglio.select_font("Courier")
	foglio.open_object do |testa|
		foglio.save_state
		dimcar = 12
		x = foglio.margin_x_middle
		y = foglio.absolute_top_margin
		z = foglio.absolute_left_margin
		w = foglio.absolute_right_margin
		testo = "<b>Azienda agricola #{@s.ragsoc.ragsoc}</b>"
		testo2 = "<b>Allegato del Modello 4 #{@s.stalle.cod317}/#{@giorno.strftime("%Y")}/#{@m4.text} - Capi totali: #{@capi.length}</b>"
		boh = foglio.text_width(testo, dimcar) / 2.0
		boh2 = foglio.text_width(testo2, dimcar) / 2.0
		m = x - boh
		m2 = x-boh2
		y2 = y - dimcar + 5
		foglio.add_text(m, y+10, testo, dimcar)
		foglio.add_text(m2, y2, testo2, dimcar)
		foglio.start_page_numbering(w-70, foglio.absolute_bottom_margin-5, 8, nil, "pag. <PAGENUM> di <TOTALPAGENUM>")
		foglio.restore_state
		foglio.close_object
		foglio.add_object(testa, :all_pages)
	end
	data = Array.new
	@capi.each do |i|
		data << i.marca
	end
	capi = String.new
	data.each do |m|
		capi += m.ljust(14) + '  '
	end

	foglio.margins_mm(17, 25, 15, 20)
	foglio.text(capi, :justification => :left, :font_size => 12, :leading => 15)
	if @sistema == "linux"
		foglio.save_as('./altro/allegato.pdf')
		system("evince ./altro/allegato.pdf")
	else
		foglio.save_as('.\altro\allegato.pdf')
		@shell.ShellExecute('.\altro\allegato.pdf', '', '', 'open', 3)
	end

end

def reinvio
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
			capimod = Animals.find(:all, :conditions => "relaz_id='#{@stallaoper}' and file ='1' and tipo = '#{tipomov}' and data_ingr = '#{giorno}' and marca LIKE '%#{marca.text}%'")
		elsif tipomov == "U"
			capimod = Animals.find(:all, :conditions => "relaz_id='#{@stallaoper}' and file ='1' and tipo = '#{tipomov}' and uscita = '#{giorno}' and marca LIKE '%#{marca.text}%'")
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

#Richiesta numero capi da inserire

def masccontaingr
	mcontaingr = Gtk::Window.new("")
	mcontaingr.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxcontaingrv = Gtk::VBox.new(false, 0)
	boxcontaingr1 = Gtk::HBox.new(false, 5)
	boxcontaingr2 = Gtk::HBox.new(false, 5)
	boxcontaingr3 = Gtk::HBox.new(false, 5)
	boxcontaingrv.pack_start(boxcontaingr1, false, false, 5)
	boxcontaingrv.pack_start(boxcontaingr2, false, false, 5)
	boxcontaingrv.pack_start(boxcontaingr3, false, false, 5)
	mcontaingr.add(boxcontaingrv)

	labelingr = Gtk::Label.new("Numero di capi da inserire:")
	boxcontaingr1.pack_start(labelingr, false, false, 5)
	numeroingr = Gtk::Entry.new
	boxcontaingr1.pack_start(numeroingr, false, false, 5)

	bottmov = Gtk::Button.new( "OK" )
	boxcontaingr1.pack_start(bottmov, false, false, 5)

	bottmov.signal_connect( "clicked" ) {
		@containgressi = numeroingr.text.to_i
		mcontaingr.destroy
		inscapo
	}
	mcontaingr.show_all
end

#Inizio con finestra principale

Gtk.init
	@window = Gtk::Window.new( Gtk::Window::TOPLEVEL )
	@window.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	@window.set_default_size(600, 500)
	@window.set_title( "AUROX" )
	@window.signal_connect( "delete_event" ) {
		delete_event( nil, nil )
	}
	@window.signal_connect( "destroy" ) {
		destroy( nil )
	}
	box1 = Gtk::VBox.new(false, 10)
	boxstalla = Gtk::HBox.new(false, 0 )
	boxragsoc = Gtk::HBox.new(false, 0)
	boxprop = Gtk::HBox.new(false, 0)
	menubar = createMenuBar()
	box1.pack_start(menubar, false, false, 0)
	box1.pack_start(boxstalla, false, false, 5)
	box1.pack_start(boxragsoc, false, false, 5)
	box1.pack_start(boxprop, false, false, 5)
	@window.add(box1)
	ingressi = Gtk::Button.new( "INGRESSI" )
	uscite = Gtk::Button.new( "USCITE" )
	bottcreafile = Gtk::Button.new("CREA FILE PER L'INVIO DEI DATI")
	stampareg = Gtk::Button.new("STAMPA REGISTRO")
	stampavidimati = Gtk::Button.new("STAMPA PAGINE VIDIMATE")
	bottcompilaregistro = Gtk::Button.new("COMPILA IL REGISTRO")
	@listacombo = Gtk::ListStore.new(Integer, String)
	@listacombo2 = Gtk::ListStore.new(Integer, String, Integer)
	@listacombo3 = Gtk::ListStore.new(Integer, String, Integer, String, String)
	@sel1 = Stalles.find(:all)
	lun = 0
	@sel1.each do |@r|
		@iter1 = @listacombo.append
		@iter1[0] = @r.id
		@iter1[1] = @r.cod317
		lun +=1
	end

	#Selezione della stalla

	@combo = Gtk::ComboBox.new(@listacombo)
	renderer1 = Gtk::CellRendererText.new
	@combo.pack_start(renderer1,false)
	@combo.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	@combo.pack_start(renderer1,false)
	@combo.set_attributes(renderer1, :text => 0)
	labelstalle = Gtk::Label.new("Seleziona una stalla:")
	boxstalla.pack_start(labelstalle, false, false, 5)
	boxstalla.pack_start(@combo, false, false, 0)

	#Selezione della ragione sociale

	@combo.signal_connect( "changed" ) {
		@stallascelta = @combo.active_iter[1]
		@sel2 = Relazs.find(:all, :from => "relazs", :conditions => "relazs.stalle_id='#{@combo.active_iter[0]}'", :order => "ragsoc_id")
		@listacombo3.clear
		@listacombo2.clear
		@sel2.each do |@t|
			iter = @listacombo2.append
			iter[0] = @t.id.to_i
			iter[1] = @t.ragsoc.ragsoc.to_s
			iter[2] = @t.ragsoc.id.to_i #.to_i
		end
		arrconfronto = []
		x = nil
		@listacombo2.each do |modello, percorso, iterat|
			(iterat[1] == x) and arrconfronto.push(Gtk::TreeRowReference.new(modello, percorso))
			x = iterat[1]
		end
		arrconfronto.each do |rif|
			(percorso = rif.path) and @listacombo2.remove(@listacombo2.get_iter(percorso))
		end
		#@combo2.active=(0)
	}
	@combo2 = Gtk::ComboBox.new(@listacombo2)
	renderer = Gtk::CellRendererText.new
	renderer.visible=(false)
	@combo2.pack_start(renderer,false)
	@combo2.set_attributes(renderer, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	@combo2.pack_start(renderer1,false)
	@combo2.set_attributes(renderer1, :text => 1)
	render2 = Gtk::CellRendererText.new
	render2.visible=(false)
	@combo2.pack_start(render2,false)
	@combo2.set_attributes(render2, :text => 2)
	labelragsoc = Gtk::Label.new("Seleziona una ragione sociale:")
	boxragsoc.pack_start(labelragsoc, false, false, 5)
	boxragsoc.pack_start(@combo2, false, false, 0)

	#Selezione del proprietario

	@combo2.signal_connect( "changed" ) {
		if @combo2.active != -1 then
			@idragsoc = @combo2.active
			sel3 = Relazs.find(:all, :from => "props, relazs", :conditions => "relazs.stalle_id='#{@combo.active_iter[0]}' and relazs.ragsoc_id='#{@combo2.active_iter[2]}' and props.id=relazs.prop_id")
			@listacombo3.clear
			sel3.each do |@s|
				iter = @listacombo3.append
				iter[0] = @s.id.to_i
				iter[1] = @s.prop.prop.to_s
				iter[2] = @s.prop_id.to_i
				iter[3] = @s.atp
				iter[4] = "-"
			end
		else
		end
	}
	@combo3 = Gtk::ComboBox.new(@listacombo3)
	renderer = Gtk::CellRendererText.new
	renderer.visible=(false)
	@combo3.pack_start(renderer,false)
	@combo3.set_attributes(renderer, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	@combo3.pack_start(renderer1,false)
	@combo3.set_attributes(renderer1, :text => 1)
	renderer2 = Gtk::CellRendererText.new
	renderer2.visible=(false)
	@combo3.pack_start(renderer2,false)
	@combo3.set_attributes(renderer2, :text => 2)
	renderer3 = Gtk::CellRendererText.new
	@combo3.pack_start(renderer3,false)
	@combo3.set_attributes(renderer3, :text => 4)
	renderer4 = Gtk::CellRendererText.new
	@combo3.pack_start(renderer4,false)
	@combo3.set_attributes(renderer4, :text => 3)
	labelprop = Gtk::Label.new("Seleziona un proprietario:")
	boxprop.pack_start(labelprop, false, false, 5)
	boxprop.pack_start(@combo3, false, false, 0)
	@combo3.signal_connect( "changed" ) {
		@stallaoper = 0
		if @combo3.active != -1
			@stallaoper = @combo3.active_iter[0]
		else
		end
	}

	ingressi.signal_connect( "clicked" ) {
		if @combo.active == -1 or @combo2.active == -1 or @combo3.active == -1
			Avvisoprova.avviso(@window, "Seleziona una stalla, una ragione sociale ed un proprietario.")
		else
			masccontaingr
		end
	}

	uscite.signal_connect( "clicked" ) {
		if @combo.active == -1 or @combo2.active == -1 or @combo3.active == -1
			Avvisoprova.avviso(@window, "Seleziona una stalla, una ragione sociale ed un proprietario.")
		else
			mascuscite
		end
	}

	bottcreafile.signal_connect("clicked") {
		if @combo.active == -1 or @combo2.active == -1 or @combo3.active == -1
			Avvisoprova.avviso(@window, "Seleziona una stalla, una ragione sociale ed un proprietario.")
		else
			nmov = Animals.find(:all, :from=> "animals", :conditions => "relaz_id='#{@stallaoper}' and file='0'").length
			if nmov != 0
				avviso = Gtk::MessageDialog.new(@window, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Ci sono #{nmov} movimenti da inviare. Procedo con la creazione del file?")
				risposta = avviso.run
				avviso.destroy
				if risposta == Gtk::Dialog::RESPONSE_YES
					creafile
				else
					Conferma.conferma(@window, "Operazione annullata.")
				end
			else
				Conferma.conferma(@window, "Non ci sono movimenti disponibili.")
			end
		end
	}

	stampareg.signal_connect("clicked") {
		if @combo.active == -1 or @combo2.active == -1 or @combo3.active == -1
			Avvisoprova.avviso(@window, "Seleziona una stalla, una ragione sociale ed un proprietario.")
		else
			mascstamparegistro
		end
	}
	stampavidimati.signal_connect("clicked") {
		if @combo.active == -1 or @combo2.active == -1 or @combo3.active == -1
			Avvisoprova.avviso(@window, "Seleziona una stalla, una ragione sociale ed un proprietario.")
		else
			mascvidimati
		end
	}
	bottcompilaregistro.signal_connect("clicked") {
		if @combo.active == -1 or @combo2.active == -1 or @combo3.active == -1
			Avvisoprova.avviso(@window, "Seleziona una stalla, una ragione sociale ed un proprietario.")
		else
			compilaregistro
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
		@window.destroy
	}
	box1.pack_start(bottchiudi, false, false, 0)
	@window.show_all

Gtk.main
