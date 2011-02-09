def mascimportadb(selezione)

	mimportadb = Gtk::Window.new("Importazione database")
	mimportadb.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boximportadbv = Gtk::VBox.new(false, 0)
	boximportadb1 = Gtk::HBox.new(false, 5)
	boximportadb2 = Gtk::HBox.new(false, 5)
	boximportadb3 = Gtk::HBox.new(false, 5)
	boximportadbv.pack_start(boximportadb1, false, false, 5)
	boximportadbv.pack_start(boximportadb2, false, false, 5)
	boximportadbv.pack_start(boximportadb3, false, false, 5)
	mimportadb.add(boximportadbv)

	labelpass = Gtk::Label.new("Password di amministratore:")
	boximportadb1.pack_start(labelpass, false, false, 5)
	password2 = Gtk::Entry.new
	password2.visibility = false
	boximportadb1.pack_start(password2, false, false, 5)

	bottesp = Gtk::Button.new( "OK" )
	boximportadb1.pack_start(bottesp, false, false, 5)

	password2.signal_connect("activate") {
		importadb(mimportadb, password2, selezione)
	}

	bottesp.signal_connect( "clicked" ) {
		importadb(mimportadb, password2, selezione)
	}

	mimportadb.show_all

end

def importadb(mimportadb, password2, selezione)
	if password2.text == ""
		Errore.avviso(mimportadb, "Password sbagliata")
	else
		nomecopia = Time.now.strftime('aurox_%y%m%d%H%M')
		if @sistema == "linux"
#			puts Dir.pwd
			`mysqldump -u root -p"#{password2.text}" aurox > #{@dir}/esportadb/#{nomecopia}`
			`mysqladmin -u root -p"#{password2.text}" create "#{nomecopia}"`
			`mysql "#{nomecopia}" < #{@dir}/esportadb/#{nomecopia} -u root -p"#{password2.text}" 2>&1`
			#`rm ./esportadb/#{nomecopia}`
			File.delete("#{@dir}/esportadb/#{nomecopia}")
#			comando = `mysql aurox < "#{@selezione.filename}" -u root -p'#{password2.text}' 2>&1`
		else
#			Dir.chdir("../esportadb")
#			directory = Dir.pwd
			dir = @dir.tr('\/',  '\\')
			selez = selezione.filename.tr('\/',  '\\')
#			`mysqldump -u root -p"#{password2.text}" aurox > "#{directory}"/"#{nomecopia}"`
#			`mysqladmin -u root -p"#{password2.text}" create "#{nomecopia}"`
#			`mysql "#{nomecopia}" < "#{directory}"/"#{nomecopia}" -u root -p"#{password2.text}" 2>&1`
			`mysqldump -u root -p"#{password2.text}" aurox > "#{dir}\\esportadb\\#{nomecopia}"`
			`mysqladmin -u root -p"#{password2.text}" create "#{nomecopia}"`
			`mysql "#{nomecopia}" < #{dir}\\esportadb\\#{nomecopia} -u root -p"#{password2.text}" 2>&1`
			File.delete("#{dir}\\esportadb\\#{nomecopia}")
#			File.delete("#{directory}"/"#{nomecopia}")
##			comando = `mysql aurox < "#{@selezione.filename}" -u root -p"#{password2.text}" 2>&1`
		end
		comando = `mysql aurox < "#{selezione.filename}" -u root -p"#{password2.text}" 2>&1`
		#puts comando
		#puts $?
		if $? != 0
#			puts "sbagliato"
			Errore.avviso(mimportadb, "Errore")
			password2.text = ""
		else
			Conferma.conferma(mimportadb, "Database importato correttamente")
#			puts "giusto"
			password2.text = ""
			mimportadb.destroy
			selezione.destroy
		end
	end
end
