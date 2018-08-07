class Mejoramientositem < ActiveRecord::Base
  has_many :conveniosmejoramientos
  has_many :mejoramientoselementos
  belongs_to :capitulo

  def self.search(search, page)
        paginate :per_page => 15,
                 :page => page,
                 :conditions => ['descripcion like ?', "%#{search}%"],
                 :order => 'descripcion'
  end

  def descripcioninforme
    consecutivo = self.consecutivo rescue nil
    codigo = self.consecutivo rescue nil
    descr = self.descripcion rescue nil
    return consecutivo.to_s + ' ' + codigo.to_s + ' ' + descr.to_s
  end
end
