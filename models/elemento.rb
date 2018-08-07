class Elemento < ActiveRecord::Base
  belongs_to :tiposelemento
  has_many :elementoscaracteristicas, :dependent =>:destroy
  has_many :elementosmantenimientos, :dependent =>:destroy
  has_many :elementosusers, :dependent =>:destroy
  has_many :elementosotros, :dependent =>:destroy
  has_many :elementossoportes, :dependent =>:destroy
  belongs_to :user

  validates_presence_of :tiposelemento_id, :placa, :marca, :user_id
  validates_uniqueness_of :placa
  
  def self.search (tiposelemento_id,marca,referencia,placa,serial,user_id,userfuncionario_id,ubicacion,observacion)
    cadena = ""
    if tiposelemento_id.to_s != ""
      if cadena != ""
        cadena = cadena + ' and tiposelemento_id  = '+ "'#{tiposelemento_id}'"
      else
        cadena = cadena + ' tiposelemento_id  = '+ "'#{tiposelemento_id}'"
      end
    end
    if marca != ""
      s = marca.upcase
      if cadena != ""
        cadena = cadena + ' and upper(marca) like '+ "'%%#{replacespace(s.to_s.strip)}%%'"
      else
        cadena = cadena + ' upper(marca) like '+ "'%%#{replacespace(s.to_s.strip)}%%'"
      end
    end
    if referencia != ""
      s = referencia.upcase
      if cadena != ""
        cadena = cadena + ' and upper(referencia) like '+ "'%%#{replacespace(s.to_s.strip)}%%'"
      else
        cadena = cadena + ' upper(referencia) like '+ "'%%#{replacespace(s.to_s.strip)}%%'"
      end
    end
    if placa != ""
      if cadena != ""
        cadena = cadena + ' and placa like '+ "'%%#{replacespace(placa.strip)}%%'"
      else
        cadena = cadena + ' placa like '+ "'%%#{replacespace(placa.strip)}%%'"
      end
    end
    if serial != ""
      if cadena != ""
        cadena = cadena + ' and serial like '+ "'%%#{replacespace(serial.strip)}%%'"
      else
        cadena = cadena + ' serial like '+ "'%%#{replacespace(serial.strip)}%%'"
      end
    end
    if ubicacion != ""
      s = ubicacion.upcase
      if cadena != ""
        cadena = cadena + ' and upper(ubicacion) like '+ "'%%#{replacespace(s.to_s.strip)}%%'"
      else
        cadena = cadena + ' upper(ubicacion) like '+ "'%%#{replacespace(s.to_s.strip)}%%'"
      end
    end
    if observacion != ""
      s = observacion.upcase
      if cadena != ""
        cadena = cadena + ' and upper(observacion) like '+ "'%%#{replacespace(s.to_s.strip)}%%'"
      else
        cadena = cadena + ' upper(observacion) like '+ "'%%#{replacespace(s.to_s.strip)}%%'"
      end
    end
    if user_id.to_i > 0
      if cadena != ""
        cadena = cadena + ' and id in (select distinct elemento_id from elementosusers where fecha_fin is null and user_id = '+ "'#{user_id}')"
      else
        cadena = cadena + ' id in (select distinct elemento_id from elementosusers where fecha_fin is null and user_id = '+ "'#{user_id}')"
      end
    end
    if userfuncionario_id.to_s != ""
      if cadena != ""
        cadena = cadena + ' and user_id = '+ "'#{userfuncionario_id}'"
      else
        cadena = cadena + ' user_id = '+ "'#{userfuncionario_id}'"
      end
    end
    if cadena != ""
      find(:all, :conditions => [cadena], :order => "tiposelemento_id, marca, referencia, created_at")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "tiposelemento_id, marca, referencia, created_at")
    end
  end

  def self.searchsistemas(user_id)
    cadena = ""
    if user_id != ""
      if cadena != ""
        cadena = cadena + ' and id in (select distinct elemento_id from elementosusers where fecha_fin is null and user_id = '+ "'#{user_id}')"
      else
        cadena = cadena + ' id in (select distinct elemento_id from elementosusers where fecha_fin is null and user_id = '+ "'#{user_id}')"
      end
    end
    if cadena != ""
      find(:all, :conditions => [cadena], :order => "tiposelemento_id, marca, referencia, created_at")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "tiposelemento_id, marca, referencia, created_at")
    end
  end

  def intercambio(usa1, usn2)
    @elementos = Elemento.find_all_by_user_id(usa1.to_i)
    @elementos.each do |ele|
       elemento = Elemento.find(ele.id)
       elemento.user_id = usn2.to_i
       elemento.save
       cant = cant + 1
      ActiveRecord::Base.connection.execute("insert into log values ('Actualizado - #{elemento.id} - #{usn2.to_i}')")
    end
  end

  def self.replacespace(campo)
     b = campo.sub(" ","%%")
     b = b.sub(" ","%%")
     b = b.sub(" ","%%")
     b = b.sub(" ","%%")
     return b
   end


  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end
end
