require 'stamparegnv'
def mascregnonvidim
	mregnonvidim = Gtk::Window.new("Stampa registro non vidimato")
	mregnonvidim.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxregnvv = Gtk::VBox.new(false, 0)
	boxregnv1 = Gtk::HBox.new(false, 5)
	boxregnv2 = Gtk::HBox.new(false, 5)
	boxregnv3 = Gtk::HBox.new(false, 5)
	boxregnvv.pack_start(boxregnv1, false, false, 5)
	boxregnvv.pack_start(boxregnv2, false, false, 5)
	boxregnvv.pack_start(boxregnv3, false, false, 5)
	mregnonvidim.add(boxregnvv)

	anni = Gtk::ListStore.new(Integer)
	arranni = [(@giorno.strftime("%Y").to_i), (@giorno.strftime("%Y").to_i) -1, (@giorno.strftime("%Y").to_i) -2]

	arranni.each do |a|
		iter = anni.append
		iter[0] = a
	end

	comboanno = Gtk::ComboBox.new(anni)

	renderer1 = Gtk::CellRendererText.new
	comboanno.pack_start(renderer1,false)
	comboanno.set_attributes(renderer1, :text => 0)
	comboanno.active=(0)
	labelanno = Gtk::Label.new("Seleziona l'anno:")
	boxregnv1.pack_start(labelanno, false, false, 5)
	boxregnv1.pack_start(comboanno, false, false, 0)

	stampaingrnv = Gtk::Button.new("Stampa ingressi")
	boxregnvv.pack_start(stampaingrnv, false, false, 5)
	stampauscnv = Gtk::Button.new("Stampa uscite")
	boxregnvv.pack_start(stampauscnv, false, false, 5)
	stamparegnv = Gtk::Button.new("Stampa registro")
	boxregnvv.pack_start(stamparegnv, false, false, 5)

	stampaingrnv.signal_connect("clicked") {
		#rel = Relazs.find(:first, :conditions => "id = '#{@stallaoper.id}'")
		if Registros.find(:first, :conditions => ["relaz_id= ? and YEAR(dataingresso) = ?", "#{@stallaoper.id}", "#{comboanno.active_iter[0]}"]) == nil
			Conferma.conferma(mregnonvidim, "Nessun capo presente.")
		else
			#conto = Registros.find(:first, :conditions => ["contatori_id= ? and YEAR(dataingresso) = ?", "#{@stallaoper.contatori_id}", "#{comboanno.active_iter[0]}"])
			#puts conto.class
			#puts conto
			registroingrnv(comboanno)
		end
	}
	stampauscnv.signal_connect("clicked") {
		#rel = Relazs.find(:first, :conditions => "id = '#{@stallaoper.id}'")
		if Registros.find(:first, :conditions => ["relaz_id= ? and tipouscita != 'null' and YEAR(datauscita) = ?", "#{@stallaoper.id}", "#{comboanno.active_iter[0]}"], :order => ["datauscita, id"]) == nil
			Conferma.conferma(mregnonvidim, "Nessun capo presente.")
		else
			registrouscnv(comboanno)
		end
	}
	stamparegnv.signal_connect("clicked") {
		#rel = Relazs.find(:first, :conditions => "id = '#{@stallaoper.id}'")
		if Registros.find(:first, :conditions => ["relaz_id= ? and tipouscita != 'null' and YEAR(datauscita) = ?", "#{@stallaoper.id}", "#{comboanno.active_iter[0]}"], :order => ["dataingresso, id"]) == nil
			Conferma.conferma(mregnonvidim, "Nessun capo presente.")
		else
			registronv(comboanno)
		end
	}
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mregnonvidim.destroy
	}
	boxregnvv.pack_start(bottchiudi, false, false, 0)
	mregnonvidim.show_all
end

def registroingrnv(comboanno)
	foglio = PDF::Writer.new(:paper => "A4") # , :font_size => 5)
	foglio.margins_mm(5, 8, 12, 13)
	foglio.select_font("Helvetica")
	foglio.open_object do |testa|
		foglio.save_state
		dimcar = 8
		x = foglio.margin_x_middle
		y = foglio.absolute_top_margin
		z = foglio.absolute_left_margin
		w = foglio.absolute_right_margin
		testo = "MOVIMENTI DI CARICO DELLA STALLA #{@stallaoper.stalle.cod317}"
		boh = foglio.text_width(testo, dimcar) / 2.0
		q = foglio.absolute_top_margin - (dimcar * 1.5)
		m = x - boh
		foglio.add_text(z, y, testo, dimcar)
		
		testoragsoc = "RAGIONE SOCIALE:  #{@stallaoper.prop.prop}"
		qragsoc = foglio.absolute_top_margin - (dimcar * 1.5)
		foglio.add_text(z, qragsoc, testoragsoc, dimcar)


		if @stallaoper.detentori.detentore.length > 40
			detentore = @stallaoper.detentori.detentore[0..40] + "..."
		else
			detentore = @stallaoper.detentori.detentore
		end
		if @stallaoper.prop.prop.length > 40
			proprietario = @stallaoper.prop.prop[0..40] + "..."
		else
			proprietario = @stallaoper.prop.prop
		end
		testo2 = "DETENTORE:  #{detentore}  -  PROPRIETARIO:  #{proprietario}"
		boh2 = foglio.text_width(testo, dimcar) / 2.0
		q2 = qragsoc - (dimcar * 1.5)
		m2 = x - boh2
		foglio.add_text(z, q2, testo2, dimcar)
		
		
		

#		bohragsoc = foglio.text_width(testo, dimcar) / 2.0

#		mragsoc = x - boh2


		if @stallaoper.detentori.detentore.length > 40
			detentore = @stallaoper.detentori.detentore[0..40] + "..."
		else
			detentore = @stallaoper.detentori.detentore
		end
		if @stallaoper.prop.prop.length > 40
			proprietario = @stallaoper.prop.prop[0..40] + "..."
		else
			proprietario = @stallaoper.prop.prop
		end
		testo2 = "DETENTORE:  #{detentore}  -  PROPRIETARIO:  #{proprietario}"
		boh2 = foglio.text_width(testo, dimcar) / 2.0
		q2 = qragsoc - (dimcar * 1.5)
		m2 = x - boh2
		foglio.add_text(z, q2, testo2, dimcar)
		
		
		
		
		
		
		
		
		
		
		
		
		
		
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
		selcapi = Registros.find(:all, :conditions => ["relaz_id= ? and YEAR(dataingresso) = ?", "#{@stallaoper.id}", "#{comboanno.active_iter[0]}"], :order => ["dataingresso, id"])
	selcapi.each do |i, index|
		data << {"prog" => "#{i.progressivo.to_s}", "marca" => "#{i.marca}", "razza" => "#{i.razza}", "sesso" => "#{i.sesso}", "madre" => "#{i.madre}",	"nc" => "#{i.tipoingresso}", "nascita" => "#{i.datanascita.strftime("%d/%m/%Y")}", "ingresso" => "#{i.dataingresso.strftime("%d/%m/%Y")}", "prov" => "#{i.provenienza}"}
	end
	tabella.data.replace data
	tabella.render_on(foglio)
	foglio.save_as("#{@dir}/regnv/registro_ingressonv.pdf")
	if @sistema == "linux"
		system("evince #{@dir}/regnv/registro_ingressonv.pdf")
	else
#		foglio.save_as('.\regnv\registro_ingressonv.pdf')
#		@shell.ShellExecute('./regnv/registro_ingressonv.pdf', '', '', 'open', 3)
		@shell.ShellExecute('.\regnv\registro_ingressonv.pdf', '', '', 'open', 3)
	end
end
