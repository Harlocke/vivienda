class Tiposactosdocumento < ActiveRecord::Base
  belongs_to :tiposacto
  belongs_to :user
end
