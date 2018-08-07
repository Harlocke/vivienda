class Producto < ActiveRecord::Base
  has_many :almacenessalidas
  has_many :almacenesentradas
  has_many :almacenescierres
  has_many :almacenessolicitudes

  def self.search(search, page)
    if search.to_s != ""
      s = search.upcase
    else
      s = search
    end
      paginate :per_page => 15,
               :page => page,
               :conditions => ['descripcion like ? or codigo = ? ', "%#{s.to_s}%", "#{search}"],
               :order => 'descripcion'
  end

  def dtipo
     if self.tipo == "1"
       return "PAPELERIA"
     elsif self.tipo == "2"
       return "ASEO Y CAFETERIA"
     elsif self.tipo == "3"
       return "FERRETERIA"
     end
  end
end
