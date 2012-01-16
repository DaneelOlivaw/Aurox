#Esporta database

def mascesportadb

	mesportadb = Gtk::Window.new("Esportazione database")
	mesportadb.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxesportadbv = Gtk::VBox.new(false, 0)
	boxesportadb1 = Gtk::HBox.new(false, 5)
	boxesportadb2 = Gtk::HBox.new(false, 5)
	boxesportadb3 = Gtk::HBox.new(false, 5)
	boxesportadbv.pack_start(boxesportadb1, false, false, 5)
	boxesportadbv.pack_start(boxesportadb2, false, false, 5)
	boxesportadbv.pack_start(boxesportadb3, false, false, 5)
	mesportadb.add(boxesportadbv)

	labelpass = Gtk::Label.new("Password di amministratore:")
	boxesportadb1.pack_start(labelpass, false, false, 5)
	password = Gtk::Entry.new
	password.visibility = false
	boxesportadb1.pack_start(password, false, false, 5)

	bottesp = Gtk::Button.new( "OK" )
	boxesportadb1.pack_start(bottesp, false, false, 5)

	password.signal_connect("activate") {
		esportadb(mesportadb, password)
	}

	bottesp.signal_connect( "clicked" ) {
		esportadb(mesportadb, password)
	}

	mesportadb.show_all

end

def esportadb(mesportadb, password)
	if password.text == ""
		Errore.avviso(mesportadb, "Password sbagliata")
	else
		#system("mysqldump -u root -p'#{password.text}' aurox > ./esportadb/aurox.sql 2> errore.txt")
		#comando = `mysqldump -u root -p'#{password.text}' aurox > ./esportadb/aurox.sql 2>&1`
		if @sistema == "linux"
#			comando = `mysqldump -u root -p'#{password.text}' aurox > ./esportadb/#{Time.now.strftime('aurox_%H%M%d%m%y.sql')} 2>&1`
			comando = `mysqldump -u root -p"#{password.text}" aurox > #{@dir}/esportadb/#{Time.now.strftime("aurox_%Y%m%d%H%M.sql")} 2>&1`
		else
			comando = `mysqldump -u root -p"#{password.text}" aurox > .\\esportadb\\#{Time.now.strftime("aurox_%Y%m%d%H%M.sql")} 2>&1`
#			comando = `mysqldump -u root -p"#{password.text}" aurox > #{@dir}\\esportadb\\#{Time.now.strftime("aurox_%H%M%d%m%y.sql")} 2>&1`
		end
#		puts comando
#		puts $?
		if $? != 0
#			puts "sbagliato"
			Errore.avviso(mesportadb, "Errore nell'esportazione")
			password.text = ""
		else
			Conferma.conferma(mesportadb, "Database esportato correttamente")
			password.text = ""
			mesportadb.destroy
		end
	end
end
