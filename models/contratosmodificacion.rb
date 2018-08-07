class Contratosmodificacion < ActiveRecord::Base
  belongs_to :contrato
  belongs_to :user

  validates_presence_of :tipo_modificacion
  validates_presence_of :valor, :unless=> :plazo_mes?
  validates_presence_of :plazo_mes, :unless=> :valor?
  validates_presence_of :plazo_dias, :unless=> :plazo_mes?
  validates_numericality_of :valor, :allow_nil => true

  def dtipomodificacion
     if (self.tipo_modificacion == 'P')
       return 'PLAZO'
     elsif (self.tipo_modificacion == 'V')
       return 'VALOR'
     elsif (self.tipo_modificacion == 'C')
       return 'CLAUSULAS'
     elsif (self.tipo_modificacion == 'PV')
       return 'PLAZO - VALOR'
     elsif (self.tipo_modificacion == 'PC')
       return 'PLAZO - CLAUSULAS'
     elsif (self.tipo_modificacion == 'PVC')
       return 'PLAZO - VALOR - CLAUSULAS'
     elsif (self.tipo_modificacion == 'VC')
       return 'VALOR - CLAUSULAS'
     end
  end

  def before_create
    @contrato = Contrato.find(self.contrato_id)
    ingreso  = 'N'
    if @contrato.fecha_masmodi.to_s != ""
      fechafinal = @contrato.fecha_masmodi
    else
      fechafinal = @contrato.fecha_final
    end
    if @contrato.valor_masmodi.to_i > 0
      valorfinal = @contrato.valor_masmodi
    else
      valorfinal = @contrato.valor_contrato
    end
    if self.tipo_modificacion.to_s != 'C'
      if self.plazo_mes.to_i > 0
        ingreso = 'S'
        @objeto = Objeto.find_by_sql("select ADD_MONTHS(to_date('#{fechafinal}','dd/mm/yyyy'),#{self.plazo_mes}) fch from dual")
        @objeto.each do |objeto|
          fechafinal =  objeto.fch.to_date
        end
        if self.plazo_dias.to_i > 0
          ingreso = 'S'
          @objeto = Objeto.find_by_sql("select to_date('#{fechafinal}','yyyy-mm-dd') + #{self.plazo_dias} fch
                                       from dual")
          @objeto.each do |objeto|
             fechafinal =  objeto.fch.to_date
          end
        end
      elsif self.plazo_dias.to_i > 0
        ingreso = 'S'
        @objeto = Objeto.find_by_sql("select to_date('#{fechafinal}','dd/mm/yyyy') + #{self.plazo_dias} fch
                                     from dual")
        @objeto.each do |objeto|
           fechafinal =  objeto.fch.to_date
        end
      end
      if ingreso == 'S'
        ActiveRecord::Base.connection.execute("update contratos set fecha_masmodi = '#{fechafinal}' where id = #{@contrato.id}")
      end
      if self.valor.to_i > 0
        valorfinal = valorfinal + self.valor.to_i
        ActiveRecord::Base.connection.execute("update contratos set valor_masmodi = #{valorfinal} where id = #{@contrato.id}")
      end
      ActiveRecord::Base.connection.execute("update contratos set estado = 'E' where decode(fecha_masmodi,null,fecha_final,fecha_masmodi) > trunc(sysdate)")
    end
  end

  def before_destroy
    @contrato = Contrato.find(self.contrato_id)
    ingreso  = 'N'
    if @contrato.fecha_masmodi.to_s != ""
      fechafinal = @contrato.fecha_masmodi
    else
      fechafinal = @contrato.fecha_final
    end
    if @contrato.valor_masmodi.to_i > 0
      valorfinal = @contrato.valor_masmodi
    else
      valorfinal = @contrato.valor_contrato
    end
    if self.tipo_modificacion.to_s != 'C'
      if self.plazo_mes.to_i > 0
        ingreso = 'S'
        @objeto = Objeto.find_by_sql("select ADD_MONTHS(to_date('#{fechafinal}','dd/mm/yyyy'),-#{self.plazo_mes}) fch from dual")
        @objeto.each do |objeto|
          fechafinal =  objeto.fch.to_date
        end
        if self.plazo_dias.to_i > 0
          ingreso = 'S'
          @objeto = Objeto.find_by_sql("select to_date('#{fechafinal}','yyyy-mm-dd') - #{self.plazo_dias} fch
                                       from dual")
          @objeto.each do |objeto|
             fechafinal =  objeto.fch.to_date
          end
        end
      elsif self.plazo_dias.to_i > 0
        ingreso = 'S'
        @objeto = Objeto.find_by_sql("select to_date('#{fechafinal}','dd/mm/yyyy') - #{self.plazo_dias} fch
                                     from dual")
        @objeto.each do |objeto|
           fechafinal =  objeto.fch.to_date
        end
      end
      if ingreso == 'S'
        ActiveRecord::Base.connection.execute("update contratos set fecha_masmodi = '#{fechafinal}' where id = #{@contrato.id}")
        ActiveRecord::Base.connection.execute("update contratos set fecha_masmodi = null where id = #{@contrato.id} and fecha_masmodi = fecha_final")
      end
      if self.valor.to_i > 0
        valorfinal = valorfinal - self.valor.to_i
        ActiveRecord::Base.connection.execute("update contratos set valor_masmodi = #{valorfinal} where id = #{@contrato.id}")
        ActiveRecord::Base.connection.execute("update contratos set valor_masmodi = null where id = #{@contrato.id} and valor_masmodi = valor_contrato")
      end
    end


  end

end
#
#
