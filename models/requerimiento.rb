class Requerimiento < ActiveRecord::Base
  belongs_to :persona
  has_many :actividades
  belongs_to :dependencia

end
