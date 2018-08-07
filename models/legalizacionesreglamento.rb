class Legalizacionesreglamento < ActiveRecord::Base
  belongs_to :legalizacion
  belongs_to :user
  
  validates_presence_of :rph, :fecharph, :notariarph

  def eliminar
    if Legalizacionesmatricula.exists?(["legalizacionesreglamento_id = #{self.id}"]) == true
      return 'N'
    else
      return 'S'
    end
  end

end
