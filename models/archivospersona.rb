class Archivospersona < ActiveRecord::Base
  belongs_to :archivo
  belongs_to :persona
  belongs_to :user

  def persona_autobuscar
    persona.autobuscar if persona
  end

  def persona_autobuscar=(autobuscar)
    self.persona = Persona.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

  def validaotrascarpeta
    if Archivospersona.exists?(["persona_id = #{self.persona_id} and archivo_id != #{self.archivo_id}"])
      return 'SI'
    else
      return 'NO'
    end
  end
end
