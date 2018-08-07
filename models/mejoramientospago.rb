class Mejoramientospago < ActiveRecord::Base
  belongs_to :user
  belongs_to :mejoramiento
  belongs_to :conveniosforma
  has_many :mejoramientospagoslistas

  validates_presence_of :conveniosforma_id, :fecha_pago, :valor, :descripcion
  validate :validaingreso

#  def after_create
#    @listaspagos = Listaspago.find(:all)
#    @listaspagos.each do |listaspago|
#      @mejoramientospagoslista = Mejoramientospagoslista.new
#      @mejoramientospagoslista.mejoramientospago_id = self.id
#      @mejoramientospagoslista.listaspago_id = listaspago.id
#      @mejoramientospagoslista.save
#    end
#  end

#  def validaingreso
#    if self.id
#      sumvalor = Mejoramientospago.sum('valor', :conditions => ["mejoramiento_id = #{self.mejoramiento_id} and id != #{self.id}"])
#      sumvalor = sumvalor + self.valor
#      if sumvalor > self.mejoramiento.valor_resolucion
#        errors.add :valor, "El valor del pago supera el valor del subsidio"
#      end
#    end
#  end

  def validaingreso
    if self.id
      @clase = Conveniosforma.find(self.conveniosforma_id)
      if @clase.to_s == 'EJECUCION'
        sumvalor = Mejoramientospago.sum('valor', :conditions => ["mejoramiento_id = #{self.mejoramiento_id} and id != #{self.id}"])
        sumvalor = sumvalor + self.valor
        if sumvalor > self.mejoramiento.valor_resolucion
          errors.add :valor, "El valor del pago supera el valor del subsidio"
        end
      elsif @clase.to_s == 'DIAGNOSTICO'
        @valordiag = Mejoramientoselemento.find(:first, :conditions=>["mejoramiento_id = #{self.mejoramiento_id} and mejoramientositem_id = 10043"]).valor_total.to_i
        sumvalor = Mejoramientospago.sum('valor', :conditions => ["mejoramiento_id = #{self.mejoramiento_id} and id != #{self.id} and clase = 'DIAGNOSTICO'"])
        sumvalor = sumvalor + self.valor
        if sumvalor > @valordiag
          errors.add :valor, "El valor del pago supera el valor del subsidio para el pago del Diagnostico"
        end
      end
    end
  end

  
end
