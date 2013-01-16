# Inserimento prima importazione

def mascprimimp2(mcontaingr2, totcapi, tipomovimento)

	mprimimp = Gtk::Window.new("Prima importazione")
	mprimimp.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	mcontaingr2.destroy
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
	dataing = Gtk::Entry.new
	dataing.max_length=(6)
	boxprimimp3.pack_start(dataing, false, false, 5)

	#Nazione provenienza

	labelnazprov = Gtk::Label.new("Nazione di provenienza:")
	boxprimimp5.pack_start(labelnazprov, false, false, 5)
	listanazprov = Gtk::ListStore.new(Integer, String, String, Integer)
	controllonp = Hash.new
	selnazprov = Nations.find(:all, :order => "nome")
	selnazprov.each do |np|
		iter1 = listanazprov.append
		iter1[0] = np.id.to_i
		iter1[1] = np.nome
		iter1[2] = np.codice
		iter1[3] = np.tipo.to_i
		controllonp.merge!("#{np.nome}" => [np.id, np.codice, np.tipo])
	end
	#puts controllonp.inspect
#	combonazprov = Gtk::ComboBox.new(listanazprov)
#	renderer1 = Gtk::CellRendererText.new
#	renderer1.visible=(false)
#	combonazprov.pack_start(renderer1,false)
#	combonazprov.set_attributes(renderer1, :text => 0)
#	renderer1 = Gtk::CellRendererText.new
#	combonazprov.pack_start(renderer1,false)
#	combonazprov.set_attributes(renderer1, :text => 1)
#	renderer1 = Gtk::CellRendererText.new
#	renderer1.visible=(false)
#	combonazprov.pack_start(renderer1,false)
#	combonazprov.set_attributes(renderer1, :text => 2)
#	renderer1 = Gtk::CellRendererText.new
#	renderer1.visible=(false)
#	combonazprov.pack_start(renderer1,false)
#	combonazprov.set_attributes(renderer1, :text => 3)
#	boxprimimp5.pack_start(combonazprov, false, false, 0)

	nazprov = Gtk::Entry.new
	nazprov.width_chars=(30)
	complet = Gtk::EntryCompletion.new
	complet.model=(listanazprov)
	renderer1 = Gtk::CellRendererText.new
	complet.pack_start(renderer1,false)
	complet.set_text_column(1)
	complet.inline_completion=(true)
	if @sistema == "linux"
		complet.inline_selection=(true)
	end
	complet.minimum_key_length=(0)
	nazprov.completion=(complet)
	boxprimimp5.pack_start(nazprov, false, false, 0)
	
#	nazprov.signal_connect("focus_out_event") {
#		puts "FUORI!"
#	}
	#Certificato sanitario

	labelcertsan = Gtk::Label.new("Certificato sanitario:")
	boxprimimp7.pack_start(labelcertsan, false, false, 5)
	certsan = Gtk::Entry.new()
	certsan.max_length=(7)
	certsan.width_chars=(7)
	boxprimimp7.pack_start(certsan, false, false, 5)
	testocertsan = Gtk::Entry.new
	testocertsan.width_chars=(21)
	boxprimimp7.pack_start(testocertsan, false, false, 5)
#	certsan.signal_connect("changed") {
#		if combonazprov.active_iter[3] == 1
#			annoing = @giorno.strftime("%Y")[0,2] + dataing.text[4,2]
#			testocertsan.text=("INTRA." + "#{combonazprov.active_iter[2]}" + "." + "#{annoing}" + "." + "#{certsan.text}")
#		else
#			annoing = @giorno.strftime("%Y")[0,2] + dataing.text[4,2]
#			testocertsan.text=("CVEDA." + "#{combonazprov.active_iter[2]}" + "." + "#{annoing}" + "." + "#{certsan.text}")
#		end
#	}
	errorenaz = 0
	nazprov.signal_connect("focus_out_event") {
		#puts "FUORI!"
		if controllonp.has_key?("#{nazprov.text.upcase}")
			#puts "bene"
			#puts controllonp["#{nazprov.text.upcase}"]
			errorenaz = 0
#			certsan.signal_connect("changed") {
#				if controllonp["#{nazprov.text.upcase}"][2] == 1
#					annoing = @giorno.strftime("%Y")[0,2] + dataing.text[4,2]
#					testocertsan.text=("INTRA." + "#{controllonp["#{nazprov.text.upcase}"][1]}" + "." + "#{annoing}" + "." + "#{certsan.text}")
#				else
#					annoing = @giorno.strftime("%Y")[0,2] + dataing.text[4,2]
#					testocertsan.text=("CVEDA." + "#{controllonp["#{nazprov.text.upcase}"][1]}" + "." + "#{annoing}" + "." + "#{certsan.text}")
#				end
#			}
			else
			#puts "male"
			errorenaz = 1
			Errore.avviso(mprimimp, "La nazione non è classificata.")
		end
	}

	certsan.signal_connect("changed") {
		if errorenaz == 0 and nazprov.text != ""
			if controllonp["#{nazprov.text.upcase}"][2] == 1
				annoing = @giorno.strftime("%Y")[0,2] + dataing.text[4,2]
				testocertsan.text=("INTRA." + "#{controllonp["#{nazprov.text.upcase}"][1]}" + "." + "#{annoing}" + "." + "#{certsan.text}")
			else
				annoing = @giorno.strftime("%Y")[0,2] + dataing.text[4,2]
				testocertsan.text=("CVEDA." + "#{controllonp["#{nazprov.text.upcase}"][1]}" + "." + "#{annoing}" + "." + "#{certsan.text}")
			end
		else
			Errore.avviso(mprimimp, "C'è un problema con la nazione, non si può proseguire.")
		end
	}
	
	
	
	
	#Numero riferimento locale

	labelrifloc = Gtk::Label.new("Numero riferimento locale:")
	boxprimimp7.pack_start(labelrifloc, false, false, 5)
	rifloc = Gtk::Entry.new()
	rifloc.max_length=(20)
	boxprimimp7.pack_start(rifloc, false, false, 5)

	# Nazione di provenienza

#	if comboing.active_iter[0] == 13 or comboing.active_iter[0] == 32
#		combonazprov.set_active(0)
#		x = -1
#		while combonazprov.active_iter[2] != marca.text[0,2].upcase
#			x+=1
#			combonazprov.set_active(x)
#		end
#	end

	depositoingr = Hash.new
	#Bottone di inserimento ingressi

	bottanimale = Gtk::Button.new( "Dati dell'animale" )
	bottanimale.signal_connect("clicked") {
		begin
			errore = 0
			dataingingl = dataing.text[4,2] + dataing.text[2,2] + dataing.text[0,2]
			dataingingl = Time.parse("#{dataingingl}").strftime("%Y")[0,2] + dataingingl
			if dataing.text.to_i == 0 or dataing.text.length < 6
				Errore.avviso(mprimimp, "Data di ingresso sbagliata.")
				errore = 1
#			elsif Time.parse("#{dataingingl}") < Time.parse("#{datanasingl}")
#				Errore.avviso(mprimimp, "La data di ingresso non può essere inferiore alla data di nascita.")
#				errore = 1
			end

		rescue Exception => errore
			Errore.avviso(mprimimp, "Controllare le date.")
		end
		if errore == 0
			depositoingr["dataingr"] = dataing.text #.to_i
			depositoingr["dataingringl"] = dataingingl
			depositoingr["idallprov"] = ""
			depositoingr["nazprov"] = controllonp["#{nazprov.text.upcase}"][1]
			depositoingr["tiponazprov"] = controllonp["#{nazprov.text.upcase}"][2]
			depositoingr["mod4"] = ""
			depositoingr["datamod4"] = ""
			depositoingr["tipomovimento"] = tipomovimento
			depositoingr["certsan"] = testocertsan.text.upcase
			depositoingr["rifloc"] = rifloc.text.upcase
#			Animals.create(:relaz_id => "#{@stallaoper.to_i}", :tipo => "I", :cm_ing => "#{@comboing.active_iter[0]}", :marca => "#{@marca.text.upcase}", :specie=> "#{@valspecie}", :razza_id => "#{@comborazze.active_iter[0]}", :data_nas => "#{@datanasingl.to_i}", :stalla_nas => "#{@stallanas.text.upcase}", :sesso => "#{@valsesso}", :naz_orig => "#{@combonazorig.active_iter[2]}", :naz_nasprimimp => "#{@combonaznas.active_iter[2]}", :data_applm => "#{@datamarcingl.to_i}", :ilg => "#{@valgen}", :embryo => "#{@valembryo}", :marca_prec => "#{@prec.text.upcase}", :marca_madre => "#{@madre.text.upcase}", :marca_padre => "#{@padre.text.upcase}", :donatrice => "#{@don.text.upcase}", :clg => "#{@libgen.text.upcase}", :data_ingr => "#{@dataingingl.to_i}", :naz_prov => "#{@combonazprov.active_iter[2]}", :certsan => "#{@testocertsan.text.upcase}", :rifloc => "#{@rifloc.text.upcase}")
			#Animals.create(:relaz_id => "#{@stallaoper.id.to_i}", :tipo => "I", :cm_ing => "#{comboing.active_iter[0]}", :marca => "#{@marca.text.upcase}", :specie=> "#{@valspecie}", :razza_id => "#{@razzaid}", :data_nas => "#{@datanasingl.to_i}", :stalla_nas => "#{@stallanas.text.upcase}", :sesso => "#{@valsesso}", :naz_orig => "#{@combonazorig.active_iter[2]}", :naz_nasprimimp => "#{@combonaznas.active_iter[2]}", :data_applm => "#{@datamarcingl.to_i}", :ilg => "#{@valgen}", :embryo => "#{@valembryo}", :marca_prec => "#{@prec.text.upcase}", :marca_madre => "#{@madre.text.upcase}", :marca_padre => "#{@padre.text.upcase}", :donatrice => "#{@don.text.upcase}", :clg => "#{@libgen.text.upcase}", :data_ingr => "#{@dataingingl.to_i}", :naz_prov => "#{@combonazprov.active_iter[2]}", :certsan => "#{@testocertsan.text.upcase}", :rifloc => "#{@rifloc.text.upcase}")
#			containgressi -=1
#			labelingr.text = ("Totale capi da inserire: #{containgressi}")
##			@comborazze.active = -1
#			razza.text = ""
#			razzaid = 0
#			nascita.text = ""
#			@stallanas.text = ""
#			@combonazorig.active = -1
#			@combonaznas.active = -1
#			@marcatura.text = ""
#			@prec.text = ""
#			@madre.text = ""
#			@padre.text = ""
#			@don.text = ""
#			@libgen.text = ""
#			@marca.text = ""
#			@primocapo = 1
#			@sesso1.active=(true)
#			@valsesso="M"
			#Conferma.conferma(mprimimp, "Capo inserito correttamente.")
			mprimimp.destroy
			require 'daticapoingr2'
			inscapo2(totcapi, depositoingr)
			#finestraingr.present
		else
		end
	}

	boxprimimp1.pack_start(bottanimale, false, false, 0)

	bottchiudi = Gtk::Button.new( "Chiudi senza salvare" )
	bottchiudi.signal_connect("clicked") {
		mprimimp.destroy
		#finestraingr.present
	}
	boxprimimp1.pack_start(bottchiudi, false, false, 0)

	mprimimp.show_all
end

