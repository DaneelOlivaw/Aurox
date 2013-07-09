#require 'stamparicgen'
def ricercadata
	mricgen = Gtk::Window.new("Ricerche generiche")
	mricgen.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxricgenv = Gtk::VBox.new(false, 0)
	boxricgen1 = Gtk::HBox.new(false, 5)
	boxricgen2 = Gtk::HBox.new(false, 5)
	boxricgen3 = Gtk::HBox.new(false, 5)
	boxricgen4 = Gtk::HBox.new(false, 5)
	boxricgen5 = Gtk::HBox.new(false, 5)
	boxricgen6 = Gtk::HBox.new(false, 5)
	boxricgenv.pack_start(boxricgen1, false, false, 5)
	boxricgenv.pack_start(boxricgen2, false, false, 5)
	boxricgenv.pack_start(boxricgen3, false, false, 5)
	boxricgenv.pack_start(boxricgen4, false, false, 5)
	boxricgenv.pack_start(boxricgen5, false, false, 5)
	boxricgenv.pack_start(boxricgen6, false, false, 5)
	mricgen.add(boxricgenv)

#	anni = Gtk::ListStore.new(Integer)
#	arranni = [(@giorno.strftime("%Y").to_i), (@giorno.strftime("%Y").to_i) -1, (@giorno.strftime("%Y").to_i) -2]

#	arranni.each do |a|
#		iter = anni.append
#		iter[0] = a
#	end

#	comboanno = Gtk::ComboBox.new(anni)

#	renderer1 = Gtk::CellRendererText.new
#	comboanno.pack_start(renderer1,false)
#	comboanno.set_attributes(renderer1, :text => 0)
#	comboanno.active=(0)
#	labelanno = Gtk::Label.new("Seleziona l'anno:")
#	boxricgen1.pack_start(labelanno, false, false, 5)
#	boxricgen1.pack_start(comboanno, false, false, 0)

#	labeldoc = Gtk::Label.new("Documento:")
#	boxricgen2.pack_start(labeldoc, false, false, 5)
#	doctutti = Gtk::RadioButton.new("Tutti")
#	doctutti.active=(true)
#	tipodoc = "T"
#	doctutti.signal_connect("toggled") {
#		if doctutti.active?
#			tipodoc="T"
#		end
#	}
#	boxricgen2.pack_start(doctutti, false, false, 5)
#	mod4 = Gtk::RadioButton.new(doctutti, "Modello 4")
#	mod4.signal_connect("toggled") {
#		if mod4.active?
#			tipodoc="M"
#		end
#	}
#	boxricgen2.pack_start(mod4, false, false, 5)
#	certsan = Gtk::RadioButton.new(doctutti, "Certificato sanitario")
#	certsan.signal_connect("toggled") {
#		if certsan.active?
#			tipodoc="C"
#		end
#	}
#	boxricgen2.pack_start(certsan, false, false, 5)
#	docentry = GTK::Entry.new

	labelmovimento = Gtk::Label.new("Tipo di movimento:")
	boxricgen3.pack_start(labelmovimento, false, false, 5)
	movtutti = Gtk::RadioButton.new("Tutti")
	movtutti.active=(true)
	tipomov = "T"
	movtutti.signal_connect("toggled") {
		if movtutti.active?
			tipomov="T"
		end
	}
	boxricgen3.pack_start(movtutti, false, false, 5)
	movingr = Gtk::RadioButton.new(movtutti, "Ingresso")
	movingr.signal_connect("toggled") {
		if movingr.active?
			tipomov="I"
		end
	}
	boxricgen3.pack_start(movingr, false, false, 5)
	movusc = Gtk::RadioButton.new(movtutti, "Uscita")
	movusc.signal_connect("toggled") {
		if movusc.active?
			tipomov="U"
		end
	}
	boxricgen3.pack_start(movusc, false, false, 5)

	labelinizio = Gtk::Label.new("Da:")
	boxricgen4.pack_start(labelinizio, false, false, 5)
	datainizio = Gtk::Entry.new
	datainizio.max_length=(6)
	boxricgen4.pack_start(datainizio, false, false, 5)
	labelfine = Gtk::Label.new("A:")
	boxricgen4.pack_start(labelfine, false, false, 5)
	datafine = Gtk::Entry.new
	datafine.max_length=(6)
	boxricgen4.pack_start(datafine, false, false, 5)
=begin
	labelcercain = Gtk::Label.new("Cerca in:")
	boxricgen5.pack_start(labelcercain, false, false, 5)
	movimento = Gtk::RadioButton.new("Tabella Movimenti")
	movimento.active=(true)
	cercain = "M"
	movimento.signal_connect("toggled") {
		if movimento.active?
			cercain="M"
		end
	}
	boxricgen5.pack_start(movimento, false, false, 5)
	registro = Gtk::RadioButton.new(movimento, "Tabella Registro")
	registro.signal_connect("toggled") {
		if registro.active?
			cercain="R"
		end
	}
	boxricgen5.pack_start(registro, false, false, 5)
=end




	bottcerca = Gtk::Button.new("Cerca")
	boxricgen6.pack_start(bottcerca, false, false, 5)
	bottcerca.signal_connect("clicked") {
#	errore = 0
=begin
     if selcc != "" and selcc != "6"
        condcc = "and callcenter_id = '#{selcc}'"
        #puts condcc
      else
        condcc = ""
      end
      if @seltype != ""
        condtype = "and type_id = '#{@seltype}'"
        #puts condtype
      else
        condtype = ""
      end
      if @selconf.to_s != ""
        condconf = "and intext = '#{@selconf}'"
        #puts condconf
      else
        condconf = ""
      end
      if @selfond.to_s != ""
        condfond = "and fondato = '#{@selfond}'"
      else
        condfond = ""
      end
      @grievances = Grievance.where("id > ? #{condcc} #{condtype} #{condconf} #{condfond}", "0").order("callcenter_id, id desc") #.paginate(:page => params[:page], :per_page => 10)
    end
=end
	
=begin	
	if cercain == "M"
		puts "Movimento"
#		if tipodoc == "M"
#			querydoc = "and mod4 LIKE %#{docentry.text}"
#		elsif tipodoc == "C"
#			querydoc = "and certsan LIKE %#{docentry.text}"
=end
#		if tipomov == "I"
#			querymov = ""
#		else
#			querymov = "and tipouscita IS NOT NULL"
#		end

		if tipomov == "U"
			querymov = "and tipouscita IS NOT NULL"
			ordinamento = "datauscita, mod4usc, id"
		else
			querymov = ""
			ordinamento = "dataingresso, id"
		end
		if tipomov == "I"
			orientamento = "portait"
		else
			orientamento = "landscape"
		end
#=begin
		begin
		if datainizio.text != ""# and tipomov == "I"
			inizioingl = datainizio.text[4,2] + datainizio.text[2,2] + datainizio.text[0,2]
			inizioingl = Time.parse("#{inizioingl}").strftime("%Y")[0,2] + inizioingl
			inizioita = inizioingl.to_date.strftime("%d/%m/%Y")
			if tipomov == "I"
				queryinizio = "and dataingresso >= '#{inizioingl}'"
			elsif tipomov == "U"
				queryinizio = "and datauscita >= '#{inizioingl}'"
			else
				queryinizio = "and (dataingresso >= '#{inizioingl}' or datauscita >= '#{inizioingl}')"
			end
		else
			queryinizio = ""
			inizioita = ""
		end

		if datafine.text != ""# and tipomov == "I"
			fineingl = datafine.text[4,2] + datafine.text[2,2] + datafine.text[0,2]
			fineingl = Time.parse("#{fineingl}").strftime("%Y")[0,2] + fineingl
			fineita = fineingl.to_date.strftime("%d/%m/%Y")
			if tipomov == "I"
				queryfine = "and dataingresso <= '#{fineingl}'"
			elsif tipomov == "U"
				queryfine = "and datauscita <= '#{fineingl}'"
			else
				queryfine = "and (dataingresso <= '#{fineingl}' or datauscita <= '#{fineingl}')"
			end
		else
			queryfine = ""
			fineita = ""
		end

#=end
		selmov = Registros.find(:all, :conditions => ["relaz_id = ? #{querymov} #{queryinizio} #{queryfine}", "#{@stallaoper.id}"], :order => "#{ordinamento}")
		#selmov = Animals.find(:all, :conditions => ["relaz_id = ? #{querymov} #{queryinizio} #{queryfine}", "#{@stallaoper.id}"])
		#selmov = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and marca LIKE ?", "#{@stallaoper.id}", "%#{visricercaentry.text}%"])
		#puts selmov.length
		
		#riempimento2
		#vismovimenti2(selmov, inizioingl, fineingl)
		require 'visregistro2'
		visregistro2(selmov, inizioita, fineita, orientamento)
=begin
	else
		puts "Registro"
	end
=end
		rescue Exception => errore
			#puts errore
			Errore.avviso(mricgen, "Controllare le date.")
		end
	}
	
	
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mricgen.destroy
	}
	boxricgen6.pack_start(bottchiudi, false, false, 0)
=begin
	stampauscnv = Gtk::Button.new("Stampa registro di scarico")
	boxricgenv.pack_start(stampauscnv, false, false, 5)
	stamparicgen = Gtk::Button.new("Stampa registro nuovo")
	boxricgenv.pack_start(stamparicgen, false, false, 5)

	stampaingrnv.signal_connect("clicked") {
		#rel = Relazs.find(:first, :conditions => "id = '#{@stallaoper.id}'")
		if Registros.find(:first, :conditions => ["contatori_id= ? and YEAR(dataingresso) = ?", "#{@stallaoper.contatori_id}", "#{comboanno.active_iter[0]}"]) == nil
			Conferma.conferma(mricgen, "Nessun capo presente.")
		else
			#conto = Registros.find(:first, :conditions => ["contatori_id= ? and YEAR(dataingresso) = ?", "#{@stallaoper.contatori_id}", "#{comboanno.active_iter[0]}"])
			#puts conto.class
			#puts conto
			registroingrnv(comboanno)
		end
	}
	stampauscnv.signal_connect("clicked") {
		#rel = Relazs.find(:first, :conditions => "id = '#{@stallaoper.id}'")
		if Registros.find(:first, :conditions => ["contatori_id= ? and tipouscita != 'null' and YEAR(datauscita) = ?", "#{@stallaoper.contatori_id}", "#{comboanno.active_iter[0]}"], :order => ["datauscita, id"]) == nil
			Conferma.conferma(mricgen, "Nessun capo presente.")
		else
			registrouscnv(comboanno)
		end
	}
	stamparicgen.signal_connect("clicked") {
		#rel = Relazs.find(:first, :conditions => "id = '#{@stallaoper.id}'")
		if Registros.find(:first, :conditions => ["contatori_id= ? and tipouscita != 'null' and YEAR(datauscita) = ?", "#{@stallaoper.contatori_id}", "#{comboanno.active_iter[0]}"], :order => ["dataingresso, id"]) == nil
			Conferma.conferma(mricgen, "Nessun capo presente.")
		else
			registronv(comboanno)
		end
	}
=end
	mricgen.show_all
end
=begin
def registroingrnv(comboanno)
	foglio = PDF::Writer.new(:paper => "A4") # , :font_size => 5)
	foglio.select_font("Helvetica")
	foglio.open_object do |testa|
		foglio.save_state
		dimcar = 8
		x = foglio.margin_x_middle
		y = foglio.absolute_top_margin
		z = foglio.absolute_left_margin
		w = foglio.absolute_right_margin
		testo = "<b>Registro non vidimato di carico della stalla #{@stallaoper.stalle.cod317} di #{@stallaoper.ragsoc.ragsoc}</b>"
		boh = foglio.text_width(testo, dimcar) / 2.0
		q = foglio.absolute_top_margin - (dimcar * 1.5)
		m = x - boh
		foglio.add_text(m, y, testo, dimcar)
		spostapagina = x + 36
		foglio.start_page_numbering(w-20, foglio.absolute_bottom_margin, 8, nil, "pag. <PAGENUM> di <TOTALPAGENUM>")
		foglio.restore_state
		foglio.close_object
		foglio.add_object(testa, :all_pages)
	end
	foglio.margins_mm(15, 10, 10)
	tabella = PDF::SimpleTable.new
	tabella.show_lines = :all
	tabella.show_headings = true
	tabella.orientation = :right
	tabella.position = :left
	tabella.shade_rows = :none
	tabella.split_rows = true
	tabella.font_size = 8
	tabella.heading_font_size = 8
	tabella.width = 550
	tabella.minimum_space = 10
	tabella.column_order.push(*%w(prog marca razza sesso madre nc nascita ingresso prov))
	tabella.columns["prog"] = PDF::SimpleTable::Column.new("prog") { |col|
		col.heading = "Numero ordine"
		col.width = 40
	}
	tabella.columns["marca"] = PDF::SimpleTable::Column.new("marca") { |col|
		col.heading = "Marchio di identificazione"
		col.width = 90
	}
	tabella.columns["razza"] = PDF::SimpleTable::Column.new("razza") { |col|
		col.heading = "Razza"
		col.width = 35
	}
	tabella.columns["sesso"] = PDF::SimpleTable::Column.new("sesso") { |col|
		col.heading = "Sesso"
		col.width = 35
	}
	tabella.columns["madre"] = PDF::SimpleTable::Column.new("madre") { |col|
		col.heading = "Codice della madre"
		col.width = 90
	}
	tabella.columns["nc"] = PDF::SimpleTable::Column.new("nc") { |col|
		col.heading = "Nato / acquisto"
		col.width = 40
	}
	tabella.columns["nascita"] = PDF::SimpleTable::Column.new("nascita") { |col|
		col.heading = "Data di nascita"
		col.width = 55
	}
	tabella.columns["ingresso"] = PDF::SimpleTable::Column.new("ingresso") { |col|
		col.heading = "Data di ingresso"
		col.width = 55
	}
	tabella.columns["prov"] = PDF::SimpleTable::Column.new("prov") { |col|
		col.heading = "Provenienza"
	}
	data = Array.new

		#rel = Relazs.find(:first, :conditions => "id = '#{@stallaoper.id}'")
		selcapi = Registros.find(:all, :conditions => ["contatori_id= ? and YEAR(dataingresso) = ?", "#{@stallaoper.contatori_id}", "#{comboanno.active_iter[0]}"], :order => ["dataingresso, id"])
	selcapi.each do |i, index|
		data << {"prog" => "#{i.progressivo.to_s}", "marca" => "#{i.marca}", "razza" => "#{i.razza}", "sesso" => "#{i.sesso}", "madre" => "#{i.madre}",	"nc" => "#{i.tipoingresso}", "nascita" => "#{i.datanascita.strftime("%d/%m/%Y")}", "ingresso" => "#{i.dataingresso.strftime("%d/%m/%Y")}", "prov" => "#{i.provenienza}"}
	end
	tabella.data.replace data
	tabella.render_on(foglio)
	foglio.save_as("#{@dir}/ricgen/registro_ingressonv.pdf")
	if @sistema == "linux"
		system("evince #{@dir}/ricgen/registro_ingressonv.pdf")
	else
#		foglio.save_as('.\ricgen\registro_ingressonv.pdf')
#		@shell.ShellExecute('./ricgen/registro_ingressonv.pdf', '', '', 'open', 3)
		@shell.ShellExecute('.\ricgen\registro_ingressonv.pdf', '', '', 'open', 3)
	end
end
=end
