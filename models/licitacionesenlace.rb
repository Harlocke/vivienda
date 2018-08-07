class Licitacionesenlace < ActiveRecord::Base
  belongs_to :licitacion
  belongs_to :user
  belongs_to :analisisprecio
  belongs_to :grupo
  has_many :licitacionesenlacespagos
  has_many :licitacionesinformesdetalles
  has_many :licenlacesimagenes

  validates_presence_of :analisisprecio_descripcion

  def analisisprecio_descripcion
    analisisprecio.descripcion if analisisprecio
  end

  def analisisprecio_descripcion=(descripcion)
    self.analisisprecio = Analisisprecio.find_or_create_by_descripcion(descripcion) unless descripcion.blank?
  end

##  def after_create
##    lastid = self.id
##    nextid = 0
##    objetos = Objeto.find_by_sql("select max(id) id1 from licitacionesprecios")
##    objetos.each do |objeto|
##      if objeto.id1
##        nextid = objeto.id1.to_i + 1
##      else
##        nextid = 1
##      end
##    end
##    ActiveRecord::Base.connection.execute(
##      "insert into licitacionesprecios (id,licitacionesenlace_id,proponente,descripcion,fecha,user_id,
#                                        user_actualiza,porc_admin,porc_utilidad,created_at,updated_at)
#       select #{nextid},#{lastid},proponente,descripcion,fecha,user_id,user_actualiza,porc_admin,porc_utilidad,
#              CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP()
#       from   analisisprecios where id = #{self.analisisprecio_id}#")
##    ActiveRecord::Base.connection.execute(
##      "insert into licitacionesprecioselementos (id,licitacionesprecio_id,elemento_id,cantidad,valorunitario,
#                                                 valortotal,user_id,porc_rendimiento,porc_desperdicio,
#                                                 created_at,updated_at)
#       select 0,#{nextid},elemento_id,cantidad,valorunitario,valortotal,user_id,porc_rendimiento,porc_desperdicio,
#              CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP()
#       from   analisisprecioselementos where analisisprecio_id = #{self.analisisprecio_id}#")
##  end

end
