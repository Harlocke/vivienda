class Indicadoresactualizacion < ActiveRecord::Base
  belongs_to :indicador
  belongs_to :user
end
