class Correspondenciasinterna < ActiveRecord::Base
  belongs_to :user
  belongs_to :dependencia
  has_many :corresinternasdirigidos
  has_many :corresinternasobservaciones
  has_many :corresinternasimagenes
  has_many :corresinternasbitacoras

  validates_presence_of :fecha_documento, :asunto, :tipo, :user_envia, :user_para

##  def self.radicacion(correspondenciasinterna)
##      users  = User.find(:all, :conditions => ["id in (select user_id
#                                                       from   corresinternasdirigidos
#                                                       where  correspondenciasinterna_id = #{correspondenciasinterna.id})#"])
##      users.each do |x|
##        corresinternasdirigidos = Corresinternasdirigido.find(:all, :conditions=>["correspondenciasinterna_id = #{correspondenciasinterna.id}"],:order => 'created_at ASC')
##        Notifier.deliver_radicacion_message(x,correspondenciasinterna,corresinternasdirigidos)
##      end
##  end
#
#  def after_create
#    corresinternasbitacora = Corresinternasbitacora.new
#    corresinternasbitacora.consecutivo = 1
#    corresinternasbitacora.correspondenciasinterna_id = self.id
#    corresinternasbitacora.actividad = 'CREACIÓN DE MEMORANDO - ASUNTO: '+self.asunto.to_s
#    corresinternasbitacora.inicio = self.created_at
#    corresinternasbitacora.user_id = self.user_id
#    corresinternasbitacora.save
#  end
#
#  def after_save
#   if self.aprueba.to_s == 'SI'
#        corresinternasbitacora = Corresinternasbitacora.new
#        corresinternasbitacora.consecutivo = Corresinternasbitacora.maximum("consecutivo", :conditions=>["correspondenciasinterna_id = #{self.id}"]).to_i + 1
#        corresinternasbitacora.correspondenciasinterna_id = self.id
#        corresinternasbitacora.actividad = 'USUARIO APROBÓ - OK'
#        corresinternasbitacora.inicio = Time.now
#        corresinternasbitacora.user_id = self.user_actualiza
#        corresinternasbitacora.save
#    end
#  end
  
  def consecutivog
    if self.id
      if self.consecutivo.to_i > 0
        return self.consecutivo.to_i
      else 
        return "<img src='/images/amarillo1.png' title='Pendiente de Radicacion'/>"
      end
    else
      return "<img src='/images/blanco1.png' title='Sin registrar'/>"
    end  
  end

  def self.search (consecutivo, fchdocinicial, fchdocfinal, dependenciaid, asunto, userproyecta, tipo)
    cadena = ""
    if consecutivo.to_s != ""
      if cadena != ""
        cadena = cadena + ' and consecutivo = '+ "'#{consecutivo.strip}'"
      else
        cadena = cadena + ' consecutivo = '+ "'#{consecutivo.strip}'"
      end
    end
    if fchdocinicial.to_s != "" and fchdocfinal.to_s != ""
      if cadena != ""
        cadena = cadena + ' and fecha_documento between ' + "'#{fchdocinicial}'" + ' and ' + "'#{fchdocfinal}'"
      else
        cadena = cadena + ' fecha_documento between ' + "'#{fchdocinicial}'" + ' and ' + "'#{fchdocfinal}'"
      end
    end
    if dependenciaid.to_s != ""
      if cadena != ""
        cadena = cadena + ' and dependencia_id = '+ "'#{dependenciaid}'"
      else
        cadena = cadena + ' dependencia_id = '+ "'#{dependenciaid}'"
      end
    end
    if asunto.to_s != ""
      s = asunto.upcase
      if cadena != ""
        cadena = cadena + ' and upper(asunto) like '+ "'%%#{s.to_s.strip}%%'"
      else
        cadena = ' upper(asunto) like '+ "'%%#{s.to_s.strip}%%'"
      end
    end
    if userproyecta.to_s != ""
      if cadena != ""
        cadena = cadena + ' and user_proyecta = '+ "'#{userproyecta}'"
      else
        cadena = cadena + ' user_proyecta = '+ "'#{userproyecta}'"
      end
    end
    if tipo.to_s != ""
      if cadena != ""
        cadena = cadena + ' and tipo = '+ "'#{tipo}'"
      else
        cadena = cadena + ' tipo = '+ "'#{tipo}'"
      end
    end
    if cadena != ""
      find(:all, :conditions => [cadena], :order => "fecha_documento")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
    end
  end


  def nombreenvia
    user = User.find(self.user_envia)
    return "<strong>#{user.nombre.to_s}</strong><br/>#{user.dependencia.descripcion rescue nil}"
  end

  def nombreelabora
    user = User.find(self.user_elabora)
    return user.nombre.to_s
  end

  def cargoelabora
    user = User.find(self.user_elabora)
    return user.cargo.to_s
  end

  def nombreaprueba
    user = User.find(self.user_aprueba)
    return user.nombre.to_s
  end

  def cargoaprueba
    user = User.find(self.user_aprueba)
    return user.cargo.to_s
  end

  def desarrolloinforme
     b = self.desarrollo.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     return b
  end

end
