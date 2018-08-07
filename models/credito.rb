class Credito < ActiveRecord::Base
  belongs_to :persona
  belongs_to :entidad
  belongs_to :user

  validates_presence_of :entidad_id, :fecha_credito, :fecha_vencimiento, :resolucion, :estado
  validates_numericality_of :valor

  def respaldo(userid)
    antcredito = Antcredito.new
    antcredito.persona_id = self.persona_id
    antcredito.consecutivo_viv = self.consecutivo_viv
    antcredito.entidad_id = self.entidad_id
    antcredito.valor = self.valor
    antcredito.fecha_credito = self.fecha_credito
    antcredito.fecha_vencimiento = self.fecha_vencimiento
    antcredito.estado = self.estado
    antcredito.resolucion = self.resolucion
    antcredito.user_id = userid
    antcredito.save
  end
 
end
