class Mensaje < ActiveRecord::Base
  has_many :mensajesusers

  def asignadoscorreos
  	if Mensajesuser.exists?(["mensaje_id = #{self.id}"])
  	  correos = ""
  	  self.mensajesusers.each do |mensajesuser|
  		if correos != ""
  			correos = correos + "," + mensajesuser.user.email.to_s
  		else
  			correos = correos + mensajesuser.user.email.to_s
  		end
      end
      return correos
    end
  end

  def asignadosid
    if Mensajesuser.exists?(["mensaje_id = #{self.id}"])
      correos = ""
      self.mensajesusers.each do |mensajesuser|
      if correos != ""
        correos = correos + "," + mensajesuser.user_id.to_s
      else
        correos = correos + mensajesuser.user_id.to_s
      end
      end
      return correos
    end
  end  
end
