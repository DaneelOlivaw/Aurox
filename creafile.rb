#Creazione del file da inviare all'ULSS

def creafile(finestra)
	nomefile = Time.now.strftime("#{@stallaoper.ragsoc.ragsoc.gsub(/[ ]/, "")}""%m%d_%H%M.asc")
#	if @sistema == "linux"
		fileulss = File.new("#{@dir}/file/#{nomefile}", "w+")
#	else
#		fileulss = File.new(".\\file\\#{nomefile}", "w+")
#	end
	selmov = Animals.find(:all, :from=> "animals", :conditions => ["relaz_id= ? and file= ?", "#{@stallaoper.id}", "0"])

	if selmov.length != 0
		selluncampi = Luncampis.find(:all)
		itercampi = Array.new
		selluncampi.each do |campi|
			itercampi[0] = campi.id
			itercampi[1] = campi.tipo
			itercampi[2] = campi.operazione
			itercampi[3] = campi.cod317
			itercampi[4] = campi.ragsoc
			itercampi[5] = campi.tifragsoc
			itercampi[6] = campi.ifragsoc
			itercampi[7] = campi.atp
			itercampi[8] = campi.prop
			itercampi[9] = campi.tifprop
			itercampi[10] = campi.ifprop
			itercampi[11] = campi.marca
			itercampi[12] = campi.specie
			itercampi[13] = campi.razza
			itercampi[14] = campi.nascita
			itercampi[15] = campi.cod317nascita
			itercampi[16] = campi.sesso
			itercampi[17] = campi.nazorig
			itercampi[18] = campi.nazprimimp
			itercampi[19] = campi.applmarca
			itercampi[20] = campi.ilg
			itercampi[21] = campi.marcaprec
			itercampi[22] = campi.madre
			itercampi[23] = campi.padre
			itercampi[24] = campi.datapass
			itercampi[25] = campi.codmoving
			itercampi[26] = campi.dataing
			itercampi[27] = campi.cod317prov
			itercampi[28] = campi.comuneprov
			itercampi[29] = campi.nazprov
			itercampi[30] = campi.codmovusc
			itercampi[31] = campi.datausc
			itercampi[32] = campi.cod317dest
			itercampi[33] = campi.comunedest
			itercampi[34] = campi.nazdest
			itercampi[35] = campi.ragsocdest
			itercampi[36] = campi.trasportatore
			itercampi[37] = campi.comunetrasp
			itercampi[38] = campi.targatrasp
			itercampi[39] = campi.mod4
			itercampi[40] = campi.marcasost
			itercampi[41] = campi.idfiscall
			itercampi[42] = campi.datamod4
			itercampi[43] = campi.codlibgen
			itercampi[44] = campi.regmac
			itercampi[45] = campi.idfiscmac
			itercampi[46] = campi.bollomac
			itercampi[47] = campi.embryo
			itercampi[48] = campi.idfisc317nasc
			itercampi[49] = campi.dataprimoingr
			itercampi[50] = campi.madreembryotransf
			itercampi[51] = campi.rifloc
			itercampi[52] = campi.certsan
			itercampi[53] = campi.crlf
		end
		itermov = Array.new
		selmov.each do |mov|
			itermov[0] = mov.id
			itermov[1] = mov.relaz_id
			itermov[2] = mov.tipo
			itermov[3] = 0 #mov.movimenti_id
			itermov[4] = mov.marca
			itermov[6] = mov.razza_id
			itermov[8] = mov.specie
			itermov[9] = mov.data_nas
			itermov[10] = mov.stalla_nas
			itermov[11] = mov.naz_nasprimimp
			itermov[12] = mov.naz_orig
			itermov[13] = mov.data_applm
			itermov[14] = mov.ilg
			itermov[15] = mov.clg
			itermov[16] = mov.embryo
			itermov[17] = mov.marca_prec
			itermov[18] = mov.marca_madre
			itermov[19] = mov.marca_padre
			itermov[20] = mov.donatrice
			itermov[22] = mov.sesso
			itermov[23] = mov.cm_ing
			itermov[24] = mov.data_ingr
			if mov.allevamenti_id != nil
				itermov[25] = mov.allevamenti.ragsoc
				itermov[28] = mov.allevamenti.idfisc
				itermov[29] = mov.allevamenti.cod317
			else
				itermov[25] = ""
				itermov[28] = ""
				itermov[29] = ""
			end
			itermov[26] = mov.mod4
			itermov[27] = mov.data_mod4
			itermov[32] = mov.naz_prov
			itermov[34] = mov.cm_usc
			itermov[35] = mov.uscita
			itermov[36] = mov.ditta_racc
			itermov[37] = mov.trasp
			itermov[38] = mov.marcasost
			itermov[39] = mov.certsan
			itermov[40] = mov.rifloc
			itermov[41] = mov.data_certsan
			itermov[44] = mov.naz_dest
#			if mov.allevamentiusc_id != nil
#				itermov[43] = mov.allevamentiusc.cod317
#				itermov[45] = mov.allevamentiusc.ragsoc
#				itermov[47] = mov.allevamentiusc.if
#			else
#				itermov[43] = ""
#				itermov[45] = ""
#				itermov[47] = ""
#			end
			if mov.macelli_id != nil
				itermov[46] = mov.macelli.nomemac
				itermov[48] = mov.macelli.region.codreg
				itermov[49] = mov.macelli.ifmac
				itermov[50] = mov.macelli.bollomac
			else
				itermov[46] = ""
				itermov[48] = ""
				itermov[49] = ""
				itermov[50] = ""
			end
			itermov[51] = mov.uscito
			itermov[52] = mov.certsanusc
			itermov[53] = mov.data_certsanusc
			itermov[54] = mov.file

			#creazione tipofile

			tipofile = itermov[2].ljust(itercampi[1])

			#creazione 317 prop

			file317 = mov.relaz.stalle.cod317.ljust(itercampi[3])

			#creazione ragsoc

			ragsocfile = mov.relaz.ragsoc.ragsoc.ljust(itercampi[4])

			#creazione tipo idfisc ragsoc

			tifragsocfile = mov.relaz.ragsoc.idf.ljust(itercampi[5])

			#creazione idfisc ragsoc
			if mov.relaz.ragsoc.idf == 'I'
				ifragsocfile = mov.relaz.ragsoc.piva.ljust(itercampi[6])
			else
				ifragsocfile = mov.relaz.ragsoc.codfisc.ljust(itercampi[6])
			end
			#ifragsocfile= ifragsoc.ljust(itercampi[6])

			#creazione atp

			atpfile = mov.relaz.atp.ljust(itercampi[7])

			#creazione prop

			propfile = mov.relaz.prop.prop.ljust(itercampi[8])

			#creazione tipo idfisc prop

			tifpropfile = mov.relaz.prop.idf.ljust(itercampi[9])

			#creazione idfisc prop
			if mov.relaz.prop.idf == 'I'
				ifpropfile = mov.relaz.prop.piva.ljust(itercampi[10])
			else
				ifpropfile = mov.relaz.prop.codfisc.ljust(itercampi[10])
			end
			#contaspazi = itercampi[10] - ifprop.to_s.length
			#spaziifprop = " " * contaspazi
			#ifpropfile = "#{ifprop}" + "#{spaziifprop}"

			#ifpropfile = ifprop.ljust(itercampi[10])

			#creazione marca

			marcafile = itermov[4].ljust(itercampi[11])

			#creazione specie

			speciefile = itermov[8].ljust(itercampi[12])

			#Creazione razza
			if itermov[6] != nil
				razzafile = mov.razza.cod_razza.ljust(itercampi[13])
			else
				razzafile = itermov[6].ljust(itercampi[13])
			end

			#creazione data nascita
			if itermov[9] != nil
				datafile = itermov[9].strftime("%d%m%Y").ljust(itercampi[14])
			else
				datafile = "".ljust(itercampi[14])
			end
			#datafile = datait.ljust(itercampi[14])

			#creazione cod. 317 nascita / prima importazione

			file317nas = itermov[10].ljust(itercampi[15])

			#creazione sesso

			sessofile = itermov[22].ljust(itercampi[16])

			#creazione nazione origine

			nazorigfile = itermov[12].ljust(itercampi[17])

			#creazione nazione prima importazione

			nazprimimpfile = itermov[11].ljust(itercampi[18])

			#creazione data applicazione marca
			if itermov[13] != nil
				dataapplmarcafile = itermov[13].strftime("%d%m%Y").ljust(itercampi[19])
			else
				dataapplmarcafile = "".ljust(itercampi[19])
			end

			#dataapplmarcafile = dataapplmarcait.ljust(itercampi[19])

			#creazione ilg

			ilgfile = itermov[14].ljust(itercampi[20])

			#creazione marca precedente
			if itermov[17] != nil
				marcaprecfile = itermov[17].to_s.ljust(itercampi[21])
			else
				marcaprecfile = "".ljust(itercampi[21])
			end
			#creazione marca madre
			if itermov[18] != nil
				madrefile = itermov[18].to_s.ljust(itercampi[22])
			else
				madrefile = "".ljust(itercampi[22])
			end
			#creazione marca padre
			if itermov[19] != nil
				padrefile = itermov[19].to_s.ljust(itercampi[23])
			else
				padrefile = itermov[19].to_s.ljust(itercampi[23])
			end
			#creazione data passaporto (campo non presente nella tabella)

			datapassfile = "".ljust(itercampi[24])

			#creazione codice movimento ingresso

			movingfile = "#{itermov[23]}".ljust(itercampi[25])

			#creazione data ingresso
			if itermov[24] != nil
				dataingfile = itermov[24].strftime("%d%m%Y").ljust(itercampi[26])
			else
				dataingfile = "".ljust(itercampi[26])
			end
			#dataingfile = dataingit.ljust(itercampi[26])

			#creazione cod. 317 provenienza o destinazione
			if itermov[2] == "I"
				file317prov = itermov[29].ljust(itercampi[27])
				file317dest = "".ljust(itercampi[32])
				ragsocdestfile = "".ljust(itercampi[35])
			elsif itermov[2] == "U"
				file317prov = "".ljust(itercampi[27])
				file317dest = itermov[29].ljust(itercampi[32])
				ragsocdestfile = itermov[25].ljust(itercampi[35])
			end
			#creazione comune provenienza (campo non presente nella tabella)

			comunefile = "".ljust(itercampi[28])

			#creazione nazione provenienza

			nazprovfile = "#{itermov[32]}".ljust(itercampi[29])

			#creazione codice movimento uscita

			movuscfile = itermov[34].to_s.ljust(itercampi[30])

			#creazione data uscita
			if itermov[35] != nil
				datauscfile = itermov[35].strftime("%d%m%Y").ljust(itercampi[31])
			else
				datauscfile = "".ljust(itercampi[31])
			end

			#datauscfile = "#{datauscit}".ljust(itercampi[31])

			#creazione codice 317 allevamento destinazione

#			file317dest = itermov[29].ljust(itercampi[32])

			#creazione comune destinazione (campo non presente nella tabella)

			comunedestfile = "".ljust(itercampi[33])

			#creazione nazione destinazione

			nazdestfile = "#{itermov[44]}".ljust(itercampi[34])

			#creazione rag. soc. destinazione

#			ragsocdestfile = itermov[25].ljust(itercampi[35]) #obsoleto

			#creazione trasportatore

			traspfile = "#{itermov[37]}".ljust(itercampi[36])

			#creazione comune trasportatore (campo non presente nella tabella)

			comtraspfile = "".ljust(itercampi[37])

			#creazione targa trasportatore (campo non presente nella tabella)

			targatraspfile = "".ljust(itercampi[38])

			#creazione mod. 4
			if itermov[34] != 4
				mod4file = "#{itermov[26]}".ljust(itercampi[39])
			else
				mod4file = itermov[52].ljust(itercampi[39])
			end

			#creazione marca sostitutiva

			marcasostfile = "#{itermov[38]}".ljust(itercampi[40])

			#creazione identificativo fiscale allevamento provenienza o destinazione

			idfiscallfile = "#{itermov[28]}".ljust(itercampi[41])

			#creazione data mod. 4
			if itermov[27] != nil
				datamod4file = itermov[27].strftime("%d%m%Y").ljust(itercampi[42])
			elsif itermov[53] != nil
				datamod4file = itermov[53].strftime("%d%m%Y").ljust(itercampi[42])
			else
				datamod4file ="".ljust(itercampi[42])
			end

			#datamod4file = datamod4it.ljust(itercampi[42])

			#creazione libro genealogico

			clgfile = "#{itermov[15]}".ljust(itercampi[43])

			#creazione regione macello

			regmacfile = itermov[48].ljust(itercampi[44])

			#creazione identificativo fiscale macello

			idfiscmacfile = itermov[49].ljust(itercampi[45])

			#creazione bollo CEE macello

			bollomacfile = itermov[50].ljust(itercampi[46])

			#creazione embryo transfer

			embryofile = "#{itermov[16]}".ljust(itercampi[47])

			#creazione identificativo fiscale stalla di nascita o prima importazione
			#ATTENZIONE: creare tabella con scelta allevamenti anche qua.

			ifragsocnasfile = "".ljust(itercampi[48])

			#creazione data primo ingresso (campo non presente nella tabella)

			primoingrfile = "".ljust(itercampi[49])

			#creazione madre donatrice

			donatricefile = "#{itermov[20]}".ljust(itercampi[50])

			#creazione riferimento locale

			riflocfile = "#{itermov[40]}".ljust(itercampi[51])

			#creazione certificato sanitario

			certsanfile = "#{itermov[39]}".ljust(itercampi[52])

			fileulss.puts("RC" + "#{tipofile}" + "I" + "#{file317}" + "#{ragsocfile}" + "#{tifragsocfile}" + "#{ifragsocfile}" + "#{atpfile}" + "#{propfile}" + "#{tifpropfile}" + "#{ifpropfile}" + "#{marcafile}" + "#{speciefile}" + "#{razzafile}" + "#{datafile}" + "#{file317nas}" + "#{sessofile}" + "#{nazorigfile}" + "#{nazprimimpfile}" + "#{dataapplmarcafile}" + "#{ilgfile}" + "#{marcaprecfile}" + "#{madrefile}" + "#{padrefile}" + "#{datapassfile}" + "#{movingfile}" +"#{dataingfile}" + "#{file317prov}" + "#{comunefile}" + "#{nazprovfile}" + "#{movuscfile}" + "#{datauscfile}" + "#{file317dest}" + "#{comunedestfile}" + "#{nazdestfile}" + "#{ragsocdestfile}" + "#{traspfile}" + "#{comtraspfile}" + "#{targatraspfile}" + "#{mod4file}" + "#{marcasostfile}" + "#{idfiscallfile}" + "#{datamod4file}" + "#{clgfile}" + "#{regmacfile}" + "#{idfiscmacfile}" + "#{bollomacfile}" + "#{embryofile}" + "#{ifragsocnasfile}" + "#{primoingrfile}" + "#{donatricefile}" + "#{riflocfile}" + "#{certsanfile}")
			Animals.update(itermov[0], {:file => "1"})
		end

		filler1 = "".ljust(441)
		filler2 = "".ljust(94)

		fileulss.rewind
		righe = fileulss.readlines.length + 1
		righefile = "#{righe}".ljust(6)
		fileulss.write("RCT" + "#{filler1}" + "#{righefile}")
		fileulss.rewind
		checksum = 0
		fileulss.each_byte do |ch|
			checksum+=ch
		end
		checksumfile = "#{checksum}".ljust(12)
		fileulss.puts("#{checksumfile}" + "#{filler2}")
		fileulss.puts("")
		fileulss.close

#		if @sistema == "linux"
			Dir.foreach("#{@dir}/invio") do |f|
				File.delete("#{@dir}/invio/#{f}") if f.include?(".asc")
			end
			File.copy("#{@dir}/file/#{nomefile}", "#{@dir}/invio")
#		else
#			Dir.foreach(".\\invio") do |f|
#				File.delete(".\\invio\\#{f}") if f.include?(".asc")
#			end
#			File.copy(".\\file\\#{nomefile}", ".\\invio")
#		end

		Conferma.conferma(finestra, "File generato correttamente.")
	else
		Conferma.conferma(finestra, "Nessun capo da inviare.")
	end
end
