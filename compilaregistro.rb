# Compilazione registro

def compilaregistro(finestra)
	#contid = @stallaoper.contatori.id
	nprog = @stallaoper.contatori.progreg.split('/')
	#anno = "#{@giorno.strftime("%y")[0,2]} + #{nprog[1]}".to_i
	anno = Time.parse("#{nprog[1]}").strftime("%Y")[0,2] + nprog[1]
	#puts anno
	#puts @giorno.strftime("%Y")
	if anno.to_i < @giorno.strftime("%Y").to_i # and Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and registro= ? and YEAR(data_ingr)= ?", "#{@stallaoper.id}", "I", "0", "#{anno}"]).length != 0 or compusc = Animals.find(:all, :conditions => ["relaz_id= ? and tipo= ? and registro= ? and YEAR(uscita)= ?", "#{@stallaoper.id}", "U", "0", "#{anno}"]).length != 0
		#puts "prima condizione"
		avviso = Gtk::MessageDialog.new(finestra, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Attenzione: ci sono ancora movimenti dell\'anno #{anno}. Si ricorda che prima di passare alla gestione dei dati del #{@giorno.strftime("%Y")} non dovranno esserci movimenti di ingresso dell'anno precedente. Proseguo?")
		risposta = avviso.run
		avviso.destroy
		if risposta == Gtk::Dialog::RESPONSE_YES
			compingr = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and registro= ? and YEAR(data_ingr)= ?", "#{@stallaoper.id}", "I", "0", "#{anno}"])
			compusc = Animals.find(:all, :conditions => ["relaz_id= ? and tipo= ? and registro= ? and YEAR(uscita)= ?", "#{@stallaoper.id}", "U", "0", "#{anno}"])
			compilazione(finestra, compingr, compusc, nprog[0].to_i, nprog[1].to_i)
		else
			Conferma.conferma(finestra, "Operazione annullata.")
		end
	elsif anno < @giorno.strftime("%Y") and Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and registro= ? and YEAR(data_ingr)= ?", "#{@stallaoper.id}", "I", "0", "#{@giorno.strftime("%Y")}"]).length != 0 or compusc = Animals.find(:all, :conditions => ["relaz_id= ? and tipo= ? and registro= ? and YEAR(uscita)= ?", "#{@stallaoper.id}", "U", "0", "#{@giorno.strftime("%Y")}"]).length != 0
		#puts "seconda condizione"
		compingr = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and registro= ?", "#{@stallaoper.id}", "I", "0"])
		compusc = Animals.find(:all, :conditions => ["relaz_id= ? and tipo= ? and registro= ?", "#{@stallaoper.id}", "U", "0"])
		compilazione(finestra, compingr, compusc, 0, @giorno.strftime("%y"))
	elsif anno == @giorno.strftime("%Y")
		#puts "terza condizione"
		compingr = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and registro= ?", "#{@stallaoper.id}", "I", "0"])
		compusc = Animals.find(:all, :conditions => ["relaz_id= ? and tipo= ? and registro= ?", "#{@stallaoper.id}", "U", "0"])
		compilazione(finestra, compingr, compusc, nprog[0].to_i, nprog[1].to_i)
	end

=begin
	compingr = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and tipo= ? and registro= ? and YEAR(data_ingr)= ?", "#{@stallaoper.id}", "I", "0", "#{anno}"])
	compusc = Animals.find(:all, :conditions => ["relaz_id= ? and tipo= ? and registro= ?", "#{@stallaoper.id}", "U", "0"])
	if "#{compingr}" == "" and "#{compusc}" == ""
		Conferma.conferma(finestra, "Nessun capo da spostare nel registro.")
	else
		if "#{compingr}" != ""
		arrayreg = Array.new
		contid = @stallaoper.contatori.id
		nprog = @stallaoper.contatori.progreg.split('/')
		prog1 = nprog[0].to_i
		anno = @giorno.strftime("%y")
		annoreg = 0
#		if nprog[1].to_i == anno.to_i
#			annoreg = nprog[1]
#		else
#			prog1 = 0
#			annoreg = anno.to_i
#		end
		compingr.each do |iter|
			arrayreg[0] = iter.id
			arrayreg[1] = iter.marca
			arrayreg[2] = iter.razza.cod_razza
			arrayreg[3] = iter.sesso
			arrayreg[4] = iter.marca_madre
			if iter.cm_ing == 1
				arrayreg[5] = "N"
			elsif iter.cm_ing == 19
				arrayreg[5] = "C"
			else
				arrayreg[5] = "A"
			end
			arrayreg[6] = iter.data_nas
			arrayreg[7] = iter.data_ingr
			#puts Time.parse("#{iter.data_ingr}").strftime("%y")
			if nprog[1].to_i == Time.parse("#{iter.data_ingr}").strftime("%y").to_i
				#puts "uguali"
				annoreg = nprog[1]
			else
				#puts "diversi"
				@stallaoper.contatori.progreg = "0/{#iter.data_ingr}"
				prog1 = 0
				annoreg = Time.parse("#{iter.data_ingr}").strftime("%y")
			end
			if iter.cm_ing == 2 or iter.cm_ing == 1 or iter.cm_ing == 19 or iter.cm_ing == 24 or iter.cm_ing == 25 or iter.cm_ing == 26
				arrayreg[8] = iter.allevamenti.cod317
			elsif iter.cm_ing == 13 or iter.cm_ing == 23 or iter.cm_ing == 32
				if iter.certsan != "" or iter.certsan != nil
					arrayreg[8] = iter.certsan
				else
					arrayreg[8] = iter.rifloc
				end
			end
			arrayreg[9] = iter.mod4
			arrayreg[10] = iter.certsan
			arrayreg[11] = iter.relaz.ragsoc.ragsoc
			arrayreg[12] = iter.relaz_id
			prog1 += 1
			puts prog1
			#Registros.create(:progressivo => "#{prog1}/#{annoreg}", :marca => "#{arrayreg[1]}", :razza => "#{arrayreg[2]}", :sesso => "#{arrayreg[3]}", :madre => "#{arrayreg[4]}", :tipoingresso => "#{arrayreg[5]}", :datanascita => "#{arrayreg[6]}", :dataingresso => "#{arrayreg[7]}", :provenienza => "#{arrayreg[8]}", :mod4ingr => "#{arrayreg[9]}", :certsaningr => "#{arrayreg[10]}", :ragsoc => "#{arrayreg[11]}", :relaz_id => "#{arrayreg[12]}", :contatori_id => "#{contid}")
			#Animals.update(arrayreg[0], { :registro => "1"})
		end
		puts annoreg
		#Contatoris.update(@stallaoper.contatori.id, { :progreg => "#{prog1}/#{annoreg}"})
		end
		if "#{compusc}" != ""
		arrayusc = Array.new
		compusc.each do |iterusc|
			arrayusc[0] = iterusc.id
			arrayusc[1] = iterusc.marca
			if iterusc.cm_usc == 4
				arrayusc[2] = "M"
			elsif iterusc.cm_usc == 6
				arrayusc[2] = "F"
			elsif iterusc.cm_usc == 20
				arrayusc[2] = "C"
			else
				arrayusc[2] = "V"
			end
			arrayusc[3] = iterusc.uscita
			if iterusc.cm_usc == 4 or iterusc.cm_usc == 6 or iterusc.cm_usc == 10 or iterusc.cm_usc == 11
				arrayusc[4] = ""
			elsif iterusc.cm_usc == 9
				arrayusc[4] = iterusc.macelli.nomemac
			else
				arrayusc[4] = iterusc.allevamenti.cod317
			end
			arrayusc[5] = iterusc.mod4
			arrayusc[6] = iterusc.certsanusc
			Registros.update_all({:tipouscita => "#{arrayusc[2]}", :datauscita => "#{arrayusc[3]}", :destinazione => "#{arrayusc[4]}", :mod4usc => "#{arrayusc[5]}", :certsanusc => "#{arrayusc[6]}"}, "marca = '#{arrayusc[1]}'")
			Animals.update(arrayusc[0], { :registro => "1"})
		end
		end
		Conferma.conferma(finestra, "Registro compilato correttamente.")
	end
=end

end
