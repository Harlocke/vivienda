class Agendasproceso < ActiveRecord::Base
  has_many :agendasfechas, :dependent =>:destroy
  has_many :agendasprocesosusers, :dependent =>:destroy
  has_many :agendasparametros, :dependent =>:destroy
  has_many :agendasrangos, :dependent =>:destroy

  def name
    self.descripcion
  end

  acts_as_chainable :select_label => 'P R O C E S O',
                    :conditions=>["estado = 'ACTIVO'"],
                    :to => :agendasfecha,
                    :root => true,
                    :order => :descripcion


  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end
 
end
