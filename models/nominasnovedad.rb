class Nominasnovedad < ActiveRecord::Base
  belongs_to :empleado

  validates_presence_of :tipo_novedad, :fecha_novedad
  validates_presence_of :valor, :unless=> :dias?, :if => :in_us2?
  validates_presence_of :dias, :unless=> :valor?, :if => :in_us2?
  validates_numericality_of :valor, :allow_nil => true, :if => :in_us2?
  validates_numericality_of :dias, :allow_nil => true, :if => :in_us2?
  validates_presence_of :fecha_inicial, :fecha_final, :if => :in_us1?

  def in_us1?
    self.tipo_novedad == '4'
  end

  def in_us2?
    self.tipo_novedad != '4' and self.tipo_novedad != '5' and self.tipo_novedad != '6'
  end

  def dtiponovedad
     if self.tipo_novedad == "1"
       return "DEDUCCION"
     elsif self.tipo_novedad == "2"
       return "INCAPACIDAD"
     elsif self.tipo_novedad == "3"
       return "DEVENGADO"
     elsif self.tipo_novedad == "4"
       return "VACACIONES"
     elsif self.tipo_novedad == "5"
       return "PRIMA DE VACACIONES"
     elsif self.tipo_novedad == "6"
       return "BONIFICACION VACACIONES"
     elsif self.tipo_novedad == "7"
       return "PRIMA DE NAVIDAD"

    end
  end

  def before_create
    if self.tipo_novedad == '4'
      @dias = 0
      @objeto = Objeto.find_by_sql("SELECT to_date('#{self.fecha_final.to_date}','YYYY-MM-DD') - to_date('#{self.fecha_inicial.to_date}','YYYY-MM-DD') dias from dual")
      @objeto.each do |objeto|
        @dias = objeto.dias + 1
      end
      #logger.error("Nro de dias.." + @dias.to_s)
      if @dias.to_i > 0
        @valdiasalario = 0
        contratosvinculado = Contratosvinculado.find(:last, :conditions => ["empleado_id = #{self.empleado_id} "])
        @valdiasalario = (contratosvinculado.salario.to_f / 30).round
        #logger.error("Valor Dia Salario.." + @valdiasalario.to_s)
        self.valor = @valdiasalario * @dias
        self.dias = @dias
        #logger.error("Valor Novedad.." + self.valor.to_s)
      end
    end
  end

  def after_create
    #logger.error("After createee")
    if self.tipo_novedad == '4'
      @dias = 15
      contratosvinculado = Contratosvinculado.find(:last, :conditions => ["empleado_id = #{self.empleado_id} "])
      @valdiasalario = (contratosvinculado.salario.to_f / 30).round
      @nominasnovedad = Nominasnovedad.new
      @nominasnovedad.empleado_id = self.empleado_id
      @nominasnovedad.tipo_novedad = '5'
      @nominasnovedad.fecha_novedad = self.fecha_novedad
      @nominasnovedad.valor = @valdiasalario * @dias
      @nominasnovedad.dias = @dias
      @nominasnovedad.fecha_inicial = self.fecha_inicial
      @nominasnovedad.fecha_final = self.fecha_final
      @nominasnovedad.observaciones = self.observaciones
      @nominasnovedad.save
      @nominasnovedad = Nominasnovedad.new
      @nominasnovedad.empleado_id = self.empleado_id
      @nominasnovedad.tipo_novedad = '6'
      @nominasnovedad.fecha_novedad = self.fecha_novedad
      @nominasnovedad.valor = @valdiasalario * 2
      @nominasnovedad.dias = 2
      @nominasnovedad.fecha_inicial = self.fecha_inicial
      @nominasnovedad.fecha_final = self.fecha_final
      @nominasnovedad.observaciones = self.observaciones
      @nominasnovedad.save
    end
  end

end
