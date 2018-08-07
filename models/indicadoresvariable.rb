class Indicadoresvariable < ActiveRecord::Base
  belongs_to :indicador
  belongs_to :user
end
