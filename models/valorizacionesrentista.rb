class Valorizacionesrentista < ActiveRecord::Base
  belongs_to :valorizacion
  belongs_to :persona

  def persona_autobuscar
    persona.autobuscar if persona
  end

  def persona_autobuscar=(autobuscar)
    self.persona = Persona.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end
end
