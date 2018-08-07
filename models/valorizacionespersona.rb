class Valorizacionespersona < ActiveRecord::Base
  belongs_to :valorizacion
  belongs_to :persona

  validates_presence_of :persona_autobuscar, :tipo

  def persona_autobuscar
    persona.autobuscar if persona
  end

  def persona_autobuscar=(autobuscar)
    self.persona = Persona.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end
end
