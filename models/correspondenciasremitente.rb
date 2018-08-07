class Correspondenciasremitente < ActiveRecord::Base

  has_many :correspondenciasenviadas
  has_many :correspondenciasrecibidas
  
  def self.search(search, page)
        paginate :per_page => 14,
                 :page => page,
                 :conditions => ["upper(nombre)||' '||upper(entidad) like '%%#{replacespace(search.to_s)}%%'"],
                 :order => 'nombre'
  end

  def before_save
    nom =  ""
    if self.nombre.nil? == false
      if nom.nil? == false
        nom = nom + ' ' + self.nombre.to_s
      else
        nom = self.nombre.to_s
      end
    end
    if self.entidad.nil? == false
      if nom.nil? == false
        nom = nom + ' - ' + self.entidad.to_s
      else
        nom = self.entidad.to_s
      end
    end
    self.autobuscar = nom
  end

  def self.replacespace(campo)
    b = campo.sub(" ","%%")
    b = b.sub(" ","%%")
    b = b.sub(" ","%%")
    b = b.sub(" ","%%")
    return b
  end
end
