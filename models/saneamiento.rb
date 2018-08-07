class Saneamiento < ActiveRecord::Base
  has_many :saneamientosimagenes
  has_many :saneamientosnotas
  belongs_to :user
  belongs_to :comuna
  validates_presence_of :nro_matricula, :encargo_tramite

  def self.search (saneamiento)
    cadena = ""
    if saneamiento.nro_matricula.to_s != ""
      if cadena != ""
        cadena = cadena + ' and nro_matricula = ' + "'#{saneamiento.nro_matricula.to_s}'"
      else
        cadena = ' nro_matricula = ' + "'#{saneamiento.nro_matricula.to_s}'"
      end
    end
    if saneamiento.comuna_id.to_s != ""
      if cadena != ""
        cadena = cadena + ' and comuna_id = ' + "'#{saneamiento.comuna_id.to_s}'"
      else
        cadena = ' comuna_id = ' + "'#{saneamiento.comuna_id.to_s}'"
      end
    end
    if saneamiento.identificacion != ""
      if cadena != ""
        cadena = cadena + ' and identificacion = ' + "'#{saneamiento.identificacion.to_s.strip}'"
      else
        cadena = ' identificacion = ' + "'#{saneamiento.identificacion.to_s.strip}'"
      end
    end
    if saneamiento.cbml != ""
      if cadena != ""
        cadena = cadena + ' and cbml = ' + "'#{saneamiento.cbml.to_s.strip}'"
      else
        cadena = ' cbml = ' + "'#{saneamiento.cbml.to_s.strip}'"
      end
    end
    if saneamiento.encargo_tramite != ""
      if cadena != ""
        cadena = cadena + ' and encargo_tramite = ' + "'#{saneamiento.encargo_tramite.to_s}'"
      else
        cadena = ' encargo_tramite = ' + "'#{saneamiento.encargo_tramite.to_s}'"
      end
    end
    if cadena != ""
      find(:all, :conditions => [cadena], :order => "id")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "id")
    end
  end

#  def self.search(search,searchn,search0, page)
#    if search == "" and searchn == "" and search0 == ""
#      paginate :per_page => 10, :page => page, :conditions => ["identificacion = '-1'"]
#    else
#      if search != ""
#        paginate :per_page => 10, :page => page, :conditions => ["nro_matricula like '%%#{search.to_s.strip}%%'"], :order=>'nro_matricula'
#      elsif search0 != ""
#        paginate :per_page => 10, :page => page, :conditions => ["identificacion = '#{search0.to_s}'"]
#      elsif searchn != ""
#        paginate :per_page => 10, :page => page, :conditions => ["comuna_id = '#{searchn.to_s}'"], :order=>'nro_matricula'
#      end
#    end
#  end
end
