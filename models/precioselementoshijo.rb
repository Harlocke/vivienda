class Precioselementoshijo < ActiveRecord::Base
  validates_presence_of :elementoenlace_id, :cantidad

  belongs_to :precioselemento

end
