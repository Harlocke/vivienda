class Contratosinterventoria < ActiveRecord::Base
  belongs_to :contrato
  belongs_to :user
end
