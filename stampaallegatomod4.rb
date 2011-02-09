def mascallmod4
	mallmod4 = Gtk::Window.new("Stampa dell'allegato al Modello 4")
	mallmod4.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxallmod4v = Gtk::VBox.new(false, 0)
	boxallmod41 = Gtk::HBox.new(false, 5)
	boxallmod42 = Gtk::HBox.new(false, 5)
	boxallmod43 = Gtk::HBox.new(false, 5)
	boxallmod4v.pack_start(boxallmod41, false, false, 5)
	boxallmod4v.pack_start(boxallmod42, false, false, 5)
	boxallmod4v.pack_start(boxallmod43, false, false, 5)
	mallmod4.add(boxallmod4v)
	labelmod4 = Gtk::Label.new("Numero modello 4:")
	boxallmod41.pack_start(labelmod4, false, false, 5)
	m4 = Gtk::Entry.new()
	boxallmod41.pack_start(m4, false, false, 5)

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
	boxallmod42.pack_start(labelanno, false, false, 5)
	boxallmod42.pack_start(comboanno, false, false, 0)

	stampa = Gtk::Button.new("Stampa l'allegato")
	boxallmod43.pack_start(stampa, false, false, 5)
	stampa.signal_connect("clicked") {
		capi = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and mod4= ?", "#{@stallaoper.id}", "U", "#{@stallaoper.stalle.cod317}/#{comboanno.active_iter[0]}/#{m4.text}"])
		if capi.length == 0
			Errore.avviso(mallmod4, "Questo modello 4 non esiste.") #.avvia
		else
			stampaallegato(m4, comboanno.active_iter[0], capi)
		end
	}
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mallmod4.destroy
	}
	boxallmod4v.pack_start(bottchiudi, false, false, 0)
	mallmod4.show_all
end

def stampaallegato(m4, anno, capi)
	foglio = PDF::Writer.new(:paper => "A4")
	foglio.select_font("Courier")
	foglio.open_object do |testa|
		foglio.save_state
		dimcar = 12
		x = foglio.margin_x_middle
		y = foglio.absolute_top_margin
		z = foglio.absolute_left_margin
		w = foglio.absolute_right_margin
		testo = "<b>Azienda agricola #{@stallaoper.ragsoc.ragsoc}</b>"
		testo2 = "<b>Allegato del Modello 4 #{@stallaoper.stalle.cod317}/#{anno}/#{m4.text} - Capi totali: #{capi.length}</b>"
		boh = foglio.text_width(testo, dimcar) / 2.0
		boh2 = foglio.text_width(testo2, dimcar) / 2.0
		m = x - boh
		m2 = x-boh2
		y2 = y - dimcar + 5
		foglio.add_text(m, y+10, testo, dimcar)
		foglio.add_text(m2, y2, testo2, dimcar)
		foglio.start_page_numbering(w-70, foglio.absolute_bottom_margin-5, 8, nil, "pag. <PAGENUM> di <TOTALPAGENUM>")
		foglio.restore_state
		foglio.close_object
		foglio.add_object(testa, :all_pages)
	end
	data = Array.new
	capi.each do |i|
		data << i.marca
	end
	capi = String.new
	data.each do |m|
		capi += m.ljust(14) + '  '
	end

	foglio.margins_mm(17, 25, 15, 20)
	foglio.text(capi, :justification => :left, :font_size => 12, :leading => 15)
	foglio.save_as("#{@dir}/altro/allegato.pdf")
	if @sistema == "linux"
		system("evince #{@dir}/altro/allegato.pdf")
	else
#		foglio.save_as('.\altro\allegato.pdf')
		@shell.ShellExecute('.\altro\allegato.pdf', '', '', 'open', 3)
	end

end
