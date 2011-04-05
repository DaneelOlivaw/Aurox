# Inserimento dei dati di uscita dei capi

def datiuscita(finestra, muscite, listasel, combousc)
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
	datausc = Gtk::Entry.new()
	datausc.max_length =(6)
	boxusc2.pack_start(datausc, false, false, 5)

	#Allevamento / mercato di destinazione

	labelallevdest = Gtk::Label.new("Codice allevamento / mercato di destinazione:")
	boxusc3.pack_start(labelallevdest, false, false, 5)
	listall = Gtk::ListStore.new(Integer, String, String, String)
	selalldest = Allevamentis.find(:all, :order => "ragsoc")
	selalldest.each do |alldest|
		iteralldest = listall.append
		iteralldest[0] = alldest.id
		iteralldest[1] = alldest.ragsoc
		iteralldest[2] = alldest.idfisc
		iteralldest[3] = alldest.cod317
	end
	comboalldest = Gtk::ComboBox.new(listall)
	renderusc = Gtk::CellRendererText.new
	renderusc.visible=(false)
	comboalldest.pack_start(renderusc,false)
	comboalldest.set_attributes(renderusc, :text => 0)
	renderusc = Gtk::CellRendererText.new
	comboalldest.pack_start(renderusc,false)
	comboalldest.set_attributes(renderusc, :text => 1)
	renderusc = Gtk::CellRendererText.new
	renderusc.visible=(false)
	comboalldest.pack_start(renderusc,false)
	comboalldest.set_attributes(renderusc, :text => 2)
	renderusc = Gtk::CellRendererText.new
	comboalldest.pack_start(renderusc,false)
	comboalldest.set_attributes(renderusc, :text => 3)
	boxusc3.pack_start(comboalldest, false, false, 5)

	#Inserimento nuovo allevamento

	nallev = Gtk::Button.new("Nuovo allevamento")
	nallev.signal_connect( "released" ) { mascallevam(listall) }
	boxusc3.pack_start(nallev, false, false, 5)

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
	seltrasp = Trasportatoris.find(:all)
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


	#Marca sostitutiva

	labelmarcasost = Gtk::Label.new("Marca sostitutiva:")
	boxusc7.pack_start(labelmarcasost, false, false, 5)
	marcasost = Gtk::Entry.new()
	boxusc7.pack_start(marcasost, false, false, 5)

	# Modello 4

	labelmod4usc = Gtk::Label.new("Modello 4:")
	boxusc8.pack_start(labelmod4usc, false, false, 5)
	mod4usc = Gtk::Entry.new()
	progmod4 = @stallaoper.contatori.mod4usc.split("/")
	progmod41 = progmod4[0].to_i
#	anno = @giorno.strftime("%y")
#		if progmod4[1].to_i == anno.to_i
#			progmod41 += 1
#			#annoreg = progmod4[1]
#		else
#			progmod41 = 1
#			#annoreg = anno
#		end
#	mod4usc.text = ("#{progmod41}")
	boxusc8.pack_start(mod4usc, false, false, 5)

	# Data modello 4

	labeldatamod4usc = Gtk::Label.new("Data Modello 4 (GGMMAA):")
	boxusc8.pack_start(labeldatamod4usc, false, false, 5)
	datamod4usc = Gtk::Entry.new()
	datamod4usc.max_length=(6)
	boxusc8.pack_start(datamod4usc, false, false, 5)

	datausc.signal_connect("changed") {
		datamod4usc.text =("#{datausc.text}")
		if datausc.cursor_position == 5
			if datausc.text[4,2] == progmod4[1]
				nmod4 = progmod41 + 1
			else
				nmod4 = 1
			end
		mod4usc.text = ("#{nmod4}")
		end
	}

	#Bottone di inserimento uscite

	bottmovusc = Gtk::Button.new( "Inserisci" )
	bottmovusc.signal_connect("clicked") {
		errore = nil
			if datausc.text == ""
				Errore.avviso(mdatiuscita, "Mancano dati.")
				errore = 1
			elsif combousc.active_iter[0] == 3 or 10 or 11 or 16 or 20 or 28 or 29 or 30	# and comboalldest.active == -1 or combotrasp.active == -1 or combonazdest.active == -1 or mod4usc.text == nil or datamod4usc.text == nil
				if comboalldest.active == -1 or combotrasp.active == -1 or combonazdest.active == -1 or mod4usc.text == "" or datamod4usc.text == ""
					Errore.avviso(mdatiuscita, "Mancano dati: altri casi.")
					errore = 1
				else
				end
			else
			end
		if errore == nil
			begin
				if datausc.text.to_i != 0
					datauscingl = @giorno.strftime("%Y")[0,2] + datausc.text[4,2] + datausc.text[2,2] + datausc.text[0,2]
					Time.parse("#{datauscingl}")
				else
					Errore.avviso(mdatiuscita, "Data uscita errata.")
					errore = 1
				end
				if datamod4usc.text != ""
					if datamod4usc.text.to_i != 0
						datamod4uscingl = @giorno.strftime("%Y")[0,2] + datamod4usc.text[4,2] + datamod4usc.text[2,2] + datamod4usc.text[0,2]
						Time.parse("#{datamod4uscingl}")
					else
						Errore.avviso(mdatiuscita, "Data mod4 errata.")
						errore = 1
					end
				else
				end
			rescue Exception => errore
				Errore.avviso(mdatiuscita, "Controllare le date")
			end
		end
	if errore == nil
		if comboalldest.active == -1 or comboalldest.sensitive? == false
			valcomboalldest = ""
		else
			mod4 = "#{@stallaoper.stalle.cod317}/#{Time.parse("#{datamod4uscingl}").strftime("%Y")}/#{mod4usc.text}"
			#puts mod4
			idalldest = comboalldest.active_iter[0]
			valcomboalldest = comboalldest.active_iter[1]
			alldestidfisc = comboalldest.active_iter[2]
			alldest317 = comboalldest.active_iter[3]
			#provaunione = Relazs.joins(:stalle, :ragsoc)
#			alldir = Relazs.find(:first, :from => "relazs, stalles, ragsocs", :conditions => ["stalles.cod317 = ? and ragsocs.ragsoc = ?", "#{alldest317}", "#{valcomboalldest}"])
			#alldir = Relazs.find(:all, :from => "relazs, stalles, ragsocs", :conditions => ["stalles.cod317= ?  and ragsocs.ragsoc= ?", "#{alldest317}", "#{valcomboalldest}"])
			alldir = Relazs.find(:all, :include => [:stalle, :ragsoc], :conditions => ["stalles.cod317= ? and ragsocs.ragsoc= ?", "#{alldest317}", "#{valcomboalldest}"])
#			puts alldir.length
#			puts "alldir = #{alldir.id}"
#			alldir.each do|a|
#			puts a.ragsoc.ragsoc
#			puts a.stalle.cod317
#			end
		end
		if combonazdest.active == -1 or combonazdest.sensitive? == false
			valcombonazdest = ""
		else
			valcombonazdest = combonazdest.active_iter[2]
		end
		if combotrasp.active == -1 or combotrasp.sensitive? == false
			valcombotrasp = ""
		else
			valcombotrasp = combotrasp.active_iter[1]
		end
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
			Animals.create(:relaz_id => "#{@stallaoper.id.to_i}", :tipo => "U", :cm_usc => "#{combousc.active_iter[0]}", :marca => "#{marcausc}", :specie => "#{specieusc}", :razza_id => "#{razzausc}", :data_nas => "#{nascitausc}", :stalla_nas => "#{cod317nasusc}", :sesso => "#{sessousc}", :naz_orig => "#{nazorigusc}", :naz_nasprimimp => "#{nazprimimpusc}", :data_applm => "#{datamarcausc}", :ilg => "#{ilgusc}", :marca_prec => "#{marcaprecedenteusc}", :marca_madre => "#{madreusc}", :marca_padre => "#{padreusc}", :uscita => "#{datauscingl}", :allevamenti_id => "#{idalldest}", :naz_dest => "#{valcombonazdest}", :trasp => "#{valcombotrasp}", :mod4 => "#{mod4}", :data_mod4 => "#{datamod4uscingl.to_i}", :marcasost => "#{marcasost.text}", :idcoll => "#{marcauscid}")
			usc = Animals.find(:first, :conditions => ["idcoll = ?", "#{marcauscid}"])
			Animals.update(marcauscid, { :uscito => "1", :idcoll => "#{usc.id}"})
		end
		Contatoris.update(@stallaoper.contatori.id, { :mod4usc => "#{mod4usc.text}/#{Time.parse("#{datamod4uscingl}").strftime("%y")}"})
		@stallaoper.contatori.mod4usc = mod4usc.text + "/" + Time.parse("#{datamod4uscingl}").strftime("%y")
		Conferma.conferma(mdatiuscita, "Capi usciti correttamente.")
		if alldir.length > 0
			#puts "Trasf. diretto"
			avviso = Gtk::MessageDialog.new(finestra, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "L'allevamento di destinazione è tra le stalle gestite; procedo con il caricamento automatico?")
			risposta = avviso.run
			avviso.destroy
			if risposta == Gtk::Dialog::RESPONSE_YES
				#puts "Sì"
				insautomatico(finestra, listasel, valcomboalldest, alldest317, alldir, combousc.active_iter[0], datausc.text, mod4, datamod4usc.text)
			else
				Conferma.conferma(finestra, "Operazione annullata.")
			end
		end
		mdatiuscita.destroy
		muscite.destroy
		#finestra.present
		else
	end
	}
	boxusc10.pack_start(bottmovusc, false, false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mdatiuscita.destroy
		muscite.present
	}
	boxusc10.pack_start(bottchiudi, false, false, 0)
	mdatiuscita.show_all
end
