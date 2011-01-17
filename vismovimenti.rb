# Visualizza movimenti

def vismovimenti
	mvismov = Gtk::Window.new("Vista movimenti")
	#mvismov.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	mvismov.set_default_size(800, 600)
	mvismov.maximize
	mvismovscroll = Gtk::ScrolledWindow.new #(hadjustment = nil, vadjustment = nil)
	boxmovv = Gtk::VBox.new(false, 0)
	boxmov1 = Gtk::HBox.new(false, 0)
	boxmov2 = Gtk::HBox.new(false, 0)
	boxmovv.pack_start(boxmov1, false, false, 5)
	boxmovv.pack_start(boxmov2, true, true, 5)
	labelconto = Gtk::Label.new("Movimenti trovati: 0")
	mvismov.add(boxmovv)

	def riempimento(selmov, lista, labelconto)
		selmov.each do |m|
			itermov = lista.append
			itermov[0] = m.id.to_i
			itermov[1] = m.tipo
			itermov[2] = m.relaz.ragsoc.ragsoc
			itermov[3] = m.marca
			itermov[4] = m.specie
			itermov[5] = m.razza.razza
			itermov[6] = m.data_nas.strftime("%d/%m/%Y")
			itermov[7] = m.stalla_nas
			itermov[8] = m.sesso
			itermov[9] = m.naz_orig
			itermov[10] = m.naz_nasprimimp
			if m.data_applm !=nil
				itermov[11] = m.data_applm.strftime("%d/%m/%Y")
			else
				itermov[11] = ""
			end
			itermov[12] = m.ilg
			itermov[13] = m.marca_prec
			itermov[14] = m.marca_madre
			itermov[15] = m.marca_padre
			itermov[16] = m.donatrice
			itermov[17] = m.cm_ing.to_s
			if m.data_ingr != nil
				itermov[18] = m.data_ingr.strftime("%d/%m/%Y")
			else
				itermov[18] = ""
			end
			if m.tipo == "I"
				if m.allevamenti_id != nil
					itermov[19] = m.allevamenti.cod317
					itermov[20] = m.allevamenti.ragsoc
					itermov[21] = m.allevamenti.idfisc
				else
					itermov[19] = ""
					itermov[20] = ""
					itermov[21] = ""
				end
			elsif m.tipo == "U"
				if m.allevamenti_id != nil
					itermov[30] = m.allevamenti.cod317
					itermov[32] = m.allevamenti.ragsoc
					itermov[33] = m.allevamenti.idfisc
				else
					itermov[30] = ""
					itermov[32] = ""
					itermov[33] = ""
				end
			end
			itermov[22] = m.naz_prov
			itermov[23] = m.certsan
			itermov[24] = m.rifloc
			if m.data_certsan != nil
				itermov[25] = m.data_certsan.strftime("%d/%m/%Y")
			else
				itermov[25] = ""
			end
			itermov[26] = m.mod4
			if m.data_mod4 != nil
				itermov[27] = m.data_mod4.strftime("%d/%m/%Y")
			else
				itermov[27] = ""
			end
			itermov[28] = m.cm_usc.to_s
				if m.uscita != nil
				itermov[29] = m.uscita.strftime("%d/%m/%Y")
			else
				itermov[29] = ""
			end
			itermov[31] = m.naz_dest
			if m.macelli_id != nil
				itermov[34] = m.macelli.nomemac
				itermov[35] = m.macelli.ifmac
				itermov[36] = m.macelli.bollomac
				itermov[37] = m.macelli.region.regione
			else
				itermov[34] = ""
				itermov[35] = ""
				itermov[36] = ""
				itermov[37] = ""
			end
			itermov[38] = m.certsanusc
			if m.data_certsanusc != nil
				itermov[39] = m.data_certsanusc.strftime("%d/%m/%Y")
			else
				itermov[39] = ""
			end
			itermov[40] = m.trasp
			itermov[41] = m.marcasost
			itermov[42] = m.ditta_racc
			itermov[43] = m.clg
			itermov[44] = m.uscito.to_s
			if m.registro == true
				itermov[45] = "SI"
			else
				itermov[45] = "NO"
			end
#			itermov[45] = m.registro.to_s
#			puts itermov[45]
		end
	labelconto.text = ("Movimenti trovati: #{selmov.length}")
	end

	visingressi = Gtk::Button.new( "Visualizza ingressi" )
	visuscite = Gtk::Button.new( "Visualizza uscite" )
	vispresenti = Gtk::Button.new( "Visualizza presenti in stalla" )
	vistutti = Gtk::Button.new( "Visualizza tutti" )
	visricerca = Gtk::Button.new( "Cerca capo" )
	visricercaentry = Gtk::Entry.new
	lista = Gtk::ListStore.new(Integer, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String)
	vista = Gtk::TreeView.new(lista)
	vista.selection.mode = Gtk::SELECTION_SINGLE #BROWSE #SINGLE #MULTIPLE
#	vista.show_expanders = (true)
	vista.rules_hint = true
#	vista.set_enable_grid_lines(true)
#	@relid = @combo3.active_iter[0]
	visingressi.signal_connect("clicked") {
		lista.clear
		selmov = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ?", "#{@stallaoper.id}", "I"])
		riempimento(selmov, lista, labelconto)
	}
	visuscite.signal_connect("clicked") {
		lista.clear
		selmov = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ?", "#{@stallaoper.id}", "U"])
		riempimento(selmov, lista, labelconto)
	}
	vispresenti.signal_connect("clicked") {
		lista.clear
		selmov = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and uscito= ?", "#{@stallaoper.id}", "I", "0"])
		riempimento(selmov, lista, labelconto)
	}
	vistutti.signal_connect("clicked") {
		lista.clear
		selmov = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ?", "#{@stallaoper.id}"])
		riempimento(selmov, lista, labelconto)
	}
	visricerca.signal_connect("clicked") {
		lista.clear
		selmov = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and marca LIKE ?", "#{@stallaoper.id}", "%#{visricercaentry.text}%"])
		riempimento(selmov, lista, labelconto)
	}
		cella = Gtk::CellRendererText.new
		colonna1 = Gtk::TreeViewColumn.new("Tipo movimento", cella)
		colonna1.resizable = true
		colonna2 = Gtk::TreeViewColumn.new("Ragione sociale", cella)
		colonna2.resizable = true
		colonna3 = Gtk::TreeViewColumn.new("Marca", cella)
		colonna4 = Gtk::TreeViewColumn.new("Specie", cella)
		colonna5 = Gtk::TreeViewColumn.new("Razza", cella)
		colonna5.resizable = true
		colonna6 = Gtk::TreeViewColumn.new("Data di nascita", cella)
		colonna7 = Gtk::TreeViewColumn.new("Stalla di nascita", cella)
		colonna8 = Gtk::TreeViewColumn.new("Sesso", cella)
		colonna9 = Gtk::TreeViewColumn.new("Nazione origine", cella)
		colonna10 = Gtk::TreeViewColumn.new("Nazione prima importazione", cella)
		colonna11 = Gtk::TreeViewColumn.new("Data applicazione marca", cella)
		colonna12 = Gtk::TreeViewColumn.new("ILG", cella)
		colonna13 = Gtk::TreeViewColumn.new("Marca precedente", cella)
		colonna14 = Gtk::TreeViewColumn.new("Marca madre", cella)
		colonna15 = Gtk::TreeViewColumn.new("Marca padre", cella)
		colonna16 = Gtk::TreeViewColumn.new("Marca donatrice", cella)
		colonna17 = Gtk::TreeViewColumn.new("Codice movimento ingresso", cella)
		colonna18 = Gtk::TreeViewColumn.new("Data ingresso", cella)
		colonna19 = Gtk::TreeViewColumn.new("Cod. stalla provenienza", cella)
		colonna20 = Gtk::TreeViewColumn.new("Stalla provenienza", cella)
		colonna21 = Gtk::TreeViewColumn.new("Id. fisc. provenienza", cella)
		colonna22 = Gtk::TreeViewColumn.new("Nazione provenienza", cella)
		colonna23 = Gtk::TreeViewColumn.new("Certificato sanitario", cella)
		colonna24 = Gtk::TreeViewColumn.new("Riferimento locale", cella)
		colonna25 = Gtk::TreeViewColumn.new("Data certificato sanitario", cella)
		colonna26 = Gtk::TreeViewColumn.new("Modello 4", cella)
		colonna27 = Gtk::TreeViewColumn.new("Data modello 4", cella)
		colonna28 = Gtk::TreeViewColumn.new("Movimento uscita", cella)
		colonna29 = Gtk::TreeViewColumn.new("Data uscita", cella)
		colonna30 = Gtk::TreeViewColumn.new("Stalla destinazione", cella)
		colonna31 = Gtk::TreeViewColumn.new("Nazione destinazione", cella)
		colonna32 = Gtk::TreeViewColumn.new("Allevamento destinazione", cella)
		colonna33 = Gtk::TreeViewColumn.new("Id. fisc. allevamento destinazione", cella)
		colonna34 = Gtk::TreeViewColumn.new("Macello destinazione", cella)
		colonna35 = Gtk::TreeViewColumn.new("Id. fisc. macello", cella)
		colonna36 = Gtk::TreeViewColumn.new("Bollo macello", cella)
		colonna37 = Gtk::TreeViewColumn.new("Regione macello", cella)
		colonna38 = Gtk::TreeViewColumn.new("Cert. san. uscita", cella)
		colonna39 = Gtk::TreeViewColumn.new("Data cert. san. uscita", cella)
		colonna40 = Gtk::TreeViewColumn.new("Trasportatore", cella)
		colonna41 = Gtk::TreeViewColumn.new("Marca sostitutiva", cella)
		colonna42 = Gtk::TreeViewColumn.new("Ditta raccoglitrice", cella)
		colonna43 = Gtk::TreeViewColumn.new("Registro", cella)
		colonna1.set_attributes(cella, :text => 1)
		colonna2.set_attributes(cella, :text => 2)
		colonna3.set_attributes(cella, :text => 3)
		colonna4.set_attributes(cella, :text => 4)
		colonna5.set_attributes(cella, :text => 5)
		colonna6.set_attributes(cella, :text => 6)
		colonna7.set_attributes(cella, :text => 7)
		colonna8.set_attributes(cella, :text => 8)
		colonna9.set_attributes(cella, :text => 9)
		colonna10.set_attributes(cella, :text => 10)
		colonna11.set_attributes(cella, :text => 11)
		colonna12.set_attributes(cella, :text => 12)
		colonna13.set_attributes(cella, :text => 13)
		colonna14.set_attributes(cella, :text => 14)
		colonna15.set_attributes(cella, :text => 15)
		colonna16.set_attributes(cella, :text => 16)
		colonna17.set_attributes(cella, :text => 17)
		colonna18.set_attributes(cella, :text => 18)
		colonna19.set_attributes(cella, :text => 19)
		colonna20.set_attributes(cella, :text => 20)
		colonna21.set_attributes(cella, :text => 21)
		colonna22.set_attributes(cella, :text => 22)
		colonna23.set_attributes(cella, :text => 23)
		colonna24.set_attributes(cella, :text => 24)
		colonna25.set_attributes(cella, :text => 25)
		colonna26.set_attributes(cella, :text => 26)
		colonna27.set_attributes(cella, :text => 27)
		colonna28.set_attributes(cella, :text => 28)
		colonna29.set_attributes(cella, :text => 29)
		colonna30.set_attributes(cella, :text => 30)
		colonna31.set_attributes(cella, :text => 31)
		colonna32.set_attributes(cella, :text => 32)
		colonna33.set_attributes(cella, :text => 33)
		colonna34.set_attributes(cella, :text => 34)
		colonna35.set_attributes(cella, :text => 35)
		colonna36.set_attributes(cella, :text => 36)
		colonna37.set_attributes(cella, :text => 37)
		colonna38.set_attributes(cella, :text => 38)
		colonna39.set_attributes(cella, :text => 39)
		colonna40.set_attributes(cella, :text => 40)
		colonna41.set_attributes(cella, :text => 41)
		colonna42.set_attributes(cella, :text => 42)
		colonna43.set_attributes(cella, :text => 45)
		vista.append_column(colonna1)
		vista.append_column(colonna2)
		vista.append_column(colonna3)
		vista.append_column(colonna4)
		vista.append_column(colonna5)
		vista.append_column(colonna6)
		vista.append_column(colonna7)
		vista.append_column(colonna8)
		vista.append_column(colonna9)
		vista.append_column(colonna10)
		vista.append_column(colonna11)
		vista.append_column(colonna12)
		vista.append_column(colonna13)
		vista.append_column(colonna14)
		vista.append_column(colonna15)
		vista.append_column(colonna16)
		vista.append_column(colonna17)
		vista.append_column(colonna18)
		vista.append_column(colonna19)
		vista.append_column(colonna20)
		vista.append_column(colonna21)
		vista.append_column(colonna22)
		vista.append_column(colonna23)
		vista.append_column(colonna24)
		vista.append_column(colonna25)
		vista.append_column(colonna26)
		vista.append_column(colonna27)
		vista.append_column(colonna28)
		vista.append_column(colonna29)
		vista.append_column(colonna30)
		vista.append_column(colonna31)
		vista.append_column(colonna32)
		vista.append_column(colonna33)
		vista.append_column(colonna34)
		vista.append_column(colonna35)
		vista.append_column(colonna36)
		vista.append_column(colonna37)
		vista.append_column(colonna38)
		vista.append_column(colonna39)
		vista.append_column(colonna40)
		vista.append_column(colonna41)
		vista.append_column(colonna42)
		vista.append_column(colonna43)
	mvismovscroll.add(vista)
	boxmov2.pack_start(mvismovscroll, true, true, 0)
	boxmov1.pack_start(visingressi, false, false, 0)
	boxmov1.pack_start(visuscite, false, false, 0)
	boxmov1.pack_start(vispresenti, false, false, 0)
	boxmov1.pack_start(vistutti, false, false, 0)
	boxmov1.pack_start(visricerca, false, false, 5)
	boxmov1.pack_start(visricercaentry, false, false, 0)
	boxmov1.pack_start(labelconto, false, false, 5)

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mvismov.destroy
	}
	boxmovv.pack_start(bottchiudi, false, false, 0)

	vista.signal_connect("row-activated") do |view, path, column|
		selcapo = vista.selection
		if selcapo.selected[45] == "SI"
			Conferma.conferma(mvismov, "Attenzione: il capo si trova nel registro; le modifiche saranno apportate anche in quest'ultimo. Nel caso sia stato stampato sul vidimato, ricordarsi di modificarlo a mano previo accordo col funzionario preposto.")
		end
		if selcapo.selected[1] == "I" #and @selcapo.selected[45] == "NO"
			modificacapo(selcapo)
		elsif selcapo.selected[1] == "U" #and @selcapo.selected[45] == "NO"
			modificacapousc(selcapo)
		#else
			#Avvisoprova.avviso(mvismov, "Il movimento è stato inserito nel registro, per cui non è più possibile modificarlo.")
		end
	end
	mvismov.show_all
end
