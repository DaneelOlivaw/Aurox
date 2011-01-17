#Richiesta numero capi da inserire

def masccontaingr
	mcontaingr = Gtk::Window.new("")
	mcontaingr.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxcontaingrv = Gtk::VBox.new(false, 0)
	boxcontaingr1 = Gtk::HBox.new(false, 5)
	boxcontaingr2 = Gtk::HBox.new(false, 5)
	boxcontaingr3 = Gtk::HBox.new(false, 5)
	boxcontaingrv.pack_start(boxcontaingr1, false, false, 5)
	boxcontaingrv.pack_start(boxcontaingr2, false, false, 5)
	boxcontaingrv.pack_start(boxcontaingr3, false, false, 5)
	mcontaingr.add(boxcontaingrv)

	labelingr = Gtk::Label.new("Numero di capi da inserire:")
	boxcontaingr1.pack_start(labelingr, false, false, 5)
	numeroingr = Gtk::Entry.new
	boxcontaingr1.pack_start(numeroingr, false, false, 5)

	numeroingr.signal_connect("activate") {
		@containgressi = numeroingr.text.to_i
		mcontaingr.destroy
		inscapo
	}

	bottmov = Gtk::Button.new( "OK" )
	boxcontaingr1.pack_start(bottmov, false, false, 5)

	bottmov.signal_connect( "clicked" ) {
		@containgressi = numeroingr.text.to_i
		mcontaingr.destroy
		inscapo
	}
	mcontaingr.show_all
end
