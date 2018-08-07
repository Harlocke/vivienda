class Titulacionescargue < ActiveRecord::Base
  belongs_to :titulacion
  validates_presence_of :identificacion, :primer_nombre, :primer_apellido, :direccion
  validate :telefons

  def telefons
    if self.telefono1.to_s == "" and self.telefono2.to_s == "" and self.celular.to_s == ""
      errors.add :telefono1, "Debe tener minimo 1 Telefono"
      errors.add :telefono2, "Debe tener minimo 1 Telefono"
      errors.add :celular, "Debe tener minimo 1 Telefono"
    end
  end


end
