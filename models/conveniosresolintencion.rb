class Conveniosresolintencion < ActiveRecord::Base
  has_many :conveniosresolmejoramientos, :dependent =>:destroy
  has_many :conveniosresollistas, :dependent =>:destroy
  belongs_to :resolucion
  belongs_to :convenio
  belongs_to :conveniosforma
  belongs_to :conveniosresolucion
  validates_presence_of :conveniosforma_id, :fecha

  def after_create
    if Conveniosforma.find(self.conveniosforma_id).porcentaje.to_i == 10
      @listaspagos = Listaspago.find(:all, :conditions=>["pago_10 = 'SI'"])
    else
      @listaspagos = Listaspago.find(:all, :conditions=>["pago_otros = 'SI'"])
    end
    @listaspagos.each do |listaspago|
      @conveniosresollista = Conveniosresollista.new
      @conveniosresollista.conveniosresolintencion_id = self.id
      @conveniosresollista.listaspago_id = listaspago.id
      @conveniosresollista.save
    end
  end

end
