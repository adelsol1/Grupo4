class Controlador < ActiveRecord::Base

	#A este metodo le llega un id de orden de compra desde pedidos
	def self.procesar_oc(id)
		#primero se crea, con el id, la orden
		@oc = Request.getOC(id)[0]
		#luego se debe revisar el stock, sumando todos los almacenes
		sku = @oc['sku'].to_i
		cantidadDespachada = @oc['cantidadDespachada'].to_i
		cantidad = @oc['cantidad'].to_i
		total = Almacen.getSkusTotal(sku).to_i

	end

	def self.facturaFicticio(idOC)
		#ESTO GATILLA TODO EL PROCESO FICTICIO
		#Primero se recepciona orden de compra
		response = Request.receive_orden(idOC)
		#Obtenemos orden de compra
		oc = Request.getOC(idOC)
		#Generamos la factura
		factura = Request.emitir_factura(idOC)
		#Si la factura ya existe, obtenemos nil
		idFactura = ""
		if factura == nil
			#idFactura = oc.idfactura
		else
			idFactura = factura._id
		end
		#Ya tenemos la factura -> Transaccion
	end


	def self.getStock(id)
		#se debe revisar el stock, sumando todos los almacenes
		total = Almacen.getSkusTotal(id).to_i
	end

	def self.validarTrx(id)
		transaccion = Request.obtener_transaccion(id)
	end


	def self.facturar(idCliente, idFactura)
		grupo = getGrupo(idCliente)
		if grupo != 0
			#Ahora simplemente debemos enviar la ruta correspondiente
			#Delegamos el request a la clase request
			ruta = "http://integra" + grupo.to_s + ".ing.puc.cl/api/facturas/recibir/" + idFactura.to_s
			Request.enviarFactura(ruta, idFactura)
		end
	end


	def self.getGrupo(id)
		retornar = 0
		array_grupos
		@array_grupos.each do |g|
			if g['id']==id
				retornar = g['grupo']
			end
		end
		retornar
	end



	def self.array_grupos
    @array_grupos = [
        {id: "571262b8a980ba030058ab4f", grupo: 1},
        {id: "571262b8a980ba030058ab50", grupo: 2},
        {id: "571262b8a980ba030058ab51", grupo: 3},
        {id: "571262b8a980ba030058ab53", grupo: 5},
        {id: "571262b8a980ba030058ab54", grupo: 6},
        {id: "571262b8a980ba030058ab55", grupo: 7},
        {id: "571262b8a980ba030058ab56", grupo: 8},
        {id: "", grupo: 9 },
        {id: "571262b8a980ba030058ab58", grupo: 10},
        {id: "571262b8a980ba030058ab59", grupo: 11},
        {id: "571262b8a980ba030058ab5a", grupo: 12}
      ]
  end

end
