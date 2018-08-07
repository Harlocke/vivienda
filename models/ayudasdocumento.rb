class Ayudasdocumento < ActiveRecord::Base
  belongs_to :ayuda
  belongs_to :user
  has_many :ayudasdocimagenes, :dependent =>:destroy

  validates_presence_of :tiposdocumemto

end
