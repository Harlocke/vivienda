class Iguanaspersona < ActiveRecord::Base
  belongs_to :iguana
  belongs_to :persona

  validates_presence_of :persona_autobuscar, :iguanasmejora_id

  def persona_autobuscar
    persona.autobuscar if persona
  end

  def persona_autobuscar=(autobuscar)
    self.persona = Persona.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end
end
