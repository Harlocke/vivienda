class Conveniospersona < ActiveRecord::Base
  belongs_to :convenio
  belongs_to :persona
  belongs_to :user
  
  validates_presence_of :persona_autobuscar

  def persona_autobuscar
    persona.autobuscar if persona
  end

  def persona_autobuscar=(autobuscar)
    self.persona = Persona.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

end
