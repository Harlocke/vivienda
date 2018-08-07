class Fiducia < ActiveRecord::Base
  belongs_to :user
  has_many :fiduciascontratos, :dependent =>:destroy
  has_many :fiduciaspagos, :dependent =>:destroy
  has_many :fiduciasnotas, :dependent =>:destroy
  has_many :fiduciasdocumentos, :dependent =>:destroy

  validates_presence_of :nit, :nombre, :estado, :direccion, :telefono, :contacto

   def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
   end

   def self.search (nombre,nro_fondo,nro_contrato,page)
    if nombre.to_s == "" and nro_fondo.to_s == "" and nro_contrato.to_s == ""
      paginate :per_page => 10, :page => page, :conditions => ["id = '-1'"]
    else
      cadena = ""
      if nombre != ""
        s = nombre.to_s.upcase
        if cadena != ""
          cadena = cadena + ' and upper(nombre) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = ' upper(nombre) like '+ "'%%#{s.to_s}%%'"
        end
      end
      if nro_fondo != ""
        cadena = "id in (select fiducia_id from fiduciascontratos where nro_fondo = '#{nro_fondo.strip}')"
      end
      if nro_contrato != ""
        cadena = "id in (select fiducia_id from fiduciascontratos where nro_contrato = '#{nro_contrato.strip}')"
      end
      logger.error("Cadenaaaaaaaaaaaaa.......  Fondo"+ cadena.to_s)
      paginate :page => page, :conditions => [cadena], :order=>'created_at desc'
    end
  end
end
