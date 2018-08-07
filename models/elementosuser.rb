class Elementosuser < ActiveRecord::Base
  belongs_to :elemento
  belongs_to :user

  validates_presence_of :user_id, :fecha_inicio
  
  def before_create
    @elementosusers = Elementosuser.find(:all, :conditions=>["elemento_id = #{self.elemento_id} and fecha_fin is null"])
    @elementosusers.each do |elementosuser|
      elementosuser.fecha_fin = Time.now - 86400
      elementosuser.save
    end
  end
end
