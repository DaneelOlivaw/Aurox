# Visualizza registro

def visregistro
	mvisreg = Gtk::Window.new("Vista registro")
	#mvisreg.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	mvisreg.set_default_size(800, 600)
	mvisreg.maximize
	mvisregscroll = Gtk::ScrolledWindow.new #(hadjustment = nil, vadjustment = nil)
	boxregv = Gtk::VBox.new(false, 0)
	boxreg1 = Gtk::HBox.new(false, 0)
	boxreg2 = Gtk::HBox.new(false, 0)
	boxregv.pack_start(boxreg1, false, false, 5)
	boxregv.pack_start(boxreg2, true, true, 5)
	mvisreg.add(boxregv)

	def ricercareg(selreg, listareg, labelcontoreg)
		selreg.each do |m|
			iterreg = listareg.append
			iterreg[0] = m.id.to_i
			iterreg[1] = m.progressivo
			iterreg[2] = m.marca
			iterreg[3] = m.razza
			iterreg[4] = m.sesso
			iterreg[5] = m.madre
			iterreg[6] = m.tipoingresso
			iterreg[7] = m.datanascita.strftime("%d/%m/%Y")
			iterreg[8] = m.dataingresso.strftime("%d/%m/%Y")
			iterreg[9] = m.provenienza
			iterreg[10] = m.tipouscita
			if m.datauscita != nil
				iterreg[11] = m.datauscita.strftime("%d/%m/%Y")
			else
				iterreg[11] = ""
			end
			iterreg[12] = m.destinazione
			iterreg[13] = m.marcaprec
			iterreg[14] = m.mod4ingr
			iterreg[15] = m.mod4usc
			iterreg[16] = m.certsaningr
			iterreg[17] = m.certsanusc
			iterreg[18] = m.ragsoc
		end
		labelcontoreg.text = ("Movimenti trovati: #{selreg.length}")
	end

	regingressi = Gtk::Button.new( "Visualizza ingressi" )
	reguscite = Gtk::Button.new( "Visualizza uscite" )
	regpresenti = Gtk::Button.new( "Visualizza presenti in stalla" )
	regricerca = Gtk::Button.new( "Cerca capo" )
	regricercaentry = Gtk::Entry.new
	labelcontoreg = Gtk::Label.new("Movimenti trovati: 0")
	listareg = Gtk::ListStore.new(Integer, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String)
	vistareg = Gtk::TreeView.new(listareg)
	vistareg.selection.mode = Gtk::SELECTION_SINGLE #BROWSE #SINGLE #MULTIPLE
#	vistareg.show_expanders = (true)
	vistareg.rules_hint = true
#	vistareg.set_enable_grid_lines(true)
	regingressi.signal_connect("clicked") {
		listareg.clear
		selreg = Registros.find(:all, :conditions => ["relaz_id= ?", "#{@stallaoper.id}"])
		ricercareg(selreg, listareg, labelcontoreg)
	}
	reguscite.signal_connect("clicked") {
		listareg.clear
		selreg = Registros.find(:all, :conditions => ["relaz_id= ? and tipouscita IS NOT NULL", "#{@stallaoper.id}"], :order => "datauscita, id")
		#selreg = Registros.find(:all, :conditions => ["relaz_id= ? and tipouscita != ?", "#{@stallaoper.id}", "NULL"], :order => "datauscita, id")
		ricercareg(selreg, listareg, labelcontoreg)
	}

	regpresenti.signal_connect("clicked") {
		listareg.clear
		selreg = Registros.find(:all, :from => 'registros', :conditions => ["relaz_id= ? and tipouscita IS NULL", "#{@stallaoper.id}"]) # and uscito='0'")
		ricercareg(selreg, listareg, labelcontoreg)
	}
	regricerca.signal_connect("clicked") {
		listareg.clear
		#selreg = Registros.find(:all, :conditions => "relaz_id='#{@stallaoper.id}' and marca LIKE '%#{regricercaentry.text}%'")
		#ActiveRecord::Base.logger = Logger.new(STDOUT)
		selreg = Registros.find(:all, :conditions => ["relaz_id= ? and marca LIKE ?", "#{@stallaoper.id}", "%#{regricercaentry.text}%"])
		#Registros.find(:all, :conditions => "relaz_id='#{@stallaoper.id}' and marca LIKE '%#{regricercaentry.text}%'").to_sql
		ricercareg(selreg, listareg, labelcontoreg)
	}
		cella = Gtk::CellRendererText.new
		colonna0 = Gtk::TreeViewColumn.new("Id", cella)
		colonna0.resizable = true
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
		colonna10 = Gtk::TreeViewColumn.new("Tipo uscita", cella)
		colonna11 = Gtk::TreeViewColumn.new("Data uscita", cella)
		colonna12 = Gtk::TreeViewColumn.new("Destinazione", cella)
		colonna13 = Gtk::TreeViewColumn.new("Marca precedente", cella)
		colonna14 = Gtk::TreeViewColumn.new("Mod. 4 ingresso", cella)
		colonna15 = Gtk::TreeViewColumn.new("Mod. 4 uscita", cella)
		colonna16 = Gtk::TreeViewColumn.new("Cert. san. ingresso", cella)
		colonna17 = Gtk::TreeViewColumn.new("Cert. san. uscita", cella)
		colonna18 = Gtk::TreeViewColumn.new("Ragione sociale", cella)
		colonna0.set_attributes(cella, :text => 0)
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
		colonna15.set_attributes(cella, :text => 15)
		colonna16.set_attributes(cella, :text => 16)
		colonna17.set_attributes(cella, :text => 17)
		colonna18.set_attributes(cella, :text => 18)
		vistareg.append_column(colonna0)
		vistareg.append_column(colonna1)
		vistareg.append_column(colonna2)
		vistareg.append_column(colonna3)
		vistareg.append_column(colonna4)
		vistareg.append_column(colonna5)
		vistareg.append_column(colonna6)
		vistareg.append_column(colonna7)
		vistareg.append_column(colonna8)
		vistareg.append_column(colonna9)
		vistareg.append_column(colonna10)
		vistareg.append_column(colonna11)
		vistareg.append_column(colonna12)
		vistareg.append_column(colonna13)
		vistareg.append_column(colonna14)
		vistareg.append_column(colonna15)
		vistareg.append_column(colonna16)
		vistareg.append_column(colonna17)
		vistareg.append_column(colonna18)
	mvisregscroll.add(vistareg)
	boxreg2.pack_start(mvisregscroll, true, true, 0)
	boxreg1.pack_start(regingressi, false, false, 0)
	boxreg1.pack_start(reguscite, false, false, 0)
	boxreg1.pack_start(regpresenti, false, false, 0)
	boxreg1.pack_start(regricerca, false, false, 5)
	boxreg1.pack_start(regricercaentry, false, false, 0)
	boxreg1.pack_start(labelcontoreg, false, false, 5)
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mvisreg.destroy
	}
	boxregv.pack_start(bottchiudi, false, false, 0)
	mvisreg.show_all
end
