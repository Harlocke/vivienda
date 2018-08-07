class Legalizazonasreglamento < ActiveRecord::Base
  belongs_to :legalizacion
  belongs_to :user

  validates_presence_of :rph, :fecharph, :notariarph

  def eliminar
    if Legalizazonasmatricula.exists?(["legalizazonasreglamento_id = #{self.id}"]) == true
      return 'N'
    else
      return 'S'
    end
  end
end
