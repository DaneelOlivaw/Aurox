def vismod4provv(provvisori, tutti, muscite, selezione, listasel, lista4, labelselezionati, vista4, combousc)
	#puts provvisori.inspect
	#puts "vista4"
	#lista5 = lista4
	#puts vista4.select_iter[0]
	mvismod4 = Gtk::Window.new("Selezione modello 4 provvisorio")
	mvismod4.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	mvismod4.set_default_size(700, 400)
	#mvismod4.maximize
	mvismod4scroll = Gtk::ScrolledWindow.new #(hadjustment = nil, vadjustment = nil)
	boxprovvv = Gtk::VBox.new(false, 0)
	boxprovv1 = Gtk::HBox.new(false, 0)
	boxprovv2 = Gtk::HBox.new(false, 0)
	boxprovvv.pack_start(boxprovv1, false, false, 5)
	boxprovvv.pack_start(boxprovv2, true, true, 5)
	mvismod4.add(boxprovvv)
	#puts @documento
	#puts array.inspect
	#puts arrdoc.inspect
	hash2 = Hash.new
	arr2 = Array.new
#	arrdoc.each do |d|
#		puts arr2.inspect
#		puts d
#		#puts d[0]
#		#puts d[1]
#		sel = Animals.find(:all, :select => "uscita", :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "U", "#{d}"])
#		#puts sel.inspect
#		hash2["doc"] = d
#		hash2["data"] = sel[0].uscita
#		hash2["cont"] = sel.length
#		arr2 << hash2
#	end
#	puts "array di hash"
#	puts arr2.inspect
	arrcapi = []
	lista = Gtk::ListStore.new(String, String, Integer, Array, Date, Integer, Integer, Integer, String, String, Integer)
	provvisori.each do |m|
		#sel = Animals.find(:all, :select => "data_ingr", :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "I", "#{m}"])
		itermov = lista.append
		itermov[0] = m.mod4
		itermov[1] = m.datamod4.strftime("%d/%m/%Y")
		#puts itermov[1]
		arrcapi = m.capi.split(",").to_a
		#puts "qua"
		#puts arrcapi
		#puts m.capi.to_a.length
		itermov[2] = m.capi.split(",").to_a.length
		itermov[3] = m.capi.split(",").to_a
		itermov[4] = m.datausc
		itermov[5] = m.allevamenti_id.to_i
		itermov[6] = m.macelli_id.to_i
		itermov[7] = m.uscite_id.to_i
		itermov[8] = m.naz_dest
		itermov[9] = m.trasportatore #.to_s
		itermov[10] = m.id.to_i
		#puts itermov[2]
	end
	#puts lista.inspect
	
	#vista4.each do |s|
		#puts "vista"
		#puts s.inspect
	
	
	#end
#	arrdoc.each do |m|
#		sel = Animals.find(:all, :select => "uscita", :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "U", "#{m}"])
#		#puts m.inspect
#		itermov = lista.append
#		itermov[0] = m
#		itermov[1] = sel[0].uscita
#		itermov[2] = sel.length
#	end






	#lista = Gtk::ListStore.new(Integer, String, String, String, String, String, String, String, String, String, String, Date)
#	lista = Gtk::ListStore.new(String)
#	arrdoc.each do |m|
#		#puts m.inspect
#		itermov = lista.append
#		itermov[0] = m
#		#itermov[1] = 
#	end
#=begin
	vista = Gtk::TreeView.new(lista)

	vista.selection.mode = Gtk::SELECTION_SINGLE
#	vista.show_expanders = (true)
	vista.rules_hint = true
#	vista.set_enable_grid_lines(true)
#	@relid = @combo3.active_iter[0]

		cella = Gtk::CellRendererText.new
		colonna1 = Gtk::TreeViewColumn.new("Modello 4", cella)
		colonna1.resizable = true

		colonna1.set_attributes(cella, :text => 0)

		vista.append_column(colonna1)

		cella = Gtk::CellRendererText.new
		colonna1 = Gtk::TreeViewColumn.new("Data", cella)
		colonna1.resizable = true

		colonna1.set_attributes(cella, :text => 1)

		vista.append_column(colonna1)
		
		cella = Gtk::CellRendererText.new
		colonna1 = Gtk::TreeViewColumn.new("Capi", cella)
		colonna1.resizable = true

		colonna1.set_attributes(cella, :text => 2)

		vista.append_column(colonna1)
	mvismod4scroll.add(vista)
	boxprovv2.pack_start(mvismod4scroll, true, true, 0)

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mvismod4.destroy
	}
	boxprovvv.pack_start(bottchiudi, false, false, 0)
	presenti = []
	trovati = []
	differenza = []
	#m4 = ""
	vista.signal_connect("row-activated") do |view, path, column|
		tutti.clicked
		#puts "bau..."
		@mod4provv = vista.selection.selected
		#puts m4[3].inspect
		presenti = @mod4provv[3]
		#puts @mod4provv[3].inspect
		#puts column[3].inspect
		@mod4provv[3].each do |b|
			#puts "inizio each"
			#puts @mod4provv[3].inspect
			#puts "b= #{b.to_i}"
			lista4.each do |model,path,iter|
				#puts b.to_i
				#puts "#{model.inspect} - #{path.inspect} - #{iter.inspect}"
				#puts iter if iter[0] == b.to_i
				if iter[0].to_i == b.to_i
					selezione.select_path(path)
					#puts iter[2]
					trasferisci(muscite, selezione, listasel, lista4, labelselezionati, 1)
					trovati << b
				end
			end
			differenza = presenti - trovati
			#puts differenza.inspect
		end
		if differenza.length > 0
			Errore.avviso(nil, "Attenzione: dei capi di questo modello 4 provvisorio sono usciti con altri documenti.")
		end

		#puts "m4"
		#puts @mod4provv[9]
		combousc.set_active(0)
		z = -1
		while combousc.active_iter[0] != @mod4provv[7]
			z+=1
			combousc.set_active(z)
		end
		
		
		
		
		
		
		
		
		
		
		#puts lista4.get_iter(3).inspect #.path[3].inspect
#		lista4.each do |model,path,iter|
#			#puts "#{model.inspect} - #{path.inspect} - #{iter.inspect}"
#			puts iter if iter[0] == 9
#		end
#		{ ||
#				if iter3[0]== caposel[0]
#					confronta+= 1 
#				else
#				end
#			}
		
		
		selmov = vista.selection
#selcapo, marca, nascita, nazorig, naznas, madre, movingr, dataingr, nazprov
		#puts "BU!"
		@arridcapi = []
		#puts selmov.selected[0]
		#selcapi = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "I", "#{selmov.selected[0]}"])
		#puts selcapi.length
		#@totcapi = selcapi.length
		#selcapi.each {|x| @arridcapi << [x.id, x.marca, x.registro]}
		@mod4provv[3].each do |b|
			#puts b
			capo = Animals.find(:first, :conditions => ["id = ?", "#{b}"])
			#puts capo.inspect
			@arridcapi << [capo.id, capo.marca]
		end
		#puts @arridcapi.inspect
		#@dataingringl = selcapi[0].data_ingr
		#puts @dataingringl
		#@dataingringl = selcapi[0].data_ingr
		#puts @dataingringl
		#labeldocumento.text = "Documento: #{selmov.selected[0]}"
		@documento = selmov.selected[0] #unless documento == nil
		#trasferisci(finestra, selezione, listasel, lista, labelselezionati)
		#trasferisci(muscite, selezione, listasel, lista, labelselezionati)
		#puts @documento
	#	#nascita.text = selmov[0].data_nas.strftime("%d/%m/%Y")
#	unless combonazprov == nil
#		combonazprov.set_active(0)
#		contanazprov = -1
#		if selcapi[0].naz_prov != ""
#			while combonazprov.active_iter[2] != selcapi[0].naz_prov
#				contanazprov+=1
#				combonazprov.set_active(contanazprov)
#			end
#		else
#			combonazprov.set_active(-1)
#		end

#		if selcapi[0].allevamenti_id.to_s != ""
#			comboallprov.set_active(0)
#			contaallprov = -1
#			while comboallprov.active_iter[0] != selcapi[0].allevamenti_id.to_i
#				contaallprov+=1
#				comboallprov.set_active(contaallprov)
#			end
#			else
#			comboallprov.set_active(-1)
#		end

#		if selcapi[0].macelli_id.to_s != ""
#			combomacdest.set_active(0)
#			contamacdest = -1
#			while combomacdest.active_iter[0] != selcapi[0].macelli_id.to_i
#				contamacdest+=1
#				combomacdest.set_active(contamacdest)
#			end
#			else
#			combomacdest.set_active(-1)
#		end

#		combomovingr.set_active(0)
#		contamovingr = -1
#		while combomovingr.active_iter[0].to_i != selcapi[0].cm_ing.to_i
#			contamovingr+=1
#			combomovingr.set_active(contamovingr)
#		end
		
		#dataingr.text = ("#{selcapi[0].uscita.to_s[0,2]}#{selcapi[0].uscita.to_s[3,2]}#{selcapi[0].uscita.to_s[8,2]}").strftime("%d/%m/%Y")
		#dataingr.text = ("#{selcapi[0].data_ingr.strftime("%d%m%y")}")
		#certsan.text = ("#{selcapi[0].certsan}")
		#puts selcapi[0].certsan.inspect
#		if selcapi[0].certsan != nil
##			certsan.text = ""
##		else
#			certsan.text = selcapi[0].certsan
#		end
#		#puts selcapi[0].rifloc.inspect
#		if selcapi[0].rifloc != nil
##			rifloc.text = ""
##		else
#			rifloc.text = selcapi[0].rifloc
#		end
##		if selcapi[0].data_certsanusc != nil
##			datacertsan.text = ("#{selcapi[0].data_certsanusc.strftime("%d%m%y")}")
##		end
#		mod4.text = ("#{selcapi[0].mod4}")
#		if selcapi[0].data_mod4 != nil
#			datamod4.text = ("#{selcapi[0].data_mod4.strftime("%d%m%y")}")
#		end
	
#		puts "selcapi:"
#		selcapi.each do |s|
#			puts s.id
#		end
	
	#end
#		nazorig.text = selcapi[0].naz_dest
#		naznas.text = selcapi[0].naz_dest
#	#	#madre.text = selmov[0].marca_madre
#		movingr.text = selcapi[0].cm_usc.to_s
#		dataingr.text = selcapi[0].uscita.strftime("%d/%m/%Y")
#		nazprov.text = selcapi[0].naz_dest
		#labeltotcapi.text = ("Capi della partita: #{selcapi.length}")

#		@idcapo = selcapo.selected[0]
#		marca.text = selcapo.selected[1]
#		nascita.text = selcapo.selected[3]
#		nazorig.text = selcapo.selected[7]
#		naznas.text = selcapo.selected[8]
#		madre.text = selcapo.selected[9]
#		movingr.text = selcapo.selected[5]
#		dataingr.text = selcapo.selected[6]
#		nazprov.text = selcapo.selected[10]
#		@dataingringl = selcapo.selected[11]
		mvismod4.destroy
		#puts selcapo.selected[0]
		#puts @idcapo
	end
#=end
	mvismod4.show_all
end
