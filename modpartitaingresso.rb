def modpartitaingresso
	modpartingr = Gtk::Window.new("Modifica dati partita in ingresso")
	modpartingr.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	modpartingr.set_default_size(600, 500)
	#modpartingr.maximize
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
=begin
	boxmodc17 = Gtk::HBox.new(false, 0)
	boxmodc18 = Gtk::HBox.new(false, 0)
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
=begin
	boxmodcv11.pack_start(boxmodc17, false, false, 0)
	boxmodcv12.pack_start(boxmodc18, false, false, 0)
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
	modpartingr.add(boxgen)

	@arridcapi = []
	@dataingringl = ""
#	labelcercapartita = Gtk::Label.new("Cerca:")
#	boxricerca.pack_start(labelcercapartita, false, false, 10)

	docum1 = Gtk::RadioButton.new("Modello 4")
	boxricerca.pack_start(docum1, false, false, 5)
	docum2 = Gtk::RadioButton.new(docum1, "Certificato sanitario")
	boxricerca.pack_start(docum2, false, false, 5)
	docum3 = Gtk::RadioButton.new(docum1, "Riferimento locale")
	boxricerca.pack_start(docum3, false, false, 5)
	tipodocumento = "mod4"
	docum1.active=(true)
	docum1.signal_connect("toggled") {
		if docum1.active?
			tipodocumento="mod4"
		end
	}
	docum2.signal_connect("toggled") {
		if docum2.active?
			tipodocumento="certsan"
		end
	}
	docum3.signal_connect("toggled") {
		if docum3.active?
			tipodocumento="rifloc"
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
	documento = Gtk::Entry.new
	documento.width_chars=(21)
	documento.editable = false
	boxrisultato.pack_start(documento, false, false, 5)
	
	labeltotcapi = Gtk::Label.new("Totale capi:")
	boxrisultato.pack_start(labeltotcapi, false, false, 5)

	vedicapi = Gtk::Button.new("Vedi lista capi")
	vedicapi.signal_connect("clicked") {
		if @arridcapi.length == 0
			Errore.avviso(modpartingr, "Devi selezionare un documento.")
		else
			viscapi = Gtk::Window.new("Capi del documento #{documento.text}")
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
	boxmodc1.pack_end(labelmovingr, false, false, 5)
	boxmodc2.pack_start(combomovingr.popdown, false, false, 0)
	#combomovingr.set_active(0)
#	contamovingr = -1
#	while combomovingr.active_iter[0].to_i != capomod[28].to_i
#		contamovingr+=1
#		combomovingr.set_active(contamovingr)
#	end

	#Modifica data ingresso

	labeldataingr = Gtk::Label.new("Data di ingresso (GGMMAA):")
	boxmodc3.pack_end(labeldataingr, false, false, 5)
	dataingr = Gtk::Entry.new()
	dataingr.max_length=(6)
#	dataingr.text = ("#{capomod[29][0,2]}#{capomod[29][3,2]}#{capomod[29][8,2]}")
	boxmodc4.pack_start(dataingr, false , false, 0)

	#Nazione di provenienza

	labelnazprov = Gtk::Label.new("Nazione di provenienza:")
	boxmodc5.pack_end(labelnazprov, false, false, 5)
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
	boxmodc6.pack_start(combonazprov.popdown, false, false, 0)
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
	boxmodc7.pack_end(labelcertsan, false, false, 5)
	certsan = Gtk::Entry.new()
	certsan.max_length=(21)
	certsan.width_chars=(21)
#	certsan.text = ("#{capomod[38]}")
	boxmodc8.pack_start(certsan, false, false, 5)

	#Riferimento locale

	labelrifloc = Gtk::Label.new("Riferimento locale:")
	boxmodc9.pack_end(labelrifloc, false, false, 5)
	rifloc = Gtk::Entry.new()
	rifloc.max_length=(6)
#	if capomod[39] != nil
#		rifloc.text = ("#{capomod[39][0,2]}#{capomod[39][3,2]}#{capomod[39][8,2]}")
#	end
	boxmodc10.pack_start(rifloc, false , false, 0)

	#Allevamento provenienza

	labelallprov = Gtk::Label.new("Allevamento di provenienza:")
	boxmodc11.pack_end(labelallprov, false, false, 5)
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
	boxmodc12.pack_start(comboallprov.popdown, false, false, 5)
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
#	boxmodc13.pack_end(labelmacdest, false, false, 5)
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
#	boxmodc14.pack_start(combomacdest.popdown, false, false, 5)
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
	boxmodc13.pack_end(labelmod4, false, false, 5)
	mod4 = Gtk::Entry.new()
#	mod4.text = ("#{capomod[26]}")
	boxmodc14.pack_start(mod4, false, false, 5)

	#Data modello 4

	labeldatamod4 = Gtk::Label.new("Data modello 4 (GGMMAA):")
	boxmodc15.pack_end(labeldatamod4, false, false, 5)
	datamod4 = Gtk::Entry.new()
	datamod4.max_length=(6)
#	if capomod[27] != nil
#		datamod4.text = ("#{capomod[27][0,2]}#{capomod[27][3,2]}#{capomod[27][8,2]}")
#	end
	boxmodc16.pack_start(datamod4, false , false, 0)

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
			Errore.avviso(modpartingr, "Devi indicare un documento da ricercare.")
		else
				selmov = Animals.find(:all, :select => "#{tipodocumento}", :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "I", "%#{cercapartita.text}%"])
#				selmov = Animals.find(:all, :select => "id, uscita, #{tipodocumento}", :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "U", "%#{cercapartita.text}%"])
	#			selmov = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and datiunipeg = ? and certsan LIKE ?", "#{@stallaoper.id}", "I", "0", "%#{cercapartita.text}%"])
	#		elsif tipodocumento == "labelrifloc"
	#			selmov = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and datiunipeg = ? and labelrifloc LIKE ?", "#{@stallaoper.id}", "I", "0", "%#{cercapartita.text}%"])
	#		elsif
			#puts selmov.length
			if selmov.length == 0
				Conferma.conferma(modpartingr, "Non ci sono movimenti disponibili.")
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
					selcapi = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "I", "#{arrdoc[0]}"])
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
					@dataingringl = selcapi[0].data_ingr
					#puts @dataingringl
					documento.text = arrdoc[0]
		#			#nascita.text = selmov[0].data_nas.strftime("%d/%m/%Y")
					#	if capomod[31].to_s != ""
					#puts selcapi[31]
					combonazprov.set_active(0)
					contanazprov = -1
					if selcapi[0].naz_prov.to_s != ""
						while combonazprov.active_iter[2] != selcapi[0].naz_prov
							contanazprov+=1
							combonazprov.set_active(contanazprov)
						end
					else
						combonazprov.set_active(-1)
					end

					if selcapi[0].allevamenti_id.to_s != ""
						comboallprov.set_active(0)
						contaallprov = -1
						while comboallprov.active_iter[0] != selcapi[0].allevamenti_id.to_i
							contaallprov+=1
							comboallprov.set_active(contaallprov)
						end
						else
						comboallprov.set_active(-1)
					end

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

					combomovingr.set_active(0)
					contamovingr = -1
					while combomovingr.active_iter[0].to_i != selcapi[0].cm_ing.to_i
						contamovingr+=1
						combomovingr.set_active(contamovingr)
					end
					
					#dataingr.text = ("#{selcapi[0].uscita.to_s[0,2]}#{selcapi[0].uscita.to_s[3,2]}#{selcapi[0].uscita.to_s[8,2]}").strftime("%d/%m/%Y")
					dataingr.text = ("#{selcapi[0].data_ingr.strftime("%d%m%y")}")
					certsan.text = ("#{selcapi[0].certsan}")
					rifloc.text = ("#{selcapi[0].rifloc}")
#					if selcapi[0].data_certsaningr != nil
#						rifloc.text = ("#{selcapi[0].data_certsaningr.strftime("%d%m%y")}")
#					end
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
					labeltotcapi.text = ("Capi della partita: #{selcapi.length}")


				else
					#puts "Più di uno o zero"
					#visunipeg(selmov, nazorig, naznas, movingr, dataingr, nazprov)
					#puts arr.uniq.inspect
					visdocumingresso(arrdoc.uniq, tipodocumento, documento, combonazprov, comboallprov, combomovingr, dataingr, certsan, rifloc, mod4, datamod4, labeltotcapi)
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

	bottmodpartingr = Gtk::Button.new( "Salva dati" )
	bottmodpartingr.signal_connect("clicked") {
		errore = nil
		begin
			dataingringl = dataingr.text[4,2] + dataingr.text[2,2] + dataingr.text[0,2]
			dataingringl = Time.parse("#{dataingringl}").strftime("%Y")[0,2] + dataingringl
			Time.parse("#{dataingringl}")
			if combomovingr.active == -1 #or dataingr.text == ""
				Errore.avviso(modpartingr, "Mancano dei dati obbligatori.")
				errore = 1
			elsif dataingr.text.to_i == 0
				Errore.avviso(modpartingr, "Data di uscita errata.")
				errore = 1
			end
		rescue Exception => errore
			Errore.avviso(modpartingr, "Errore generico")
			errore = 1
		end
		if errore == nil
#			dataingringl = dataingr.text[4,2] + dataingr.text[2,2] + dataingr.text[0,2]
#			dataingringl = Time.parse("#{dataingringl}").strftime("%Y")[0,2] + dataingringl
#		end
			if datamod4.text != ""
				datamod4ingl = datamod4.text[4,2] + datamod4.text[2,2] + datamod4.text[0,2]
				datamod4ingl = Time.parse("#{datamod4ingl}").strftime("%Y")[0,2] + datamod4ingl
			else
				datamod4ingl = nil
			end
#			if rifloc.text != ""
#				riflocingl = rifloc.text[4,2] + rifloc.text[2,2] + rifloc.text[0,2]
#				riflocingl = Time.parse("#{riflocingl}").strftime("%Y")[0,2] + riflocingl
#			else
#				riflocingl = nil
#			end
#			if combomacdest.active == -1
#				macdest = ""
#			else
#				macdest = combomacdest.active_iter[0]
#			end
			if comboallprov.active == -1
				allprov = ""
			else
				allprov = comboallprov.active_iter[0]
			end
			if combonazprov.active == -1
				nazprov = ""
			else
				nazprov = combonazprov.active_iter[2]
			end
			
			#puts "arridcapi:"
			@arridcapi.each do |s|
				#puts s[0]
				#puts s[2]
				#puts @dataingringl
				Animals.update(s[0], {:cm_ing => "#{combomovingr.active_iter[0]}", :data_ingr => "#{dataingringl.to_i}", :naz_prov => "#{nazprov}", :certsan => "#{certsan.text.upcase}", :rifloc => "#{rifloc.text.upcase}", :allevamenti_id => "#{allprov}", :mod4 => "#{mod4.text.upcase}", :data_mod4 => "#{datamod4ingl.to_i}"})
				if s[2] == true
#				begin
#					puts @dataingringl
#					puts s[1]
					capomodreg = Registros.find(:first, :conditions => "relaz_id='#{@stallaoper.id}' and marca='#{s[1]}' and dataingresso='#{@dataingringl}'")
					#puts capomodreg.inspect
					if capomodreg == nil
						Errore.avviso(modpartingr, "Attenzione: c'è un problema coi dati sul registro. Controllare a mano.")
					else
					if combomovingr.active_iter[0] == 1
						regingr = "N"
					elsif combomovingr.active_iter[0] == 19
						regingr = "C"
		#			elsif combomovingr.active_iter[0] == 20
		#				regingr = "C"
					else
						regingr = "A"
					end

					if combomovingr.active_iter[0] == 2 or combomovingr.active_iter[0] == 1 or combomovingr.active_iter[0] == 19 or combomovingr.active_iter[0] == 24 or combomovingr.active_iter[0] == 25 or combomovingr.active_iter[0] == 26
						regprov = ""
					elsif combomovingr.active_iter[0] == 13  or combomovingr.active_iter[0] == 23 or combomovingr.active_iter[0] == 32
						if certsan.text != ""
						regprov = certsan.text
						else
							regprov = rifloc.text
						end
					end
					capomodid = capomodreg.id
					#puts capomodid
					Registros.update(capomodid, {:tipoingresso => "#{regingr}", :dataingresso => "#{dataingringl.to_i}", :provenienza => "#{regprov}", :mod4ingr => "#{mod4.text.upcase}", :certsaningr => "#{certsan.text.upcase}"})
#					rescue Exception => errore
#						puts errore
#						Errore.avviso(modpartingr, "Errore generico")
#						#errore = 1
#					end
				end
				end
			end
			Conferma.conferma(modpartingr, "Movimento modificato.")
			@arridcapi = []
			documento.text = ""
			@dataingringl = ""
			labeltotcapi.text = ("Capi della partita:")
			combomovingr.active = -1
			dataingr.text = ""
			combonazprov.active = -1
			certsan.text = ""
			rifloc.text = ""
			comboallprov.active = -1
			mod4.text = ""
			datamod4.text = ""
		
		end
	}
	boxmodc100.pack_start(bottmodpartingr, false, false, 5)

# Bottone di chiusura finestra

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		modpartingr.destroy
	}
	boxmodc100.pack_start(bottchiudi, false, false, 5)
	modpartingr.show_all
end
