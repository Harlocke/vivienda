class Ayudassocial < ActiveRecord::Base
  belongs_to :ayuda
  belongs_to :user
  belongs_to :estados_civil
  belongs_to :comuna

   def comuna_exist
    if self.comuna_id
      if !Comuna.exists?(["id = #{self.comuna_id}"])
         errors.add :comuna_descripcion2, "* El barrio no es valido"
      end
    else
      errors.add :comuna_descripcion2, "* El barrio no es valido"
    end
  end

  def comuna_descripcion2
    comuna.descripcion2 if comuna
  end

  def comuna_descripcion2=(descripcion2)
    self.comuna = Comuna.find_or_create_by_descripcion2(descripcion2) unless descripcion2.blank?
  end
end
