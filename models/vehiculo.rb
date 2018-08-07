class Vehiculo < ActiveRecord::Base
  has_many :vehiculosprogramaciones

  def diasrestantes(fecha)
    @objetos = Objeto.find_by_sql(["select fnc_horasutilizadas('#{fecha.to_date}',#{self.id}) cant
                                    from   dual"])
    @objetos.each do |objeto|
      return objeto.cant
    end
  end

  def veh
    return self.telefono.to_s + " - " + self.celular.to_s
  end

  def nombrec(fecha)
    @objetos = Objeto.find_by_sql(["select fnc_vehiculoconductor('#{fecha.to_date}',#{self.id}) nombre
                                    from   dual"])
    @objetos.each do |objeto|
      return objeto.nombre
    end
  end
end
