class Agendasparametro < ActiveRecord::Base
  belongs_to :agendasproceso

  validates_presence_of :dia, :hora_inicio, :hora_fin, :intervalo, :cantidad
  validate :dia_exist

  def dia_exist
  	if self.dia and self.id.to_i == 0
	  	if Agendasparametro.exists?(["agendasproceso_id = #{self.agendasproceso_id} and dia = '#{self.dia}'"])
         errors.add :dia, "* El dia ya esta agendado.."
      end
    end
  end  


end
