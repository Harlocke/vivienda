class Agendashorario < ActiveRecord::Base
  belongs_to :agendasfecha

  def name
    self.horario rescue nil
  end

  acts_as_chainable :select_label => 'H O R A R I O',
                    :from => :agendasfecha,
                    :conditions=>["((select count(9) from agendas where agendashorario = agendashorarios.id) < cantidad) and estado = 'ACTIVO'"],
                    :order => :id
                    
end
