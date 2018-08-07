class Seguimiento < ActiveRecord::Base
  belongs_to :user
  has_many :seguimientoslicitaciones
  has_many :seguimientosimagenes
  has_many :seguimientosobservaciones
  has_many :seguimientosmodificaciones
  belongs_to :contrato
  
  validates_presence_of :nro_contrato, :anno
  validates_numericality_of :nro_contrato, :anno
  validate :nrocontrato

  def nrocontrato
    if self.nro_contrato.to_s != "" and self.anno.to_s != ""
      if Contrato.exists?(["nro_contrato = '#{self.nro_contrato}' and to_char(fecha_inicio,'YYYY') = '#{self.anno}'"]) == false
        errors.add :nro_contrato, '* Contrato Invalido'
        errors.add :anno, '* Contrato Invalido'
      end
    end
  end

  def before_save
   @contrato = Contrato.find(:first, :conditions=>["nro_contrato = '#{self.nro_contrato}' and to_char(fecha_inicio,'YYYY') = '#{self.anno}'"])
   self.contrato_id = @contrato.id
  end

  def self.search(search, page)
      if search.nil?
         s = search
      else
         s = search.upcase
      end
      paginate :per_page => 14,
               :page => page,
               :conditions => ['responsable like ? or nro_contrato like ? or objeto like ? ', "%#{s}%", "%#{s}%", "%#{s}%"],
               :order => 'created_at desc'
  end

  def porcentajeavance
    @pagado = 0
    self.seguimientoslicitaciones.each do |seguimientoslicitacion|
      @pagado = @pagado + Licitacionesenlacespago.sum("valor",:conditions=>["licitacionesenlace_id in (select id from licitacionesenlaces where licitacion_id =#{seguimientoslicitacion.licitacion_id})"])
    end
    return ((@pagado/self.valor.to_f)*100).to_f
  end
end
