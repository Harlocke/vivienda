class Almacenessolicitud < ActiveRecord::Base
  belongs_to :producto
  belongs_to :user

  validates_presence_of :producto_descripcion, :cantidad
  
  def cantreal
    if self.cantidad_real.to_i > 0
      return self.cantidad_real
    else
      return self.cantidad
    end
  end

  def cantdisponble
    cantdis = Producto.find(self.producto_id).disponible
    sument  = Almacenesentrada.sum('cantidad', :conditions => [" producto_id = #{self.producto_id} and to_char(created_at,'YYYY-MM') =  to_char(sysdate,'YYYY-MM')"])
    sumsal  = Almacenessalida.sum('cantidad', :conditions => [" producto_id = #{self.producto_id} and to_char(created_at,'YYYY-MM') =  to_char(sysdate,'YYYY-MM')"])
    return ((cantdis.to_i + sument.to_i) - sumsal.to_i)
  end


  def producto_descripcion
    producto.descripcion if producto
  end

  def producto_descripcion=(descripcion)
    self.producto = Producto.find_or_create_by_descripcion(descripcion) unless descripcion.blank?
  end


end
