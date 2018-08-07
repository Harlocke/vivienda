class Correspondenciasdependencia < ActiveRecord::Base
  belongs_to :correspondenciasrecibida
  belongs_to :dependencia
  belongs_to :user

  validates_presence_of :dependencia_id

  def bandejacorrespondencia
    last_id = Correspondenciasdependencia.last("id")
    correspondenciasdependencia = Correspondenciasdependencia.find(last_id)
    @dependenciasusers = Dependenciasuser.find_all_by_dependencia_id(correspondenciasdependencia.dependencia_id)
    @dependenciasusers.each do |dependenciasuser|
      correspondenciasasignada = Correspondenciasasignada.new
      correspondenciasasignada.correspondenciasrecibida_id = correspondenciasdependencia.correspondenciasrecibida_id
      correspondenciasasignada.user_id = dependenciasuser.user_id
      correspondenciasasignada.tipo_asignacion = '1'
      correspondenciasasignada.estado = 'A'
#      dias = Correspondenciasclase.find(correspondenciasdependencia.correspondenciasrecibida.correspondenciasclase_id).dias rescue nil
#      correspondenciasasignada.fecha_limite = fechaprogcorrespondencia(correspondenciasdependencia.correspondenciasrecibida.fecha_elaboracion, dias)
      correspondenciasasignada.save
    end
  end


end
