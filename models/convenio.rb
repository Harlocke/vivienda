class Convenio < ActiveRecord::Base
  has_many :convenioscontratos, :dependent =>:destroy
  has_many :conveniospersonas, :dependent =>:destroy
  has_many :conveniosimagenes, :dependent =>:destroy
  has_many :conveniosobservaciones, :dependent =>:destroy
  has_many :conveniosetapas, :dependent =>:destroy
  has_many :conveniospagos, :dependent =>:destroy
  has_many :conveniosmejoramientos, :dependent =>:destroy
  has_many :conveniosresoluciones, :dependent =>:destroy
  has_many :conveniosformas, :dependent =>:destroy
  has_many :mejoramientos
  belongs_to :comuna

  def name
    self.nro_convenio.to_s + " - " + self.ejecutor.to_s + " (" + self.vigencia.to_s + ")"
  end

  acts_as_chainable :to => :conveniosresolucion,
                    :root => true,
                    :order => ["to_number(nro_convenio) asc"],
                    :conditions => ["tipo_solucion = 'MEJORAMIENTO' and cr ='SI'"]


#  def after_create
#    @mejoramientositems = Mejoramientositem.all
#    @mejoramientositems.each do |mejoramientositem|
#      @conveniosmejoramiento = Conveniosmejoramiento.new
#      @conveniosmejoramiento.convenio_id = self.id
#      @conveniosmejoramiento.mejoramientositem_id = mejoramientositem.id
#      @conveniosmejoramiento.valor_unitario = 0
#      @conveniosmejoramiento.user_id = self.user_id
#      @conveniosmejoramiento.save
#    end
#  end

  def coordinador
    @nombre
    self.conveniosresoluciones.each do |conveniosresolucion|
      if conveniosresolucion.user_coordinador.to_s != ""
        @nombre = User.find(conveniosresolucion.user_coordinador).nombre rescue nil
      end
    end
    return @nombre
  end

  def interventor
    @nombre
    self.conveniosresoluciones.each do |conveniosresolucion|
      if conveniosresolucion.user_interventor.to_s != ""
        @nombre = User.find(conveniosresolucion.user_interventor).nombre rescue nil
      end
    end
    return @nombre
  end

  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end

end
