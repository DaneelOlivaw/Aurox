#Importa database

require 'importadatabase'

def selezionadb(finestra)

	selezione = Gtk::FileChooserDialog.new("Seleziona il file da importare", finestra, Gtk::FileChooser::ACTION_OPEN, nil, [Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL], [Gtk::Stock::OPEN, Gtk::Dialog::RESPONSE_ACCEPT])
#	if @sistema == "linux"
#		selezione.current_folder=("./importadb")
#	else
		#Dir.chdir("./importadb")
		#directory = @dir + "/importadb"
		#puts directory
		selezione.current_folder=("#{@dir}/importadb")
#	end
	filtro = Gtk::FileFilter.new
	filtro.add_pattern("*.sql")
	selezione.filter=(filtro)
	if selezione.run == Gtk::Dialog::RESPONSE_ACCEPT
		#puts "filename = #{selezione.filename}"
		mascimportadb(selezione)
	end
	#selezione.destroy
end
