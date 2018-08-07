class Contratosobservacion < ActiveRecord::Base
    belongs_to :contrato
    belongs_to :user

  validates_presence_of :observacion


end
