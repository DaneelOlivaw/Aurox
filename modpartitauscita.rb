def modpartitauscita
	modpartusc = Gtk::Window.new("Modifica dati partita in uscita")
	modpartusc.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	modpartusc.set_default_size(600, 500)
	#modpartusc.maximize
	boxgen = Gtk::VBox.new(false, 0)
	boxricerca = Gtk::HBox.new(false, 0)
	boxrisultato = Gtk::HBox.new(false, 0)
	boxgrande = Gtk::HBox.new(false, 0)
	boxmodcv1 = Gtk::HBox.new(false, 0)
	boxmodcv11 = Gtk::VBox.new(true, 0)
	boxmodcv12 = Gtk::VBox.new(true, 0)
#	boxmodcv2 = Gtk::HBox.new(false, 0)
#	boxmodcv21 = Gtk::VBox.new(true, 0)
#	boxmodcv22 = Gtk::VBox.new(true, 0)
	boxmodc1 = Gtk::HBox.new(false, 0)
	boxmodc2 = Gtk::HBox.new(false, 0)
	boxmodc3 = Gtk::HBox.new(false, 0)
	boxmodc4 = Gtk::HBox.new(false, 0)
	boxmodc5 = Gtk::HBox.new(false, 0)
	boxmodc6 = Gtk::HBox.new(false, 0)
	boxmodc7 = Gtk::HBox.new(false, 0)
	boxmodc8 = Gtk::HBox.new(false, 0)
	boxmodc9 = Gtk::HBox.new(false, 0)
	boxmodc10 = Gtk::HBox.new(false, 0)
	boxmodc11 = Gtk::HBox.new(false, 0)
	boxmodc12 = Gtk::HBox.new(false, 0)
	boxmodc13 = Gtk::HBox.new(false, 0)
	boxmodc14 = Gtk::HBox.new(false, 0)
	boxmodc15 = Gtk::HBox.new(false, 0)
	boxmodc16 = Gtk::HBox.new(false, 0)
	boxmodc17 = Gtk::HBox.new(false, 0)
	boxmodc18 = Gtk::HBox.new(false, 0)
=begin
	boxmodc19 = Gtk::HBox.new(false, 0)
	boxmodc20 = Gtk::HBox.new(false, 0)
	boxmodc21 = Gtk::HBox.new(false, 0)
	boxmodc22 = Gtk::HBox.new(false, 0)
	boxmodc23 = Gtk::HBox.new(false, 0)
	boxmodc24 = Gtk::HBox.new(false, 0)
	boxmodc25 = Gtk::HBox.new(false, 0)
	boxmodc26 = Gtk::HBox.new(false, 0)
	boxmodc27 = Gtk::HBox.new(false, 0)
	boxmodc28 = Gtk::HBox.new(false, 0)
	boxmodc29 = Gtk::HBox.new(false, 0)
	boxmodc30 = Gtk::HBox.new(false, 0)
	boxmodc31 = Gtk::HBox.new(false, 0)
	boxmodc32 = Gtk::HBox.new(false, 0)
	boxmodc33 = Gtk::HBox.new(false, 0)
	boxmodc34 = Gtk::HBox.new(false, 0)
	boxmodc35 = Gtk::HBox.new(false, 0)
	boxmodc36 = Gtk::HBox.new(false, 0)
	boxmodc37 = Gtk::HBox.new(false, 0)
	boxmodc38 = Gtk::HBox.new(false, 0)
	boxmodc39 = Gtk::HBox.new(false, 0)
	boxmodc40 = Gtk::HBox.new(false, 0)
	boxmodc41 = Gtk::HBox.new(false, 0)
	boxmodc42 = Gtk::HBox.new(false, 0)
	boxmodc43 = Gtk::HBox.new(false, 0)
	boxmodc44 = Gtk::HBox.new(false, 0)
	boxmodc45 = Gtk::HBox.new(false, 0)
	boxmodc46 = Gtk::HBox.new(false, 0)
	boxmodc47 = Gtk::HBox.new(false, 0)
	boxmodc48 = Gtk::HBox.new(false, 0)
=end
	boxmodc100 = Gtk::HBox.new(true, 0)
	boxmodcv11.pack_start(boxmodc1, false, false, 0)
	boxmodcv12.pack_start(boxmodc2, false, false, 0)
	boxmodcv11.pack_start(boxmodc3, false, false, 0)
	boxmodcv12.pack_start(boxmodc4, false, false, 0)
	boxmodcv11.pack_start(boxmodc5, false, false, 0)
	boxmodcv12.pack_start(boxmodc6, false, false, 0)
	boxmodcv11.pack_start(boxmodc7, false, false, 0)
	boxmodcv12.pack_start(boxmodc8, false, false, 0)
	boxmodcv11.pack_start(boxmodc9, false, false, 0)
	boxmodcv12.pack_start(boxmodc10, false, false, 0)
	boxmodcv11.pack_start(boxmodc11, false, false, 0)
	boxmodcv12.pack_start(boxmodc12, false, false, 0)
	boxmodcv11.pack_start(boxmodc13, false, false, 0)
	boxmodcv12.pack_start(boxmodc14, false, false, 0)
	boxmodcv11.pack_start(boxmodc15, false, false, 0)
	boxmodcv12.pack_start(boxmodc16, false, false, 0)
	boxmodcv11.pack_start(boxmodc17, false, false, 0)
	boxmodcv12.pack_start(boxmodc18, false, false, 0)
=begin	
	boxmodcv11.pack_start(boxmodc19, false, false, 0)
	boxmodcv12.pack_start(boxmodc20, false, false, 0)
	boxmodcv11.pack_start(boxmodc21, false, false, 0)
	boxmodcv12.pack_start(boxmodc22, false, false, 0)
	boxmodcv11.pack_start(boxmodc23, false, false, 0)
	boxmodcv12.pack_start(boxmodc24, false, false, 0)
	boxmodcv21.pack_start(boxmodc25, false, false, 0)
	boxmodcv22.pack_start(boxmodc26, false, false, 0)
	boxmodcv21.pack_start(boxmodc27, false, false, 0)
	boxmodcv22.pack_start(boxmodc28, false, false, 0)
	boxmodcv21.pack_start(boxmodc29, false, false, 0)
	boxmodcv22.pack_start(boxmodc30, false, false, 0)
	boxmodcv21.pack_start(boxmodc31, false, false, 0)
	boxmodcv22.pack_start(boxmodc32, false, false, 0)
	boxmodcv21.pack_start(boxmodc33, false, false, 0)
	boxmodcv22.pack_start(boxmodc34, false, false, 0)
	boxmodcv21.pack_start(boxmodc35, false, false, 0)
	boxmodcv22.pack_start(boxmodc36, false, false, 0)
	boxmodcv21.pack_start(boxmodc37, false, false, 0)
	boxmodcv22.pack_start(boxmodc38, false, false, 0)
	boxmodcv21.pack_start(boxmodc39, false, false, 0)
	boxmodcv22.pack_start(boxmodc40, false, false, 0)
	boxmodcv21.pack_start(boxmodc41, false, false, 0)
	boxmodcv22.pack_start(boxmodc42, false, false, 0)
	boxmodcv21.pack_start(boxmodc43, false, false, 0)
	boxmodcv22.pack_start(boxmodc44, false, false, 0)
	boxmodcv21.pack_start(boxmodc45, false, false, 0)
	boxmodcv22.pack_start(boxmodc46, false, false, 0)
	boxmodcv21.pack_start(boxmodc47, false, false, 0)
	boxmodcv22.pack_start(boxmodc48, false, false, 0)
=end
	boxmodcv1.pack_start(boxmodcv11, false, false, 0)
	boxmodcv1.pack_start(boxmodcv12, false, false, 0)
#	boxmodcv2.pack_start(boxmodcv21, false, false, 0)
#	boxmodcv2.pack_start(boxmodcv22, false, false, 0)
	boxgrande.pack_start(boxmodcv1, true, true)
#	boxgrande.pack_start(boxmodcv2, true, true)
	boxgen.pack_start(boxricerca, false, false, 5)
	boxgen.pack_start(boxrisultato, false, false, 5)
	boxgen.pack_start(boxgrande, true, true)
	boxgen.pack_start(boxmodc100, false, false)
	modpartusc.add(boxgen)

	@arridcapi = []
	@datauscingl = ""
	@documento = ""
#	labelcercapartita = Gtk::Label.new("Cerca:")
#	boxricerca.pack_start(labelcercapartita, false, false, 10)

	docum1 = Gtk::RadioButton.new("Modello 4")
	boxricerca.pack_start(docum1, false, false, 5)
	docum2 = Gtk::RadioButton.new(docum1, "Certificato sanitario")
	boxricerca.pack_start(docum2, false, false, 5)
	tipodocumento = "mod4"
	docum1.active=(true)
	docum1.signal_connect("toggled") {
		if docum1.active?
			tipodocumento="mod4"
		end
	}
	docum2.signal_connect("toggled") {
		if docum2.active?
			tipodocumento="certsanusc"
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
			Errore.avviso(modpartusc, "Devi selezionare un documento.")
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
				#sel = Animals.find(:all, :select => "uscita", :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "U", "#{m}"])
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

	#Modifica motivo uscita

	labelmovusc = Gtk::Label.new("Motivo uscita:")
	listamovusc = Gtk::ListStore.new(Integer, String)
	selmovusc = Uscites.find(:all)
	selmovusc.each do |u|
		iter1 = listamovusc.append
		iter1[0] = u.codice.to_i
		iter1[1] = u.descr
	end

	combomovusc = Gtk::ComboBox.new(listamovusc)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combomovusc.pack_start(renderer1,false)
	combomovusc.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combomovusc.pack_start(renderer1,false)
	combomovusc.set_attributes(renderer1, :text => 1)
	boxmodc1.pack_end(labelmovusc, false, false, 5)
	boxmodc2.pack_start(combomovusc.popdown, false, false, 0)
	#combomovusc.set_active(0)
#	contamovusc = -1
#	while combomovusc.active_iter[0].to_i != capomod[28].to_i
#		contamovusc+=1
#		combomovusc.set_active(contamovusc)
#	end

	#Modifica data uscita

	labeldatausc = Gtk::Label.new("Data di uscita (GGMMAA):")
	boxmodc3.pack_end(labeldatausc, false, false, 5)
	datausc = Gtk::Entry.new()
	datausc.max_length=(6)
#	datausc.text = ("#{capomod[29][0,2]}#{capomod[29][3,2]}#{capomod[29][8,2]}")
	boxmodc4.pack_start(datausc, false , false, 0)

	#Nazione di destinazione

	labelnazdest = Gtk::Label.new("Nazione di destinazione:")
	boxmodc5.pack_end(labelnazdest, false, false, 5)
	listanazdest = Gtk::ListStore.new(Integer, String, String)
	listanazdest.clear
	selnazdest = Nations.find(:all, :order => "nome")
	selnazdest.each do |n|
		iter1 = listanazdest.append
		iter1[0] = n.id
		iter1[1] = n.nome
		iter1[2] = n.codice
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
	boxmodc6.pack_start(combonazdest.popdown, false, false, 0)
#	if capomod[31].to_s != ""
#		combonazdest.set_active(0)
#		contanazdest = -1
#		while combonazdest.active_iter[2] != capomod[31]
#			contanazdest+=1
#			combonazdest.set_active(contanazdest)
#		end
#	else
#	combonazdest.set_active(-1)
#	end

	#Certificato sanitario

	labelcertsan = Gtk::Label.new("Certificato sanitario:")
	boxmodc7.pack_end(labelcertsan, false, false, 5)
	certsan = Gtk::Entry.new()
	certsan.max_length=(21)
	certsan.width_chars=(21)
#	certsan.text = ("#{capomod[38]}")
	boxmodc8.pack_start(certsan, false, false, 5)

	#Data certificato sanitario

	labeldatacertsan = Gtk::Label.new("Data certificato sanitario (GGMMAA):")
	boxmodc9.pack_end(labeldatacertsan, false, false, 5)
	datacertsan = Gtk::Entry.new()
	datacertsan.max_length=(6)
#	if capomod[39] != nil
#		datacertsan.text = ("#{capomod[39][0,2]}#{capomod[39][3,2]}#{capomod[39][8,2]}")
#	end
	boxmodc10.pack_start(datacertsan, false , false, 0)

	#Allevamento destinazione

	labelalldest = Gtk::Label.new("Allevamento di destinazione:")
	boxmodc11.pack_end(labelalldest, false, false, 5)
	listaalldest = Gtk::ListStore.new(Integer, String, String, String)
	listaalldest.clear
	selalldest = Allevamentis.find(:all, :order => "ragsoc")
	selalldest.each do |a|
		iter1 = listaalldest.append
		iter1[0] = a.id
		iter1[1] = a.ragsoc
		iter1[2] = a.idfisc
		iter1[3] = a.cod317
	end
	comboalldest = Gtk::ComboBox.new(listaalldest)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	comboalldest.pack_start(renderer1,false)
	comboalldest.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	comboalldest.pack_start(renderer1,false)
	comboalldest.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	comboalldest.pack_start(renderer1,false)
	comboalldest.set_attributes(renderer1, :text => 2)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	comboalldest.pack_start(renderer1,false)
	comboalldest.set_attributes(renderer1, :text => 3)
	boxmodc12.pack_start(comboalldest.popdown, false, false, 5)
#	if capomod[30] != ""
#		comboalldest.set_active(0)
#		contaalldest = -1
#		while comboalldest.active_iter[0] != capomod[47].to_i
#			contaalldest+=1
#			comboalldest.set_active(contaalldest)
#		end
#		else
#		comboalldest.set_active(-1)
#	end

	#Macello destinazione

	labelmacdest = Gtk::Label.new("Macello di destinazione:")
	boxmodc13.pack_end(labelmacdest, false, false, 5)
	listamacdest = Gtk::ListStore.new(Integer, String, String, String, String)
	listamacdest.clear
	selmacdest = Macellis.find(:all, :order => "nomemac")
	selmacdest.each do |a|
		iter1 = listamacdest.append
		iter1[0] = a.id
		iter1[1] = a.nomemac
		iter1[2] = a.ifmac
		iter1[3] = a.bollomac
		iter1[4] = a.region.regione
	end
	combomacdest = Gtk::ComboBox.new(listamacdest)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combomacdest.pack_start(renderer1,false)
	combomacdest.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combomacdest.pack_start(renderer1,false)
	combomacdest.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combomacdest.pack_start(renderer1,false)
	combomacdest.set_attributes(renderer1, :text => 2)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combomacdest.pack_start(renderer1,false)
	combomacdest.set_attributes(renderer1, :text => 3)
#	renderer1 = Gtk::CellRendererText.new
#	renderer1.visible=(false)
#	combomacdest.pack_start(renderer1,false)
#	combomacdest.set_attributes(renderer1, :text => 4)
	boxmodc14.pack_start(combomacdest.popdown, false, false, 5)
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
	boxmodc15.pack_end(labelmod4, false, false, 5)
	mod4 = Gtk::Entry.new()
#	mod4.text = ("#{capomod[26]}")
	boxmodc16.pack_start(mod4, false, false, 5)

	#Data modello 4

	labeldatamod4 = Gtk::Label.new("Data modello 4 (GGMMAA):")
	boxmodc17.pack_end(labeldatamod4, false, false, 5)
	datamod4 = Gtk::Entry.new()
	datamod4.max_length=(6)
#	if capomod[27] != nil
#		datamod4.text = ("#{capomod[27][0,2]}#{capomod[27][3,2]}#{capomod[27][8,2]}")
#	end
	boxmodc18.pack_start(datamod4, false , false, 0)

#	#Marca sostitutiva

#	labelsost = Gtk::Label.new("Marca sostitutiva:")
#	boxmodc43.pack_end(labelsost, false, false, 5)
#	sost = Gtk::Entry.new()
#	sost.max_length=(14)
##	sost.text = ("#{capomod[41]}")
#	boxmodc44.pack_start(sost, false, false, 5)
	


	vispartita.signal_connect("clicked") {
#		lista.clear
		if cercapartita.text == ""
			Errore.avviso(modpartusc, "Devi indicare un documento da ricercare.")
		else
				selmov = Animals.find(:all, :select => "#{tipodocumento}", :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "U", "%#{cercapartita.text}%"])
#				selmov = Animals.find(:all, :select => "id, uscita, #{tipodocumento}", :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "U", "%#{cercapartita.text}%"])
	#			selmov = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and datiunipeg = ? and certsan LIKE ?", "#{@stallaoper.id}", "I", "0", "%#{cercapartita.text}%"])
	#		elsif tipodocumento == "rifloc"
	#			selmov = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and datiunipeg = ? and rifloc LIKE ?", "#{@stallaoper.id}", "I", "0", "%#{cercapartita.text}%"])
	#		elsif
			#puts selmov.length
			if selmov.length == 0
				Conferma.conferma(modpartusc, "Non ci sono movimenti disponibili.")
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
					selcapi = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "U", "#{arrdoc[0]}"])
		#		end
					#puts "selcapi:"
#					selcapi.each do |s|
#						puts s.id
#					end
					@arridcapi = []
					selcapi.each {|x| @arridcapi << [x.id, x.marca, x.registro]}
					#puts @arridcapi.inspect
				#puts selmov.uniq.inspect
				#puts selmov.uniq.length
				#if selmov.length == 1
		#			#@idcapo = selmov[0].id
					#puts selcapi.length
					@datauscingl = selcapi[0].uscita
					#puts @dataingringl
					@documento = arrdoc[0]
		#			#nascita.text = selmov[0].data_nas.strftime("%d/%m/%Y")
					#	if capomod[31].to_s != ""
					#puts selcapi[31]
					combonazdest.set_active(0)
					contanazdest = -1
					if selcapi[0].naz_dest.to_s != ""
						while combonazdest.active_iter[2] != selcapi[0].naz_dest
							contanazdest+=1
							combonazdest.set_active(contanazdest)
						end
					else
						combonazdest.set_active(-1)
					end

					if selcapi[0].allevamenti_id.to_s != ""
						comboalldest.set_active(0)
						contaalldest = -1
						while comboalldest.active_iter[0] != selcapi[0].allevamenti_id.to_i
							contaalldest+=1
							comboalldest.set_active(contaalldest)
						end
						else
						comboalldest.set_active(-1)
					end

					if selcapi[0].macelli_id.to_s != ""
						combomacdest.set_active(0)
						contamacdest = -1
						while combomacdest.active_iter[0] != selcapi[0].macelli_id.to_i
							contamacdest+=1
							combomacdest.set_active(contamacdest)
						end
						else
						combomacdest.set_active(-1)
					end

					combomovusc.set_active(0)
					contamovusc = -1
					while combomovusc.active_iter[0].to_i != selcapi[0].cm_usc.to_i
						contamovusc+=1
						combomovusc.set_active(contamovusc)
					end
					
					#datausc.text = ("#{selcapi[0].uscita.to_s[0,2]}#{selcapi[0].uscita.to_s[3,2]}#{selcapi[0].uscita.to_s[8,2]}").strftime("%d/%m/%Y")
					datausc.text = ("#{selcapi[0].uscita.strftime("%d%m%y")}")
					certsan.text = ("#{selcapi[0].certsanusc}")
					if selcapi[0].data_certsanusc != nil
						datacertsan.text = ("#{selcapi[0].data_certsanusc.strftime("%d%m%y")}")
					end
					mod4.text = ("#{selcapi[0].mod4}")
					if selcapi[0].data_mod4 != nil
						datamod4.text = ("#{selcapi[0].data_mod4.strftime("%d%m%y")}")
					end

					#nazorig.text = selcapi[0].naz_dest
					#naznas.text = selcapi[0].naz_dest
		#			#madre.text = selmov[0].marca_madre
					#movingr.text = selcapi[0].cm_usc.to_s
					#dataingr.text = selcapi[0].uscita.strftime("%d/%m/%Y")
					#nazprov.text = selcapi[0].naz_dest
					labeldocumento.text = "Documento: #{arrdoc[0]}"
					labeltotcapi.text = ("Capi della partita: #{selcapi.length}")


				else
					#puts "Più di uno o zero"
					#visunipeg(selmov, nazorig, naznas, movingr, dataingr, nazprov)
					#puts arr.uniq.inspect
					require 'visdocumuscita'
					visdocumuscita(arrdoc.uniq, tipodocumento, labeldocumento, combonazdest, comboalldest, combomacdest, combomovusc, datausc, certsan, datacertsan, mod4, datamod4, labeltotcapi)
#					puts "arridcapi:"
#					@arridcapi.each do |s|
#						puts s
#					end
				end
			end
		end
		#riempimento(selmov, lista, labelconto)
	}

	#Bottone di inserimento

	bottmodpartusc = Gtk::Button.new( "Salva dati" )
	bottmodpartusc.signal_connect("clicked") {
		errore = nil
		begin
			datauscingl = datausc.text[4,2] + datausc.text[2,2] + datausc.text[0,2]
			datauscingl = Time.parse("#{datauscingl}").strftime("%Y")[0,2] + datauscingl
			Time.parse("#{datauscingl}")
			if combomovusc.active == -1 #or datausc.text == ""
				Errore.avviso(modcapousc, "Mancano dei dati obbligatori.")
				errore = 1
			elsif datausc.text.to_i == 0
				Errore.avviso(modcapousc, "Data di uscita errata.")
				errore = 1
			end
		rescue Exception => errore
			Errore.avviso(modcapousc, "Errore generico")
			errore = 1
		end
		if errore == nil
#			datauscingl = datausc.text[4,2] + datausc.text[2,2] + datausc.text[0,2]
#			datauscingl = Time.parse("#{datauscingl}").strftime("%Y")[0,2] + datauscingl
#		end
			if datamod4.text != ""
				datamod4ingl = datamod4.text[4,2] + datamod4.text[2,2] + datamod4.text[0,2]
				datamod4ingl = Time.parse("#{datamod4ingl}").strftime("%Y")[0,2] + datamod4ingl
			else
				datamod4ingl = nil
			end
			if datacertsan.text != ""
				datacertsaningl = datacertsan.text[4,2] + datacertsan.text[2,2] + datacertsan.text[0,2]
				datacertsaningl = Time.parse("#{datacertsaningl}").strftime("%Y")[0,2] + datacertsaningl
			else
				datacertsaningl = nil
			end
			if combomacdest.active == -1
				macdest = ""
			else
				macdest = combomacdest.active_iter[0]
			end
			if comboalldest.active == -1
				alldest = ""
			else
				alldest = comboalldest.active_iter[0]
			end
			if combonazdest.active == -1
				nazdest = ""
			else
				nazdest = combonazdest.active_iter[2]
			end
			
			#puts "arridcapi:"
			@arridcapi.each do |s|
				#puts s[0]
				#puts s[1]
				Animals.update(s[0], {:cm_usc => "#{combomovusc.active_iter[0]}", :uscita => "#{datauscingl.to_i}", :naz_dest => "#{nazdest}", :certsanusc => "#{certsan.text.upcase}", :data_certsanusc => "#{datacertsaningl.to_i}", :allevamenti_id => "#{alldest}", :macelli_id => "#{macdest}", :mod4 => "#{mod4.text.upcase}", :data_mod4 => "#{datamod4ingl.to_i}"})
				if s[2] == true
#				begin
#					puts @datauscingl
#					puts s[1]
					#puts nazdest
					capomodreg = Registros.find(:first, :conditions => "relaz_id='#{@stallaoper.id}' and marca='#{s[1]}' and datauscita='#{@datauscingl}'")
					if capomodreg == nil
						Errore.avviso(modpartingr, "Attenzione: c'è un problema coi dati sul registro. Controllare a mano.")
					else
						if combomovusc.active_iter[0] == 4
							regusc = "M"
						elsif combomovusc.active_iter[0] == 6
							regusc = "F"
			#			elsif combomovusc.active_iter[0] == 20
			#				regusc = "C"
						else
							regusc = "V"
						end
						if combomovusc.active_iter[0] == 4 or combomovusc.active_iter[0] == 6 or combomovusc.active_iter[0] == 10 or combomovusc.active_iter[0] == 11
							regdest = ""
						elsif combomovusc.active_iter[0] == 9
							regdest = combomacdest.active_iter[3]
						elsif combomovusc.active_iter[0] == 16
							regdest = nazdest
						else
							regdest = comboalldest.active_iter[3]
						end
						capomodid = capomodreg.id
						#puts capomodreg.id
						Registros.update(capomodid, {:tipouscita => "#{regusc}", :datauscita => "#{datauscingl.to_i}", :destinazione => "#{regdest}", :mod4usc => "#{mod4.text.upcase}", :certsanusc => "#{certsan.text.upcase}"})
#					rescue Exception => errore
#						puts errore
#						Errore.avviso(modcapousc, "Errore generico")
#						#errore = 1
#					end
					end
				end
			end
			Conferma.conferma(modpartusc, "Movimento modificato.")
			@arridcapi = []
			labeldocumento.text = "Documento:"
			@datauscingl = ""
			labeltotcapi.text = ("Capi della partita:")
			combomovusc.active = -1
			datausc.text = ""
			combonazdest.active = -1
			certsan.text = ""
			datacertsan.text = ""
			comboalldest.active = -1
			combomacdest.active = -1
			mod4.text = ""
			datamod4.text = ""
		end
	}
	boxmodc100.pack_start(bottmodpartusc, false, false, 5)

# Bottone di chiusura finestra

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		modpartusc.destroy
	}
	boxmodc100.pack_start(bottchiudi, false, false, 5)
	modpartusc.show_all
end
