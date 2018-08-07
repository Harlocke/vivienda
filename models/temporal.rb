class Temporal < ActiveRecord::Base
  belongs_to :resolucion
  belongs_to :persona

  require 'number_to_words'
  
end
