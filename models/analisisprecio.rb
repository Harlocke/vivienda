class Analisisprecio < ActiveRecord::Base
  belongs_to :user
  has_many :analisisprecioselementos
  has_many :licitacionesenlaces
  belongs_to :gruposactividad

  #validates_presence_of :gruposactividad_id, #:fecha#, :porc_admin, :porc_utilidad

  def gruposactividad_descripcion
    gruposactividad.descripcion if gruposactividad
  end

  def gruposactividad_descripcion=(descripcion)
    self.gruposactividad = Gruposactividad.find_or_create_by_descripcion(descripcion) unless descripcion.blank?
  end
  
  def self.search(search, page)
      if search.nil?
         s = search
      else
         s = search.upcase
      end
      paginate :per_page => 14,
               :page => page,
               :conditions => ['gruposactividad_id in (select id from gruposactividades where descripcion like ?)', "%#{s}%"],
               :order => 'created_at desc'
  end

#  def self.buscar(obra)
#    cadena = ""
#      if obra != ""
#        if cadena != ""
#          s = obra.upcase
#          cadena = cadena + ' and upper(descripcion) like '+ "'%%#{s.to_s}%%'"
#        else
#          s = obra.upcase
#          cadena = ' upper(descripcion) like '+ "'%%#{s.to_s}%%'"
#        end
#      end
#      if cadena != ""
#        find(:all, :conditions => [cadena], :order => "fecha")
#      else
#        find(:all, :conditions => ['created_at = curdate()'], :order => "fecha")
#      end
#  end
end
