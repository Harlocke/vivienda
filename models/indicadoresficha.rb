class Indicadoresficha < ActiveRecord::Base
  belongs_to :indicador
  has_many :indicadoresfichasimagenes, :dependent =>:destroy
  
  validates_presence_of :valor_numerador
  validates_numericality_of :valor_numerador

  validates_presence_of :valor_denominador, :if => :in_us2?
  validates_numericality_of :valor_denominador, :if => :in_us2?

  def in_us2?
    self.indicador.clase_indicador.to_s == 'COMPUESTO' or self.indicador.clase_indicador.to_s == 'ESPECIFICO'
  end

  def before_save
    if self.indicador.clase_indicador.to_s == 'COMPUESTO'
      begin
        if self.valor_denominador.to_f == 0.0 and self.valor_numerador.to_f > 0.0
          self.resultado = 100.to_f
        elsif self.valor_denominador.to_f > 0.0 and self.valor_numerador.to_f == 0.0
          self.resultado = 0.to_f
        elsif self.valor_denominador.to_f == 0.0 and self.valor_numerador.to_f == 0.0
          self.resultado = 0.to_f
        else
          self.resultado = ((self.valor_numerador.to_f / self.valor_denominador.to_f)*100).to_f
        end
        if self.resultado > 100.to_f
          self.resultado = 100.to_f
        end
      rescue self.resultado = 0
      end      
    elsif self.indicador.clase_indicador.to_s == 'SIMPLE'
      self.resultado = self.valor_numerador.to_f
    elsif self.indicador.clase_indicador.to_s == 'ESPECIFICO'
      begin
        if self.valor_denominador.to_f == 0.0 and self.valor_numerador.to_f > 0.0
          self.resultado = 100.to_f
        elsif self.valor_denominador.to_f > 0.0 and self.valor_numerador.to_f == 0.0
          self.resultado = 0.to_f
        elsif self.valor_denominador.to_f == 0.0 and self.valor_numerador.to_f == 0.0
          self.resultado = 0.to_f
        else
          self.resultado = ((self.valor_numerador.to_f / self.valor_denominador.to_f)*100).to_f
        end
        if self.resultado > 100.to_f
          self.resultado = 100.to_f
        end
        if self.resultado.to_f > 0
          self.resultado = self.resultado.to_f * self.indicador.valor_constante.to_f
        end
      rescue self.resultado = 0
      end      
    end
    if self.indicador.seguridadysalud.to_s == 'SI'
      if self.indicador.unidad_medida.to_s == 'PORCENTAJE'
        self.resultado = ( (self.valor_numerador.to_f / self.valor_denominador.to_f).to_f ) *100.to_f
      else
        self.resultado = ( (self.valor_numerador.to_f / self.valor_denominador.to_f).to_f )
      end
    end
  end

  def estado
    if self.indicador.clase_indicador.to_s == 'SIMPLE'
        if self.valor_numerador.to_f >= self.indicador.meta_periodica.to_f 
          return "<img src='/images/verde1.png' title='No es necesario tomar acciones'/>"
        elsif self.valor_numerador.to_f >= self.indicador.limite.to_f 
          return "<img src='/images/amarillo1.png' title='Se debe tomar acciones preventivas o Oportunidad de mejora'/>"
        elsif self.valor_numerador.to_i < self.indicador.limite.to_i and self.valor_numerador.to_f > 0 
          return "<img src='/images/rojo1.png' title='Se debe tomar acciones correctivas'/>"
        end
    else
      if self.resultado.to_f >= self.indicador.meta_periodica.to_f 
        return "<img src='/images/verde1.png' title='No es necesario tomar acciones'/>"
      elsif self.resultado.to_f >= self.indicador.limite.to_f 
        return "<img src='/images/amarillo1.png' title='Se debe tomar acciones preventivas o Oportunidad de mejora'/>"
      elsif self.resultado.to_i < self.indicador.limite.to_i and self.resultado.to_f > 0 
        return "<img src='/images/rojo1.png' title='Se debe tomar acciones correctivas'/>"
      elsif self.resultado == 0 
        if self.indicador.cre_dec.to_s == 'DECRECIENTE'
          return "<img src='/images/verde1.png' title='No es necesario tomar acciones'/>"
        else
          return "<img src='/images/rojo1.png' title='Se debe tomar acciones correctivas'/>"
        end
      end 
    end  
  end

  def unidadmedida
    if self.indicador.unidad_medida.to_s == 'NUMERO'
      return nil
    elsif  self.indicador.unidad_medida.to_s == 'PORCENTAJE'
      return '%'
    elsif  self.indicador.unidad_medida.to_s == 'NUMERO'
      return nil     
    end
  end
end
