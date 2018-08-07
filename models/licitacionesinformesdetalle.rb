class Licitacionesinformesdetalle < ActiveRecord::Base
  belongs_to :licitacionesinforme
  belongs_to :licitacionesenlace
end
