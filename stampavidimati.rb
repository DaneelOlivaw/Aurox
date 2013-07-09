# Finestra di stampa vidimati

def stampavidimati
	mvidimati = Gtk::Window.new("Stampa fogli da vidimare")
	mvidimati.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxvidimv = Gtk::VBox.new(false, 0)
	boxvidim1 = Gtk::HBox.new(false, 5)
	boxvidim2 = Gtk::HBox.new(false, 5)
	boxvidim3 = Gtk::HBox.new(false, 5)
	boxvidim4 = Gtk::HBox.new(false, 5)
	boxvidimv.pack_start(boxvidim1, false, false, 5)
	boxvidimv.pack_start(boxvidim2, false, false, 5)
	boxvidimv.pack_start(boxvidim3, false, false, 5)
	boxvidimv.pack_start(boxvidim4, false, false, 5)
	mvidimati.add(boxvidimv)

#	pagregcar = @stallaoper.contatori.pagregcar.split("/")
#	pagregscar = @stallaoper.contatori.pagregscar.split("/")
#	pagreg = @stallaoper.contatori.pagreg.split("/")
#	if pagregcar[1].to_i == @giorno.strftime("%y").to_i
#		npagc = pagregcar[0].to_i
#		annopagc = pagregcar[1]
#	else
#		npagc = 0
#		annopagc = @giorno.strftime("%y")
#	end
#	if pagregscar[1].to_i == @giorno.strftime("%y").to_i
#		npags = pagregscar[0].to_i
#		annopags = pagregscar[1]
#	else
#		npags = 0
#		annopags = @giorno.strftime("%y")
#	end
#	if pagreg[1].to_i == @giorno.strftime("%y").to_i
#		npagr = pagreg[0].to_i
#		annopagr = pagreg[1]
#	else
#		npagr = 0
#		annopagr = @giorno.strftime("%y")
#	end
	#npagr = 0
	#progreg = 25
	#puts @stallaoper.ultimoreg+1
	labelreg = Gtk::Label.new("Registro aziendale numero: #{@stallaoper.ultimoreg+1}")
	boxvidim1.pack_start(labelreg, false, false, 5)
	labelnpagine = Gtk::Label.new("Numero pagine da stampare:")
	boxvidim2.pack_start(labelnpagine, false, false, 5)
	npagine = Gtk::Entry.new
	boxvidim2.pack_start(npagine, false, false, 5)
#	labelultimo = Gtk::Label.new("Ultimo numero stampato:")
#	boxvidim3.pack_start(labelultimo, false, false, 5)
#	nultimo = Gtk::Entry.new()
	#boxvidim3.pack_start(nultimo, false, false, 5)
#	labeltiporeg = Gtk::Label.new("Tipo di registro:")
#	boxvidim2.pack_start(labeltiporeg, false, false, 5)
#	tiporeg1 = Gtk::RadioButton.new("Carico")
#	tiporeg1.active=(true)
#	tiporeg="C"
#	#nultimo.text = "#{npagc}/#{annopagc}"
#	tiporeg1.signal_connect("toggled") {
#		if tiporeg1.active?
#			tiporeg="C"
#			nultimo.text = "#{npagc}/#{annopagc}"
#		end
#	}
#	boxvidim2.pack_start(tiporeg1, false, false, 5)
#	tiporeg2 = Gtk::RadioButton.new(tiporeg1, "Scarico")
#	tiporeg2.signal_connect("toggled") {
#		if tiporeg2.active?
#			tiporeg="S"
#			nultimo.text = "#{npags}/#{annopags}"
#		end
#	}
#	boxvidim2.pack_start(tiporeg2, false, false, 5)
#	tiporeg3 = Gtk::RadioButton.new(tiporeg1, "Nuovo")
#	tiporeg3.signal_connect("toggled") {
#		if tiporeg3.active?
#			tiporeg="N"
#			#nultimo.text = "#{npagr}/#{npagine}"
#		end
#	}
#	boxvidim2.pack_start(tiporeg3, false, false, 5)
	stampavidim = Gtk::Button.new( "STAMPA" )
	boxvidim4.pack_start(stampavidim, true, false, 5)
	stampavidim.signal_connect("clicked") {
		if npagine.text.to_i == 0 #or nultimo.text == ""
			Errore.avviso(mvidimati, "Mancano dei dati o sono stati inseriti non correttamente.")
		else
#			if tiporeg == "S"
#				orientation = :landscape
#				testotiporeg = "SCARICO"
#			elsif tiporeg == "C"
#				orientation = :portrait
#				testotiporeg = "CARICO"
#			else
#				orientation = :landscape
#				testotiporeg = "CARICO E SCARICO"
#			end
			registro = PDF::Writer.new(:paper => "A4", :orientation => :landscape) # , :font_size => 5)
			registro.select_font("Helvetica")
			registro.margins_mm(7, 10)
			#prog = npagr #nultimo.text.split('/')
			#prpagina = 1 #prog[0].to_i
			#prpagina += 1
			registro.open_object do |testa|
				registro.save_state
				dimcar = 8
				x = registro.margin_x_middle
				y = registro.absolute_top_margin
				z = registro.absolute_left_margin
				w = registro.absolute_right_margin
				testo = "REGISTRO AZIENDALE N. #{@stallaoper.ultimoreg+1} - STALLA #{@stallaoper.stalle.cod317} - #{@stallaoper.stalle.via} - #{@stallaoper.stalle.comune}"
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
				testopag= "PAG. <PAGENUM> DI #{npagine.text}"
				#registro.start_page_numbering(spostapagina, y, 8, nil, "PAG. <PAGENUM> DI #{npagine.text}", prpagina)
				boh = registro.text_width(testopag, dimcar) / 2.0
				#q = registro.absolute_bottom_margin + (dimcar * 1.01)
				m = w - boh
				#registro.start_page_numbering(m, y, 8, nil, testopag, prpagina)
				registro.start_page_numbering(m, y, 8, nil, testopag, 1)
				registro.restore_state
				registro.close_object
				registro.add_object(testa, :all_pages)
				#cont = npagine.text.to_i
				(2..npagine.text.to_i).each do
					registro.start_new_page
				end
#				cont -= 1
#				while cont != 0
#					registro.start_new_page
#					cont -= 1
#				end
			end
#		if File.exist?('./vidim/vidimati_ingresso.pdf')
#			puts "sì"
#		else
#			puts "no"
#		end
			registro.save_as("#{@dir}/vidim/vidimati.pdf")
			if @sistema == "linux"
				system("evince #{@dir}/vidim/vidimati.pdf")
			else
	#			registro.save_as('.\vidim\vidimati_ingresso.pdf')
				#@shell.ShellExecute('./vidim/vidimati.pdf', '', '', 'open', 3)
				@shell.ShellExecute('.\vidim\vidimati.pdf', '', '', 'open', 3)
			end

			avviso = Gtk::MessageDialog.new(mvidimati, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "La stampa è stata eseguita correttamente?")
			risposta = avviso.run
			avviso.destroy
			if risposta == Gtk::Dialog::RESPONSE_YES
				avviso2 = Gtk::MessageDialog.new(mvidimati, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Procedo con l'aggiornamento dei dati?")
				risposta2 = avviso2.run
				avviso2.destroy
				if risposta2 == Gtk::Dialog::RESPONSE_YES
					#somma = npagine.text.to_i + prog[0].to_i
#					if tiporeg == "C"
#						Contatoris.update(@stallaoper.contatori.id, { :pagregcar => "#{somma}/#{prog[1]}"})
#					elsif tiporeg == "S"
#						Contatoris.update(@stallaoper.contatori.id, { :pagregscar => "#{somma}/#{prog[1]}"})
#					elsif tiporeg == "N"
						Relazs.update(@stallaoper.id, { :ultimoreg => "#{@stallaoper.ultimoreg+1}"})
					#end
				else
					Conferma.conferma(mvidimati, "I dati non sono stati aggiornati.")
				end
			else
				Conferma.conferma(mvidimati, "Si dovrà rilanciare la stampa.")
			end
		end
	}
	bottchiudi = Gtk::Button.new( "CHIUDI" )
	bottchiudi.signal_connect("clicked") {
		mvidimati.destroy
	}
	boxvidim4.pack_start(bottchiudi, true, false, 0)
	mvidimati.show_all
end
