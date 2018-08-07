class Feria2014beneficiario < ActiveRecord::Base
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

  def nombres
    nom =  ""
    if self.primer_nombre.nil? == false
      nom = nom + ' ' + self.primer_nombre.to_s
    end
    if self.segundo_nombre.nil? == false
      nom = nom + ' ' + self.segundo_nombre.to_s
    end
    if self.primer_apellido.nil? == false
      nom = nom + ' ' + self.primer_apellido.to_s
    end
    if self.segundo_apellido.nil? == false
      nom = nom + ' ' + self.segundo_apellido.to_s
    end
    return nom
  end
end
