class Valorizacion < ActiveRecord::Base
  has_many :valorizacionespersonas, :dependent =>:destroy
  has_many :valorizacionespagos, :dependent =>:destroy
  has_many :valorizacionesnotas, :dependent =>:destroy
  has_many :valorizacionesimagenes, :dependent =>:destroy
  has_many :valorizacionesrentistas, :dependent =>:destroy
  belongs_to :valorizacionesestado
  belongs_to :valorizacionesobra

  validates_presence_of :valorizacionesobra_id, :matricula, :comuna_id, :manzana, :lote, :userabogado_id, :usersocial_id, :valorizacionesestado_id
  validates_numericality_of :cobama
  validates_length_of :cobama, :maximum => 11, :message=> "* El cobama debe ser de 11 digitos"#, :if => :in_us1?
  validates_length_of :cobama, :minimum => 11, :message=> "* El cobama debe ser de 11 digitos"#, :if => :in_us1?

  def self.search (valorizacion,identificacion)
      cadena = ""
      if valorizacion.cobama != ""
        s = valorizacion.cobama.upcase
        if cadena != ""
          cadena = cadena + ' and upper(cobama) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = ' upper(cobama) like '+ "'%%#{s.to_s}%%'"
        end
      end
      if valorizacion.valorizacionesobra_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and valorizacionesobra_id = ' + "'#{valorizacion.valorizacionesobra_id.to_s}'"
        else
          cadena = ' valorizacionesobra_id = ' + "'#{valorizacion.valorizacionesobra_id.to_s}'"
        end
      end
      if valorizacion.valorizacionesestado_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and valorizacionesestado_id = ' + "'#{valorizacion.valorizacionesestado_id.to_s}'"
        else
          cadena = ' valorizacionesestado_id = ' + "'#{valorizacion.valorizacionesestado_id.to_s}'"
        end
      end
      if identificacion != ""
        if cadena != ""
          cadena = cadena + ' and id in (select valorizacion_id
                                         from valorizacionespersonas
                                         where persona_id in (select id
                                                              from personas
                                                              where identificacion = '+ "'#{identificacion.strip}'" +'))'
        else
          cadena = cadena + ' id in (select valorizacion_id
                                         from valorizacionespersonas
                                         where persona_id in (select id
                                                              from personas
                                                              where identificacion = '+ "'#{identificacion.strip}'" +'))'
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "created_at")
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
      end
  end

  def fechaprogvalorizacion(fechainicial, dias)
     if fechainicial.to_s != "" and dias.to_s != ""
       fechawork = fechainicial.to_time
       minutosmas = dias.to_i * 86400
       fechaprog = (fechawork + minutosmas.to_i)
       cantidad = Festivo.count(:conditions =>['fecha between ? and ?', fechawork, fechaprog])
       if cantidad > 0
         minutosadd = cantidad.to_i * 86400
         fechaprogramacion = fechawork + minutosmas.to_i + minutosadd.to_i
         fecha = fechaprogramacion.strftime("%d-%m-%Y")
         cantidad1 = Festivo.count(:conditions =>['fecha = ?', fecha])
         while cantidad1.to_i > 0
           fechaprogramacion = fechaprogramacion + 86400
           fecha = fechaprogramacion.strftime("%d-%m-%Y")
           cantidad1 = Festivo.count(:conditions =>['fecha = ?', fecha])
         end
       else
         fechaprogramacion = fechaprog
         fecha = fechaprog.strftime("%d-%m-%Y")
         cantidad1 = Festivo.count(:conditions =>['fecha = ?', fecha])
         while cantidad1.to_i > 0
           fechaprogramacion = fechaprogramacion + 86400
           fecha = fechaprogramacion.strftime("%d-%m-%Y")
           cantidad1 = Festivo.count(:conditions =>['fecha = ?', fecha])
         end
       end
     end
     return fecha
   end

  def before_update
    self.fecha_limite = fechaprogvalorizacion(self.fecha_sol_avaluo,214)
  end
  
end
