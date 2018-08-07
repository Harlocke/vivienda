class Estudiosprevio < ActiveRecord::Base
  belongs_to :empleado
  belongs_to :user
  has_many :estudiospreviosrubros, :dependent =>:destroy
  has_many :estudiosactividades, :dependent =>:destroy
  has_many :estudiosmodificaciones, :dependent =>:destroy
  belongs_to :modalidad
  belongs_to :tiposcontrato
  belongs_to :contrato
  
  validates_presence_of :fecha_suscripcion, :empleado_autobuscar, :valor_mes, :objeto, :dias, :meses, :valor_total, :valor_compromiso, 
                        :fecha_inicio, :fecha_fin, :modalidad_id, :tiposcontrato_id, :poliza, :secop, 
                        :abogadoempleado_id, :user_interventor, :pago_anticipado, :anticipo
  validate :empleadoid

  def empleadoid
    if self.empleado_id
      if Empleado.exists?(["id = #{self.empleado_id}"]) == false
        errors.add :empleado_autobuscar, "* Debe indicar el contratista..."
      end
    else
      errors.add :empleado_autobuscar, "* Debe indicar el contratista..."
    end
  end

  def after_create
    @estudiosactividad = Estudiosactividad.new
    @estudiosactividad.estudiosprevio_id = self.id
    @estudiosactividad.observaciones = "EN CUMPLIMIENTO DEL ARTÍCULO 282 DE LA LEY 100 DE 1993 Y DEL 50 DE LA LEY 789 DE 2002, DEBERÁ PRESENTAR LA CONSTANCIA DE AFILIACIÓN COMO TRABAJADOR INDEPENDIENTE Y DE SUS PAGOS RESPECTIVOS AL SISTEMA INTEGRAL DE SEGURIDAD SOCIAL EN SALUD, PENSIONES Y RIESGOS, DURANTE LA VIGENCIA DEL CONTRATO, CON UNA BASE DE COTIZACIÓN DEL 40% SOBRE LOS HONORARIOS PERCIBIDOS MENSUALMENTE, LOS CUALES, EN TODO CASO NO PODRÁ SER INFERIOR AL MÍNIMO LEGAL MENSUAL VIGENTE. EL NO CUMPLIMIENTO DE ESTA OBLIGACIÓN SERÁ CAUSAL DE SUSPENSIÓN INMEDIATA DEL CONTRATO. EN CASO DE PERSISTIR EN LA CONDUCTA, SE DARÁ POR TERMINADO DE MANERA UNILATERAL EL CONTRATO, CONFORME A LO ESTABLECIDO EN EL ARTÍCULO 17 DE LA LEY 80 DE 1993. ESTOS PAGOS SE DEBEN REALIZAR EN LAS FECHAS ESTABLECIDAS EN EL ARTÍCULO 4 DEL DECRETO 1670 DE 2007."
    @estudiosactividad.user_id = self.user_id
    @estudiosactividad.save
  end

  def empleado_autobuscar
    empleado.autobuscar if empleado
  end

  def empleado_autobuscar=(autobuscar)
    self.empleado = Empleado.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

  def userinterventor
    return Empleado.find(self.user_interventor).nombres rescue nil
  end

  def userdependencia
    return Empleado.find(self.empleado_id).dependencia.descripcion rescue nil
  end

  def self.search(search,searchn,page)
    if search == "" and searchn == ""
      paginate :per_page => 10, :page => page, :order=>'created_at desc'
    else
      var = search.to_s rescue nil
      var1 = searchn.to_s rescue nil
      logger.error("Ingresooo")
      if var != ""
        paginate :per_page => 10, :page => page, :conditions => ["empleado_id = (select id from empleados where identificacion = '#{search.to_s.strip}')"], :order=>'created_at desc'
      elsif var1 != ""
        paginate :per_page => 10, :page => page, :conditions => ["contrato_id in (select id from contratos where nro_contrato = '#{searchn.to_s.strip}')"], :order=>'created_at desc'
      else
        paginate :per_page => 10, :page => page, :order=>'created_at desc'
      end
    end
  end

  def self.searchcontratos (fchinicial, fchfinal)
      cadena = ""
         if fchinicial.to_s != "" and fchfinal.to_s != ""
           cadena = cadena + " to_char(trunc(fecha_inicio),'YYYY-MM-DD') between " + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
        end
       if cadena != ""
        find(:all, :conditions => [cadena], :order => "created_at")
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
      end      
  end


  
  def self.replacespace(campo)
    b = campo.sub(" ","%%")
    b = b.sub(" ","%%")
    b = b.sub(" ","%%")
    b = b.sub(" ","%%")
    return b
  end
end