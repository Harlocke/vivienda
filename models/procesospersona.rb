class Procesospersona < ActiveRecord::Base
  belongs_to :procesosjuridico
  belongs_to :persona
  belongs_to :user

  def persona_autobuscar
    persona.autobuscar if persona
  end

  def persona_autobuscar=(autobuscar)
    self.persona = Persona.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end
end
