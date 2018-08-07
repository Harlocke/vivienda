class Licitacion < ActiveRecord::Base
  belongs_to :user
  has_many :licitacionesenlaces, :dependent =>:destroy
  has_many :seguimientoslicitaciones
  has_many :licitacionesimagenes, :dependent =>:destroy
  has_many :licitacionesobservaciones, :dependent =>:destroy
  has_many :licitacionesinformes, :dependent =>:destroy
  has_many :licitacionespagos, :dependent =>:destroy
  belongs_to :persona
  belongs_to :resolucion

  validates_presence_of :persona_autobuscar
  validates_presence_of :descripcion

  def persona_autobuscar
    persona.autobuscar if persona
  end

  def persona_autobuscar=(autobuscar)
    self.persona = Persona.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

  def self.search(search, page)
      if search.nil?
         s = search
      else
         s = search.upcase
      end
      paginate :per_page => 14,
               :page => page,
               :conditions => ['codigo like ? or descripcion like ?', "%#{s}%", "%#{s}%"],
               :order => 'created_at desc'
  end

  def porcentajeavance
    vlrejecucion = Licitacionesinformesdetalle.sum("valor_total", :conditions=>["licitacion_id = #{self.id}"])
    logger.error("valor vlrejecucion ..."+vlrejecucion.to_s)
    logger.error("valor self.valor_resolucion ..."+self.valor_resolucion.to_s)
    porcentajea = (vlrejecucion.to_f / self.valor_resolucion.to_f).to_f * 100
    return porcentajea
  end

end
