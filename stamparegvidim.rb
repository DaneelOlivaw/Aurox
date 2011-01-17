# Maschera stampa registro vidimato

def mascstamparegistro
	mstamparegistro = Gtk::Window.new("Stampa registro")
	mstamparegistro.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxsregv = Gtk::VBox.new(false, 0)
	boxsreg1 = Gtk::HButtonBox.new #(false, 5)
	boxsreg2 = Gtk::HButtonBox.new #(false, 5)
	boxsreg3 = Gtk::HBox.new(false, 5)
#	boxsreg4 = Gtk::HBox.new(false, 5)
#	boxsreg5 = Gtk::HBox.new(false, 5)
#	boxsreg6 = Gtk::HBox.new(false, 5)
#	boxsreg7 = Gtk::HBox.new(false, 5)
#	boxsreg8 = Gtk::HBox.new(false, 5)
#	boxsreg9 = Gtk::HBox.new(false, 5)
#	boxsreg10 = Gtk::HBox.new(false, 5)
	boxsregv.pack_start(boxsreg1, false, false, 5)
	boxsregv.pack_start(boxsreg2, false, false, 5)
	boxsregv.pack_start(boxsreg3, false, false, 5)
#	boxsregv.pack_start(boxsreg4, false, false, 5)
#	boxsregv.pack_start(boxsreg5, false, false, 5)
#	boxsregv.pack_start(boxsreg6, false, false, 5)
#	boxsregv.pack_start(boxsreg7, false, false, 5)
#	boxsregv.pack_start(boxsreg8, false, false, 5)
#	boxsregv.pack_start(boxsreg9, false, false, 5)
#	boxsregv.pack_start(boxsreg10, false, false, 5)
	mstamparegistro.add(boxsregv)
	stampaingr = Gtk::Button.new("Stampa registro di carico")
	boxsreg1.pack_start(stampaingr, false, false, 5)
	stampausc = Gtk::Button.new("Stampa registro di scarico")
	boxsreg2.pack_start(stampausc, false, false, 5)
	stampanuovo = Gtk::Button.new("Stampa registro nuovo")
	boxsreg3.pack_start(stampanuovo, false, false, 5)
	stampaingr.signal_connect("clicked") {
		registroingr(mstamparegistro)
	}
	stampausc.signal_connect("clicked") {
		registrousc(mstamparegistro)
	}
	stampanuovo.signal_connect("clicked") {
		registronuovo(mstamparegistro)
	}
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mstamparegistro.destroy
	}
	boxsregv.pack_start(bottchiudi, false, false, 0)
	mstamparegistro.show_all
end
