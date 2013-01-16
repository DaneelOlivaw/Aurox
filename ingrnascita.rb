def mascnascita(finestra, labelingr)
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
	boxingnas5.pack_start(@combonazprov, false, false, 0)

	@dataing.text = @nascita.text
	#@combonazprov.set_active(@nnaz) #sensitive=(false)
	@combonazprov.set_active(0)
	contaprov = -1
	while @combonazprov.active_iter[2] != @nnaz
		contaprov+=1
		@combonazprov.set_active(contaprov)
	end

	#Bottone di inserimento ingressi

	bottinserisci = Gtk::Button.new( "Inserisci" )
	bottinserisci.signal_connect("clicked") {
		begin
			errore = 0
			@dataingingl = @dataing.text[4,2] + @dataing.text[2,2] + @dataing.text[0,2]
			@dataingingl = Time.parse("#{@dataingingl}").strftime("%Y")[0,2] + @dataingingl
			if @dataing.text.to_i == 0 or @dataing.text.length < 6
				Errore.avviso(mnascita, "Data di ingresso sbagliata.")
				errore = 1
			elsif Time.parse("#{@dataingingl}") < Time.parse("#{@datanasingl}")
				Errore.avviso(mnascita, "La data di ingresso non può essere inferiore alla data di nascita.")
				errore = 1
			else
			end
		rescue Exception => errore
			Errore.avviso(mnascita, "Controllare le date.")
		end
		if errore == 0
			@depositoingr["dataingr"] = @datanasingl.to_i
			@depositoingr["nazprov"] = @combonazprov.active_iter[2]
			allprov = Allevamentis.find(:first, :conditions => "cod317 = '#{@stallaoper.stalle.cod317}'")
			@depositoingr["idallprov"] = allprov.id
			#Animals.create(:relaz_id => "#{@t.id.to_i}", :tipo => "I", :cm_ing => "#{@comboing.active_iter[0]}", :marca => "#{@marca.text.upcase}", :specie=> "#{@valspecie}", :razza_id => "#{@comborazze.active_iter[0]}", :data_nas => "#{@datanasingl.to_i}", :stalla_nas => "#{@stallanas.text.upcase}", :sesso => "#{@valsesso}", :naz_orig => "#{@combonazorig.active_iter[2]}", :naz_nasprimimp => "#{@combonaznas.active_iter[2]}", :data_applm => "#{@datamarcingl.to_i}", :ilg => "#{@valgen}", :embryo => "#{@valembryo}", :marca_prec => "#{@prec.text.upcase}", :marca_madre => "#{@madre.text.upcase}", :marca_padre => "#{@padre.text.upcase}", :donatrice => "#{@don.text.upcase}", :clg => "#{@libgen.text.upcase}", :data_ingr => "#{@dataingingl.to_i}", :naz_prov => "#{@combonazprov.active_iter[2]}", :allevamenti_id => "#{@depositoingr["idallprov"]}")
			Animals.create(:relaz_id => "#{@stallaoper.id.to_i}", :tipo => "I", :cm_ing => "#{@comboing.active_iter[0]}", :marca => "#{@marca.text.upcase}", :specie=> "#{@valspecie}", :razza_id => "#{@razzaid}", :data_nas => "#{@datanasingl.to_i}", :stalla_nas => "#{@stallanas.text.upcase}", :sesso => "#{@valsesso}", :naz_orig => "#{@combonazorig.active_iter[2]}", :naz_nasprimimp => "#{@combonaznas.active_iter[2]}", :data_applm => "#{@datamarcingl.to_i}", :ilg => "#{@valgen}", :embryo => "#{@valembryo}", :marca_prec => "#{@prec.text.upcase}", :marca_madre => "#{@madre.text.upcase}", :marca_padre => "#{@padre.text.upcase}", :donatrice => "#{@don.text.upcase}", :clg => "#{@libgen.text.upcase}", :data_ingr => "#{@dataingingl.to_i}", :naz_prov => "#{@combonazprov.active_iter[2]}", :allevamenti_id => "#{@depositoingr["idallprov"]}")
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
			Conferma.conferma(mnascita, "Capo inserito correttamente.")
			mnascita.destroy
			finestra.present
		else
		end
	}

	boxingnas1.pack_start(bottinserisci, false, false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi senza salvare" )
	bottchiudi.signal_connect("clicked") {
		mnascita.destroy
		finestra.present
	}
	boxingnas1.pack_start(bottchiudi, false, false, 0)
	mnascita.show_all
end
