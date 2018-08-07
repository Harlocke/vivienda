class Convenioscontrato < ActiveRecord::Base
  belongs_to :convenio
  belongs_to :user
  belongs_to :contrato

  validates_presence_of :nro_contrato, :anno
end


