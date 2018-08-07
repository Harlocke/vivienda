class Corresinternasdirigido < ActiveRecord::Base
  belongs_to :correspondenciasinterna
  belongs_to :dependencia
  belongs_to :user

  validates_presence_of :dependencia_id, :if => :in_us?
  validates_presence_of :user_id, :if => :in_us2?

  def in_us?
    user_id.to_s  == ""
  end

  def in_us2?
    dependencia_id.to_s  == ""
  end

end
