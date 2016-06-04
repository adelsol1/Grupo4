class Boletum < ActiveRecord::Base
    
    def self.crearBoleta(sku, cantidad, direccion, monto)
        monto = monto
        boleta=Request.crear_boleta(Factura.getIdPropio, direccion, monto)
        boletafinal = Boletum.new(proveedor: Factura.getIdPropio, direccion: direccion, monto: monto, idboleta: boleta['_id'], cantidad: cantidad, sku: sku) 
        boletafinal.save
        boletaid = boleta['_id']
        url = getUrl(boletaid)
        url
    end

    def self.getUrl(boletaId)
        if Rails.env == 'development'
            url = "http://integracion-2016-dev.herokuapp.com/web/pagoenlinea?callbackUrl=http%3A%2F%2Flocalhost%3A3000%2Fexito&cancelUrl=http%3A%2F%2Flocalhost%3A3000%2Ffalla&boletaId="+boletaId
        else
            url = "http://integracion-2016-prod.herokuapp.com/web/pagoenlinea?callbackUrl=http%3A%2F%2Fintegra4.ing.puc.cl%2Fexito&cancelUrl=http%3A%2F%2Fintegra4.ing.puc.cl%2Ffalla&boletaId="+boletaId
        end
        url
    end
    
end
