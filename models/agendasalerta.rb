class Agendasalerta < ActiveRecord::Base
  belongs_to :user
  #belongs_to :agenda
  belongs_to :persona

  validates_presence_of :descripcion  

  def completa
  	return self.created_at.strftime("%Y-%m-%d %X").to_s +  ' -  ' + self.user.nombre.to_s + " - <strong>" + self.descripcion.to_s + "</strong>  " rescue nil
  end

  def desact
  	if self.estado.to_s == 'DESACTIVADA'
  		return ' ('+ User.find(self.user_desactiva).username.to_s + ')'
  	end
  end
end
