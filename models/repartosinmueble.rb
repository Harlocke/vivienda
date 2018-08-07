class Repartosinmueble < ActiveRecord::Base
  belongs_to :reparto
  belongs_to :user
  belongs_to :persona
  belongs_to :vivienda
  belongs_to :corvide

  validates_presence_of :persona_autobuscar
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

  def before_create
  	if self.persona_id
      if Viviendaspersona.exists?(["persona_id = #{self.persona_id}"]) == true
      	viv = Vivienda.find(:first, :conditions=>["id in (select vivienda_id from viviendaspersonas where persona_id = #{self.persona_id})"])
      	self.vivienda_id = viv.id
      elsif Corvide.exists?(["id in (select corvide_id from corvidespersonas where persona_id = #{self.persona_id})"]) == true
        cor = Corvide.find(:first, :conditions=>["id in (select corvide_id from corvidespersonas where persona_id = #{self.persona_id})"])
        self.corvide_id = cor.id
      end
    end
  end
end
