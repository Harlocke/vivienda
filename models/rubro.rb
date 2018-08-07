class Rubro < ActiveRecord::Base
  has_many :contratosrubros
  has_many :contratospagos
  has_many :estudiospreviosrubros
  has_many :estudiosmrubros

  def dtipo
    if self.tipo.to_s == ""
      return self.agregado.to_s
    else
      return self.tipo.to_s
    end
  end

  def self.searchv(search, page)
      paginate :per_page => 15,
                 :page => page,
                 :conditions => ["tipo= 'V' and autobuscar like '%%#{replacespace(search.to_s)}%%'"],
                 :order => 'primer_nombre'
  end
  
end
