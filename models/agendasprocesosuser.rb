class Agendasprocesosuser < ActiveRecord::Base
  belongs_to :agendasproceso
  belongs_to :user

  validates_presence_of :user_nombre
  validate :user_exist

  def user_exist
    if self.user_id
      if !User.exists?(["id = #{self.user_id}"])
         errors.add :user_nombre, "* El usuario no es valido"
      end
    else
      errors.add :user_nombre, "* El usuario no es valido"
    end
  end  

  def user_nombre
    user.nombre if user
  end

  def user_nombre=(nombre)
    self.user = User.find_or_create_by_nombre(nombre) unless nombre.blank?
  end

end
