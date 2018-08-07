class Obraspublica < ActiveRecord::Base
  has_many :obrasobservaciones
  has_many :obrasvendedores
  has_many :obrasradicados
  has_many :obrasdisponibilidades
  belongs_to :user
  belongs_to :persona
  belongs_to :obrasproyecto

  validates_presence_of :persona_autobuscar

  def persona_autobuscar
    persona.autobuscar if persona
  end

  def persona_autobuscar=(autobuscar)
    self.persona = Persona.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

  def self.search (identificacion, obrasproyecto_id, estado, pui_comuna, pui_oriental, opcion_vivienda, caso_especial)
      cadena = ""
      if identificacion != ""
        if cadena != ""
          cadena = cadena + ' and persona_id in (select id
                                         from personas
                                         where identificacion = '+ "'#{identificacion.strip}'" +')'
        else
          cadena = cadena + ' persona_id in (select id
                                         from personas
                                         where identificacion = '+ "'#{identificacion.strip}'" +')'
        end
      end
      if obrasproyecto_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and obrasproyecto_id  = ' + "'#{obrasproyecto_id}'"
        else
          cadena = ' obrasproyecto_id  = ' + "'#{obrasproyecto_id}'"
        end
      end
      if estado.to_s != ""
        if cadena != ""
          cadena = cadena + ' and estado  = ' + "'#{estado.strip}'"
        else
          cadena = ' estado  = ' + "'#{estado.strip}'"
        end
      end
      if pui_comuna.to_s != ""
        if cadena != ""
          cadena = cadena + ' and pui_comuna  = ' + "'#{pui_comuna.strip}'"
        else
          cadena = ' pui_comuna  = ' + "'#{pui_comuna.strip}'"
        end
      end
      if pui_oriental.to_s != ""
        if cadena != ""
          cadena = cadena + ' and pui_oriental  = ' + "'#{pui_oriental.strip}'"
        else
          cadena = ' pui_oriental  = ' + "'#{pui_oriental.strip}'"
        end
      end
      if opcion_vivienda.to_s != ""
        if cadena != ""
          cadena = cadena + ' and opcion_vivienda  = ' + "'#{opcion_vivienda.strip}'"
        else
          cadena = ' opcion_vivienda  = ' + "'#{opcion_vivienda.strip}'"
        end
      end
      if caso_especial.to_s != ""
        if cadena != ""
          cadena = cadena + ' and caso_especial  = ' + "'#{caso_especial.strip}'"
        else
          cadena = ' caso_especial  = ' + "'#{caso_especial.strip}'"
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "created_at")
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
      end
  end

end
