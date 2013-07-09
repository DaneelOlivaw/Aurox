#Maschera dati movimento d'ingresso generica

def ingrgenerica(finestraingr, labelingr)

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
	listall = Gtk::ListStore.new(Integer, String, String, String)
	codallev = Array.new
	selallprov = Allevamentis.find(:all, :order => "ragsoc")
	selallprov.each do |allprov|
		iterallprov = listall.append
		iterallprov[0] = allprov.id
		iterallprov[1] = allprov.ragsoc
		iterallprov[2] = allprov.idfisc
		iterallprov[3] = allprov.cod317
		codallev << allprov.cod317
	end

	@idfiscp = Gtk::Entry.new()
	@idfiscp.editable=(false)

	@comboallprov = Gtk::ComboBox.new(listall)
	if codallev.include?("#{@stallanas.text.upcase}")
		cont = -1
		@comboallprov.set_active(0)
		while @comboallprov.active_iter[3] != @stallanas.text.upcase
			cont+=1
			@comboallprov.set_active(cont)
		end
		@idfiscp.text = ("#{@comboallprov.active_iter[2]}")
	end

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

#	#Inserimento nuovo allevamento
#	
	nallev = Gtk::Button.new("Nuovo allevamento")
	nallev.signal_connect( "released" ) { mascallevam(listall) }
	boxing4.pack_start(nallev, false, false, 5)

	#Nazione provenienza

	labelnazprov = Gtk::Label.new("Nazione di provenienza:")
	boxing5.pack_start(labelnazprov, false, false, 5)
	listanazprov = Gtk::ListStore.new(Integer, String, String)
	selnazprov = Nations.find(:all, :order => "nome")
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
	#@combonazprov.set_active(@nnaz)
	@combonazprov.set_active(0)
	contaprov = -1
	while @combonazprov.active_iter[2] != @nnaz
		contaprov+=1
		@combonazprov.set_active(contaprov)
	end

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

	@dataing.signal_connect("changed") {
		@datamod4.text =("#{@dataing.text}")
	}

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
#	@certsan.signal_connect("changed") {
#		annoing = @giorno.strftime("%Y")[0,2] + @dataing.text[4,2]
#		@testocertsan.text=("INTRA." + "#{@combonazprov.active_iter[2]}" + "." + "#{annoing}" + "." + "#{@certsan.text}")
#	}

	@certsan.signal_connect("changed") {
		if @combonazprov.active_iter[3] == 1
			annoing = @giorno.strftime("%Y")[0,2] + @dataing.text[4,2]
			@testocertsan.text=("INTRA." + "#{@combonazprov.active_iter[2]}" + "." + "#{annoing}" + "." + "#{@certsan.text}")
		else
			annoing = @giorno.strftime("%Y")[0,2] + @dataing.text[4,2]
			@testocertsan.text=("CVEDA." + "#{@combonazprov.active_iter[2]}" + "." + "#{annoing}" + "." + "#{@certsan.text}")
		end
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
#	@idfiscp = Gtk::Entry.new()
#	@idfiscp.editable=(false)
	boxing8.pack_start(@idfiscp, false, false, 5)

	#Bottone di inserimento ingressi

	bottinserisci = Gtk::Button.new( "Inserisci" )
	bottinserisci.signal_connect("clicked") {
		begin
			errore = 0
			@dataingingl = @dataing.text[4,2] + @dataing.text[2,2] + @dataing.text[0,2]
			@dataingingl = Time.parse("#{@dataingingl}").strftime("%Y")[0,2] + @dataingingl
			if @dataing.text.to_i == 0 or @dataing.text.length < 6
				Errore.avviso(mingressi, "Data di ingresso sbagliata.")
				errore = 1
			elsif Time.parse("#{@dataingingl}") < Time.parse("#{@datanasingl}")
				Errore.avviso(mingressi, "La data di ingresso non può essere inferiore alla data di nascita.")
				errore = 1
			elsif @datamod4.text.to_i == 0 or @datamod4.text.length < 6 #@datamod4.text != "" and @datamod4.text.to_i == 0 or @datamod4.text == "" #and @datamod4.text.to_i != 0
				Errore.avviso(mingressi, "Data mod.4 sbagliata.")
				errore = 1
			elsif @datamod4.text != "" and @datamod4.text.to_i != 0
				@datamod4ingl = @datamod4.text[4,2] + @datamod4.text[2,2] + @datamod4.text[0,2]
				@datamod4ingl = Time.parse("#{@datamod4ingl}").strftime("%Y")[0,2] + @datamod4ingl
				#puts Time.parse("#{@datamod4ingl}").strftime("%Y")
					if Time.parse("#{@datamod4ingl}") > Time.parse("#{@dataingingl}")
						Errore.avviso(mingressi, "La data del mod.4 non può essere successiva alla data di ingresso.")
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
			Errore.avviso(mingressi, "Controllare le date.")
		end
		if errore == 0
			#puts @dataingingl
			@depositoingr["dataingr"] = @dataingingl.to_i
			@depositoingr["idallprov"] = @idallprov
			@depositoingr["nazprov"] = @combonazprov.active_iter[2]
			@depositoingr["mod4"] = @comboallprov.active_iter[3] + "/" + Time.parse("#{@datamod4ingl}").strftime("%Y") + "/" + @mod4.text
			@depositoingr["datamod4"] = @datamod4ingl.to_i
			@depositoingr["certsan"] = @testocertsan.text.upcase
			@depositoingr["rifloc"] = @rifloc.text.upcase

#			Animals.create(:relaz_id => "#{@stallaoper.to_i}", :tipo => "I", :cm_ing => "#{@comboing.active_iter[0]}", :marca => "#{@marca.text.upcase}", :specie=> "#{@valspecie}", :razza_id => "#{@comborazze.active_iter[0]}", :data_nas => "#{@datanasingl.to_i}", :stalla_nas => "#{@stallanas.text.upcase}", :sesso => "#{@valsesso}", :naz_orig => "#{@combonazorig.active_iter[2]}", :naz_nasprimimp => "#{@combonaznas.active_iter[2]}", :data_applm => "#{@datamarcingl.to_i}", :ilg => "#{@valgen}", :embryo => "#{@valembryo}", :marca_prec => "#{@prec.text.upcase}", :marca_madre => "#{@madre.text.upcase}", :marca_padre => "#{@padre.text.upcase}", :donatrice => "#{@don.text.upcase}", :clg => "#{@libgen.text.upcase}", :data_ingr => "#{@dataingingl.to_i}", :allevamenti_id => "#{@idallprov}", :naz_prov => "#{@combonazprov.active_iter[2]}", :mod4 => "#{@comboallprov.active_iter[3] + "/" + @giorno.strftime("%Y") + "/" + @mod4.text}", :data_mod4 => "#{@datamod4ingl.to_i}", :certsan => "#{@testocertsan.text.upcase}", :rifloc => "#{@rifloc.text.upcase}")
			Animals.create(:relaz_id => "#{@stallaoper.id.to_i}", :tipo => "I", :cm_ing => "#{@comboing.active_iter[0]}", :marca => "#{@marca.text.upcase}", :specie=> "#{@valspecie}", :razza_id => "#{@razzaid}", :data_nas => "#{@datanasingl.to_i}", :stalla_nas => "#{@stallanas.text.upcase}", :sesso => "#{@valsesso}", :naz_orig => "#{@combonazorig.active_iter[2]}", :naz_nasprimimp => "#{@combonaznas.active_iter[2]}", :data_applm => "#{@datamarcingl.to_i}", :ilg => "#{@valgen}", :embryo => "#{@valembryo}", :marca_prec => "#{@prec.text.upcase}", :marca_madre => "#{@madre.text.upcase}", :marca_padre => "#{@padre.text.upcase}", :donatrice => "#{@don.text.upcase}", :clg => "#{@libgen.text.upcase}", :data_ingr => "#{@dataingingl.to_i}", :allevamenti_id => "#{@idallprov}", :naz_prov => "#{@combonazprov.active_iter[2]}", :mod4 => "#{@comboallprov.active_iter[3] + "/" + Time.parse("#{@datamod4ingl}").strftime("%Y") + "/" + @mod4.text}", :data_mod4 => "#{@datamod4ingl.to_i}", :certsan => "#{@testocertsan.text.upcase}", :rifloc => "#{@rifloc.text.upcase}")
			@containgressi -=1
			labelingr.text = ("Totale capi da inserire: #{@containgressi}")
			#@comborazze.active = -1
			@razza.text = ""
			@razzaid = 0
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
			Conferma.conferma(mingressi, "Capo inserito correttamente.")
			mingressi.destroy
			finestraingr.present
		else
		end
	}

	boxing1.pack_start(bottinserisci, false, false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi senza salvare" )
	bottchiudi.signal_connect("clicked") {
		mingressi.destroy
		finestraingr.present
	}
	boxing1.pack_start(bottchiudi, false, false, 0)
	mingressi.show_all
end

