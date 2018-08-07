class Precioselemento < ActiveRecord::Base
  belongs_to :tiposelemento
  belongs_to :user
  has_many :analisisprecioselementos
  has_many :licitacionesprecioselementos
  has_many :precioselementoshijos

  #validates_presence_of :tiposelemento_id, :unidadmedida, :valor, :fecha_verificacion
  validates_presence_of :grupo,:descripcion,:unidadmedida,:valor,:fecha_verificacion
  
  def self.search(search, page)
      if search.nil?
         s = search
      else
         s = search.upcase
      end
      paginate :per_page => 14,
               :page => page,
               :conditions => ['grupo like ? or descripcion like ?', "%#{s}%", "%#{s}%"],
               :order => 'grupo, descripcion asc'
  end

  def before_save
    nom =  ""
    if self.descripcion.nil? == false
      nom = self.descripcion.to_s
    end
    if self.grupo.nil? == false
      nom = nom + ' - ' + self.grupo.to_s
    end
    self.autobuscar = nom
  end

##  def actualizavaloresitems
##     ActiveRecord::Base.connection.execute("update analisisprecioselementos set valorunitario = #{self.valorunitario}, valortotal = #{self.valorunitario} * cantidad, updated_at = CURRENT_TIMESTAMP()
#                                            where  elemento_id = #{self.id}#")
##  end

end
