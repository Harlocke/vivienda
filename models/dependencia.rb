class Dependencia < ActiveRecord::Base
  has_many :requerimientos
  has_many :users
  has_many :usersinventarios
  has_many :correspondenciasdependencias
  has_many :dependenciasusers
  has_many :correspondenciasrecibidas
  has_many :correspondenciasenviadas
  has_many :correspondenciasinternas
  has_many :corresinternasdirigidos
  has_many :comitesactividades
  has_many :empleados
  has_many :indicadores
  has_many :impresorasconsumos


  def depcorreo
    @cant = 0
    @correos = ""
    @dependenciasusers = Dependenciasuser.find_all_by_dependencia_id(self.id)
    @dependenciasusers.each do |dependenciasuser|
      @cant = @cant + 1
      if @cant == @dependenciasusers.count
        @correos = @correos.to_s + dependenciasuser.user.email.to_s
      else
        @correos = @correos.to_s + dependenciasuser.user.email.to_s + ','
      end
    end
    return @correos
  end
  
end
