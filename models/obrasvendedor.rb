class Obrasvendedor < ActiveRecord::Base
  belongs_to :obraspublica
  belongs_to :user
end
