class Encuesta < ActiveRecord::Base	
	belongs_to :user


  validates_presence_of :claridad, :suministro, :satisfaccion, :medio, :comunicacion_interna, :espacios
  validates_presence_of :claridad_comentario, :if => :in_a?
  validates_presence_of :suministro_comentario, :if => :in_b?
  validates_presence_of :satisfaccion_comentario, :if => :in_c?
  validates_presence_of :medio_cual, :if => :in_d?

  def in_a?
    self.claridad.to_i < 3
  end

  def in_b?
    self.suministro.to_i < 3
  end

  def in_c?
    self.satisfaccion.to_i < 3
  end

  def in_d?
    self.medio.to_s == 'OTROS'
  end

end


      #t.string :claridad
      #t.string :claridad_comentario
      #t.string :suministro
      #t.string :suministro_comentario
      #t.string :satisfaccion
      #t.string :satisfaccion_comentario
      #t.string :espacios
      #t.string :medio
      #t.string :medio_cual
      #t.string :comunicacion_interna
      #t.string :observacion

