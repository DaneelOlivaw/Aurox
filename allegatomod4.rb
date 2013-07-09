def allegatomod4(m4, anno, capi)
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
