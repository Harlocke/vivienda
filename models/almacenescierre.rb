class Almacenescierre < ActiveRecord::Base

  belongs_to :producto

  def self.informe (v_mes, v_anno)
#    existeconsolidado = Almacenescierre.exists?(['anno = ? and mes = ? and estado = ?', v_anno, v_mes, "C"])
#    if !existeconsolidado
      existeperiodo = Almacenescierre.exists?(['anno = ? and mes = ? and estado = ?', v_anno, v_mes, "P"])
      if existeperiodo
        almacenescierres = Almacenescierre.find(:all, :conditions =>['anno = ? and mes = ? and estado = ?', v_anno, v_mes, "P"])
        almacenescierres.each do |x|
          x.destroy
        end
      end
      productos  = Producto.find(:all, :order =>['descripcion'])
      productos.each do |x|
        m = Almacenescierre.new
        m.mes = v_mes
        m.anno = v_anno
        m.cantidad = 0
        m.producto_id = x.id
        m.estado = 'P'
        m.save
      end
      almacenescierres = Almacenescierre.find(:all, :conditions =>['anno = ? and mes = ? and estado = ?', v_anno, v_mes, "P"])
      almacenescierres.each do |x|
        if v_mes == 1
          almacencierre = Almacenescierre.find_by_anno_and_mes_and_producto_id( (v_anno.to_i-1), "12", x.producto_id)
        else
          almacencierre = Almacenescierre.find_by_anno_and_mes_and_producto_id(v_anno, (v_mes.to_i - 1), x.producto_id)
        end
        if almacencierre
          suminicial = almacencierre.cantidad.to_i
        else
          suminicial = 0
        end
        sumentrada = Almacenesentrada.sum('cantidad', :conditions => [' to_number(to_char(created_at,'+"'#{"mm"}'"+')) = ? and to_number(to_char(created_at,'+"'#{"yyyy"}'"+')) = ? and producto_id =?' , v_mes, v_anno, x.producto_id])
        sumsalida  = Almacenessalida.sum('cantidad', :conditions => [' to_number(to_char(created_at,'+"'#{"mm"}'"+')) = ? and to_number(to_char(created_at,'+"'#{"yyyy"}'"+')) = ? and producto_id =?' , v_mes, v_anno, x.producto_id])
        x.entradas = sumentrada
        x.salidas  = sumsalida
        x.inicial  = suminicial
        total = (suminicial.to_i + sumentrada.to_i) - sumsalida.to_i
        x.cantidad = total
        x.save
      end
#    end
  end

end