class Almacenessalida < ActiveRecord::Base
  belongs_to :user
  belongs_to :producto

  def self.search (producto, funcionario,inicial,final)
      cadena = ""
      if funcionario != ""
        if cadena != ""
          cadena = cadena + ' and user_id = '+ "'#{funcionario}'"
        else
          cadena = cadena + ' user_id  = '+ "'#{funcionario}'"
        end
      end
      if producto != ""
        if cadena != ""
          cadena = cadena + ' and producto_id  = '+ "'#{producto}'"
        else
          cadena = cadena + ' producto_id  = '+ "'#{producto}'"
        end
      end
      if inicial.to_s != "" and final.to_s != ""
        if cadena != ""
          cadena = cadena + ' and trunc(created_at) between ' + "'#{inicial}'" + ' and ' + "'#{final}'"
        else
          cadena = cadena + ' trunc(created_at) between ' + "'#{inicial}'" + ' and ' + "'#{final}'"
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "created_at")
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
      end
  end
  
end
