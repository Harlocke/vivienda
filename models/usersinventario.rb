class Usersinventario < ActiveRecord::Base

  belongs_to :user
  belongs_to :inventarioselemento
  belongs_to :dependencia



  def self.search (inventarioselemento_id, usuario, codigo, serial, dependencia)
      cadena = ""
      if usuario != ""
        if cadena != ""
          cadena = cadena + ' and user_id = '+ "'#{usuario}'"
        else
          cadena = cadena + ' user_id  = '+ "'#{usuario}'"
        end
      end
      if inventarioselemento_id != ""
        if cadena != ""
          cadena = cadena + ' and inventarioselemento_id  = '+ "'#{inventarioselemento_id}'"
        else
          cadena = cadena + ' inventarioselemento_id  = '+ "'#{inventarioselemento_id}'"
        end
      end
      if dependencia != ""
        if cadena != ""
          cadena = cadena + ' and dependencia_id  = '+ "'#{dependencia}'"
        else
          cadena = cadena + ' dependencia_id  = '+ "'#{dependencia}'"
        end
      end
      if codigo != ""
        if cadena != ""
          cadena = cadena + ' and codigo  = '+ "'#{codigo.strip}'"
        else
          cadena = cadena + ' codigo  = '+ "'#{codigo.strip}'"
        end
      end
      if serial != ""
        if cadena != ""
          cadena = cadena + ' and serial  = '+ "'#{serial.strip}'"
        else
          cadena = cadena + ' serial  = '+ "'#{serial.strip}'"
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "user_id")
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
      end
  end

end
