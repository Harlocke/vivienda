class Calidaddocumento < ActiveRecord::Base
  belongs_to :calidadproceso
  belongs_to :calidadtiposdocumento
  has_many :calidaddocumentosimagenes, :dependent =>:destroy
  has_many :calidaddocnotas, :dependent =>:destroy

  validates_presence_of :calidadtiposdocumento_id,:nombre,:activo
  validate :vcodigo

  def self.search(search,searchn,page)
    if search == "" and searchn == ""
      paginate :per_page => 10, :page => page, :conditions => ["codigo = '-1'"]
    else
      var = search.to_s rescue nil
      var1 = searchn.to_s rescue nil
      #logger.error("Valor...,."+var.to_s)
      #logger.error("Valor1...,."+var1.to_s)
      if var != ""
        paginate :per_page => 10, :page => page, :conditions => ["activo = 'ACTIVO' and codigo = '#{search.to_s.strip}'"], :order=>'nombre'
      elsif var1 != ""
        s = var1.upcase
        paginate :per_page => 10, :page => page, :conditions => ["activo = 'ACTIVO' and nombre like '%%#{s.to_s.strip}%%'"], :order=>'nombre'
      end
    end
  end

  def vcodigo
    if (self.calidadtiposdocumento_id.to_i == 7 or self.calidadtiposdocumento_id.to_i == 1 or self.calidadtiposdocumento_id.to_i == 4 or self.calidadtiposdocumento_id.to_i == 5 or self.calidadtiposdocumento_id.to_i == 8)
      if self.codigo.to_s == ""
        errors.add :codigo, "Debe registrar el codigo"
      end
      if self.version.to_s == ""
        errors.add :version, "Debe registrar la version"
      end
    end
  end

end
