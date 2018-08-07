class Seguimientoslicitacion < ActiveRecord::Base
  belongs_to :seguimiento
  belongs_to :licitacion
  validates_presence_of :licitacion_id

  validate :lic, :rep

  def lic
    if Licitacion.exists?(["id = #{self.licitacion_id.to_i}"]) == false
      errors.add :licitacion_id, "* El presupuesto #{self.licitacion_id.to_s} NO existe. Verifique!!!"
    end
  end

  def rep
    if Seguimientoslicitacion.exists?(["licitacion_id = #{self.licitacion_id}"]) == true
      errors.add :licitacion_id, "* El presupuesto #{self.licitacion_id.to_s} ya se encuentra Asociado. Verifique!!!"
    end
  end


end