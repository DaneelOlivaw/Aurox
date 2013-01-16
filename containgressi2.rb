#Richiesta numero capi da inserire

def masccontaingr2
	mcontaingr2 = Gtk::Window.new("")
	mcontaingr2.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxcontaingrv = Gtk::VBox.new(false, 0)
	boxcontaingr1 = Gtk::HBox.new(false, 5)
	boxcontaingr2 = Gtk::HBox.new(false, 5)
	boxcontaingr3 = Gtk::HBox.new(false, 5)
	boxcontaingrv.pack_start(boxcontaingr1, false, false, 5)
	boxcontaingrv.pack_start(boxcontaingr2, false, false, 5)
	boxcontaingrv.pack_start(boxcontaingr3, false, false, 5)
	mcontaingr2.add(boxcontaingrv)

	labelingr = Gtk::Label.new("Numero di capi da inserire:")
	boxcontaingr1.pack_start(labelingr, false, false, 5)
	numeroingr = Gtk::Entry.new
	boxcontaingr1.pack_start(numeroingr, false, false, 5)

#	numeroingr.signal_connect("activate") {
#		containgressi = numeroingr.text.to_i
#		mcontaingr2.destroy
#		#inscapo
#	}

	#Motivo ingresso

	labelmotivoi = Gtk::Label.new("Motivo ingresso:")
	boxcontaingr2.pack_start(labelmotivoi, false, false, 5)
	listaing = Gtk::ListStore.new(Integer, String)
	#comboing = Gtk::ComboBox.new
	controlloingr = Hash.new
	seling = Ingressos.find(:all)
	seling.each do |ing|
		iteri = listaing.append
		iteri[0] = ing.codice
		iteri[1] = ing.descr
		controlloingr.merge!("#{ing.codice}" => ing.descr)
	end
	#puts controlloingr.inspect
#	comboing = Gtk::ComboBox.new(listaing)
#	rendering = Gtk::CellRendererText.new
#	comboing.pack_start(rendering,false)
#	comboing.set_attributes(rendering, :text => 1)
#	rendering = Gtk::CellRendererText.new
#	rendering.visible=(false)
#	comboing.pack_start(rendering,false)
#	comboing.set_attributes(rendering, :text => 0)
	motivoingr = Gtk::Entry.new
	motivoingr.width_chars=(45)
	complet = Gtk::EntryCompletion.new
	complet.model=(listaing)
	renderer1 = Gtk::CellRendererText.new
	complet.pack_start(renderer1,false)
	complet.set_text_column(1)
	complet.inline_completion=(true)
	if @sistema == "linux"
		complet.inline_selection=(true)
	end
	complet.minimum_key_length=(0)
	motivoingr.completion=(complet)

	boxcontaingr2.pack_start(motivoingr, false, false, 5)
	
	
	
	

	bottmov = Gtk::Button.new( "OK" )
	boxcontaingr3.pack_start(bottmov, false, false, 5)

	bottmov.signal_connect( "clicked" ) {
		#containgressi = numeroingr.text.to_i
		#puts controlloingr.inspect
		if controlloingr.has_value?("#{motivoingr.text.upcase}")
			ingressoid = controlloingr.index("#{motivoingr.text.upcase}")
			#puts ingressoid
			if ingressoid.to_i == 1
	#			puts "nascita"
				#nnaz = "IT"
				require 'mascnascita2'
				mascnascita2(mcontaingr2, numeroingr.text.to_i, ingressoid)
				#mascnascita2.active
				#mcontaingr2.destroy
			elsif ingressoid.to_i == 13 or ingressoid.to_i == 32
	#			puts "prima importazione"
				#nnaz = combonaznas.active_iter[2]
				require 'ingrprimaimp2'
				mascprimimp2(mcontaingr2, numeroingr.text.to_i, ingressoid)
			else
	#			puts "altro"
				#nnaz = "IT"
				require 'ingrgenerica2'
				mascingrgenerica2(mcontaingr2, numeroingr.text.to_i, ingressoid)
			end
		else
			Errore.avviso(mcontaingr2, "Il movimento non è classificato.")
			#errore = 1
			ingressoid = 0
			#puts "razza inesistente"
		end
#		if motivoingr.active_iter[0] == 1
##			puts "nascita"
#			#nnaz = "IT"
#			require 'mascnascita2'
#			mascnascita2(mcontaingr2, numeroingr.text.to_i, motivoingr.active_iter[0])
#			#mascnascita2.active
#			#mcontaingr2.destroy
#		elsif motivoingr.active_iter[0] == 13 or comboing.active_iter[0] == 32
##			puts "prima importazione"
#			#nnaz = combonaznas.active_iter[2]
#			require 'ingrprimaimp2'
#			mascprimimp2(mcontaingr2, numeroingr.text.to_i, motivoingr.active_iter[0])
#		else
##			puts "altro"
#			#nnaz = "IT"
#			require 'ingrgenerica2'
#			mascingrgenerica2(mcontaingr2, numeroingr.text.to_i, motivoingr.active_iter[0])
#		end
		#mcontaingr2.destroy
		#inscapo
	}
	mcontaingr2.show_all
end
