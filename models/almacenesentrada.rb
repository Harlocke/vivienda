class Almacenesentrada < ActiveRecord::Base
  belongs_to :user
  belongs_to :producto
  belongs_to :empleado

  #validates_presence_of :fecha_factura,:producto_id,:empleado_id,:cantidad,:valor_unitario,:valor_total
  #validates_presence_of :nro_factura, :if => :in_us1?
  #validates_presence_of :nro_remision, :if => :in_us2?

  validates_presence_of :nro_remision,:fecha_factura,:producto_id,:empleado_id,:cantidad,:valor_unitario,:valor_total
  #validates_presence_of :nro_factura, :if => :in_us1?
  #validates_uniqueness_of :nro_remision, :producto_id, :empleado_id

  def in_us1?
    self.nro_remision.to_s == ""
  end

  def in_us2?
    self.nro_factura.to_s == ""
  end

  def self.search (producto, funcionario, factura, remision,inicial,final)
      cadena = ""
      if funcionario != ""
        if cadena != ""
          cadena = cadena + ' and empleado_id = '+ "'#{funcionario}'"
        else
          cadena = cadena + ' empleado_id  = '+ "'#{funcionario}'"
        end
      end
      if producto != ""
        if cadena != ""
          cadena = cadena + ' and producto_id  = '+ "'#{producto}'"
        else
          cadena = cadena + ' producto_id  = '+ "'#{producto}'"
        end
      end
      if factura != ""
        if cadena != ""
          cadena = cadena + ' and nro_factura  = '+ "'#{factura.strip}'"
        else
          cadena = cadena + ' nro_factura  = '+ "'#{factura.strip}'"
        end
      end
      if remision != ""
        if cadena != ""
          cadena = cadena + ' and nro_remision  = '+ "'#{remision.strip}'"
        else
          cadena = cadena + ' nro_remision  = '+ "'#{remision.strip}'"
        end
      end
      if inicial.to_s != "" and final.to_s != ""
        if cadena != ""
          cadena = cadena + ' and trunc(created_at) between ' + "'#{inicial}'" + ' and ' + "'#{final}'"
        else
          cadena = cadena + ' trunc(created_at) between ' + "'#{inicial}'" + ' and ' + "'#{final}'"
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "created_at")
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
      end
  end

end
