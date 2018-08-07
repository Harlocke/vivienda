class Feria2014jefe < ActiveRecord::Base
  belongs_to :persona
  belongs_to :caja
  belongs_to :documento
  belongs_to :especial
  belongs_to :estados_civil
  belongs_to :familiar
  belongs_to :ocupacion
  belongs_to :parentesco
  belongs_to :sisben
  belongs_to :comuna

  def generos
    case self.genero
    when true then "MASCULINO"
    when false then "FEMENINO"
    end
  end
end
