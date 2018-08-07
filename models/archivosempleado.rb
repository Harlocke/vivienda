class Archivosempleado < ActiveRecord::Base
  belongs_to :archivo
  belongs_to :empleado
  belongs_to :user

  def empleado_autobuscar
    empleado.autobuscar if empleado
  end

  def empleado_autobuscar=(autobuscar)
    self.empleado = Empleado.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end
end
