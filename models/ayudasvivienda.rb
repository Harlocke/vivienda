class Ayudasvivienda < ActiveRecord::Base
  belongs_to :ayuda
  belongs_to :user
  belongs_to :propietario
  belongs_to :comuna

  validates_presence_of :propietario_autobuscar, :comuna_descripcion2
  validate :comuna_exist, :propitario_e
  validates_numericality_of :telefono_nueva_vivienda, :in=> 7...10, :message=>"El numero debe ser entre 7 y 10 digitos. Verifique!!"


  def comuna_exist
    if self.comuna_id
      if !Comuna.exists?(["id = #{self.comuna_id}"])
         errors.add :comuna_descripcion2, "* El barrio no es valido"
      end
    else
      errors.add :comuna_descripcion2, "* El barrio no es valido"
    end
  end  

  def propitario_e
    if self.propietario_id
      if !Propietario.exists?(["id = #{self.propietario_id}"])
         errors.add :propietario_autobuscar, "* El propietario no es valido"
      end
    else
      errors.add :propietario_autobuscar, "* El propietario no es valido"
    end
  end  

  def propietario_autobuscar
    propietario.autobuscar if propietario
  end

  def propietario_autobuscar=(autobuscar)
    self.propietario = Propietario.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

  def comuna_descripcion2
    comuna.descripcion2 if comuna
  end

  def comuna_descripcion2=(descripcion2)
    self.comuna = Comuna.find_or_create_by_descripcion2(descripcion2) unless descripcion2.blank?
  end

end
