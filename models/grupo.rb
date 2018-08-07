class Grupo < ActiveRecord::Base
  has_many :licitacionesenlaces
  has_many :gruposactividades

  validates_presence_of :codigogrupo,:grupo,:codigosubgrupo,:subgrpo

  def self.search(search, page)
      if search.nil?
         s = search
      else
         s = search.upcase
      end
      paginate :per_page => 14,
               :page => page,
               :conditions => ['autobuscar like ?', "%#{s}%"],
               :order => 'autobuscar asc'
  end
end
