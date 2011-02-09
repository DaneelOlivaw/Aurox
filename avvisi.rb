#Avvisi

class Errore
	def initialize(a,e="Servono tutti i dati.", b=Gtk::Dialog::DESTROY_WITH_PARENT, c=Gtk::MessageDialog::WARNING, d=Gtk::MessageDialog::BUTTONS_CLOSE)
		@avviso = Gtk::MessageDialog.new(a,b,c,d,e)
	end
	def avvia
		@avviso.run
		@avviso.destroy
	end
	def self.avviso(a,b)
		Errore.new(a, b).avvia
	end
end

class Conferma
	def initialize(a, e="", b=Gtk::Dialog::DESTROY_WITH_PARENT, c=Gtk::MessageDialog::INFO, d=Gtk::MessageDialog::BUTTONS_OK)
		@conferma = Gtk::MessageDialog.new(a,b,c,d,e)
	end
	def avvia
		@conferma.run
		@conferma.destroy
	end
	def self.conferma(a,b)
		Conferma.new(a, b).avvia
	end
end
