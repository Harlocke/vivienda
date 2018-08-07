class Archivosactualizacion < ActiveRecord::Base
  belongs_to :archivo
  belongs_to :user

  def self.search (userid, fchinicial, fchfinal)
    cadena = ""
    if userid.to_s != ""
      if cadena != ""
        cadena = cadena + ' and user_id  = ' + "'#{userid}'"
      else
        cadena = cadena + ' user_id  = ' + "'#{userid}'"
      end
    end
    if fchinicial.to_s != "" and fchfinal.to_s != ""
      if cadena != ""
        cadena = cadena + " and to_char(trunc(created_at),'YYYY-MM-DD') between "  + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
      else
        cadena = cadena + " to_char(trunc(created_at),'YYYY-MM-DD') between " + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
      end
    end
    if cadena != ""
      find(:all, :conditions => [cadena], :order => "created_at")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
    end
  end
end
