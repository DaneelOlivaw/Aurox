# Uscita per macellazione

def datimacellazione(finestra, muscite, listasel, combousc)
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
	datausc = Gtk::Entry.new()
	datausc.max_length =(6)
	boxusc2.pack_start(datausc, false, false, 5)

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

	#Macello di destinazione

	labelmacdest = Gtk::Label.new("Codice macello di destinazione:")
	boxusc5.pack_start(labelmacdest, false, false, 5)
	listamacdest = Gtk::ListStore.new(Integer, String, String, String)
	selmacdest = Macellis.find(:all, :order => "nomemac")
	selmacdest.each do |macdest|
		itermacdest = listamacdest.append
		itermacdest[0] = macdest.id
		itermacdest[1] = macdest.nomemac
		itermacdest[2] = macdest.bollomac
		itermacdest[3] = macdest.region.regione
	end

	combomacdest = Gtk::ComboBox.new(listamacdest)
	rendermac = Gtk::CellRendererText.new
	rendermac.visible=(false)
	combomacdest.pack_start(rendermac,false)
	combomacdest.set_attributes(rendermac, :text => 0)
	rendermac = Gtk::CellRendererText.new
	combomacdest.pack_start(rendermac,false)
	combomacdest.set_attributes(rendermac, :text => 1)
	rendermac = Gtk::CellRendererText.new
	combomacdest.pack_start(rendermac,false)
	combomacdest.set_attributes(rendermac, :text => 2)
	rendermac = Gtk::CellRendererText.new
	combomacdest.pack_start(rendermac,false)
	combomacdest.set_attributes(rendermac, :text => 3)
	boxusc5.pack_start(combomacdest, false, false, 5)

	# Inserimento nuovo macello

	nmac = Gtk::Button.new("Nuovo macello")
	nmac.signal_connect( "released" ) { insmacelli(listamacdest) }
	boxusc5.pack_start(nmac, false, false, 5)

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

#	#Inserimento nuovo trasportatore

	ntrasp = Gtk::Button.new("Nuovo trasportatore")
	ntrasp.signal_connect( "released" ) { instrasportatori(listatrasp) }
	boxusc6.pack_start(ntrasp, false, false, 5)

	# Modello 4

	labelmod4usc = Gtk::Label.new("Modello 4:")
	boxusc8.pack_start(labelmod4usc, false, false, 5)
	mod4usc = Gtk::Entry.new()
	progmod4 = @stallaoper.mod4usc.split("/")
	progmod41 = progmod4[0].to_i
#	anno = @giorno.strftime("%y")
#		if progmod4[1].to_i == anno.to_i
#			progmod41 += 1
#			#annoreg = progmod4[1]
#		else
#			progmod41 = 1
#			#annoreg = anno
#		end
	#mod4usc.text = ("#{progmod41}")
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

	combonazdest.set_active(0)
	z = -1
	while combonazdest.active_iter[0] != 24
		z+=1
		combonazdest.set_active(z)
	end

	#Bottone di inserimento uscite

	bottmovusc = Gtk::Button.new( "Inserisci" )
	bottmovusc.signal_connect("clicked") {
		begin
			errore = nil
			if datausc.text == "" or combomacdest.active == -1 or combotrasp.active == -1 or mod4usc.text == "" or datamod4usc.text == ""
				Errore.avviso(mdatimacellazione, "Mancano dati.")
				errore = 1
			elsif datausc.text.to_i == 0 or datamod4usc.text.to_i == 0
				Errore.avviso(mdatimacellazione, "Date errate.")
				errore = 1
			else
				datauscingl = @giorno.strftime("%Y")[0,2] + datausc.text[4,2] + datausc.text[2,2] + datausc.text[0,2]
				Time.parse("#{datauscingl}")
				datamod4uscingl = @giorno.strftime("%Y")[0,2] + datamod4usc.text[4,2] + datamod4usc.text[2,2] + datamod4usc.text[0,2]
				Time.parse("#{datamod4uscingl}")
				if Time.parse("#{datamod4uscingl}") < Time.parse("#{datauscingl}")
					Errore.avviso(mdatimacellazione, "La data del modello 4 non può essere inferiore a quella di uscita.")
					errore = 1
				else
				end
			end
		rescue Exception => errore
			Errore.avviso(mdatimacellazione, "Controllare le date")
		end
	if errore == nil
		valcombonazdest = combonazdest.active_iter[2]
		valcombomacdest = combomacdest.active_iter[0]
		valcombotrasp = combotrasp.active_iter[1]
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

			Animals.create(:relaz_id => "#{@stallaoper.id.to_i}", :tipo => "U", :cm_usc => "#{combousc.active_iter[0]}", :marca => "#{marcausc}", :specie => "#{specieusc}", :razza_id => "#{razzausc}", :data_nas => "#{nascitausc}", :stalla_nas => "#{cod317nasusc}", :sesso => "#{sessousc}", :naz_orig => "#{nazorigusc}", :naz_nasprimimp => "#{nazprimimpusc}", :data_applm => "#{datamarcausc}", :ilg => "#{ilgusc}", :marca_prec => "#{marcaprecedenteusc}", :marca_madre => "#{madreusc}", :marca_padre => "#{padreusc}", :uscita => "#{datauscingl}", :naz_dest => "#{valcombonazdest}", :macelli_id => "#{valcombomacdest}", :trasp => "#{valcombotrasp}", :mod4 => "#{@stallaoper.stalle.cod317}/#{Time.parse("#{datamod4uscingl}").strftime("%Y")}/#{mod4usc.text}", :data_mod4 => "#{datamod4uscingl.to_i}", :idcoll => "#{marcauscid}")
			usc = Animals.find(:first, :conditions => ["idcoll = ?", "#{marcauscid}"])
			Animals.update(marcauscid, { :uscito => "1", :idcoll => "#{usc.id}"})
		end
		Relazs.update(@stallaoper.id, { :mod4usc => "#{mod4usc.text}/#{Time.parse("#{datamod4uscingl}").strftime("%y")}"})
		@stallaoper.mod4usc = mod4usc.text + "/" + Time.parse("#{datamod4uscingl}").strftime("%y")
		#puts @s.contatori.mod4usc
		listamacdest == nil
		Conferma.conferma(mdatimacellazione, "Capi usciti correttamente.")
		mdatimacellazione.destroy
		muscite.destroy
		finestra.present
	else
	end
	}
	boxusc10.pack_start(bottmovusc, false, false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		listamacdest.clear
		#puts @listamacdest.length
		mdatimacellazione.destroy
		muscite.present
	}
	boxusc10.pack_start(bottchiudi, false, false, 0)
	mdatimacellazione.show_all
end

