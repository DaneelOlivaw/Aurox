# Inserimento dei dati di uscita dei capi verso estero

def datiestero(finestra, muscite, listasel, combousc)
	mdatiestero = Gtk::Window.new("Compravendita verso estero")
	mdatiestero.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
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
	mdatiestero.add(boxuscv)

	#Data uscita

	labeldatausc = Gtk::Label.new("Data uscita (GGMMAA):")
	boxusc2.pack_start(labeldatausc, false, false, 5)
	datausc = Gtk::Entry.new()
	datausc.max_length =(6)
	boxusc2.pack_start(datausc, false, false, 5)

#	#Allevamento / mercato di destinazione

#	labelallevdest = Gtk::Label.new("Codice allevamento / mercato di destinazione:")
#	boxusc3.pack_start(labelallevdest, false, false, 5)
#	listall = Gtk::ListStore.new(Integer, String, String, String)
#	selalldest = Allevamentis.find(:all, :order => "ragsoc")
#	selalldest.each do |alldest|
#		iteralldest = listall.append
#		iteralldest[0] = alldest.id
#		iteralldest[1] = alldest.ragsoc
#		iteralldest[2] = alldest.idfisc
#		iteralldest[3] = alldest.cod317
#	end
#	comboalldest = Gtk::ComboBox.new(listall)
#	renderusc = Gtk::CellRendererText.new
#	renderusc.visible=(false)
#	comboalldest.pack_start(renderusc,false)
#	comboalldest.set_attributes(renderusc, :text => 0)
#	renderusc = Gtk::CellRendererText.new
#	comboalldest.pack_start(renderusc,false)
#	comboalldest.set_attributes(renderusc, :text => 1)
#	renderusc = Gtk::CellRendererText.new
#	renderusc.visible=(false)
#	comboalldest.pack_start(renderusc,false)
#	comboalldest.set_attributes(renderusc, :text => 2)
#	renderusc = Gtk::CellRendererText.new
#	comboalldest.pack_start(renderusc,false)
#	comboalldest.set_attributes(renderusc, :text => 3)
#	boxusc3.pack_start(comboalldest, false, false, 5)

#	#Inserimento nuovo allevamento

#	nallev = Gtk::Button.new("Nuovo allevamento")
#	nallev.signal_connect( "released" ) { mascallevam(listall) }
#	boxusc3.pack_start(nallev, false, false, 5)

	#Nazione destinazione

	labelnazdest = Gtk::Label.new("Nazione di destinazione:")
	boxusc4.pack_start(labelnazdest, false, false, 5)
	listanazdest = Gtk::ListStore.new(Integer, String, String)
	selnazdest = Nations.find(:all, :order => "nome")
	selnazdest.each do |nd|
	iter1 = listanazdest.append
	iter1[0] = nd.id.to_i
	iter1[1] = nd.nome
	iter1[2] = nd.codice
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
	boxusc4.pack_start(combonazdest, false, false, 0)
	combonazdest.set_active(0)
	z = -1
	while combonazdest.active_iter[0] != 24
		z+=1
		combonazdest.set_active(z)
	end

	# Nome trasportatore

	labeltrasp = Gtk::Label.new("Nome trasportatore:")
	boxusc6.pack_start(labeltrasp, false, false, 5)
	listatrasp = Gtk::ListStore.new(Integer, String)
	seltrasp = Trasportatoris.find(:all, :order => "nometrasp")
	seltrasp.each do |trasp|
		itertrasp = listatrasp.append
		itertrasp[0] = trasp.id
		itertrasp[1] = trasp.nometrasp
	end
	combotrasp = Gtk::ComboBox.new(listatrasp)
	rendertrasp = Gtk::CellRendererText.new
	rendertrasp.visible=(false)
	combotrasp.pack_start(rendertrasp,false)
	combotrasp.set_attributes(rendertrasp, :text => 0)
	rendertrasp = Gtk::CellRendererText.new
	combotrasp.pack_start(rendertrasp,false)
	combotrasp.set_attributes(rendertrasp, :text => 1)
	boxusc6.pack_start(combotrasp, false, false, 5)

	#Inserimento nuovo trasportatore

	ntrasp = Gtk::Button.new("Nuovo trasportatore")
	ntrasp.signal_connect( "released" ) { instrasportatori(listatrasp) }
	boxusc6.pack_start(ntrasp, false, false, 5)

#	#Marca sostitutiva

#	labelmarcasost = Gtk::Label.new("Marca sostitutiva:")
#	boxusc7.pack_start(labelmarcasost, false, false, 5)
#	marcasost = Gtk::Entry.new()
#	boxusc7.pack_start(marcasost, false, false, 5)

	# Certificato sanitario

	labelcertsanc = Gtk::Label.new("Certificato sanitario (ultime 7 cifre):")
	boxusc8.pack_start(labelcertsanc, false, false, 5)
	certsanusc = Gtk::Entry.new()
	certsanusc.max_length=(7)
	#progmod4 = @stallaoper.certsanusc.split("/")
	#progmod41 = progmod4[0].to_i
#	anno = @giorno.strftime("%y")
#		if progmod4[1].to_i == anno.to_i
#			progmod41 += 1
#			#annoreg = progmod4[1]
#		else
#			progmod41 = 1
#			#annoreg = anno
#		end
#	certsanusc.text = ("#{progmod41}")
	boxusc8.pack_start(certsanusc, false, false, 5)

	# Data modello 4

	labeldatacersanusc = Gtk::Label.new("Data certificato sanitario (GGMMAA):")
	boxusc8.pack_start(labeldatacersanusc, false, false, 5)
	datacertsanusc = Gtk::Entry.new()
	datacertsanusc.max_length=(6)
	boxusc8.pack_start(datacertsanusc, false, false, 5)

	datausc.signal_connect("changed") {
		datacertsanusc.text =("#{datausc.text}")
#		if datausc.cursor_position == 5
#			if datausc.text[4,2] == progmod4[1]
#				nmod4 = progmod41 + 1
#			else
#				nmod4 = 1
#			end
#		certsanusc.text = ("#{nmod4}")
#		end
	}

	#Bottone di inserimento uscite

	bottmovusc = Gtk::Button.new( "Inserisci" )
	bottmovusc.signal_connect("clicked") {
		errore = nil
			if datausc.text == "" or combonazdest.active == -1 or certsanusc.text == "" or datacertsanusc.text == ""
				Errore.avviso(mdatiestero, "Mancano dati.")
				errore = 1
			end
		if errore == nil
			begin
				if datausc.text.to_i != 0
					datauscingl = @giorno.strftime("%Y")[0,2] + datausc.text[4,2] + datausc.text[2,2] + datausc.text[0,2]
					Time.parse("#{datauscingl}")
				else
					Errore.avviso(mdatiestero, "Data uscita errata.")
					errore = 1
				end
				if datacertsanusc.text != ""
					if datacertsanusc.text.to_i != 0
						datacertsanuscingl = @giorno.strftime("%Y")[0,2] + datacertsanusc.text[4,2] + datacertsanusc.text[2,2] + datacertsanusc.text[0,2]
						Time.parse("#{datacertsanuscingl}")
					else
						Errore.avviso(mdatiestero, "Data certificato sanitario errata.")
						errore = 1
					end
				else
				end
			rescue Exception => errore
				Errore.avviso(mdatiestero, "Controllare le date")
			end
		end
	if errore == nil
#		if comboalldest.active == -1 or comboalldest.sensitive? == false
#			valcomboalldest = ""
#		else
#			#mod4 = "#{@stallaoper.stalle.cod317}/#{Time.parse("#{datacertsanuscingl}").strftime("%Y")}/#{certsanusc.text}"
#			#puts mod4
#			idalldest = comboalldest.active_iter[0]
#			valcomboalldest = comboalldest.active_iter[1]
#			alldestidfisc = comboalldest.active_iter[2]
#			alldest317 = comboalldest.active_iter[3]
#			#provaunione = Relazs.joins(:stalle, :ragsoc)
##			alldir = Relazs.find(:first, :from => "relazs, stalles, ragsocs", :conditions => ["stalles.cod317 = ? and ragsocs.ragsoc = ?", "#{alldest317}", "#{valcomboalldest}"])
#			#alldir = Relazs.find(:all, :from => "relazs, stalles, ragsocs", :conditions => ["stalles.cod317= ?  and ragsocs.ragsoc= ?", "#{alldest317}", "#{valcomboalldest}"])
#			alldir = Relazs.find(:all, :include => [:stalle, :ragsoc], :conditions => ["stalles.cod317= ? and ragsocs.ragsoc= ?", "#{alldest317}", "#{valcomboalldest}"])
##			puts alldir.length
##			puts "alldir = #{alldir.id}"
##			alldir.each do|a|
##			puts a.ragsoc.ragsoc
##			puts a.stalle.cod317
##			end
#		end
#		if combonazdest.active == -1 or combonazdest.sensitive? == false
#			valcombonazdest = ""
#		else
#			valcombonazdest = combonazdest.active_iter[2]
#		end
#		if combotrasp.active == -1 or combotrasp.sensitive? == false
#			valcombotrasp = ""
#		else
#			valcombotrasp = combotrasp.active_iter[1]
#		end
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
			certsancompl = "INTRA.IT." + "#{@giorno.strftime("%Y")}." + "#{certsanusc.text}"
			Animals.create(:relaz_id => "#{@stallaoper.id.to_i}", :tipo => "U", :cm_usc => "#{combousc.active_iter[0]}", :marca => "#{marcausc}", :specie => "#{specieusc}", :razza_id => "#{razzausc}", :data_nas => "#{nascitausc}", :stalla_nas => "#{cod317nasusc}", :sesso => "#{sessousc}", :naz_orig => "#{nazorigusc}", :naz_nasprimimp => "#{nazprimimpusc}", :data_applm => "#{datamarcausc}", :ilg => "#{ilgusc}", :marca_prec => "#{marcaprecedenteusc}", :marca_madre => "#{madreusc}", :marca_padre => "#{padreusc}", :uscita => "#{datauscingl}", :naz_dest => "#{combonazdest.active_iter[2]}", :trasp => "#{combotrasp.active_iter[1]}", :certsanusc => "#{certsancompl}", :data_certsanusc => "#{datacertsanuscingl}", :idcoll => "#{marcauscid}")
			usc = Animals.find(:first, :conditions => ["idcoll = ?", "#{marcauscid}"])
			Animals.update(marcauscid, { :uscito => "1", :idcoll => "#{usc.id}"})
		end
		#Relazs.update(@stallaoper.id, { :certsanusc => "#{certsanusc.text}/#{Time.parse("#{datacertsanuscingl}").strftime("%y")}"})
		#@stallaoper.certsanusc = certsanusc.text + "/" + Time.parse("#{datacertsanuscingl}").strftime("%y")
		Conferma.conferma(mdatiestero, "Capi usciti correttamente.")

		mdatiestero.destroy
		muscite.destroy
		#finestra.present
		else
	end
	}
	boxusc10.pack_start(bottmovusc, false, false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mdatiestero.destroy
		muscite.present
	}
	boxusc10.pack_start(bottchiudi, false, false, 0)
	mdatiestero.show_all
end
