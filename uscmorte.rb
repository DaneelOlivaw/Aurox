def uscmorte(finestra, muscite, listasel, combousc)
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
	datausc = Gtk::Entry.new()
	datausc.max_length =(6)
	boxusc1.pack_end(datausc, false, false, 5)

	# Certificato sanitario uscita

	labelcertsanusc = Gtk::Label.new("Certificato sanitario:")
	boxusc2.pack_start(labelcertsanusc, false, false, 5)
	certsanusc = Gtk::Entry.new()
	boxusc2.pack_end(certsanusc, false, false, 5)

	# Data certificato sanitario

	labeldatacertsanusc = Gtk::Label.new("Data Certificato Sanitario (GGMMAA):")
	boxusc3.pack_start(labeldatacertsanusc, false, false, 5)
	datacertsanusc = Gtk::Entry.new()
	datacertsanusc.max_length=(6)
	boxusc3.pack_end(datacertsanusc, false, false, 5)

	datausc.signal_connect("changed") {
		datacertsanusc.text =("#{datausc.text}")
	}

	#Bottone di inserimento uscite

	bottmovusc = Gtk::Button.new( "Inserisci" )
	bottmovusc.signal_connect("clicked") {
		begin
		errore = nil
		if datausc.text == "" or certsanusc.text == "" or datacertsanusc.text == ""
			Errore.avviso(mdatimorte, "Mancano dati: morte.")
			errore = 1
		elsif datausc.text.to_i == 0
			Errore.avviso(mdatimorte, "Data uscita errata.")
			errore = 1
		elsif datacertsanusc.text.to_i == 0
			Errore.avviso(mdatimorte, "Data certificato sanitario errata.")
			errore = 1
		else
			datauscingl = @giorno.strftime("%Y")[0,2] + datausc.text[4,2] + datausc.text[2,2] + datausc.text[0,2]
			Time.parse("#{datauscingl}")
			datacertsanuscingl = @giorno.strftime("%Y")[0,2] + datacertsanusc.text[4,2] + datacertsanusc.text[2,2] + datacertsanusc.text[0,2]
			Time.parse("#{datacertsanuscingl}")
			if Time.parse("#{datacertsanuscingl}") < Time.parse("#{datauscingl}")
				Errore.avviso(mdatimorte, "La data del certificato sanitario non può essere inferiore a quella di uscita.")
				errore = 1
			else
			end
		end
		rescue Exception => errore
			Errore.avviso(mdatimorte, "Controllare le date")
		end
	if errore == nil
		listasel.each do |model,path,iter|
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
			Animals.create(:relaz_id => "#{@stallaoper.id.to_i}", :tipo => "U", :cm_usc => "#{combousc.active_iter[0]}", :marca => "#{marcausc}", :specie => "#{specieusc}", :razza_id => "#{razzausc}", :data_nas => "#{nascitausc}", :stalla_nas => "#{cod317nasusc}", :sesso => "#{sessousc}", :naz_orig => "#{nazorigusc}", :naz_nasprimimp => "#{nazprimimpusc}", :data_applm => "#{datamarcausc}", :ilg => "#{ilgusc}", :marca_prec => "#{marcaprecedenteusc}", :marca_madre => "#{madreusc}", :marca_padre => "#{padreusc}", :uscita => "#{datauscingl}", :certsanusc => "#{certsanusc.text}", :data_certsanusc => "#{datacertsanuscingl.to_i}", :idcoll => "#{marcauscid}")
			usc = Animals.find(:first, :conditions => ["idcoll = ?", "#{marcauscid}"])
			Animals.update(marcauscid, { :uscito => "1", :idcoll => "#{usc.id}"})
		end
		Conferma.conferma(mdatimorte, "Capi usciti correttamente.")
		mdatimorte.destroy
		muscite.destroy
		finestra.present
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
