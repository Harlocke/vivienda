class Agendasfecha < ActiveRecord::Base
  belongs_to :agendasproceso
  has_many :agendashorarios, :dependent =>:destroy

  def name
    self.fecha.to_s rescue nil
  end

  acts_as_chainable :select_label => 'F E C H A',
                    :from => :agendasproceso,
                    :to => :agendashorario,
                    :conditions=>["fecha >= trunc(sysdate) and estado = 'ACTIVO'"],
                    :order => :fecha


  def after_create
    if self.id
      ActiveRecord::Base.connection.execute("begin prc_agendasprogramacion(#{self.id}, #{self.cantidad.to_i}, '#{self.hora_inicio.to_s}', '#{self.hora_fin.to_s}', #{self.intervalo.to_i}); end;")
    end
  end

end
