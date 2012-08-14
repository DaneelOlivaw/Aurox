#def visdocusc(selcapo, nazorig, naznas, movingr, dataingr, nazprov)
#def visdocumuscita(arrdoc, tipodocumento, documento, nazorig, naznas, movingr, dataingr, nazprov, labeltotcapi)
def visdocumuscita(arrdoc, tipodocumento, documento, combonazdest, comboalldest, combomacdest, combomovusc, datausc, certsan, datacertsan, mod4, datamod4, labeltotcapi)
	mvisdocusc = Gtk::Window.new("Selezione documento di uscita")
	mvisdocusc.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	mvisdocusc.set_default_size(700, 400)
	#mvisdocusc.maximize
	mvisdocuscscroll = Gtk::ScrolledWindow.new #(hadjustment = nil, vadjustment = nil)
	boxmovv = Gtk::VBox.new(false, 0)
	boxmov1 = Gtk::HBox.new(false, 0)
	boxmov2 = Gtk::HBox.new(false, 0)
	boxmovv.pack_start(boxmov1, false, false, 5)
	boxmovv.pack_start(boxmov2, true, true, 5)
	mvisdocusc.add(boxmovv)

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

	lista = Gtk::ListStore.new(String, String, Integer)
	arrdoc.each do |m|
		#puts m.inspect
		sel = Animals.find(:all, :select => "uscita", :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "U", "#{m}"])
		itermov = lista.append
		itermov[0] = m
		itermov[1] = sel[0].uscita.strftime("%d/%m/%Y")
		itermov[2] = sel.length
	end

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

	vista = Gtk::TreeView.new(lista)

	vista.selection.mode = Gtk::SELECTION_SINGLE
#	vista.show_expanders = (true)
	vista.rules_hint = true
#	vista.set_enable_grid_lines(true)
#	@relid = @combo3.active_iter[0]

		cella = Gtk::CellRendererText.new
		colonna1 = Gtk::TreeViewColumn.new("Documento ingresso", cella)
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
	mvisdocuscscroll.add(vista)
	boxmov2.pack_start(mvisdocuscscroll, true, true, 0)

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mvisdocusc.destroy
	}
	boxmovv.pack_start(bottchiudi, false, false, 0)

	vista.signal_connect("row-activated") do |view, path, column|
		selmov = vista.selection
#selcapo, marca, nascita, nazorig, naznas, madre, movingr, dataingr, nazprov
		#puts "BU!"
		@arridcapi = []
		#puts selmov.selected[0]
		selcapi = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "U", "#{selmov.selected[0]}"])
		#puts selcapi.length
		selcapi.each {|x| @arridcapi << [x.id, x.marca, x.registro]}
		#puts @arridcapi.inspect
		@datauscingl = selcapi[0].uscita
		#puts @datauscingl
		#@dataingringl = selcapi[0].data_ingr
		#puts @dataingringl
		documento.text = selmov.selected[0]
	#	#nascita.text = selmov[0].data_nas.strftime("%d/%m/%Y")
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
	
#		puts "selcapi:"
#		selcapi.each do |s|
#			puts s.id
#		end
	
	
#		nazorig.text = selcapi[0].naz_dest
#		naznas.text = selcapi[0].naz_dest
#	#	#madre.text = selmov[0].marca_madre
#		movingr.text = selcapi[0].cm_usc.to_s
#		dataingr.text = selcapi[0].uscita.strftime("%d/%m/%Y")
#		nazprov.text = selcapi[0].naz_dest
		labeltotcapi.text = ("Capi della partita: #{selcapi.length}")

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
		mvisdocusc.destroy
		#puts selcapo.selected[0]
		#puts @idcapo
	end
	mvisdocusc.show_all
end
