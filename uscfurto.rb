# Uscita per furto

def uscfurto(finestra, muscite, listasel, combousc)
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
	datausc = Gtk::Entry.new()
	datausc.max_length =(6)
	boxusc1.pack_start(datausc, false, false, 5)

	#Bottone di inserimento uscite

	bottmovusc = Gtk::Button.new( "Inserisci" )
	bottmovusc.signal_connect("clicked") {
		begin
			errore = nil
			if datausc.text == ""
				Errore.avviso(mdatifurto, "Mancano dati.")
				errore = 1
			elsif datausc.text.to_i == 0
				Errore.avviso(mdatifurto, "Data uscita errata.")
				errore = 1
			else
				datauscingl = @giorno.strftime("%Y")[0,2] + datausc.text[4,2] + datausc.text[2,2] + datausc.text[0,2]
				Time.parse("#{datauscingl}")
			end
		rescue Exception => errore
			Errore.avviso(mdatifurto, "Controllare le date")
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
				Animals.create(:relaz_id => "#{@stallaoper.id.to_i}", :tipo => "U", :cm_usc => "#{combousc.active_iter[0]}", :marca => "#{marcausc}", :specie => "#{specieusc}", :razza_id => "#{razzausc}", :data_nas => "#{nascitausc}", :stalla_nas => "#{cod317nasusc}", :sesso => "#{sessousc}", :naz_orig => "#{nazorigusc}", :naz_nasprimimp => "#{nazprimimpusc}", :data_applm => "#{datamarcausc}", :ilg => "#{ilgusc}", :marca_prec => "#{marcaprecedenteusc}", :marca_madre => "#{madreusc}", :marca_padre => "#{padreusc}", :uscita => "#{datauscingl}", :idcoll => "#{marcauscid}")
				usc = Animals.find(:first, :conditions => ["idcoll = ?", "#{marcauscid}"])
				Animals.update(marcauscid, { :uscito => "1", :idcoll => "#{usc.id}"})
			end
		Conferma.conferma(mdatifurto, "Capi usciti correttamente.")
			mdatifurto.destroy
			muscite.destroy
			finestra.present
		else
		end
	}
	boxusc2.pack_start(bottmovusc, false, false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mdatifurto.destroy
		muscite.present
	}
	boxusc2.pack_start(bottchiudi, false, false, 0)

	mdatifurto.show_all

end
