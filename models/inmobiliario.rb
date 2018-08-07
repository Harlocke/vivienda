class Inmobiliario < ActiveRecord::Base
  belongs_to :user
  belongs_to :comuna
  has_many :inmobiliariosimagenes
  belongs_to :persona
  
  validates_presence_of :comuna_id

  #validates_presence_of :persona_autobuscar

  def persona_autobuscar
    persona.autobuscar if persona
  end

  def persona_autobuscar=(autobuscar)
    self.persona = Persona.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

  def self.search(comuna_id,disponible, fchinicial, fchfinal, precioinicial, preciofinal, concepto, resultado, funcionario, fecharegistro, idinmueble)
    cadena = ""
    if comuna_id != ""
      if cadena != ""
        cadena = cadena + ' and comuna_id = '+ "'#{comuna_id}'"
      else
        cadena = ' comuna_id = '+ "'#{comuna_id}'"
      end
    end
    if disponible != ""
      if cadena != ""
        cadena = cadena + ' and disponible = '+ "'#{disponible.strip}'"
      else
        cadena = ' disponible = '+ "'#{disponible.strip}'"
      end
    end
    if fchinicial != "" and fchfinal != ""
      if cadena != ""
        cadena = cadena + ' and fecha_disponible between ' + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
      else
        cadena = ' fecha_disponible between ' + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
      end
    end
    if precioinicial != "" and preciofinal != ""
      if cadena != ""
        cadena = cadena + ' and precio between '+ "'#{precioinicial.strip}'" + ' and '+ "'#{preciofinal.strip}'"
      else
        cadena = ' precio between '+ "'#{precioinicial.strip}'" + ' and '+ "'#{preciofinal.strip}'"
      end
    end
    if concepto != ""
      if cadena != ""
        cadena = cadena + ' and concepto_riesgo = '+ "'#{concepto.strip}'"
      else
        cadena = ' concepto_riesgo = '+ "'#{concepto.strip}'"
      end
    end
    if resultado != ""
      if cadena != ""
        cadena = cadena + ' and resultado_concepto = '+ "'#{resultado.strip}'"
      else
        cadena = ' resultado_concepto = '+ "'#{resultado.strip}'"
      end
    end
    if funcionario != ""
      if cadena != ""
        cadena = cadena + ' and user_id = '+ "'#{funcionario}'"
      else
        cadena = ' user_id = '+ "'#{funcionario}'"
      end
    end
    if fecharegistro != ""
      if cadena != ""
        cadena = cadena + ' and trunc(created_at) = ' + "'#{fecharegistro}'"
      else
        cadena = ' trunc(created_at) = ' + "'#{fecharegistro}'"
      end
    end
    if idinmueble != ""
      if cadena != ""
        cadena = cadena + ' and id =  ' + "'#{idinmueble.strip}'"
      else
        cadena = ' id = ' + "'#{idinmueble.strip}'"
      end
    end
    if cadena != ""
      find(:all, :conditions => [cadena], :order => "comuna_id")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "comuna_id")
    end
  end

end
