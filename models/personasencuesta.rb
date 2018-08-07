class Personasencuesta < ActiveRecord::Base
  belongs_to :persona
  belongs_to :user

  validates_presence_of :info_recibida, :respetuoso, :tiempo, :instalaciones, :satisfecho, :observaciones
  validate :oo

  def before_save
    self.total = (self.info_recibida.to_f + self.respetuoso.to_f + self.tiempo.to_f + self.instalaciones.to_f + self.satisfecho.to_f).to_i rescue 0
  end

  def self.search (creainicial,creafinal)
    cadena = ""
    if creainicial.to_s != "" and creafinal.to_s != ""
      if cadena != ""
        cadena = cadena + ' and trunc(created_at) between ' + "'#{creainicial.to_date}'" + ' and ' + "'#{creafinal.to_date}'"
      else
        cadena = cadena + ' trunc(created_at) between ' + "'#{creainicial.to_date}'" + ' and ' + "'#{creafinal.to_date}'"
      end
    end
    if cadena != ""
      find(:all, :conditions => [cadena], :order => "created_at")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
    end
  end  

  def temadesc
    cadena = ""
    if self.arriendo.to_s == "SI"
      cadena = cadena + '* Arriendo temporal<br/>'
    end
    if self.postulacion.to_s == "SI"
      cadena = cadena + '* Postulaciones<br/>'
    end
    if self.plan_retorno.to_s == "SI"
      cadena = cadena + '* Plan retorno<br/>'
    end
    if self.opv.to_s == "SI"
      cadena = cadena + '* OPV<br/>'
    end
    if self.desastre.to_s == "SI"
      cadena = cadena + '* Desastres<br/>'
    end
    if self.vivenda_usada.to_s == "SI"
      cadena = cadena + '* Vivienda usada<br/>'
    end
    if self.cartera.to_s == "SI"
      cadena = cadena + '* Cartera<br/>'
    end
    if self.feria.to_s == "SI"
      cadena = cadena + '* Feria de vivienda<br/>'
    end
    if self.inf_gral.to_s == "SI"
      cadena = cadena + '* Información general<br/>'
    end
    if self.riesgo.to_s == "SI"
      cadena = cadena + '* Riesgo<br/>'
    end
    if self.post_venta.to_s == "SI"
      cadena = cadena + '* Post – ventas<br/>'
    end
    if self.escrituracion.to_s == "SI"
      cadena = cadena + '* Escrituración<br/>'
    end
    if self.desplazado.to_s == "SI"
      cadena = cadena + '* Desplazados<br/>'
    end
    if self.legalizacion.to_s == "SI"
      cadena = cadena + '* Legalización<br/>'
    end
    if self.vivenda_nueva.to_s == "SI"
      cadena = cadena + '* Vivienda nueva<br/>'
    end
    if self.mejoramiento.to_s == "SI"
      cadena = cadena + '* Mejoramiento vivienda<br/>'
    end
    if self.titulacion.to_s == "SI"
      cadena = cadena + '* Titulación<br/>'
    end
    return cadena.to_s
  end

  def oo
    if self.arriendo.to_s == "NO" and  self.postulacion.to_s == "NO" and  self.plan_retorno.to_s == "NO" and  self.opv.to_s == "NO" and  self.desastre.to_s == "NO" and  self.vivenda_usada.to_s == "NO" and  self.cartera.to_s == "NO" and  self.feria.to_s == "NO" and  self.inf_gral.to_s == "NO" and  self.riesgo.to_s == "NO" and  self.post_venta.to_s == "NO" and  self.escrituracion.to_s == "NO" and  self.desplazado.to_s == "NO" and  self.legalizacion.to_s == "NO" and  self.vivenda_nueva.to_s == "NO" and  self.mejoramiento.to_s == "NO" and  self.titulacion.to_s == "NO"
        errors.add :area, "* Debe seleccionar minimo 1 motivo de atención"
    end
  end
end
