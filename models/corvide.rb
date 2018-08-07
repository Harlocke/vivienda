class Corvide < ActiveRecord::Base
  has_many :corvidesdocumentos
  has_many :corvidesobservaciones
  has_many :corvidespersonas
  belongs_to :persona
  belongs_to :comuna

  validates_presence_of :nro_expediente, :matricula, :cbml

  def persona_autobuscar
    persona.autobuscar if persona
  end

  def persona_autobuscar=(autobuscar)
    self.persona = Persona.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

  def self.search (corvide,poseedor,adjudicatario)
    cadena = ""
    if corvide.nro_expediente.to_s != ""
      if cadena != ""
        cadena = cadena + ' and nro_expediente = ' + "'#{corvide.nro_expediente.to_s}'"
      else
        cadena = ' nro_expediente = ' + "'#{corvide.nro_expediente.to_s}'"
      end
    end
    if corvide.comuna_id.to_s != ""
      if cadena != ""
        cadena = cadena + ' and comuna_id = ' + "'#{corvide.comuna_id.to_s}'"
      else
        cadena = ' comuna_id = ' + "'#{corvide.comuna_id.to_s}'"
      end
    end
    if corvide.cbml != ""
      if cadena != ""
        cadena = cadena + ' and cbml = ' + "'#{corvide.cbml.to_s.strip}'"
      else
        cadena = ' cbml = ' + "'#{corvide.cbml.to_s.strip}'"
      end
    end
    if corvide.matricula != ""
      if cadena != ""
        cadena = cadena + ' and matricula = ' + "'#{corvide.matricula.to_s.strip}'"
      else
        cadena = ' matricula = ' + "'#{corvide.matricula.to_s.strip}'"
      end
    end
    if corvide.transferencia != ""
      if cadena != ""
        cadena = cadena + ' and transferencia = ' + "'#{corvide.transferencia.to_s.strip}'"
      else
        cadena = ' transferencia = ' + "'#{corvide.transferencia.to_s.strip}'"
      end
    end
    if corvide.estado != ""
      if cadena != ""
        cadena = cadena + ' and estado = ' + "'#{corvide.estado.to_s.strip}'"
      else
        cadena = ' estado = ' + "'#{corvide.estado.to_s.strip}'"
      end
    end
    if poseedor != ""
      if cadena != ""
        cadena = cadena + ' and persona_id in (select id from personas where identificacion = '+ "'#{poseedor.strip}'" +')'
      else
        cadena = cadena + ' persona_id in (select id from personas where identificacion = '+ "'#{poseedor.strip}'" +')'
      end
    end
    if adjudicatario != ""
      if cadena != ""
        cadena = cadena + ' and id in (select corvide_id
                                       from   corvidespersonas
                                       where  persona_id in (select id
                                                             from   personas
                                                             where  identificacion = '+ "'#{adjudicatario.strip}'" +'))'
      else
        cadena = cadena + ' id in (select corvide_id
                                   from   corvidespersonas
                                   where  persona_id in (select id
                                                         from   personas
                                                         where  identificacion = '+ "'#{adjudicatario.strip}'" +'))'
      end
    end
    if cadena != ""
      find(:all, :conditions => [cadena], :order => "id")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "id")
    end
  end
end
