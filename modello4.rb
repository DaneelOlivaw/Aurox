def modello4(m4, anno, finestra)
	#selcapi = Registros.find(:all, :conditions => ["relaz_id= ? and tipouscita IS NULL", "#{@stallaoper.id}"], :order => ["dataingresso, id"])
	selcapi = Animals.find(:first, :conditions => ["relaz_id= ? and tipo= ? and mod4= ?", "#{@stallaoper.id}", "U", "#{@stallaoper.stalle.cod317}/#{anno}/#{m4}"])
	#puts selcapi.inspect
	errore = 0
	if selcapi.cm_usc == 9
		if selcapi.macelli.via.to_s == "" or selcapi.macelli.comune.to_s == "" or selcapi.macelli.provincia.to_s == ""
			Errore.avviso(finestra, "Manca l'indirizzo del macello, inseriscilo.")
			require 'modificamacello'
			modificamacello(selcapi.macelli_id)
			errore = 1
		end
	else
		if selcapi.allevamenti.via.to_s == "" or selcapi.allevamenti.comune.to_s == "" or selcapi.allevamenti.provincia.to_s == ""
			Errore.avviso(finestra, "Manca l'indirizzo dell'allevamento, inseriscilo.")
			require 'modificaallevamento'
			modificaallevamento(selcapi.allevamenti_id)
			errore = 1
		end
	end

	if errore == 0
	#puts selcapi.inspect
	totcapi = Animals.count(:conditions => ["relaz_id= ? and tipo= ? and mod4= ?", "#{@stallaoper.id}", "U", "#{@stallaoper.stalle.cod317}/#{anno}/#{m4}"])
	#puts totcapi.inspect
	#selcapi = Registros.find(:all, :conditions => ["relaz_id= ? and YEAR (dataingresso) > 2009 and YEAR(dataingresso)<= 2010 and tipouscita IS NULL", "#{@stallaoper.id}"], :order => ["dataingresso, id"])
	foglio = PDF::Writer.new(:paper => "A4") #, :encoding => "Latin-1")
#	puts foglio.encoding
	foglio.margins_mm(8, 8, 12, 13)
	foglio.select_font("Helvetica")
	#foglio.encoding = :Unicode
#	foglio.open_object do |testa|
#		foglio.save_state
	dimcar = 12
	x = foglio.margin_x_middle
	y = foglio.absolute_top_margin
	z = foglio.absolute_left_margin
	w = foglio.absolute_right_margin
	#puts foglio.absolute_top_margin
	#testo = "CAPI PRESENTI NELLA STALLA  #{@stallaoper.stalle.cod317}  DI  #{@stallaoper.ragsoc.ragsoc}  IN DATA #{@giorno.strftime("%d/%m/%Y")}:  #{selcapi.length}"

	if @stallaoper.atp == "SST"
		colore = "<b>VERDE</b>"
	else
		colore = "<b>ROSA</b>"
	end

	testonumero = "IT#{@stallaoper.stalle.cod317}/#{anno}/#{m4}"
	q = foglio.absolute_top_margin - (dimcar * 1.1)
	foglio.add_text(z, y, colore, dimcar)
	foglio.add_text(w-110, y, testonumero, dimcar)
	#foglio.add_text(z, y, testonumero, dimcar)
	
	#foglio.add_text(z, q, colore, dimcar)
	foglio.rectangle(z-5, y-3, 55, 16).stroke
	foglio.save_state
#		foglio.fill_color Color::RGB::White
#		foglio.stroke_color Color::RGB::White
#		foglio.rectangle(z, q, 50, 15).fill
#		foglio.restore_state
	
	#foglio.justification = :center
	testointestaz = "<b><c:uline>DICHIARAZIONE DI PROVENIENZA E DESTINAZIONE DEGLI ANIMALI  </c:uline></b>"

	boh = foglio.text_width(testointestaz, dimcar) / 2.0
	#q = foglio.absolute_top_margin - (dimcar * 1.1)
	qvar = q -7 #*1.1
	m = x - boh
	#foglio.add_text(z, y, testo, dimcar)
	foglio.add_text(m, qvar, testointestaz, dimcar)
	#foglio.justification = :left
#		testodet = "DETENTORE:  #{@stallaoper.detentori.detentore}"
#		#bohdet = foglio.text_width(testo, dimcar) / 2.0
#		qdet = foglio.absolute_top_margin -dimcar*1.1
#		#mdet = x - bohdet
#		foglio.add_text(z, qdet, testodet, dimcar)


#title = "PDF::Writer for Ruby"
#size = 72
#fh = foglio.font_height(size) * 1.01
#fd = foglio.font_descender(size) * 1.01
#foglio.save_state
#foglio.fill_color Color::RGB::White
#foglio.stroke_color Color::RGB::White
#foglio.rectangle(foglio.absolute_left_margin, 0, fh, foglio.page_height).fill
#foglio.fill_color Color::RGB::White
#foglio.stroke_color Color::RGB::White
#foglio.add_text(foglio.absolute_left_margin + fh + fd, 70, title, size, 90)
#foglio.restore_state

	testoregione = "REGIONE #{@stallaoper.stalle.region.regione} - A.S.L. #{@stallaoper.stalle.ulss}"
#		bohragsoc = foglio.text_width(testo, dimcar) / 2.0
	dimcar = 9
	#qregione = foglio.absolute_top_margin - dimcar -10
	qregione = qvar -15 #- dimcar*1.2 # -10
#		mragsoc = x - boh2
	foglio.add_text(z, qregione, testoregione, dimcar)
	dimcar = 8.5
	testoident = "<b>A) IDENTIFICAZIONE</b>"
	qident = qregione - dimcar -5
	#testoident.fill_color(:red)
#		foglio.save_state
#		foglio.fill_color Color::RGB::White
#		foglio.stroke_color Color::RGB::White
#		foglio.rectangle(z, qident, 100, 10).fill
#		foglio.restore_state
	#foglio.add_text(z, qident, testoident, dimcar)
	
#		if @stallaoper.detentori.detentore.length > 40
#			detentore = @stallaoper.detentori.detentore[0..40] + "..."
#		else
#			detentore = @stallaoper.detentori.detentore
#		end
#		if @stallaoper.prop.prop.length > 40
#			proprietario = @stallaoper.prop.prop[0..40] + "..."
#		else
#			proprietario = @stallaoper.prop.prop
#		end
	testodetentore = "Il sottoscritto #{@stallaoper.detentori.detentore} in qualit\xe0 di detentore degli animali dell'azienda sita in"
	#boh2 = foglio.text_width(testo, dimcar) / 2.0
	qvar = qident - dimcar*1.10
	#m2 = x - boh2
	foglio.add_text(z, qvar, testodetentore, dimcar)
	testovia = "#{@stallaoper.stalle.via}  Comune di #{@stallaoper.stalle.comune}  Provincia #{@stallaoper.stalle.provincia}"
	#q3 = q2 -dimcar*1.1
	qvar = qvar -dimcar*1.1
	#m3 = x - boh2
	foglio.add_text(z, qvar, testovia, dimcar)
	testostalla = "Codice IT#{@stallaoper.stalle.cod317}  registrata presso la A.S.L. n. #{@stallaoper.stalle.ulss} di  #{@stallaoper.stalle.citta_ulss}"
	#q4 = q3 -dimcar*1.1
	qvar = qvar -dimcar*1.1
	#m4 = x - boh2
	foglio.add_text(z, qvar, testostalla, dimcar)
	testodichiara = "dichiara che i seguenti animali:"
	#q5 = q4 -dimcar*1.1
	qvar = qvar -dimcar*1.1
	#m5 = x - boh2
	foglio.add_text(z, qvar, testodichiara, dimcar)

	#testoallegato = "SPECIE: BOVINA - VEDI ALLEGATO"
	#q6 = q5 - dimcar-10
	#qvar = qvar -dimcar-10
	#m6 = x - boh2
	#foglio.add_text(z, qvar, testoallegato, 12)

	foglio.pointer = qvar -5
	tabcapi = PDF::SimpleTable.new
	tabcapi.show_lines = :all
	tabcapi.show_headings = true
	tabcapi.orientation = :right
	#tabcapi.position = :left
	tabcapi.position = z+5
	#tabcapi.orientation = :right
	#tabcapi.orientation = :left
	tabcapi.shade_rows = :none
	tabcapi.split_rows = true
	tabcapi.font_size = dimcar
	tabcapi.heading_font_size = dimcar
	tabcapi.width = 550
	tabcapi.row_gap = 1
	#tabcapi.minimum_space = 10
	tabcapi.column_order.push(*%w(specie categoria numero marca))
	tabcapi.columns["specie"] = PDF::SimpleTable::Column.new("specie") { |col|
		col.heading = "Specie"
		#col.width = 160
	}
	tabcapi.columns["categoria"] = PDF::SimpleTable::Column.new("categoria") { |col|
		col.heading = "Categoria"
		#col.width = 130
	}
	tabcapi.columns["numero"] = PDF::SimpleTable::Column.new("numero") { |col|
		col.heading = "Numero"
		#col.width = 130
	}
	tabcapi.columns["marca"] = PDF::SimpleTable::Column.new("marca") { |col|
		col.heading = "Contrassegno di identificazione degli animali o contenitori"
		#col.width = 35
	}
	dati = Array.new
	dati << {"specie" => "BOVINA", "categoria" => " ", "numero" => "#{totcapi} ", "marca" => "VEDI ALLEGATO"}
	tabcapi.data.replace dati
	tabcapi.render_on(foglio)

	testodichiara1 = "Non sono sottoposti al divieto di spostamento, in applicazione delle misure di polizia veterinaria."
	#q7 = q6 - dimcar-10
	qvar = qvar -48
	#m5 = x - boh2
	foglio.add_text(z, qvar, testodichiara1, dimcar)
	testodichiara2 = "Dichiara altres\xec che gli animali sopraccitati sono stati introdotti con regolare documentazione di accompagnamento e provengono da aziende"
	#q8 = q7 -dimcar*1.1
	qvar = qvar -dimcar*1.1
	#m5 = x - boh2
	foglio.add_text(z, qvar, testodichiara2, dimcar)
	testodichiara3 = "identificate dai seguenti codici aziendali ........................................................................................................................................................................."
	#q9 = q8 -dimcar*1.1
	qvar = qvar -dimcar*1.5
	#m5 = x - boh2
	#puts foglio.pointer
	foglio.add_text(z, qvar, testodichiara3, dimcar)
	foglio.rectangle(z-5, qident+(dimcar/2), w, -115).stroke
	foglio.save_state
	foglio.fill_color Color::RGB::White
	foglio.stroke_color Color::RGB::White
	foglio.rectangle(z, qident, 87, 10).fill
	foglio.restore_state
	foglio.add_text(z, qident, testoident, dimcar)

	testomac = "<b>B) DICHIARAZIONE PER IL MACELLO</b>"
	#qmac = q9 - dimcar -20
	qmac = qvar - dimcar -10
	testomac1 = "Dichiara inoltre che gli animali destinati alla macellazione"
	#q10 = qmac - dimcar -5
	qvar = qmac -dimcar*1.1
	foglio.add_text(z, qvar, testomac1, dimcar)
	testomac2 = "  1) [  ] non sono stati trattati o alimentati con sostanze di cui \xe8 vietato l'impiego"
	#q11 = q10 -dimcar*1.1
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac2, dimcar)
	testomac3 = "  2) [  ]  nei 90 giorni precedenti la data odierna          [  ]  dalla nascita"
	#q12 = q11 -dimcar*1.1
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac3, dimcar)
	testomac4 = "    a) [  ] NON SONO STATI           [  ] SONO STATI sottoposti a trattamento con le seguenti sostanze di cui agli art. 4 e 5 del D.l.vo 16.03.2006,"
	#q13 = q12 -dimcar*1.1
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac4, dimcar)
	testomac5 = "      n. 158 e successive modifiche e integrazioni"
	#q14 = q13 -dimcar*1.1
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac5, dimcar)
	testomac6 = "      ..................................................................................................................................................................................................................................."
	#q15 = q14 -dimcar*1.1
	qvar = qvar -dimcar*1.5
	foglio.add_text(z, qvar, testomac6, dimcar)
	
	testomac7 = "    b) [  ] NON SONO STATI           [  ] SONO STATI sottoposti a trattamento con i seguenti alimenti medicamentosi"
	#q16 = q15 -dimcar*1.1
	qvar = qvar -dimcar*1.3
	foglio.add_text(z, qvar, testomac7, dimcar)
	#testomac8 = "      ....................................................................................................................................................................................."
	#q17 = q16 -dimcar*1.1
	qvar = qvar -dimcar*1.5
	foglio.add_text(z, qvar, testomac6, dimcar)
	testomac9 = "    c) [  ] NON SONO STATI           [  ] SONO STATI sottoposti a trattamento con le seguenti specialit\xe0 medicinali"
	#q18 = q17 -dimcar*1.1
	qvar = qvar -dimcar*1.3
	foglio.add_text(z, qvar, testomac9, dimcar)
	#testomac10 = "      .............................................................................................................................................................................................."
	#q19 = q18 -dimcar*1.1
	qvar = qvar -dimcar*1.5
	foglio.add_text(z, qvar, testomac6, dimcar)
	testomac11 = "  3) [  ] Sono stati osservati i previsti tempi di sospensione per i trattamenti con i prodotti di cui al punto 2, nonch\xe9 quelli previsti in seguito alla"
	#q20 = q19 -dimcar*1.1
	qvar = qvar -dimcar*1.3
	foglio.add_text(z, qvar, testomac11, dimcar)
	testomac12 = "    somministrazione di alimenti contenenti premiscele con additivi del gruppo antibiotici, coccidiostatici o altre sostanze medicamentose."
	#q21 = q20 -dimcar*1.1
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac12, dimcar)
#	testomac13 = "    coccidiostatici o altre sostanze medicamentose."
#	#q22 = q21 -dimcar*1.1
#	qvar = qvar -dimcar*1.1
#	foglio.add_text(z, qvar, testomac13, dimcar)
	testomac14 = "  4) [  ] Dichiara inoltre di allegare copia dell'elenco del trattamento recante firma del veterinario o dei veterinari prescrittori come previsto dal"
	#q23 = q22 -dimcar*1.1
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac14, dimcar)
	testomac15 = "    D.l.vo 16.03.2006, n. 158 e dal D.M. 28/05/1992."
	#q24 = q23 -dimcar*1.1
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac15, dimcar)
	testomac16 = "    Dichiara inoltre che gli animali sopraccitati non saranno sottoposti a trattamenti di cui ai punti 1, 2 e 3, nonch\xe9 alla somministrazione di alimenti"
	#q25 = q24 -dimcar*1.1
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac16, dimcar)
	testomac17 = "    contenenti premiscele con additivi del gruppo antibiotici, coccidiostatici o altre sostanze medicamentose."
	#q26 = q25 -dimcar*1.1
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac17, dimcar)
	testomac18 = "  5) Dichiarazione ai sensi del regolamento 853/2004/CE - Allegato 2, sezione 3 (informazioni pertinenti della catena alimentare)"
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac18, dimcar)
	testomac19 = "    Riguardo a:"
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac19, dimcar)
	testomac20 = "    - status sanitario dell'azienda di provenienza o lo status sanitario regionale per quanto riguarda gli animali;"
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac20, dimcar)
	testomac21 = "    - le condizioni di salute degli animali;"
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac21, dimcar)
	testomac22 = "    - le pertinenti relazioni relative alle ispezioni ante e post mortem sugli animali della stessa azienda di provenienza, comprese, in particolare le"
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac22, dimcar)
	testomac23 = "      relazioni del Veterinario Ufficiale;"
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac23, dimcar)
	testomac24 = "    - i dati relativi alla produzione, quando ci\xf2 potrebbe indicare la presenza di una malattia;"
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac24, dimcar)
	testomac25 = "    - presenza di malattie che potrebbero incidere sulla sicurezza delle carni;"
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac25, dimcar)
	testomac26 = "    - presenza di risultati di analisi effettuate sui campioni, compresi quelli prelevati nel quadro del monitoraggio e controllo delle zoonosi e dei"
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac26, dimcar)
	testomac27 = "      residui, prelevati dagli animali o su altri campioni prelevati al fine di diagnosticare malattie che potrebbero incidere sulla sicurezza delle carni;"
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac27, dimcar)
	testomac28 = "    [  ] NON VI SONO           [  ] VI SONO informazioni da riferire come da modello allegato"
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testomac28, dimcar)
	testomac29 = "    Veterinario aziendale (firma e indirizzo) ......................................................................................................................................................................"
	qvar = qvar -dimcar*2
	foglio.add_text(z, qvar, testomac29, dimcar)

	foglio.rectangle(z-5, qmac+(dimcar/2), w, -293).stroke
	foglio.save_state
	foglio.fill_color Color::RGB::White
	foglio.stroke_color Color::RGB::White
	foglio.rectangle(z, qmac, 155, 10).fill
	foglio.restore_state
	foglio.add_text(z, qmac, testomac, dimcar)
	
	testodest = "<b>C) DESTINAZIONE</b>"
	qdest = qvar - dimcar -10
	testodest1 = "Gli animali sono destinati a:"
	#q28 = qdest -dimcar*1.1
	qvar = qdest -dimcar*1.1
	foglio.add_text(z, qvar, testodest1, dimcar)
	if selcapi.cm_usc == 3
		testodest2 = "[X] Allevamento, [  ] Macello, [  ] Mercato o fiera, [  ] Stalla di sosta, [  ] Pascolo, [  ] Altro ............................................................................................."
		coddest = selcapi.allevamenti.cod317
		dendest = selcapi.allevamenti.ragsoc
		indirizzodest = "#{selcapi.allevamenti.via} - #{selcapi.allevamenti.comune} - #{selcapi.allevamenti.provincia}"
	elsif selcapi.cm_usc == 9
		testodest2 = "[  ] Allevamento, [X] Macello, [  ] Mercato o fiera, [  ] Stalla di sosta, [  ] Pascolo, [  ] Altro ............................................................................................."
		coddest = selcapi.macelli.bollomac
		dendest = selcapi.macelli.nomemac
		indirizzodest = "#{selcapi.macelli.via} - #{selcapi.macelli.comune} - #{selcapi.macelli.provincia}"
	elsif selcapi.cm_usc == 28
		testodest2 = "[  ] Allevamento, [  ] Macello, [X] Mercato o fiera, [  ] Stalla di sosta, [  ] Pascolo, [  ] Altro ............................................................................................."
		coddest = selcapi.allevamenti.cod317
		dendest = selcapi.allevamenti.ragsoc
		indirizzodest = "#{selcapi.allevamenti.via} - #{selcapi.allevamenti.comune} - #{selcapi.allevamenti.provincia}" #(i mercati finiscono sotto gli allevamenti)"
	elsif selcapi.cm_usc == 30
		testodest2 = "[  ] Allevamento, [  ] Macello, [  ] Mercato o fiera, [X] Stalla di sosta, [  ] Pascolo, [  ] Altro ............................................................................................."
		coddest = selcapi.allevamenti.cod317
		dendest = selcapi.allevamenti.ragsoc
		indirizzodest = "#{selcapi.allevamenti.via} - #{selcapi.allevamenti.comune} - #{selcapi.allevamenti.provincia}"
	else
		testodest2 = "[  ] Allevamento, [  ] Macello, [  ] Mercato o fiera, [  ] Stalla di sosta, [  ] Pascolo, [X] Altro ............................................................................................."
		coddest = selcapi.allevamenti.cod317
		dendest = selcapi.allevamenti.ragsoc
		indirizzodest = "#{selcapi.allevamenti.via} - #{selcapi.allevamenti.comune} - #{selcapi.allevamenti.provincia}"
	end
	#q29 = q28 -dimcar*1.1
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testodest2, dimcar)
	testodest3 = "Codice: #{coddest}   Denominazione: #{dendest}"
	#q30 = q29 -dimcar*1.1
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testodest3, dimcar)
	testodest4 = "Indirizzo: #{indirizzodest}"
	#q31 = q30 -dimcar*1.1
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testodest4, dimcar)
	testodest5 = "Data: #{selcapi.data_mod4.strftime("%d/%m/%Y")}"
	testodest6 = "Il detentore degli animali ........................................................................"
	#q32 = q31 -dimcar*1.1
	qvar = qvar -dimcar*1.1
	foglio.add_text(z, qvar, testodest5, dimcar)
	foglio.add_text(w-250, qvar, testodest6, dimcar)

	foglio.rectangle(z-5, qdest+(dimcar/2), w, -55).stroke
	foglio.save_state
	foglio.fill_color Color::RGB::White
	foglio.stroke_color Color::RGB::White
	foglio.rectangle(z, qdest, 77, 10).fill
	foglio.restore_state
	foglio.add_text(z, qdest, testodest, dimcar)

	testotrasp = "<b>D) TRASPORTO</b>"
	qtrasp = qvar - dimcar -10
	testotrasp1 = "Il sottoscritto ............................................................................................ sito in .............................................................................................................."
	#q33 = q29 -dimcar*1.1
	qvar = qtrasp -dimcar*1.9
	foglio.add_text(z, qvar, testotrasp1, dimcar)
	testotrasp2 = "Comune di ................................................................................ Prov. .............. conduttore del mezzo di trasporto ......................................................."
	qvar = qvar -dimcar*1.9
	foglio.add_text(z, qvar, testotrasp2, dimcar)
	testotrasp3 = "targato .......................................... garantisce che gli animali suindicati sono trasportati nel rispetto della vigente normativa."
	qvar = qvar -dimcar*1.9
	foglio.add_text(z, qvar, testotrasp3, dimcar)
	testotrasp4 = "Si attesta, inoltre, che il mezzo di trasporto \xe8 stato regolarmente disinfettato (ai sensi dell'art. 64 del D.P.R. 320/54.)"
	qvar = qvar -dimcar*1.9
	foglio.add_text(z, qvar, testotrasp4, dimcar)
	#testotrasp5 = "Data ........................................"
	testotrasp5 = testodest5
	testotrasp6 = "Il trasportatore ........................................................................................"
	qvar = qvar -dimcar*1.9
	foglio.add_text(z, qvar, testotrasp5, dimcar)
	foglio.add_text(w-250, qvar, testotrasp6, dimcar)

	foglio.rectangle(z-5, qtrasp+(dimcar/2), w, -90).stroke
	foglio.save_state
	foglio.fill_color Color::RGB::White
	foglio.stroke_color Color::RGB::White
	foglio.rectangle(z, qtrasp, 67, 10).fill
	foglio.restore_state
	foglio.add_text(z, qtrasp, testotrasp, dimcar)

	testosan = "<b>E) ATTESTAZIONI SANITARIE</b>"
	qsan = qvar - dimcar -12
	testosan1 = "Il sottoscritto dichiara di aver visitato gli animali con esito favorevole in data ................................................................................................................."
	qvar = qsan -dimcar*1.9
	foglio.add_text(z, qvar, testosan1, dimcar)
	testosan2 = "Attesta (*) che dagli atti di questo ufficio, l'azienda di provenienza \xe8 sotto controllo ufficiale con la seguente qualifica sanitaria e che gli animali"
	qvar = qvar -dimcar*1.9
	foglio.add_text(z, qvar, testosan2, dimcar)
	testosan3 = "sopraindicati sono stati sottoposti con esito negativo alle prove diagnostiche per:"
	qvar = qvar -dimcar*1.9
	foglio.add_text(z, qvar, testosan3, dimcar)
	qvar = qvar -dimcar #*1.5
	#puts foglio.y
	#foglio.move_pointer(300)
	foglio.pointer = qvar
	#puts foglio.y
	tabella = PDF::SimpleTable.new
	tabella.show_lines = :all
	tabella.show_headings = true
	tabella.orientation = :right
	#tabella.position = :left
	tabella.position = z+5
	#tabella.orientation = :right
	#tabella.orientation = :left
	tabella.shade_rows = :none
	tabella.split_rows = true
	tabella.font_size = dimcar
	tabella.heading_font_size = dimcar
	tabella.width = 550
	tabella.minimum_space = 10
	tabella.column_order.push(*%w(malattia datacapi dataallev qualifica))
	tabella.columns["malattia"] = PDF::SimpleTable::Column.new("malattia") { |col|
		col.heading = "Malattia"
		col.width = 160
	}
	tabella.columns["datacapi"] = PDF::SimpleTable::Column.new("datacapi") { |col|
		col.heading = "Data controllo capi"
		col.width = 130
	}
	tabella.columns["dataallev"] = PDF::SimpleTable::Column.new("dataallev") { |col|
		col.heading = "Data controllo allevamento"
		col.width = 130
	}
	tabella.columns["qualifica"] = PDF::SimpleTable::Column.new("qualifica") { |col|
		col.heading = "Qualifica allevamento"
		#col.width = 35
	}
	dati = Array.new
	2.times {dati << {"malattia" => " ", "datacapi" => " ", "dataallev" => " ", "qualifica" => " "}}
	tabella.data.replace dati
	tabella.render_on(foglio)

	testosan4 = "(*) tale dichiarazione ha validit\xe0 15 giorni, rinnovabile ai sensi di legge."
	qvar = qvar -dimcar*6.5
	foglio.add_text(z, qvar, testosan4, dimcar)
	testosan5 = "Gli animali suindicati sono stati immunizzati contro .................................................................................................."
	testosan6 = "in data ....................................."
	qvar = qvar -dimcar*1.9
	foglio.add_text(z, qvar, testosan5, dimcar)
	foglio.add_text(w-100, qvar, testosan6, dimcar)
	testosan7 = "[  ] Osservazioni, [  ] Prescrizioni, [  ] Vincolo sanitario ...................................................................................................................................................."
	qvar = qvar -dimcar*1.9
	foglio.add_text(z, qvar, testosan7, dimcar)
	testosan8 = testodest5
	testosan9 = "Il veterinario ufficiale ..............................................................................."
	qvar = qvar -dimcar*1.9
	foglio.add_text(z, qvar, testosan8, dimcar)
	foglio.add_text(w-250, qvar, testosan9, dimcar)

	foglio.rectangle(z-5, qsan+(dimcar/2), w, -170).stroke
	foglio.save_state
	foglio.fill_color Color::RGB::White
	foglio.stroke_color Color::RGB::White
	foglio.rectangle(z, qsan, 123, 10).fill
	foglio.restore_state
	foglio.add_text(z, qsan, testosan, dimcar)

	foglio.save_as("#{@dir}/altro/mod4.pdf")
	if @sistema == "linux"
		system("evince #{@dir}/altro/mod4.pdf")
	else
#		foglio.save_as('.\altro\allegato.pdf')
		@shell.ShellExecute('.\altro\mod4.pdf', '', '', 'open', 3)
	end
end
end
