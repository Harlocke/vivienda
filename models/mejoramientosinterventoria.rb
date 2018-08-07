class Mejoramientosinterventoria < ActiveRecord::Base
  belongs_to :mejoramiento
  belongs_to :user
  has_many :mejoramientosinformes, :dependent =>:destroy

  def after_create
    @mejoramientosinforme = Mejoramientosinforme.new
    @mejoramientosinforme.mejoramientosinterventoria_id = self.id
    @mejoramientosinforme.mejoramiento_id = self.mejoramiento_id
    @mejoramientosinforme.user_id = self.user_id
    @mejoramientosinforme.save
    last_id = Mejoramientosinforme.maximum('id')
    #logger.error("SIFI - Informa #{last_id.to_s rescue nil}")
    @mejoramientoselementos = Mejoramientoselemento.find(:all,:conditions=>["mejoramiento_id = #{self.mejoramiento_id}"],:order=>"mejoramientositem_id asc")
    @mejoramientoselementos.each do |mejoramientoselemento|
      #logger.error("SIFI - Ingresa")
      @mej = Mejorainformeselemento.new
      @mej.mejoramientosinforme_id = last_id
      @mej.mejoramientoselemento_id = mejoramientoselemento.id
      @mej.cantidad = 0
      @mej.save
      last_id2 = Mejorainformeselemento.maximum('id')
      habilitacriterio(last_id2,self.user_id,mejoramientoselemento.id,self.mejoramiento_id)
    end
  end

  def habilitacriterio(id, userid, mejoramientoselementoid, mejoramientoid)
     @objetos = Objeto.find_by_sql("select distinct ic.capituloscriterio_id, ic.created_at
                                    from   mejorainformescriterios ic, mejorainformeselementos ie, mejoramientosinformes i, mejoramientosinterventorias it
                                    where  ic.mejorainformeselemento_id = ie.id
                                    and    ie.mejoramientosinforme_id = i.id
                                    and    ie.mejoramientoselemento_id = #{mejoramientoselementoid}
                                    and    i.mejoramientosinterventoria_id = it.id
                                    and    it.mejoramiento_id = #{mejoramientoid}
                                    and    ic.realizado is null
                                    group by ic.capituloscriterio_id, ic.created_at")
     if @objetos.count >0
       @objetos.each do |objeto|
         @mejcriterio = Mejorainformescriterio.new
         @mejcriterio.mejorainformeselemento_id = id.to_i
         @mejcriterio.capituloscriterio_id = objeto.capituloscriterio_id
         @mejcriterio.user_id = userid
         @mejcriterio.created_at = objeto.created_at
         @mejcriterio.save
       end
     end
  end
end
