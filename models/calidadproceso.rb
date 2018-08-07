class Calidadproceso < ActiveRecord::Base
  has_many :calidaddocumentos
  validates_presence_of :tipoproceso,:descripcion,:tipologia,:objetivo,:alcance,:codigo,:version

  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end
  
end
