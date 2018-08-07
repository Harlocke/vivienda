class Mensajesenvio < ActiveRecord::Base
  belongs_to :user
  belongs_to :soporte

  validates_presence_of :calificacion, :observaciones

  def self.enviado(user_id, vivienda_id)
    Mensajesenvio.exists?(["user_id = ? and vivienda_id = ?", user_id, vivienda_id])
  end
end
