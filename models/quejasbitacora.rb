class Quejasbitacora < ActiveRecord::Base
  belongs_to :queja
  belongs_to :user
end
