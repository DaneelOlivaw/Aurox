def menu(finestra, listacombo, combo, combo2, combodet, combo3)

	topmen = Gtk::MenuItem.new( "Visualizza" )
	menu = Gtk::Menu.new
#	menu2 = Gtk::Menu.new
	item = Gtk::MenuItem.new( "Movimenti" )
	item.signal_connect("activate") {
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			#puts stalla.ragsoc.ragsoc
			require 'vismovimenti'
			vismovimenti
		end
	}
	menu.append( item )
	item = Gtk::MenuItem.new( "Registro" )
	item.signal_connect("activate") { 
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			require 'visregistro'
			visregistro
		end
	}
	menu.append( item )
		item = Gtk::MenuItem.new( "Richerca per data su registro" )
	item.signal_connect("activate") { 
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			require 'ricercadata'
			ricercadata
		end
	}
	menu.append( item )

	item = Gtk::MenuItem.new( "Richerca capi per permanenza" )
	item.signal_connect("activate") { 
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			require 'ricercapermanenza'
			ricercapermanenza
		end
	}
	menu.append( item )

	item = Gtk::MenuItem.new( "Richerca capi presenti il giorno" )
	item.signal_connect("activate") { 
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			require 'ricercapresenti'
			ricercapresenti
		end
	}
	menu.append( item )

	topmen.set_submenu( menu )

	modifica = Gtk::MenuItem.new( "Modifica" )
	menumod = Gtk::Menu.new
	itemmod = Gtk::MenuItem.new( "Allevamenti" )
	itemmod.signal_connect("activate") {
		require 'modificaallevamento'
		modificaallevamento(nil)
	}
	menumod.append( itemmod )
	itemmod = Gtk::MenuItem.new( "Macelli" )
	itemmod.signal_connect("activate") {
		require 'modificamacello'
		modificamacello(nil)
	}
	menumod.append( itemmod )
	itemmod = Gtk::MenuItem.new( "Trasportatori" )
	itemmod.signal_connect("activate") {
		require 'modificatrasportatore'
		modificatrasportatore
	}
	menumod.append( itemmod )
	separatore = Gtk::SeparatorMenuItem.new
	menumod.append( separatore )
	itemmod = Gtk::MenuItem.new( "Ragioni sociali" )
	itemmod.signal_connect("activate") {
		require 'modificaragsoc'
		modificaragsoc
	}
	menumod.append( itemmod )
	itemmod = Gtk::MenuItem.new( "Detentori" )
	itemmod.signal_connect("activate") {
		require 'modificadetentore'
		modificadetentore
	}
	menumod.append( itemmod )
	itemmod = Gtk::MenuItem.new( "Proprietari" )
	itemmod.signal_connect("activate") {
		require 'modificaproprietario'
		modificaproprietario
	}
	menumod.append( itemmod )
	itemmod = Gtk::MenuItem.new( "Stalle" )
	itemmod.signal_connect("activate") {
		require 'modificadatistalle'
		modificadatistalle
	}
	menumod.append( itemmod )
	itemmod = Gtk::MenuItem.new( "Dati allevamento" )
	itemmod.signal_connect("activate") {
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			require 'modificadatiallev'
			modificadatiallev
		end
	}
	menumod.append( itemmod )

	separatore = Gtk::SeparatorMenuItem.new
	menumod.append( separatore )
	itemmod = Gtk::MenuItem.new( "Reinvio capi" )
	itemmod.signal_connect("activate") {
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			require 'reinviocapi'
			reinviocapi
		end
	}
	menumod.append( itemmod )
	itemmod = Gtk::MenuItem.new( "Partite in ingresso" )
	itemmod.signal_connect("activate") {
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			require 'modpartitaingresso'
			modpartitaingresso
		end
	}
	menumod.append( itemmod )
	itemmod = Gtk::MenuItem.new( "Partite in uscita" )
	itemmod.signal_connect("activate") {
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			require 'modpartitauscita'
			modpartitauscita
		end
	}
	menumod.append( itemmod )

	modifica.set_submenu( menumod )

	prova = Gtk::MenuItem.new( "Inserimento" )
	menuprova = Gtk::Menu.new
	itemprova = Gtk::MenuItem.new("Allevamenti")
	itemprova.signal_connect("activate") {
		require 'nuovoallevamento'
		nuovoallevamento(nil)
	}
	menuprova.append(itemprova)
	itemprova = Gtk::MenuItem.new("Macelli")
	itemprova.signal_connect("activate") {
		require 'nuovomacello'
		nuovomacello(nil)
	}
	menuprova.append(itemprova)
	itemprova = Gtk::MenuItem.new("Trasportatori")
	itemprova.signal_connect("activate") {
		require 'nuovotrasportatore'
		nuovotrasportatore(nil)
	}
	menuprova.append( itemprova )
	separatore = Gtk::SeparatorMenuItem.new
	menuprova.append( separatore )
	itemprova = Gtk::MenuItem.new("Codice stalla")
	itemprova.signal_connect("activate") {
		require 'nuovocodstalla'
		nuovocodstalla(finestra, listacombo)
	}
	menuprova.append( itemprova )
	itemprova = Gtk::MenuItem.new("Ragioni sociali")
	itemprova.signal_connect("activate") {
		require 'nuovaragsoc'
		nuovaragsoc(finestra)
	}
	menuprova.append( itemprova )
	itemprova = Gtk::MenuItem.new("Detentori")
	itemprova.signal_connect("activate") {
		require 'nuovodetentore'
		nuovodetentore(finestra)
	}
	menuprova.append( itemprova )
	itemprova = Gtk::MenuItem.new("Proprietari")
	itemprova.signal_connect("activate") {
		require 'nuovoproprietario'
		nuovoproprietario(finestra)
	}
	menuprova.append( itemprova )
	separatore = Gtk::SeparatorMenuItem.new
	menuprova.append( separatore )
	itemprova = Gtk::MenuItem.new("Crea una stalla")
	itemprova.signal_connect("activate") {
		require 'nuovastalla'
		nuovastalla
	}
	menuprova.append( itemprova )
	prova.set_submenu( menuprova )

	stampe = Gtk::MenuItem.new( "Altre stampe" )
	menustampe = Gtk::Menu.new
	itemstampe = Gtk::MenuItem.new("Registro non vidimato")
		itemstampe.signal_connect("activate") {
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			#stalla = Relazs.find(:first, :conditions => "id='#{@stallaoper}'")
			require 'stamparegnonvidim'
			stamparegnonvidim
		end
	}
	menustampe.append(itemstampe)
	itemstampe = Gtk::MenuItem.new("Presenti in stalla")
	itemstampe.signal_connect("activate") {
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			require 'stampapresenti'
			stampapresenti(finestra)
			#stampapresmov(finestra)
		end
	}
	menustampe.append(itemstampe)
	itemstampe = Gtk::MenuItem.new("Modello 4 e allegato")
	itemstampe.signal_connect("activate") {
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			require 'stampaallegatomod4'
			stampaallegatomod4
		end
	}
	menustampe.append(itemstampe)
	itemstampe = Gtk::MenuItem.new("Ristampa pagine vidimate")
	itemstampe.signal_connect("activate") {
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			#puts "Stampa pagine vidimate"
			require 'ristampavidimati'
			ristampavidimati
		end
	}
	menustampe.append(itemstampe)
	itemstampe = Gtk::MenuItem.new("Partita/documento")
	itemstampe.signal_connect("activate") {
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			#puts "Stampa partita"
			require 'sceltapartita'
			sceltapartita
		end
	}
	menustampe.append(itemstampe)
	stampe.set_submenu( menustampe )

	strumenti = Gtk::MenuItem.new( "Strumenti" )
	menustrum = Gtk::Menu.new
	itemstrum = Gtk::MenuItem.new("Esporta database")
		itemstrum.signal_connect("activate") {
			require 'esportadatabase'
			esportadatabase
		}
	menustrum.append(itemstrum)
	itemstrum = Gtk::MenuItem.new("Importa database")
		itemstrum.signal_connect("activate") {
			require 'selezionadatabase'
			selezionadatabase(finestra)
		}
	menustrum.append(itemstrum)
	strumenti.set_submenu( menustrum )

	menubar = Gtk::MenuBar.new
	menubar.append( topmen )
	menubar.append( modifica )
	menubar.append( prova )
	menubar.append( stampe )
	menubar.append( strumenti )
	return menubar
end
