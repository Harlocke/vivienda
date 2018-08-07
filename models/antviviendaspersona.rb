class Antviviendaspersona < ActiveRecord::Base
  belongs_to :persona
  belongs_to :vivienda
end
