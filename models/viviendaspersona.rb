class Viviendaspersona < ActiveRecord::Base
  belongs_to :persona
  belongs_to :vivienda
  has_many :proyectoscopcomites
 
  def persona_autobuscar
    persona.autobuscar if persona
  end

  def persona_autobuscar=(autobuscar)
    self.persona = Persona.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

  def self.buscar(buscarident)
      if buscarident != ""
        find(:all, :conditions => [' persona_id = (select distinct persona_id from relaciones where identificacion = ?) ', "#{buscarident}"])
      end
  end
end
