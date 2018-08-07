class Catastros2017dato < ActiveRecord::Base
  belongs_to :persona
  
  validates_presence_of :codcomuna, :matricula, :codbarrio, :manzana, :cbml, :cedcat, :tipopropietario, :nombre, :apellidos, :identificacion, :direccionencasillada

  def self.search (matricula,cbml,identificacion,page)
    if matricula.to_s =="" and cbml.to_s == "" and identificacion.to_s == ""
      paginate :per_page => 10, :page => page, :conditions => ["id = '-1'"]
    else
      cadena = ""
      if matricula != ""
        if cadena != ""
          cadena = cadena + "and matricula = '#{matricula.to_s}'"
        else
          cadena = "matricula = '#{matricula.to_s}'"
        end
      end
      if cbml != ""
        if cadena != ""
          cadena = cadena + " and cbml = '#{cbml.to_s}'"
        else
          cadena = " cbml = '#{cbml.to_s}'"
        end
      end
      if identificacion != ""
        if cadena != ""
          cadena = cadena + " and identificacion = '#{identificacion.to_s}'"
        else
          cadena = " identificacion = '#{identificacion.to_s}'"
        end
      end
      paginate :per_page => 10, :page => page, :conditions => [cadena], :order=>'created_at desc'
    end
  end

  def nombres_compl
    return self.nombre.to_s + " " + self.apellidos.to_s
  end
end



