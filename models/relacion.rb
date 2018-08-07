class Relacion < ActiveRecord::Base
  belongs_to :persona
  belongs_to :benevivienda
end
