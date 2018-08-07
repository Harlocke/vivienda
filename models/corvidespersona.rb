class Corvidespersona < ActiveRecord::Base
  belongs_to :corvide
  belongs_to :persona
  belongs_to :user

  validates_presence_of :cisa, :habita, :valor_cisa
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
end
