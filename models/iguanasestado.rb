class Iguanasestado < ActiveRecord::Base
  has_many :iguanasestadosnotas
  has_many :iguanas
end
