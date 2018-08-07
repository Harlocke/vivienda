class Viviendastramite < ActiveRecord::Base
  belongs_to :vivienda
  belongs_to :viviendastipostramite
  validates_presence_of :viviendastipostramite_id, :fecha_inicio

  def before_create
    if self.viviendastipostramite_id.to_s == "10102"
      vivienda = Vivienda.find(self.vivienda_id)
      if vivienda.fecha_registro.to_s == ""
        festivos = Festivo.find_by_sql("select fnc_dias(to_date('#{self.fecha_inicio}','dd/mm/yyyy'),90) fch from dual")
        festivos.each do |festivo|
          vivienda.fecha_registro = festivo.fch
        end
        vivienda.save
      end
    end
    if self.viviendastipostramite_id.to_s == "10073"
      vivienda = Vivienda.find(self.vivienda_id)
      if vivienda.fecha_registro.to_s != ""
        if vivienda.fecha_registro > self.fecha_inicio
          vivienda.fecha_registro = ""
          vivienda.save
        end
      end
    end
  end

end
