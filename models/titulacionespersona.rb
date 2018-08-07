class Titulacionespersona < ActiveRecord::Base
  belongs_to :titulacion
  belongs_to :persona
  belongs_to :user
  has_many :titulacionespersonasnotas, :dependent =>:destroy

  validates_presence_of :matricula, :persona_autobuscar
  validate :ident

  def ident
    if self.persona_id.to_i > 0
      if Persona.exists?(["id = ?", self.persona_id.to_i]) == false
        errors.add :persona_autobuscar, "**** Debe ingresar una identificación valida"
      end
    else
      errors.add :persona_autobuscar, "**** Debe ingresar una identificación valida"
    end
  end

  def persona_autobuscar
    persona.autobuscar if persona
  end

  def persona_autobuscar=(autobuscar)
    self.persona = Persona.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

  def respaldo(userid)
    anttitulacionespersona = Anttitulacionespersona.new
    anttitulacionespersona.persona_id = self.persona_id
    anttitulacionespersona.titulacion_id = self.titulacion_id
    anttitulacionespersona.user_id = userid
    anttitulacionespersona.save
  end

end
