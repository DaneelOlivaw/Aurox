def inscapo

	finestraingr = Gtk::Window.new("Dati del capo")
	finestraingr.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
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
	finestraingr.add(boxingrvert)

	bottaltricod = Gtk::Button.new("Codice a barre francese")
	boxingr1.pack_start(bottaltricod, true, false, 0)

	bottaltricod.signal_connect("clicked") {
		insaltricod
	}
	errore = 0
	labelingr = Gtk::Label.new("Totale capi da inserire: #{@containgressi}")
	boxingr1.pack_start(labelingr, true, false, 0)

	#Generazione array coi capi presenti
	presenti = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and uscito= ?", "#{@stallaoper.id}", "I", "0"])
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
		Errore.avviso(finestraingr, "La marca è già presente.")
		errore = 2
	else
		errore = 0
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
#	@listarazze = Gtk::ListStore.new(Integer, String, String)
#	selrazze = Razzas.find(:all, :order => "razza")
#	selrazze.each do |@r|
#		iter1 = @listarazze.append
#		iter1[0] = @r.id.to_i
#		iter1[1] = @r.razza
#		iter1[2] = @r.cod_razza
#	end
#	@comborazze = Gtk::ComboBox.new(@listarazze)
#	renderer1 = Gtk::CellRendererText.new
#	@comborazze.pack_start(renderer1,false)
#	@comborazze.set_attributes(renderer1, :text => 1)
#	renderer1 = Gtk::CellRendererText.new
#	renderer1.visible=(false)
#	@comborazze.pack_start(renderer1,false)
#	@comborazze.set_attributes(renderer1, :text => 2)
#	boxingr3.pack_end(@comborazze.popdown, false, false, 0)
#	boxingr3.pack_end(labelrazza, false, false, 5)

	listar = Gtk::ListStore.new(String, Integer)
	controllo = Hash.new
	selr = Razzas.find(:all, :order => "razza")
	selr.each do |r|
		iter = listar.append
		iter[0] = r.razza
		iter[1] = r.id
		controllo.merge!("#{r.id}" => r.razza)
	end

	@razza = Gtk::Entry.new
	@razza.width_chars=(40)
	complet = Gtk::EntryCompletion.new
	complet.model=(listar)
	renderer1 = Gtk::CellRendererText.new
	complet.pack_start(renderer1,false)
	complet.set_text_column(0)
	complet.inline_completion=(true)
	if @sistema == "linux"
		complet.inline_selection=(true)
	end
	complet.minimum_key_length=(0)
	@razza.completion=(complet)
	boxingr3.pack_end(@razza, false, false, 0)
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
			@stallanas.text = "#{@stallaoper.stalle.cod317.to_s}"
		end
	end

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
	selnazorig = Nations.find(:all, :order => "nome")
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
	selnaznas = Nations.find(:all, :order => "nome")
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
	#comboing = Gtk::ComboBox.new

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
			if @marca.text[0,2].upcase == "IT" and @stallanas.text.upcase == @stallaoper.stalle.cod317 #nascita
				x = -1
				@comboing.set_active(0)
				while @comboing.active_iter[0] != 1
					x+=1
					@comboing.set_active(x)
				end
		elsif @marca.text[0,2].upcase != "IT" and @stallanas.text.upcase == @stallaoper.stalle.cod317 #@combo.active_iter[1].upcase #prima importazione
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
			#puts errore
			Errore.avviso(finestraingr, "Controllare la marca")
		end
	else
	end
	}

	#Passaggio ai dati del movimento

	bottmoving = Gtk::Button.new("Dati ingresso")
	bottmoving.signal_connect("clicked") {
#	puts @comboing.active_iter[1]
	begin
#	puts Time.parse("#{@nascita.text[4,2] + @nascita.text[2,2] + @nascita.text[0,2]}")
	if @nascita.text != nil
		#@datanasingl = @giorno.strftime("%Y")[0,2] + @nascita.text[4,2] + @nascita.text[2,2] + @nascita.text[0,2]
		@datanasingl = @nascita.text[4,2] + @nascita.text[2,2] + @nascita.text[0,2]
		@datanasingl = Time.parse("#{@datanasingl}").strftime("%Y")[0,2] + @datanasingl
	end
	if errore != 2
		errore = 0
	end
	#puts "errore = 0? #{errore}"
#	puts "madre = #{@madre.text}"
#	if @arraypres.include?(@marca.text.upcase) == true
#		errore = 1
#		puts "codice esistente"
#	else
#		@arraypres << @marca.text.upcase
#	end

	if controllo.has_value?("#{@razza.text.upcase}")
		@razzaid = controllo.index("#{@razza.text.upcase}")
	else
		Errore.avviso(finestraingr, "La razza inserita non è classificata.")
		errore = 1
		@razzaid = 0
		#puts "razza inesistente"
	end

	@nnaz = @combonaznas.active
	#if @marca.text == nil or @comborazze.active == -1 or @nascita.text == nil or @combonazorig.active == -1 or @combonaznas.active == -1 or @comboing.active == -1
	if @marca.text == "" or @razzaid == 0 or @nascita.text == "" or @combonazorig.active == -1 or @combonaznas.active == -1 or @comboing.active == -1 or @madre.text == ""
		Errore.avviso(finestraingr, "Mancano dei dati obbligatori.")
		errore = 1
		#puts "dati obbligatori"
	elsif @marca.text[0,2].upcase == "IT" and @marca.text.length < 14
		Errore.avviso(finestraingr, "Marca corta.")
		#puts "marca corta"
		errore = 1
	elsif @nascita.text.to_i == 0
		Errore.avviso(finestraingr, "Data di nascita errata.")
		errore = 1
		#puts "data nascita"
	elsif Time.parse("#{@datanasingl}") > @giorno
			Errore.avviso(finestraingr, "La data di nascita non può essere successiva al giorno odierno.")
			errore = 1
			#puts "nato nel futuro"
	elsif @marcatura.text != "" and @marcatura.text.to_i != 0
		#@datamarcingl = @giorno.strftime("%Y")[0,2] + @marcatura.text[4,2] + @marcatura.text[2,2] + @marcatura.text[0,2]
		@datamarcingl = @marcatura.text[4,2] + @marcatura.text[2,2] + @marcatura.text[0,2]
		@datamarcingl = Time.parse("#{@datamarcingl}").strftime("%Y")[0,2] + @datamarcingl
		if Time.parse("#{@datamarcingl}") < Time.parse("#{@datanasingl}")
			Errore.avviso(finestraingr, "La data di marcatura non può essere minore della data di nascita.")
			errore = 1
			#puts "marcatura"
		else
		end
	elsif @marcatura.text != "" and @marcatura.text.to_i == 0
		Errore.avviso(finestraingr, "lettere.")
		errore = 1
		#puts "lettere"
	elsif @marcatura.text == "" #or @marcatura.text == 0 	#	elsif @datamod4.text != "" and @datamod4.text.to_i != 0
		@datamarcingl = ""
	end
	rescue Exception => errore
		Errore.avviso(finestraingr, "Controllare le date")
	end
	#puts "e ora, che vale? #{errore}"
	if errore == 0
		#puts "avanti"
		@arraypres << @marca.text.upcase
		#@depositoingr = Hash["marca" => @marca.text.upcase, "specie" => @valspecie, "razza" => @comborazze.active_iter[0], "datanascita" => @nascita.text, "stallanascita" => @stallanas.text.upcase, "sesso" => @valsesso, "nazorig" => @combonazorig.active_iter[0], "naznasprimimp" => @combonaznas.active_iter[0], "datamarca" => @marcatura.text, "marcaprec" => @prec.text.upcase, "madre" => @madre.text.upcase, "padre" => @padre.text.upcase, "donatrice" => @don.text.upcase, "libgen" => @libgen.text.upcase, "iscrlibgen" => @valgen, "embryo" => @valembryo, "ingresso" => @comboing.active_iter[0]]
		@depositoingr = Hash["marca" => @marca.text.upcase, "specie" => @valspecie, "razza" => @razzaid, "datanascita" => @nascita.text, "stallanascita" => @stallanas.text.upcase, "sesso" => @valsesso, "nazorig" => @combonazorig.active_iter[0], "nazorigcod" => @combonazorig.active_iter[2], "naznasprimimp" => @combonaznas.active_iter[0], "naznasprimimpcod" => @combonaznas.active_iter[2], "datamarca" => @marcatura.text, "marcaprec" => @prec.text.upcase, "madre" => @madre.text.upcase, "padre" => @padre.text.upcase, "donatrice" => @don.text.upcase, "libgen" => @libgen.text.upcase, "iscrlibgen" => @valgen, "embryo" => @valembryo, "ingresso" => @comboing.active_iter[0]]
#		puts @depositoingr.length
		if @comboing.active_iter[0] == 1
#			puts "nascita"
			mascnascita(finestraingr, labelingr)
		elsif @comboing.active_iter[0] == 13 or @comboing.active_iter[0] == 32
#			puts "prima importazione"
			mascprimimp(finestraingr, labelingr)
		else
#			puts "altro"
			mascingressi(finestraingr, labelingr)
		end
	end
	}
	boxingrvert.pack_start(bottmoving, false, false, 0)

	# Bottone inserimento consecutivo

	bottinscons = Gtk::Button.new("Inserimento consecutivo")
	bottinsconsvel = Gtk::Button.new("Inserimento consecutivo veloce")
	bottinscons.signal_connect("clicked") {
		primoins = 1
		errore = 0
		if @primocapo == 1
			labelultima = Gtk::Label.new
			labelultima.set_markup("<b>Ultima marca inserita: #{@depositoingr["marca"]}</b>")
			boxingr2.pack_start(labelultima, false, false, 20)
			bottprossimo = Gtk::Button.new("Inserisci")
			boxingr10.pack_start(bottprossimo, true, true, 5)
			finestraingr.show_all

			#Bottone inserimento dati del capo in inserimento consecutivo

			bottprossimo.signal_connect("clicked") {
				begin
					if errore != 2
						errore = 0
					end
	#				errore = 0
	#				if @arraypres.include?(@marca.text.upcase) == true
	#					errore = 1
	#				else
	#					@arraypres << @marca.text.upcase
	#				end

					if @nascita.text != nil
						#@datanasingl = @giorno.strftime("%Y")[0,2] + @nascita.text[4,2] + @nascita.text[2,2] + @nascita.text[0,2]
						@datanasingl = @nascita.text[4,2] + @nascita.text[2,2] + @nascita.text[0,2]
						@datanasingl = Time.parse("#{@datanasingl}").strftime("%Y")[0,2] + @datanasingl
					else
					end

					if controllo.has_value?("#{@razza.text.upcase}")
						@razzaid = controllo.index("#{@razza.text.upcase}")
					else
						Errore.avviso(finestraingr, "La razza inserita non è classificata.")
						errore = 1
						@razzaid = 0
					end

					#if @marca.text == nil or @marca.text == "" or @comborazze.active == -1 or @nascita.text == nil or @combonazorig.active == -1 or @combonaznas.active == -1 or @comboing.active == -1
					if @marca.text == "" or @madre.text == "" or @razzaid == 0 or @nascita.text == "" or @combonazorig.active == -1 or @combonaznas.active == -1 or @comboing.active == -1
						Errore.avviso(finestraingr, "Mancano dei dati obbligatori.")
						errore = 1
					elsif @marca.text[0,2].upcase == "IT" and @marca.text.length < 14
						Errore.avviso(finestraingr, "Marca corta.")
						errore = 1
					elsif @nascita.text.to_i == 0
						Errore.avviso(finestraingr, "Data di nascita errata.")
						errore = 1
					elsif Time.parse("#{@datanasingl}") > @giorno
						Errore.avviso(finestraingr, "La data di nascita non può essere successiva al giorno odierno.")
						errore = 1
					elsif Time.parse("#{@datanasingl}") > Time.parse("#{@depositoingr["dataingr"]}")
						Errore.avviso(finestraingr, "La data di nascita non può essere successiva alla data di ingresso.")
						errore = 1
					elsif @marcatura.text != "" and @marcatura.text.to_i != 0
						#@datamarcingl = @giorno.strftime("%Y")[0,2] + @marcatura.text[4,2] + @marcatura.text[2,2] + @marcatura.text[0,2]
						@datamarcingl = @marcatura.text[4,2] + @marcatura.text[2,2] + @marcatura.text[0,2]
						@datamarcingl = Time.parse("#{@datamarcingl}").strftime("%Y")[0,2] + @datamarcingl
						if Time.parse("#{@datamarcingl}") < Time.parse("#{@datanasingl}")
							Errore.avviso(finestraingr, "La data di marcatura non può essere minore della data di nascita.")
							errore = 1
						else
						end
					elsif @marcatura.text != "" and @marcatura.text.to_i == 0
						Errore.avviso(finestraingr, "lettere.")
						errore = 1
					elsif @marcatura.text == ""
						@datamarcingl = ""
					end

					if errore == 0
						@arraypres << @marca.text.upcase
						@depositoingr["marca"] = @marca.text.upcase
						@depositoingr["specie"] = @valspecie
						#@depositoingr["razza"] = @comborazze.active_iter[0]
						@depositoingr["razza"] = @razzaid
						@depositoingr["datanascita"] = @nascita.text
						@depositoingr["stallanascita"] = @stallanas.text.upcase
						@depositoingr["sesso"] = @valsesso
						@depositoingr["nazorig"] = @combonazorig.active_iter[0]
						@depositoingr["nazorigcod"] = @combonazorig.active_iter[2]
						@depositoingr["naznasprimimp"] = @combonaznas.active_iter[0]
						@depositoingr["naznasprimimpcod"] = @combonaznas.active_iter[2]
						@depositoingr["datamarca"] = @marcatura.text
						@depositoingr["marcaprec"] = @prec.text.upcase
						@depositoingr["madre"] = @madre.text.upcase
						@depositoingr["padre"] = @padre.text.upcase
						@depositoingr["donatrice"] = @don.text.upcase
						@depositoingr["libgen"] = @libgen.text.upcase
						@depositoingr["iscrlibgen"] = @valgen
						@depositoingr["embryo"] = @valembryo

						#Animals.create(:relaz_id => "#{@stallaoper.to_i}", :tipo => "I", :cm_ing => "#{@depositoingr["ingresso"]}", :marca => "#{@marca.text.upcase}", :specie=> "#{@valspecie}", :razza_id => "#{@comborazze.active_iter[0]}", :data_nas => "#{@datanasingl.to_i}", :stalla_nas => "#{@stallanas.text.upcase}", :sesso => "#{@valsesso}", :naz_orig => "#{@combonazorig.active_iter[2]}", :naz_nasprimimp => "#{@combonaznas.active_iter[2]}", :data_applm => "#{@datamarcingl.to_i}", :ilg => "#{@valgen}", :embryo => "#{@valembryo}", :marca_prec => "#{@prec.text.upcase}", :marca_madre => "#{@madre.text.upcase}", :marca_padre => "#{@padre.text.upcase}", :donatrice => "#{@don.text.upcase}", :clg => "#{@libgen.text.upcase}", :data_ingr => "#{@depositoingr["dataingr"]}", :naz_prov => "#{@depositoingr["nazprov"]}", :certsan => "#{@depositoingr["certsan"]}", :rifloc => "#{@depositoingr["rifloc"]}", :allevamenti_id => "#{@depositoingr["idallprov"]}", :mod4 => "#{@depositoingr["mod4"]}", :data_mod4 => "#{@depositoingr["datamod4"]}") #:stalla_prov => "#{@depositoingr["stallaprov"]}"
						Animals.create(:relaz_id => "#{@stallaoper.id.to_i}", :tipo => "I", :cm_ing => "#{@depositoingr["ingresso"]}", :marca => "#{@marca.text.upcase}", :specie=> "#{@valspecie}", :razza_id => "#{@razzaid}", :data_nas => "#{@datanasingl.to_i}", :stalla_nas => "#{@stallanas.text.upcase}", :sesso => "#{@valsesso}", :naz_orig => "#{@combonazorig.active_iter[2]}", :naz_nasprimimp => "#{@combonaznas.active_iter[2]}", :data_applm => "#{@datamarcingl.to_i}", :ilg => "#{@valgen}", :embryo => "#{@valembryo}", :marca_prec => "#{@prec.text.upcase}", :marca_madre => "#{@madre.text.upcase}", :marca_padre => "#{@padre.text.upcase}", :donatrice => "#{@don.text.upcase}", :clg => "#{@libgen.text.upcase}", :data_ingr => "#{@depositoingr["dataingr"]}", :naz_prov => "#{@depositoingr["nazprov"]}", :certsan => "#{@depositoingr["certsan"]}", :rifloc => "#{@depositoingr["rifloc"]}", :allevamenti_id => "#{@depositoingr["idallprov"]}", :mod4 => "#{@depositoingr["mod4"]}", :data_mod4 => "#{@depositoingr["datamod4"]}") #:stalla_prov => "#{@depositoingr["stallaprov"]}"
						labelultima.set_markup("<b>Ultima marca inserita: #{@depositoingr["marca"]}</b>")
						@marca.text = ""
						@nascita.text = ""
						@madre.text = ""
						@marcatura.text = ""
						@padre.text = ""
						@don.text = ""
						@containgressi -=1
						labelingr.text = ("Totale capi da inserire: #{@containgressi}")

					end
				rescue Exception => errore
				#puts errore
					Errore.avviso(finestraingr, "Controllare le date")
				end
			}

	#		@comborazze.set_active(0)
	#		contarazze = -1
	#		while @comborazze.active_iter[0] != @depositoingr["razza"]
	#			contarazze+=1
	#			@comborazze.set_active(contarazze)
	#		end
			#@razza.text = @depositoingr["razza"]
			@nascita.text = "" #@depositoingr["datanascita"]
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
			labelmotivoi.hide
			bottinsconsvel.hide
			@comboing.hide
		else
			Errore.avviso(finestraingr, "Bisogna inserire il primo capo della partita prima di procedere con l'inserimento consecutivo.")
		end
	}

	boxingrvert.pack_start(bottinscons, false, false, 0)
	
	# Inserimento consecutivo veloce (per capi esteri)
	
	#bottinsconsvel = Gtk::Button.new("Inserimento consecutivo veloce")
		bottinsconsvel.signal_connect("clicked") {
		primoins = 1
		errore = 0
		if @primocapo == 1
			labelultima = Gtk::Label.new
			labelultima.set_markup("<b>Ultima marca inserita: #{@depositoingr["marca"]}</b>")
			#@nascita.text = @depositoingr["datanascita"]
			boxingr2.pack_start(labelultima, false, false, 20)
			bottprossimo2 = Gtk::Button.new("Inserisci")
			#boxingr2.pack_start(bottprossimo2, false, false, 5)
			boxingr9.pack_start(bottprossimo2, true, true, 5)
			finestraingr.show_all

			#Bottone inserimento dati del capo in inserimento consecutivo veloce

			bottprossimo2.signal_connect("clicked") {
				begin
					if errore != 2
						errore = 0
					end
	#				errore = 0
	#				if @arraypres.include?(@marca.text.upcase) == true
	#					errore = 1
	#				else
	#					@arraypres << @marca.text.upcase
	#				end

					if @nascita.text != nil
						@datanasingl = @giorno.strftime("%Y")[0,2] + @nascita.text[4,2] + @nascita.text[2,2] + @nascita.text[0,2]
						#@datanasingl = @nascita.text[4,2] + @nascita.text[2,2] + @nascita.text[0,2]
					else
					end

					if controllo.has_value?("#{@razza.text.upcase}")
						@razzaid = controllo.index("#{@razza.text.upcase}")
					else
						Errore.avviso(finestraingr, "La razza inserita non è classificata.")
						errore = 1
						@razzaid = 0
					end

					#if @marca.text == nil or @marca.text == "" or @comborazze.active == -1 or @nascita.text == nil or @combonazorig.active == -1 or @combonaznas.active == -1 or @comboing.active == -1
					if @marca.text == "" or @madre.text == "" or @razzaid == 0 or @nascita.text == "" #or @combonazorig.active == -1 or @combonaznas.active == -1 or @comboing.active == -1
						Errore.avviso(finestraingr, "Mancano dei dati obbligatori.")
						errore = 1
					elsif @marca.text[0,2].upcase == "IT" and @marca.text.length < 14
						Errore.avviso(finestraingr, "Marca corta.")
						errore = 1
					elsif @nascita.text.to_i == 0
						Errore.avviso(finestraingr, "Data di nascita errata.")
						errore = 1
					elsif Time.parse("#{@datanasingl}") > @giorno
						Errore.avviso(finestraingr, "La data di nascita non può essere successiva al giorno odierno.")
						errore = 1
					elsif Time.parse("#{@datanasingl}") > Time.parse("#{@depositoingr["dataingr"]}")
						Errore.avviso(finestraingr, "La data di nascita non può essere successiva alla data di ingresso.")
						errore = 1
					elsif @marcatura.text != "" and @marcatura.text.to_i != 0
						@datamarcingl = @giorno.strftime("%Y")[0,2] + @marcatura.text[4,2] + @marcatura.text[2,2] + @marcatura.text[0,2]
						if Time.parse("#{@datamarcingl}") < Time.parse("#{@datanasingl}")
							Errore.avviso(finestraingr, "La data di marcatura non può essere minore della data di nascita.")
							errore = 1
						else
						end
					elsif @marcatura.text != "" and @marcatura.text.to_i == 0
						Errore.avviso(finestraingr, "lettere.")
						errore = 1
					elsif @marcatura.text == ""
						@datamarcingl = ""
					end

					if errore == 0
						@arraypres << @marca.text.upcase
						@depositoingr["marca"] = @marca.text.upcase
						#@depositoingr["specie"] = @valspecie
						#@depositoingr["razza"] = @comborazze.active_iter[0]
						@depositoingr["razza"] = @razzaid
						@depositoingr["datanascita"] = @nascita.text
						#@depositoingr["stallanascita"] = @stallanas.text.upcase
						@depositoingr["sesso"] = @valsesso
						#@depositoingr["nazorig"] = @combonazorig.active_iter[0]
						#@depositoingr["naznasprimimp"] = @combonaznas.active_iter[0]
						@depositoingr["datamarca"] = @marcatura.text
						#@depositoingr["marcaprec"] = @prec.text.upcase
						@depositoingr["madre"] = @madre.text.upcase
						#@depositoingr["padre"] = @padre.text.upcase
						#@depositoingr["donatrice"] = @don.text.upcase
						#@depositoingr["libgen"] = @libgen.text.upcase
						@depositoingr["iscrlibgen"] = @valgen
						#@depositoingr["embryo"] = @valembryo

						#Animals.create(:relaz_id => "#{@stallaoper.to_i}", :tipo => "I", :cm_ing => "#{@depositoingr["ingresso"]}", :marca => "#{@marca.text.upcase}", :specie=> "#{@valspecie}", :razza_id => "#{@comborazze.active_iter[0]}", :data_nas => "#{@datanasingl.to_i}", :stalla_nas => "#{@stallanas.text.upcase}", :sesso => "#{@valsesso}", :naz_orig => "#{@combonazorig.active_iter[2]}", :naz_nasprimimp => "#{@combonaznas.active_iter[2]}", :data_applm => "#{@datamarcingl.to_i}", :ilg => "#{@valgen}", :embryo => "#{@valembryo}", :marca_prec => "#{@prec.text.upcase}", :marca_madre => "#{@madre.text.upcase}", :marca_padre => "#{@padre.text.upcase}", :donatrice => "#{@don.text.upcase}", :clg => "#{@libgen.text.upcase}", :data_ingr => "#{@depositoingr["dataingr"]}", :naz_prov => "#{@depositoingr["nazprov"]}", :certsan => "#{@depositoingr["certsan"]}", :rifloc => "#{@depositoingr["rifloc"]}", :allevamenti_id => "#{@depositoingr["idallprov"]}", :mod4 => "#{@depositoingr["mod4"]}", :data_mod4 => "#{@depositoingr["datamod4"]}") #:stalla_prov => "#{@depositoingr["stallaprov"]}"
						Animals.create(:relaz_id => "#{@stallaoper.id.to_i}", :tipo => "I", :cm_ing => "#{@depositoingr["ingresso"]}", :marca => "#{@marca.text.upcase}", :specie=> "#{@depositoingr["specie"]}", :razza_id => "#{@razzaid}", :data_nas => "#{@datanasingl.to_i}", :stalla_nas => "#{@depositoingr["stallanascita"]}", :sesso => "#{@valsesso}", :naz_orig => "#{@depositoingr["nazorigcod"]}", :naz_nasprimimp => "#{@depositoingr["naznasprimimpcod"]}", :data_applm => "#{@datamarcingl.to_i}", :ilg => "#{@depositoingr["iscrlibgen"]}", :embryo => "#{@depositoingr["embryo"]}", :marca_madre => "#{@madre.text.upcase}", :data_ingr => "#{@depositoingr["dataingr"]}", :naz_prov => "#{@depositoingr["nazprov"]}", :certsan => "#{@depositoingr["certsan"]}", :rifloc => "#{@depositoingr["rifloc"]}", :allevamenti_id => "#{@depositoingr["idallprov"]}", :mod4 => "#{@depositoingr["mod4"]}", :data_mod4 => "#{@depositoingr["datamod4"]}") #:stalla_prov => "#{@depositoingr["stallaprov"]}"
						labelultima.set_markup("<b>Ultima marca inserita: #{@depositoingr["marca"]}</b>")
						@marca.text = ""
						@nascita.text = ""
						@madre.text = ""
						@containgressi -=1
						@marcatura.text =  "" #@depositoingr["datamarca"]
						labelingr.text = ("Totale capi da inserire: #{@containgressi}")

					end
				rescue Exception => errore
				#puts errore
					Errore.avviso(finestraingr, "Controllare le date")
				end
			}

	#		@comborazze.set_active(0)
	#		contarazze = -1
	#		while @comborazze.active_iter[0] != @depositoingr["razza"]
	#			contarazze+=1
	#			@comborazze.set_active(contarazze)
	#		end
			#@razza.text = @depositoingr["razza"]
			#@nascita.text = @depositoingr["datanascita"]
			#@stallanas.text = @depositoingr["stallanascita"]
#			@combonazorig.set_active(0)
#			contanazorig = -1
#			while @combonazorig.active_iter[0] != @depositoingr["nazorig"] #and @combonaznas.active_iter[0] != 24
#				contanazorig+=1
#				@combonazorig.set_active(contanazorig)
#			end
#			@combonaznas.set_active(0)
#			contanaznas = -1
#			while @combonaznas.active_iter[0] != @depositoingr["naznasprimimp"] #and @combonaznas.active_iter[0] != 24
#				contanaznas+=1
#				@combonaznas.set_active(contanaznas)
#			end

#			@marcatura.text = @depositoingr["datamarca"]

			labelspecie.hide
			specie1.hide
			specie2.hide
			labelstallanas.hide
			@stallanas.hide
			labelnazorig.hide
			@combonazorig.hide
			labelnaznas.hide
			@combonaznas.hide
			#labelmarcatura.hide
			#@marcatura.hide
			labelgen.hide
			gen1.hide
			gen2.hide
			gen3.hide
			labelembryo.hide
			embryo1.hide
			embryo2.hide
			labelprec.hide
			@prec.hide
			labelpadre.hide
			@padre.hide
			labeldon.hide
			@don.hide
			labellibgen.hide
			@libgen.hide
			bottinscons.hide
			bottmoving.hide
			labelmotivoi.hide
			bottinsconsvel.hide
			@comboing.hide
			#boxingr6.hide
			boxingr7.hide
			#boxingr9.hide
			boxingr10.hide
		else
			Errore.avviso(finestraingr, "Bisogna inserire il primo capo della partita prima di procedere con l'inserimento consecutivo.")
		end
	}

	boxingrvert.pack_start(bottinsconsvel, false, false, 0)

	bottchiudi = Gtk::Button.new("Chiudi finestra")
	bottchiudi.signal_connect("clicked") {
		@primocapo = 0
		finestraingr.destroy
	}
	boxingrvert.pack_start(bottchiudi, false, false, 0)
	finestraingr.show_all
end

