class Interactobservacion < ActiveRecord::Base
  belongs_to :interactividad
  belongs_to :user

  def obs
    return '(' + self.created_at.strftime("%Y-%m-%d %X") + ' - ' + self.user.username.to_s + ') '+ self.observaciones.to_s
  end
end
