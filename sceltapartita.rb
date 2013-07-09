def sceltapartita
	stampapart = Gtk::Window.new("Stampa partita in ingresso")
	stampapart.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	#stampapart.set_default_size(600, 500)
	#stampapart.maximize
	boxgen = Gtk::VBox.new(false, 0)
	boxtipomov = Gtk::HBox.new(false, 0)
	boxricerca = Gtk::HBox.new(false, 0)
	boxrisultato = Gtk::HBox.new(false, 0)
#	boxgrande = Gtk::HBox.new(false, 0)
	boxstampacv1 = Gtk::HBox.new(false, 0)
	boxstampacv11 = Gtk::VBox.new(true, 0)
	boxstampacv12 = Gtk::VBox.new(true, 0)
#	boxstampacv2 = Gtk::HBox.new(false, 0)
#	boxstampacv21 = Gtk::VBox.new(true, 0)
#	boxstampacv22 = Gtk::VBox.new(true, 0)
	boxstampac1 = Gtk::HBox.new(false, 0)
	boxstampac2 = Gtk::HBox.new(false, 0)
#	boxstampac3 = Gtk::HBox.new(false, 0)
#	boxstampac4 = Gtk::HBox.new(false, 0)
#	boxstampac5 = Gtk::HBox.new(false, 0)
#	boxstampac6 = Gtk::HBox.new(false, 0)
#	boxstampac7 = Gtk::HBox.new(false, 0)
#	boxstampac8 = Gtk::HBox.new(false, 0)
#	boxstampac9 = Gtk::HBox.new(false, 0)
#	boxstampac10 = Gtk::HBox.new(false, 0)
#	boxstampac11 = Gtk::HBox.new(false, 0)
#	boxstampac12 = Gtk::HBox.new(false, 0)
#	boxstampac13 = Gtk::HBox.new(false, 0)
#	boxstampac14 = Gtk::HBox.new(false, 0)
#	boxstampac15 = Gtk::HBox.new(false, 0)
#	boxstampac16 = Gtk::HBox.new(false, 0)
=begin
	boxstampac17 = Gtk::HBox.new(false, 0)
	boxstampac18 = Gtk::HBox.new(false, 0)
	boxstampac19 = Gtk::HBox.new(false, 0)
	boxstampac20 = Gtk::HBox.new(false, 0)
	boxstampac21 = Gtk::HBox.new(false, 0)
	boxstampac22 = Gtk::HBox.new(false, 0)
	boxstampac23 = Gtk::HBox.new(false, 0)
	boxstampac24 = Gtk::HBox.new(false, 0)
	boxstampac25 = Gtk::HBox.new(false, 0)
	boxstampac26 = Gtk::HBox.new(false, 0)
	boxstampac27 = Gtk::HBox.new(false, 0)
	boxstampac28 = Gtk::HBox.new(false, 0)
	boxstampac29 = Gtk::HBox.new(false, 0)
	boxstampac30 = Gtk::HBox.new(false, 0)
	boxstampac31 = Gtk::HBox.new(false, 0)
	boxstampac32 = Gtk::HBox.new(false, 0)
	boxstampac33 = Gtk::HBox.new(false, 0)
	boxstampac34 = Gtk::HBox.new(false, 0)
	boxstampac35 = Gtk::HBox.new(false, 0)
	boxstampac36 = Gtk::HBox.new(false, 0)
	boxstampac37 = Gtk::HBox.new(false, 0)
	boxstampac38 = Gtk::HBox.new(false, 0)
	boxstampac39 = Gtk::HBox.new(false, 0)
	boxstampac40 = Gtk::HBox.new(false, 0)
	boxstampac41 = Gtk::HBox.new(false, 0)
	boxstampac42 = Gtk::HBox.new(false, 0)
	boxstampac43 = Gtk::HBox.new(false, 0)
	boxstampac44 = Gtk::HBox.new(false, 0)
	boxstampac45 = Gtk::HBox.new(false, 0)
	boxstampac46 = Gtk::HBox.new(false, 0)
	boxstampac47 = Gtk::HBox.new(false, 0)
	boxstampac48 = Gtk::HBox.new(false, 0)
=end
	boxstampac100 = Gtk::HBox.new(true, 0)
	boxstampacv11.pack_start(boxstampac1, false, false, 0)
	boxstampacv12.pack_start(boxstampac2, false, false, 0)
#	boxstampacv11.pack_start(boxstampac3, false, false, 0)
#	boxstampacv12.pack_start(boxstampac4, false, false, 0)
#	boxstampacv11.pack_start(boxstampac5, false, false, 0)
#	boxstampacv12.pack_start(boxstampac6, false, false, 0)
#	boxstampacv11.pack_start(boxstampac7, false, false, 0)
#	boxstampacv12.pack_start(boxstampac8, false, false, 0)
#	boxstampacv11.pack_start(boxstampac9, false, false, 0)
#	boxstampacv12.pack_start(boxstampac10, false, false, 0)
#	boxstampacv11.pack_start(boxstampac11, false, false, 0)
#	boxstampacv12.pack_start(boxstampac12, false, false, 0)
#	boxstampacv11.pack_start(boxstampac13, false, false, 0)
#	boxstampacv12.pack_start(boxstampac14, false, false, 0)
#	boxstampacv11.pack_start(boxstampac15, false, false, 0)
#	boxstampacv12.pack_start(boxstampac16, false, false, 0)
=begin
	boxstampacv11.pack_start(boxstampac17, false, false, 0)
	boxstampacv12.pack_start(boxstampac18, false, false, 0)
	boxstampacv11.pack_start(boxstampac19, false, false, 0)
	boxstampacv12.pack_start(boxstampac20, false, false, 0)
	boxstampacv11.pack_start(boxstampac21, false, false, 0)
	boxstampacv12.pack_start(boxstampac22, false, false, 0)
	boxstampacv11.pack_start(boxstampac23, false, false, 0)
	boxstampacv12.pack_start(boxstampac24, false, false, 0)
	boxstampacv21.pack_start(boxstampac25, false, false, 0)
	boxstampacv22.pack_start(boxstampac26, false, false, 0)
	boxstampacv21.pack_start(boxstampac27, false, false, 0)
	boxstampacv22.pack_start(boxstampac28, false, false, 0)
	boxstampacv21.pack_start(boxstampac29, false, false, 0)
	boxstampacv22.pack_start(boxstampac30, false, false, 0)
	boxstampacv21.pack_start(boxstampac31, false, false, 0)
	boxstampacv22.pack_start(boxstampac32, false, false, 0)
	boxstampacv21.pack_start(boxstampac33, false, false, 0)
	boxstampacv22.pack_start(boxstampac34, false, false, 0)
	boxstampacv21.pack_start(boxstampac35, false, false, 0)
	boxstampacv22.pack_start(boxstampac36, false, false, 0)
	boxstampacv21.pack_start(boxstampac37, false, false, 0)
	boxstampacv22.pack_start(boxstampac38, false, false, 0)
	boxstampacv21.pack_start(boxstampac39, false, false, 0)
	boxstampacv22.pack_start(boxstampac40, false, false, 0)
	boxstampacv21.pack_start(boxstampac41, false, false, 0)
	boxstampacv22.pack_start(boxstampac42, false, false, 0)
	boxstampacv21.pack_start(boxstampac43, false, false, 0)
	boxstampacv22.pack_start(boxstampac44, false, false, 0)
	boxstampacv21.pack_start(boxstampac45, false, false, 0)
	boxstampacv22.pack_start(boxstampac46, false, false, 0)
	boxstampacv21.pack_start(boxstampac47, false, false, 0)
	boxstampacv22.pack_start(boxstampac48, false, false, 0)
=end
	boxstampacv1.pack_start(boxstampacv11, false, false, 0)
	boxstampacv1.pack_start(boxstampacv12, false, false, 0)

#	boxstampacv2.pack_start(boxstampacv21, false, false, 0)
#	boxstampacv2.pack_start(boxstampacv22, false, false, 0)

#	boxgrande.pack_start(boxstampacv1, true, true)
#	boxgrande.pack_start(boxstampacv2, true, true)
	boxgen.pack_start(boxtipomov, false, false, 5)
	boxgen.pack_start(boxricerca, false, false, 5)
	boxgen.pack_start(boxrisultato, false, false, 5)
#	boxgen.pack_start(boxgrande, true, true)
	boxgen.pack_start(boxstampac100, false, false)
	stampapart.add(boxgen)

	@arridcapi = []
	@dataingringl = ""
	@documento = ""
	@totcapi = 0
#	labelcercapartita = Gtk::Label.new("Cerca:")
#	boxricerca.pack_start(labelcercapartita, false, false, 10)

	tipomov1 = Gtk::RadioButton.new("Ingresso")
	boxtipomov.pack_start(tipomov1, false, false, 5)
	tipomov2 = Gtk::RadioButton.new(tipomov1, "Uscita")
	boxtipomov.pack_start(tipomov2, false, false, 5)
	tipomov = "I"
	tipomov1.active = true


	docum1 = Gtk::RadioButton.new("Modello 4")
	boxricerca.pack_start(docum1, false, false, 5)
	docum2 = Gtk::RadioButton.new(docum1, "Certificato sanitario")
	boxricerca.pack_start(docum2, false, false, 5)
	docum3 = Gtk::RadioButton.new(docum1, "Riferimento locale")
	boxricerca.pack_start(docum3, false, false, 5)
	tipodocumento = "mod4"
	docum1.active=(true)
	
	tipomov1.signal_connect("toggled") {
		if tipomov1.active?
			tipomov="I"
			tipodocumento="certsan" if docum2.active?
		end
	}
	tipomov2.signal_connect("toggled") {
		if tipomov2.active?
			tipomov="U"
			tipodocumento="certsanusc" if docum2.active?
		end
	}
	
	
	
	
	
	docum1.signal_connect("toggled") {
		if docum1.active?
			tipodocumento="mod4"
		end
	}
	docum2.signal_connect("toggled") {
		if docum2.active?
			if tipomov == "I"
				tipodocumento="certsan"
			else
				tipodocumento = "certsanusc"
			end
		end
	}
	docum3.signal_connect("toggled") {
		#puts tipodocumento
		if docum3.active?
			if tipomov == "I"
				tipodocumento="rifloc"
			else
				Errore.avviso(stampapart, "Un Riferimento locale non può essere di uscita.")
				docum1.active = true
			end
			#puts tipodocumento
		end
	}

	cercapartita = Gtk::Entry.new
	cercapartita.max_length=(14)
	boxricerca.pack_start(cercapartita, false, false, 10)
	vispartita = Gtk::Button.new( "Cerca" )
	boxricerca.pack_start(vispartita, false, false, 5)

#	linea = Gtk::VSeparator.new
#	boxricerca.pack_start(linea, false, false, 5)

	labeldocumento = Gtk::Label.new("Documento:")
	boxrisultato.pack_start(labeldocumento, false, false, 5)
#	documento = Gtk::Entry.new
#	documento.width_chars=(21)
#	documento.editable = false
#	boxrisultato.pack_start(documento, false, false, 5)
	
	labeltotcapi = Gtk::Label.new("Totale capi:")
	boxrisultato.pack_start(labeltotcapi, false, false, 5)

	vedicapi = Gtk::Button.new("Vedi lista capi")
	vedicapi.signal_connect("clicked") {
		if @arridcapi.length == 0
			Errore.avviso(stampapart, "Devi selezionare un documento.")
		else
			viscapi = Gtk::Window.new("Capi del documento #{@documento}")
			viscapi.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
			viscapi.set_default_size(400, 400)
			viscapiscroll = Gtk::ScrolledWindow.new #(hadjustment = nil, vadjustment = nil)
			boxmovv = Gtk::VBox.new(false, 0)
			boxmov1 = Gtk::HBox.new(false, 0)
			boxmov2 = Gtk::HBox.new(false, 0)
			boxmovv.pack_start(boxmov1, false, false, 5)
			boxmovv.pack_start(boxmov2, true, true, 5)
			viscapi.add(boxmovv)
			listacapi = Gtk::ListStore.new(String)
			@arridcapi.each do |m|
				#puts m.inspect
				#sel = Animals.find(:all, :select => "data_ingr", :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "I", "#{m}"])
				iter = listacapi.append
				iter[0] = m[1]
#				iter[1] = sel[0].uscita.strftime("%d/%m/%Y")
#				iter[2] = sel.length
			end
			vistacapi = Gtk::TreeView.new(listacapi)
			cella = Gtk::CellRendererText.new
			colonna1 = Gtk::TreeViewColumn.new("Marca", cella)
#			colonna1.resizable = true
			colonna1.set_attributes(cella, :text => 0)
			vistacapi.append_column(colonna1)
			viscapiscroll.add(vistacapi)
			boxmov2.pack_start(viscapiscroll, true, true, 0)

			bottchiudi = Gtk::Button.new( "Chiudi" )
			bottchiudi.signal_connect("clicked") {
				viscapi.destroy
			}
			boxmovv.pack_start(bottchiudi, false, false, 0)
			viscapi.show_all
		end
	}
	boxrisultato.pack_start(vedicapi, false, false, 5)

=begin
	#Modifica motivo ingresso

	labelmovingr = Gtk::Label.new("Motivo ingresso:")
	listamovingr = Gtk::ListStore.new(Integer, String)
	selmovoingr = Ingressos.find(:all)
	selmovoingr.each do |u|
		iter1 = listamovingr.append
		iter1[0] = u.codice.to_i
		iter1[1] = u.descr
	end

	combomovingr = Gtk::ComboBox.new(listamovingr)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combomovingr.pack_start(renderer1,false)
	combomovingr.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combomovingr.pack_start(renderer1,false)
	combomovingr.set_attributes(renderer1, :text => 1)
	boxstampac1.pack_end(labelmovingr, false, false, 5)
	boxstampac2.pack_start(combomovingr.popdown, false, false, 0)
	#combomovingr.set_active(0)
#	contamovingr = -1
#	while combomovingr.active_iter[0].to_i != capomod[28].to_i
#		contamovingr+=1
#		combomovingr.set_active(contamovingr)
#	end

	#Modifica data ingresso

	labeldataingr = Gtk::Label.new("Data di ingresso (GGMMAA):")
	boxstampac3.pack_end(labeldataingr, false, false, 5)
	dataingr = Gtk::Entry.new()
	dataingr.max_length=(6)
#	dataingr.text = ("#{capomod[29][0,2]}#{capomod[29][3,2]}#{capomod[29][8,2]}")
	boxstampac4.pack_start(dataingr, false , false, 0)

	#Nazione di provenienza

	labelnazprov = Gtk::Label.new("Nazione di provenienza:")
	boxstampac5.pack_end(labelnazprov, false, false, 5)
	listanazprov = Gtk::ListStore.new(Integer, String, String)
	listanazprov.clear
	selnazprov = Nations.find(:all, :order => "nome")
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
	boxstampac6.pack_start(combonazprov.popdown, false, false, 0)
#	if capomod[31].to_s != ""
#		combonazprov.set_active(0)
#		contanazprov = -1
#		while combonazprov.active_iter[2] != capomod[31]
#			contanazprov+=1
#			combonazprov.set_active(contanazprov)
#		end
#	else
#	combonazprov.set_active(-1)
#	end

	#Certificato sanitario

	labelcertsan = Gtk::Label.new("Certificato sanitario:")
	boxstampac7.pack_end(labelcertsan, false, false, 5)
	certsan = Gtk::Entry.new()
	certsan.max_length=(21)
	certsan.width_chars=(21)
#	certsan.text = ("#{capomod[38]}")
	boxstampac8.pack_start(certsan, false, false, 5)

	#Riferimento locale

	labelrifloc = Gtk::Label.new("Riferimento locale:")
	boxstampac9.pack_end(labelrifloc, false, false, 5)
	rifloc = Gtk::Entry.new()
	rifloc.max_length=(6)
#	if capomod[39] != nil
#		rifloc.text = ("#{capomod[39][0,2]}#{capomod[39][3,2]}#{capomod[39][8,2]}")
#	end
	boxstampac10.pack_start(rifloc, false , false, 0)

	#Allevamento provenienza

	labelallprov = Gtk::Label.new("Allevamento di provenienza:")
	boxstampac11.pack_end(labelallprov, false, false, 5)
	listaallprov = Gtk::ListStore.new(Integer, String, String, String)
	listaallprov.clear
	selallprov = Allevamentis.find(:all, :order => "ragsoc")
	selallprov.each do |a|
		iter1 = listaallprov.append
		iter1[0] = a.id
		iter1[1] = a.ragsoc
		iter1[2] = a.idfisc
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
	boxstampac12.pack_start(comboallprov.popdown, false, false, 5)
#	if capomod[30] != ""
#		comboallprov.set_active(0)
#		contaallprov = -1
#		while comboallprov.active_iter[0] != capomod[47].to_i
#			contaallprov+=1
#			comboallprov.set_active(contaallprov)
#		end
#		else
#		comboallprov.set_active(-1)
#	end

#	#Macello destinazione

#	labelmacdest = Gtk::Label.new("Macello di destinazione:")
#	boxstampac13.pack_end(labelmacdest, false, false, 5)
#	listamacdest = Gtk::ListStore.new(Integer, String, String, String, String)
#	listamacdest.clear
#	selmacdest = Macellis.find(:all, :order => "nomemac")
#	selmacdest.each do |a|
#		iter1 = listamacdest.append
#		iter1[0] = a.id
#		iter1[1] = a.nomemac
#		iter1[2] = a.ifmac
#		iter1[3] = a.bollomac
#		iter1[4] = a.region.regione
#	end
#	combomacdest = Gtk::ComboBox.new(listamacdest)
#	renderer1 = Gtk::CellRendererText.new
#	renderer1.visible=(false)
#	combomacdest.pack_start(renderer1,false)
#	combomacdest.set_attributes(renderer1, :text => 0)
#	renderer1 = Gtk::CellRendererText.new
#	combomacdest.pack_start(renderer1,false)
#	combomacdest.set_attributes(renderer1, :text => 1)
#	renderer1 = Gtk::CellRendererText.new
#	renderer1.visible=(false)
#	combomacdest.pack_start(renderer1,false)
#	combomacdest.set_attributes(renderer1, :text => 2)
#	renderer1 = Gtk::CellRendererText.new
#	renderer1.visible=(false)
#	combomacdest.pack_start(renderer1,false)
#	combomacdest.set_attributes(renderer1, :text => 3)
##	renderer1 = Gtk::CellRendererText.new
##	renderer1.visible=(false)
##	combomacdest.pack_start(renderer1,false)
##	combomacdest.set_attributes(renderer1, :text => 4)
#	boxstampac14.pack_start(combomacdest.popdown, false, false, 5)
#	if capomod[36] != ""
#		combomacdest.set_active(0)
#		contamacdest = -1
#		while combomacdest.active_iter[3] != capomod[36]
#			contamacdest+=1
#			combomacdest.set_active(contamacdest)
#		end
#		else
#		combomacdest.set_active(-1)
#	end

	#Modello 4

	labelmod4 = Gtk::Label.new("Modello 4:")
	boxstampac13.pack_end(labelmod4, false, false, 5)
	mod4 = Gtk::Entry.new()
#	mod4.text = ("#{capomod[26]}")
	boxstampac14.pack_start(mod4, false, false, 5)

	#Data modello 4

	labeldatamod4 = Gtk::Label.new("Data modello 4 (GGMMAA):")
	boxstampac15.pack_end(labeldatamod4, false, false, 5)
	datamod4 = Gtk::Entry.new()
	datamod4.max_length=(6)
#	if capomod[27] != nil
#		datamod4.text = ("#{capomod[27][0,2]}#{capomod[27][3,2]}#{capomod[27][8,2]}")
#	end
	boxstampac16.pack_start(datamod4, false , false, 0)

#	#Marca sostitutiva

#	labelsost = Gtk::Label.new("Marca sostitutiva:")
#	boxstampac43.pack_end(labelsost, false, false, 5)
#	sost = Gtk::Entry.new()
#	sost.max_length=(14)
##	sost.text = ("#{capomod[41]}")
#	boxstampac44.pack_start(sost, false, false, 5)
	

=end

#	bottstampa = Gtk::Button.new( "Stampa partita" )
#	bottstampa.signal_connect("clicked") {
#		puts "Stampa!"
#		require "stampapartita"
#		puts documento
#		stampapartita(documento, tipomov, tipodocumento)
#	}
#	boxstampac16.pack_start(bottstampa, false, false, 5)




	vispartita.signal_connect("clicked") {
#		lista.clear
		if cercapartita.text == ""
			Errore.avviso(stampapart, "Devi indicare un documento da ricercare.")
		else
				selmov = Animals.find(:all, :select => "#{tipodocumento}", :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "#{tipomov}", "%#{cercapartita.text}%"])
#				selmov = Animals.find(:all, :select => "id, uscita, #{tipodocumento}", :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "U", "%#{cercapartita.text}%"])
	#			selmov = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and datiunipeg = ? and certsan LIKE ?", "#{@stallaoper.id}", "I", "0", "%#{cercapartita.text}%"])
	#		elsif tipodocumento == "labelrifloc"
	#			selmov = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and datiunipeg = ? and labelrifloc LIKE ?", "#{@stallaoper.id}", "I", "0", "%#{cercapartita.text}%"])
	#		elsif
			#puts selmov.length
			if selmov.length == 0
				Conferma.conferma(stampapart, "Non ci sono movimenti disponibili.")
			else
				#puts selmov.inspect
				arrdoc = []
				#hashdoc = Hash.new #("id", "data", "tot")
			#	hashprova = Hash.new(0)
				#selmov.each {|x| puts x["#{tipodocumento}"]}
				#bau = "x.#{tipodocumento}"
				#puts bau
				selmov.each {|x| arrdoc << x["#{tipodocumento}"]}
				#puts "arrdoc.inspect:"
				#puts arrdoc.inspect
#				selmov.each do |x|
#					hashdoc["id"] = x.id
#					hashdoc["data"] = x.uscita
#				end
				#puts hashdoc.inspect
				#puts hashdoc.values
#				arrdoc.each do |doc|
#					hashprova[doc] +=1
#				end
				#puts hashprova.inspect
				#puts arr.uniq.inspect
				if arrdoc.uniq.length == 1
					#puts "dentro if singolo dato"
					#puts arr[0]
					selcapi = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "#{tipomov}", "#{arrdoc[0]}"])
		#		end
					#puts "selcapi:"
#					selcapi.each do |s|
#						puts s.id
#					end
					@totcapi = selcapi.length
					@arridcapi = []
					selcapi.each {|x| @arridcapi << [x.id, x.marca, x.registro]}
					#puts @arridcapi.inspect
				#puts selmov.uniq.inspect
				#puts selmov.uniq.length
				#if selmov.length == 1
		#			#@idcapo = selmov[0].id
					#puts selcapi.length
					@dataingringl = selcapi[0].data_ingr
					#puts @dataingringl
					labeldocumento.text = "Documento: #{arrdoc[0]}"
					@documento = arrdoc[0]
		#			#nascita.text = selmov[0].data_nas.strftime("%d/%m/%Y")
					#	if capomod[31].to_s != ""
					#puts selcapi[31]
#					combonazprov.set_active(0)
#					contanazprov = -1
#					if selcapi[0].naz_prov.to_s != ""
#						while combonazprov.active_iter[2] != selcapi[0].naz_prov
#							contanazprov+=1
#							combonazprov.set_active(contanazprov)
#						end
#					else
#						combonazprov.set_active(-1)
#					end

#					if selcapi[0].allevamenti_id.to_s != ""
#						comboallprov.set_active(0)
#						contaallprov = -1
#						while comboallprov.active_iter[0] != selcapi[0].allevamenti_id.to_i
#							contaallprov+=1
#							comboallprov.set_active(contaallprov)
#						end
#						else
#						comboallprov.set_active(-1)
#					end

#					if selcapi[0].macelli_id.to_s != ""
#						combomacdest.set_active(0)
#						contamacdest = -1
#						while combomacdest.active_iter[0] != selcapi[0].macelli_id.to_i
#							contamacdest+=1
#							combomacdest.set_active(contamacdest)
#						end
#						else
#						combomacdest.set_active(-1)
#					end

#					combomovingr.set_active(0)
#					contamovingr = -1
#					while combomovingr.active_iter[0].to_i != selcapi[0].cm_ing.to_i
#						contamovingr+=1
#						combomovingr.set_active(contamovingr)
#					end
					
					#dataingr.text = ("#{selcapi[0].uscita.to_s[0,2]}#{selcapi[0].uscita.to_s[3,2]}#{selcapi[0].uscita.to_s[8,2]}").strftime("%d/%m/%Y")
					#dataingr.text = ("#{selcapi[0].data_ingr.strftime("%d%m%y")}")
					#certsan.text = ("#{selcapi[0].certsan}")
					#rifloc.text = ("#{selcapi[0].rifloc}")
#					if selcapi[0].data_certsaningr != nil
#						rifloc.text = ("#{selcapi[0].data_certsaningr.strftime("%d%m%y")}")
#					end
#					mod4.text = ("#{selcapi[0].mod4}")
#					if selcapi[0].data_mod4 != nil
#						datamod4.text = ("#{selcapi[0].data_mod4.strftime("%d%m%y")}")
#					end

					#nazorig.text = selcapi[0].naz_dest
					#naznas.text = selcapi[0].naz_dest
		#			#madre.text = selmov[0].marca_madre
					#movingr.text = selcapi[0].cm_usc.to_s
					#dataingr.text = selcapi[0].uscita.strftime("%d/%m/%Y")
					#nazprov.text = selcapi[0].naz_dest
					labeltotcapi.text = ("Capi della partita: #{selcapi.length}")


				else
					#puts "Più di uno o zero"
					#visunipeg(selmov, nazorig, naznas, movingr, dataingr, nazprov)
					#puts arr.uniq.inspect
					if tipomov == "I"
						require 'visdocumingresso'
						visdocumingresso(arrdoc.uniq, tipodocumento, labeldocumento, nil, nil, nil, nil, nil, nil, nil, nil, labeltotcapi)
					else
						require 'visdocumuscita'
						visdocumuscita(arrdoc.uniq, tipodocumento, labeldocumento, nil, nil, nil, nil, nil, nil, nil, nil, nil, labeltotcapi)
					end
#					puts "arridcapi:"
#					@arridcapi.each do |s|
#						puts s
#					end
				end
			end
		end
		#riempimento(selmov, lista, labelconto)
	}

	bottstampa = Gtk::Button.new( "Stampa partita" )
	bottstampa.signal_connect("clicked") {
		require "stampapartita"
		#puts @documento
		#stampapartita(documento, tipomov, tipodocumento)
		stampapartita(tipomov, tipodocumento)
	}
	boxstampac100.pack_start(bottstampa, false, false, 5)



# Bottone di chiusura finestra

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		stampapart.destroy
	}
	boxstampac100.pack_start(bottchiudi, false, false, 5)
	stampapart.show_all
end
