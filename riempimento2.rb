#def riempimento2(selmov, lista, labelconto, datainizio, datafine)
def riempimento2(selreg, listareg, labelcontoreg, datainizio, datafine, disordine)
#	puts @giorno
#	puts @giorno.class
#	puts @giorno.to_i
	#array = Array.new
	#hash = Hash.new
	selreg.each do |m|
		b = Hash.new(0)
		#puts m.datanascita.strftime("%s")
		iterreg = listareg.append
		iterreg[0] = m.id.to_i
		iterreg[1] = m.progressivo
		iterreg[2] = m.marca
		iterreg[3] = m.razza
		iterreg[4] = m.sesso
		iterreg[5] = m.madre
		iterreg[6] = m.tipoingresso
		iterreg[7] = m.datanascita.strftime("%d/%m/%Y")
		iterreg[8] = m.dataingresso.strftime("%d/%m/%Y")
		iterreg[9] = m.provenienza
		iterreg[10] = m.tipouscita
		if m.datauscita != nil
			iterreg[11] = m.datauscita.strftime("%d/%m/%Y")
		else
			iterreg[11] = ""
		end
		iterreg[12] = m.destinazione
		iterreg[13] = m.marcaprec
		iterreg[14] = m.mod4ingr
		iterreg[15] = m.mod4usc
		iterreg[16] = m.certsaningr
		iterreg[17] = m.certsanusc
		iterreg[18] = m.ragsoc
		iterreg[19] = m.datanascita.strftime("%s")
		#b = {"id" => iterreg[0], "prog" => iterreg[1], "marca" => iterreg[2], "nascita" => iterreg[7], "nascitaepoch" => m.datanascita.strftime("%s")}
		#array << b
		disordine << {"id" => iterreg[0], "prog" => iterreg[1], "marca" => iterreg[2], "razza" => iterreg[3], "sesso" => iterreg[4], "madre" => iterreg[5], "tipoingresso"=> iterreg[6],  "datanascita" => iterreg[7], "dataingresso" => iterreg[8], "provenienza" => iterreg[9], "tipouscita" => iterreg[10], "datauscita" => iterreg[11], "destinazione" => iterreg[12], "marcaprec" => iterreg[13], "mod4ingr" => iterreg[14], "mod4usc" => iterreg[15], "certsaningr" => iterreg[16], "certsanusc" => iterreg[17], "ragsoc" => iterreg[18], "nascitaepoch" => m.datanascita.strftime("%s")}
	end
	#puts array.inspect
#	arr2 = Array.new
#	arr2 = array.sort_by { |hsh| hsh["nascitaepoch"] }.reverse!
#	puts arr2.inspect
	labelcontoreg.text = ("Movimenti trovati dal #{datainizio} al #{datafine}: #{selreg.length}")
end
