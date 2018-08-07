class Legalizacion < ActiveRecord::Base
  has_many :legalizacionesproyectos, :dependent =>:destroy
  has_many :legalizacionesreglamentos, :dependent =>:destroy
  has_many :legalizacionesmatriculas, :dependent =>:destroy
  has_many :legalizazonasreglamentos, :dependent =>:destroy
  has_many :legalizazonasmatriculas, :dependent =>:destroy
  has_many :legalizacionesimagenes, :dependent =>:destroy

  validates_presence_of :descripcion

  def self.search(search, page)
      paginate :per_page => 15,
                 :page => page,
                 :conditions => ["descripcion like '%%#{replacespace(search.to_s)}%%'"],
                 :order => 'descripcion'
  end

  def self.replacespace(campo)
    b = campo.sub(" ","%%")
    b = b.sub(" ","%%")
    b = b.sub(" ","%%")
    b = b.sub(" ","%%")
    return b
  end

end
