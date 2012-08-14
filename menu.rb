def createMenuBar(finestra, listacombo, combo, combo2, combodet, combo3)

	topmen = Gtk::MenuItem.new( "Visualizza" )
	menu = Gtk::Menu.new
#	menu2 = Gtk::Menu.new
	item = Gtk::MenuItem.new( "Movimenti" )
	item.signal_connect("activate") {
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			#puts stalla.ragsoc.ragsoc
			vismovimenti
		end
	}
	menu.append( item )
	item = Gtk::MenuItem.new( "Registro" )
	item.signal_connect("activate") { 
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			visregistro
		end
	}
	menu.append( item )
		item = Gtk::MenuItem.new( "Richerca per data su registro" )
	item.signal_connect("activate") { 
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			ricercagenerica
		end
	}
	menu.append( item )

	item = Gtk::MenuItem.new( "Richerca capi per permanenza" )
	item.signal_connect("activate") { 
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			ricercapermanenza
		end
	}
	menu.append( item )

	item = Gtk::MenuItem.new( "Richerca capi presenti il giorno" )
	item.signal_connect("activate") { 
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			ricercapresenti
		end
	}
	menu.append( item )

	topmen.set_submenu( menu )

	modifica = Gtk::MenuItem.new( "Modifica" )
	menumod = Gtk::Menu.new
	itemmod = Gtk::MenuItem.new( "Allevamenti" )
	itemmod.signal_connect("activate") { modallevamenti }
	menumod.append( itemmod )
	itemmod = Gtk::MenuItem.new( "Macelli" )
	itemmod.signal_connect("activate") {modmacelli}
	menumod.append( itemmod )
	itemmod = Gtk::MenuItem.new( "Trasportatori" )
	itemmod.signal_connect("activate") {modtrasportatori}
	menumod.append( itemmod )
	separatore = Gtk::SeparatorMenuItem.new
	menumod.append( separatore )
	itemmod = Gtk::MenuItem.new( "Ragioni sociali" )
	itemmod.signal_connect("activate") {modragsoc}
	menumod.append( itemmod )
	itemmod = Gtk::MenuItem.new( "Detentori" )
	itemmod.signal_connect("activate") {moddetentori}
	menumod.append( itemmod )
	itemmod = Gtk::MenuItem.new( "Proprietari" )
	itemmod.signal_connect("activate") {modprop}
	menumod.append( itemmod )
	itemmod = Gtk::MenuItem.new( "Dati allevamento" )
	itemmod.signal_connect("activate") {
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			moddatiallevam
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
			reinvio
		end
	}
	menumod.append( itemmod )
	itemmod = Gtk::MenuItem.new( "Partite in ingresso" )
	itemmod.signal_connect("activate") {
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			modpartitaingresso
		end
	}
	menumod.append( itemmod )
	itemmod = Gtk::MenuItem.new( "Partite in uscita" )
	itemmod.signal_connect("activate") {
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			modpartitauscita
		end
	}
	menumod.append( itemmod )

	modifica.set_submenu( menumod )

	prova = Gtk::MenuItem.new( "Inserimento" )
	menuprova = Gtk::Menu.new
	itemprova = Gtk::MenuItem.new("Allevamenti")
	itemprova.signal_connect("activate") {mascallevam(nil)}
	menuprova.append(itemprova)
	itemprova = Gtk::MenuItem.new("Macelli")
	itemprova.signal_connect("activate") {insmacelli(nil)}
	menuprova.append(itemprova)
	itemprova = Gtk::MenuItem.new("Trasportatori")
	itemprova.signal_connect("activate") {instrasportatori(nil)}
	menuprova.append( itemprova )
	separatore = Gtk::SeparatorMenuItem.new
	menuprova.append( separatore )
	itemprova = Gtk::MenuItem.new("Codice stalla")
	itemprova.signal_connect("activate") {inscodstalla(finestra, listacombo)}
	menuprova.append( itemprova )
	itemprova = Gtk::MenuItem.new("Ragioni sociali")
	itemprova.signal_connect("activate") {crearagsoc(finestra)}
	menuprova.append( itemprova )
	itemprova = Gtk::MenuItem.new("Detentori")
	itemprova.signal_connect("activate") {creadet(finestra)}
	menuprova.append( itemprova )
	itemprova = Gtk::MenuItem.new("Proprietari")
	itemprova.signal_connect("activate") {creaprop(finestra)}
	menuprova.append( itemprova )
	separatore = Gtk::SeparatorMenuItem.new
	menuprova.append( separatore )
	itemprova = Gtk::MenuItem.new("Crea una stalla")
	itemprova.signal_connect("activate") {creastalla}
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
			mascregnonvidim
		end
	}
	menustampe.append(itemstampe)
	itemstampe = Gtk::MenuItem.new("Presenti in stalla")
	itemstampe.signal_connect("activate") {
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			stampapres(finestra)
			#stampapresmov(finestra)
		end
	}
	menustampe.append(itemstampe)
	itemstampe = Gtk::MenuItem.new("Allegato MOD. 4")
	itemstampe.signal_connect("activate") {
		if combo.active == -1 or combo2.active == -1 or combodet.active == -1 or combo3.active == -1
			Errore.avviso(finestra, "Seleziona una stalla, una ragione sociale, un detentore ed un proprietario.")
		else
			mascallmod4
		end
	}
	menustampe.append(itemstampe)
	stampe.set_submenu( menustampe )

	strumenti = Gtk::MenuItem.new( "Strumenti" )
	menustrum = Gtk::Menu.new
	itemstrum = Gtk::MenuItem.new("Esporta database")
		itemstrum.signal_connect("activate") {
			mascesportadb
		}
	menustrum.append(itemstrum)
	itemstrum = Gtk::MenuItem.new("Importa database")
		itemstrum.signal_connect("activate") {
			selezionadb(finestra)
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
