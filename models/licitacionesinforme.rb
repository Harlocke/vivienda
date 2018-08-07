class Licitacionesinforme < ActiveRecord::Base
  belongs_to :user
  belongs_to :licitacion
  has_many :licitacionesinformesdetalles, :dependent =>:destroy

  def after_create
#    @licitacionesinformesdetalle = Licitacionesinformesdetalle.new
#    @licitacionesinformesdetalle.mejoramientosinterventoria_id = self.id
#    @licitacionesinformesdetalle.licitacion_id = self.mejoramiento_id
#    @licitacionesinformesdetalle.user_id = self.user_id
#    @licitacionesinformesdetalle.save
#    last_id = Licitacionesinformesdetalle.maximum('id')
    @licitacionesenlaces = Licitacionesenlace.find(:all,:conditions=>["licitacion_id = #{self.licitacion_id}"],:order=>"id asc")
    @licitacionesenlaces.each do |licitacionesenlace|
      #logger.error("SIFI - Ingresa")
      @lic = Licitacionesinformesdetalle.new
      @lic.licitacionesinforme_id = self.id
      @lic.licitacion_id = self.licitacion_id
      @lic.licitacionesenlace_id = licitacionesenlace.id
      @lic.analisisprecio_id = licitacionesenlace.analisisprecio_id
      @lic.cantidad = 0
      @lic.valor_total = 0
      @lic.save
      last_id2 = Licitacionesinforme.maximum('id')
    end
  end

  def porcentajeavanceinforme
    vlrejecucion = self.licitacionesinformesdetalles.sum("valor_total")
    porcentajea = (vlrejecucion.to_f / self.licitacion.valor_resolucion.to_f).to_f * 100
    return porcentajea
  end
end
