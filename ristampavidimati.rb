# Finestra di stampa delle pagine vidimate che sono andate distrutte

def ristampavidimati
	mristvidim = Gtk::Window.new("Ristampa fogli da vidimare")
	mristvidim.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxristvidimv = Gtk::VBox.new(false, 0)
	boxristvidim1 = Gtk::HBox.new(false, 5)
	boxristvidim2 = Gtk::HBox.new(false, 5)
	boxristvidim3 = Gtk::HBox.new(false, 5)
	boxristvidim4 = Gtk::HBox.new(false, 5)
	boxristvidimv.pack_start(boxristvidim1, false, false, 5)
	boxristvidimv.pack_start(boxristvidim2, false, false, 5)
	boxristvidimv.pack_start(boxristvidim3, false, false, 5)
	boxristvidimv.pack_start(boxristvidim4, false, false, 5)
	mristvidim.add(boxristvidimv)

	labelnreg = Gtk::Label.new("Numero registro di riferimento:")
	boxristvidim1.pack_start(labelnreg, false, false, 5)
	nreg = Gtk::Entry.new
	boxristvidim1.pack_start(nreg, false, false, 5)

	labelnultimo = Gtk::Label.new("Numero ultima pagina del registro:")
	boxristvidim2.pack_start(labelnultimo, false, false, 5)
	nultimo = Gtk::Entry.new
	boxristvidim2.pack_start(nultimo, false, false, 5)

	labelnpagine = Gtk::Label.new("Numero pagine da ristampare (DA A):")
	boxristvidim3.pack_start(labelnpagine, false, false, 5)
	npagine = Gtk::Entry.new
	boxristvidim3.pack_start(npagine, false, false, 5)

	stampavidim = Gtk::Button.new( "STAMPA" )
	boxristvidim4.pack_start(stampavidim, true, false, 5)
	stampavidim.signal_connect("clicked") {
		#puts nreg.text.to_i 
		if npagine.text == "" or nreg.text.to_i == 0 or nultimo.text.to_i == 0
			Errore.avviso(mristvidim, "Mancano dei dati o sono stati inseriti non correttamente.")
		else
			convertitore = npagine.text.split(' ')
			#puts convertitore
			#puts convertitore.class
			if convertitore[0].to_i > convertitore[1].to_i
				sequenza = Range.new(convertitore[0].to_i, convertitore[0].to_i, true)
			else
				sequenza = Range.new(convertitore[0].to_i, convertitore[1].to_i, true)
			end
			#puts sequenza.inspect
			#puts sequenza.to_a
			#puts sequenza.class
			#puts sequenza.to_i.class
#=begin
			registro = PDF::Writer.new(:paper => "A4", :orientation => :landscape) # , :font_size => 5)
			registro.select_font("Helvetica")
			registro.margins_mm(7, 10)
			#prog = npagr #nultimo.text.split('/')
			#prpagina = 1 #prog[0].to_i
			prpagina = convertitore[0].to_i
			#prpagina += 1
			registro.open_object do |testa|
				registro.save_state
				dimcar = 8
				x = registro.margin_x_middle
				y = registro.absolute_top_margin
				z = registro.absolute_left_margin
				w = registro.absolute_right_margin
				testo = "REGISTRO AZIENDALE N. #{nreg.text} - STALLA #{@stallaoper.stalle.cod317} - #{@stallaoper.stalle.via} - #{@stallaoper.stalle.comune}"
				boh = registro.text_width(testo, dimcar) / 2.0
				q = registro.absolute_top_margin - (dimcar * 1.5)
				m = x - boh
				#registro.add_text(m, y, testo, dimcar)
				registro.add_text(z, y, testo, dimcar)
				registro.add_text(z, q, "RAGIONE SOCIALE: #{@stallaoper.ragsoc.ragsoc}", dimcar)
				testo2 = "DETENTORE: #{@stallaoper.detentori.detentore} - PROPRIETARIO: #{@stallaoper.prop.prop}"
				ltesto2 = registro.text_width(testo2, dimcar) / 2.0
				oriztesto2 = x - ltesto2
				q2 = q -(dimcar*1.5)
				#registro.add_text(oriztesto2, q2, testo2, dimcar)
				registro.add_text(z, q2, testo2, dimcar)
				#vertlinea = q -(dimcar * 0.5)
				vertlinea2 = q2 -(dimcar * 0.5)
				registro.line(z, vertlinea2, w, vertlinea2).stroke
				#if tiporeg == "N"
					spostapagina = x # + 17
				#else
				#	spostapagina = x + 37
				#end
				testopag= "PAG. <PAGENUM> DI #{nultimo.text}"
				#registro.start_page_numbering(spostapagina, y, 8, nil, "PAG. <PAGENUM> DI #{npagine.text}", prpagina)
				boh = registro.text_width(testopag, dimcar) / 2.0
				#q = registro.absolute_bottom_margin + (dimcar * 1.01)
				m = w - boh
				registro.start_page_numbering(m, y, 8, nil, testopag, prpagina)
				registro.restore_state
				registro.close_object
				registro.add_object(testa, :all_pages)
				sequenza.each do
					registro.start_new_page
				end
				#cont = npagine.text.to_i
	#				cont -= 1
	#				while cont != 0
	#					registro.start_new_page
	#					cont -= 1
	#				end
			end
#		if File.exist?('./vidim/ristvidim_ingresso.pdf')
#			puts "sì"
#		else
#			puts "no"
#		end
			registro.save_as("#{@dir}/vidim/ristvidim.pdf")
			if @sistema == "linux"
				system("evince #{@dir}/vidim/ristvidim.pdf")
			else
	#			registro.save_as('.\vidim\ristvidim_ingresso.pdf')
				#@shell.ShellExecute('./vidim/ristvidim.pdf', '', '', 'open', 3)
				@shell.ShellExecute('.\vidim\ristvidim.pdf', '', '', 'open', 3)
			end
#=end
		end
	}
	bottchiudi = Gtk::Button.new( "CHIUDI" )
	bottchiudi.signal_connect("clicked") {
		mristvidim.destroy
	}
	boxristvidim4.pack_start(bottchiudi, true, false, 0)
	mristvidim.show_all
end
