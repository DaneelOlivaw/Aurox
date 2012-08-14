# Ricerca capi per giorni di permanenza

def ricercapermanenza
	require 'stampapresgiorni'
	mvisperm = Gtk::Window.new("Ricerca capi per giorni di permanenza")
	#mvisperm.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	mvisperm.set_default_size(800, 600)
	mvisperm.maximize
	mvispermscroll = Gtk::ScrolledWindow.new #(hadjustment = nil, vadjustment = nil)
	boxvisp = Gtk::VBox.new(false, 0)
	boxvisp1 = Gtk::HBox.new(false, 0)
	boxvisp2 = Gtk::HBox.new(false, 0)
	boxvisp3 = Gtk::HBox.new(false, 0)
	boxvisp.pack_start(boxvisp1, false, false, 5)
	boxvisp.pack_start(boxvisp2, false, false, 5)
	boxvisp.pack_start(boxvisp3, true, true, 5)
	mvisperm.add(boxvisp)
	selperm = 0
	giornipres = 0
	def ricercaperm(selperm, listaperm, labelcontoperm, valtipo)
		selperm.each do |m|
			iterreg = listaperm.append
			iterreg[0] = m.id.to_i
			iterreg[1] = m.progressivo
			iterreg[2] = m.marca
			iterreg[3] = m.razza
			iterreg[4] = m.sesso
			iterreg[5] = m.madre
			iterreg[6] = m.tipoingresso
			iterreg[7] = m.datanascita.strftime("%d/%m/%Y")
			iterreg[8] = m.dataingresso.strftime("%d/%m/%Y")
			#puts m.dataingresso.strftime("%d/%m/%Y")
			#puts (Time.parse("#{@giorno.strftime("%Y-%m-%d")}") - Time.parse("#{m.dataingresso.strftime("%Y-%m-%d")}")) / 86400
			#puts ((Time.parse("#{@giorno.strftime("%Y-%m-%d")}") - Time.parse("#{m.dataingresso.strftime("%Y-%m-%d")}")) / 86400).to_i
			iterreg[9] = m.provenienza
			iterreg[10] = m.mod4ingr
			iterreg[11] = m.certsaningr
			iterreg[12] = m.ragsoc
			if valtipo == "presenti"
				#iterreg[13] = ((Time.parse("#{@giorno}") - Time.parse("#{m.dataingresso}")) / 86400).to_i
				#iterreg[13] = (Time.parse("#{@giorno}") - Time.parse("#{m.dataingresso}")).to_i.to_day
				#puts @giorno.class
				#puts m.dataingresso.class
				iterreg[13] = @giorno.to_date - m.dataingresso
			else
				iterreg[13] = m.datauscita - m.dataingresso
			end
			iterreg[14] = m.datauscita.strftime("%d/%m/%Y") if m.datauscita != nil
			#puts iterreg[13]
		end
		labelcontoperm.text = ("Movimenti trovati: #{selperm.length}")
	end

	labeltipocapi = Gtk::Label.new("Seleziona i capi interessati:")
	boxvisp1.pack_start(labeltipocapi, false, false, 5)
	tipo1 = Gtk::RadioButton.new("Presenti")
	tipo1.active=(true)
	valtipo="presenti"
	tipo1.signal_connect("toggled") {
		if tipo1.active?
			valtipo="presenti"
		end
	}
	boxvisp1.pack_start(tipo1, false, false, 5)
	tipo2 = Gtk::RadioButton.new(tipo1, "Usciti l'anno: ")
	tipo2.signal_connect("toggled") {
		if tipo2.active?
			valtipo="usciti"
		end
	}
	boxvisp1.pack_start(tipo2, false, false, 5)

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
	#labelanno = Gtk::Label.new("Seleziona l'anno:")
	#boxvisp1.pack_start(labelanno, false, false, 5)
	boxvisp1.pack_start(comboanno, false, false, 0)



	trova210 = Gtk::Button.new( "210 giorni" )
#	reguscite = Gtk::Button.new( "Visualizza uscite" )
#	regpresenti = Gtk::Button.new( "Visualizza presenti in stalla" )
	altrigiorni = Gtk::Button.new( "giorni: " )
	altrigiornientry = Gtk::Entry.new
	labelcontoperm = Gtk::Label.new("Movimenti trovati: 0")
	listaperm = Gtk::ListStore.new(Integer, String, String, String, String, String, String, String, String, String, String, String, String, Integer, String)
	vistaperm = Gtk::TreeView.new(listaperm)
#	vistaperm.selection.mode = Gtk::SELECTION_SINGLE #BROWSE #SINGLE #MULTIPLE
#	vistaperm.show_expanders = (true)
#	vistaperm.rules_hint = true
#	vistaperm.set_enable_grid_lines(true)
	trova210.signal_connect("clicked") {
		listaperm.clear
		giornipres = 210
		if valtipo == "presenti"
			giorno = Time.parse("#{@giorno.strftime("%Y-%m-%d")}") - 210.day
			#puts giorno
			#puts giorno.to_date
			#selperm = Registros.find(:all, :conditions => ["relaz_id= ? and tipouscita IS NULL and dataingresso <= ?", "#{@stallaoper.id}", "#{giorno.strftime("%Y-%m-%d")}"])
			selperm = Registros.find(:all, :conditions => ["relaz_id= ? and tipouscita IS NULL and dataingresso <= ?", "#{@stallaoper.id}", "#{giorno.to_date}"])
		else
			selperm = Registros.find(:all, :select => "*, DATEDIFF(datauscita,dataingresso) as perman", :conditions => ["relaz_id= ? and YEAR(datauscita) = ? and DATEDIFF(datauscita,dataingresso) >= ?", "#{@stallaoper.id}", "#{comboanno.active_iter[0]}", "#{giornipres}"]) #, :order => "perman DESC")
			#selperm.each do |s|
				#puts "#{s.marca} - #{(s.datauscita - s.dataingresso)}" #.to_i #/86400
				#puts ((Time.parse("#{s.datauscita}") - Time.parse("#{s.dataingresso}")) / 86400).to_i
				#puts s.class
			#end
			#puts selperm.length
		end
		#puts selperm.length
		ricercaperm(selperm, listaperm, labelcontoperm, valtipo)
	}
#	reguscite.signal_connect("clicked") {
#		listaperm.clear
#		selperm = Registros.find(:all, :conditions => ["relaz_id= ? and tipouscita IS NOT NULL", "#{@stallaoper.id}"], :order => "datauscita, id")
#		#selperm = Registros.find(:all, :conditions => ["relaz_id= ? and tipouscita != ?", "#{@stallaoper.id}", "NULL"], :order => "datauscita, id")
#		ricercaperm(selperm, listaperm, labelcontoperm)
#	}

#	regpresenti.signal_connect("clicked") {
#		listaperm.clear
#		selperm = Registros.find(:all, :from => 'registros', :conditions => ["relaz_id= ? and tipouscita IS NULL", "#{@stallaoper.id}"]) # and uscito='0'")
#		ricercaperm(selperm, listaperm, labelcontoperm)
#	}
	altrigiorni.signal_connect("clicked") {
		listaperm.clear
		giornipres = altrigiornientry.text
#		giornolibero1 = Time.parse("#{@giorno.strftime("%Y-%m-%d")}") - altrigiornientry.text.to_i*86400
#		puts giornolibero1
		if valtipo == "presenti"
			giornolibero = Time.parse("#{@giorno.strftime("%Y-%m-%d")}") - altrigiornientry.text.to_i.day
			#puts giornolibero
			#selperm = Registros.find(:all, :conditions => "relaz_id='#{@stallaoper.id}' and marca LIKE '%#{altrigiornientry.text}%'")
			#ActiveRecord::Base.logger = Logger.new(STDOUT)
			selperm = Registros.find(:all, :conditions => ["relaz_id= ? and tipouscita IS NULL and dataingresso <= ?", "#{@stallaoper.id}", "#{giornolibero.strftime("%Y-%m-%d")}"])
			#Registros.find(:all, :conditions => "relaz_id='#{@stallaoper.id}' and marca LIKE '%#{altrigiornientry.text}%'").to_sql
		else
			#selperm = Registros.find(:all, :conditions => ["relaz_id= ? and YEAR(datauscita) = ? and (datauscita - dataingresso)*86400 >= ?", "#{@stallaoper.id}", "#{comboanno.active_iter[0]}", "#{giornipres}"])
#PERIOD_SUB(200501,200210)
			selperm = Registros.find(:all, :select => "*, DATEDIFF(datauscita,dataingresso) as perman", :conditions => ["relaz_id= ? and YEAR(datauscita) = ? and DATEDIFF(datauscita,dataingresso) >= ?", "#{@stallaoper.id}", "#{comboanno.active_iter[0]}", giornipres]) #, :order => "perman DESC")


			selperm.each do |s|
				#puts "#{s.marca} - #{(s.datauscita - s.dataingresso)}" #.to_i #/86400
				#puts "#{s.marca} - #{s.perman.class}"
			end
#			puts selperm.length
		end
		#puts selperm.length
		ricercaperm(selperm, listaperm, labelcontoperm, valtipo)
	}
		cella = Gtk::CellRendererText.new
#		colonna0 = Gtk::TreeViewColumn.new("Id", cella)
#		colonna0.resizable = true
		colonna1 = Gtk::TreeViewColumn.new("Progressivo", cella)
		colonna1.resizable = true
		colonna2 = Gtk::TreeViewColumn.new("Marca", cella)
		colonna2.resizable = true
		colonna3 = Gtk::TreeViewColumn.new("Razza", cella)
		colonna4 = Gtk::TreeViewColumn.new("Sesso", cella)
		colonna5 = Gtk::TreeViewColumn.new("Madre", cella)
		colonna5.resizable = true
		colonna6 = Gtk::TreeViewColumn.new("Tipo ingresso", cella)
		colonna7 = Gtk::TreeViewColumn.new("Data di nascita", cella)
		colonna8 = Gtk::TreeViewColumn.new("Data ingresso", cella)
		colonna9 = Gtk::TreeViewColumn.new("Provenienza", cella)
		colonna10 = Gtk::TreeViewColumn.new("Mod. 4 ingresso", cella)
		colonna11 = Gtk::TreeViewColumn.new("Cert. san. ingresso", cella)
		colonna12 = Gtk::TreeViewColumn.new("Ragione sociale", cella)
		colonna13 = Gtk::TreeViewColumn.new("Giorni permanenza", cella)
		colonna14 = Gtk::TreeViewColumn.new("Uscita", cella)
#		colonna0.set_attributes(cella, :text => 0)
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
#		vistaperm.append_column(colonna0)
		vistaperm.append_column(colonna1)
		vistaperm.append_column(colonna2)
		vistaperm.append_column(colonna3)
		vistaperm.append_column(colonna4)
		vistaperm.append_column(colonna5)
		vistaperm.append_column(colonna6)
		vistaperm.append_column(colonna7)
		vistaperm.append_column(colonna8)
		vistaperm.append_column(colonna9)
		vistaperm.append_column(colonna10)
		vistaperm.append_column(colonna11)
		vistaperm.append_column(colonna12)
		vistaperm.append_column(colonna13)
		vistaperm.append_column(colonna14)
	mvispermscroll.add(vistaperm)
	boxvisp3.pack_start(mvispermscroll, true, true, 0)
	boxvisp2.pack_start(trova210, false, false, 0)
#	boxvisp2.pack_start(reguscite, false, false, 0)
#	boxvisp2.pack_start(regpresenti, false, false, 0)
	boxvisp2.pack_start(altrigiorni, false, false, 5)
	boxvisp2.pack_start(altrigiornientry, false, false, 0)
	boxvisp2.pack_start(labelcontoperm, false, false, 5)
	bottstampa = Gtk::Button.new( "Stampa" )
	bottstampa.signal_connect("clicked") {
		stampapresgiorni(selperm, giornipres, selperm.length, valtipo)
	}
	boxvisp.pack_start(bottstampa, false, false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mvisperm.destroy
	}
	boxvisp.pack_start(bottchiudi, false, false, 0)
	mvisperm.show_all
end
