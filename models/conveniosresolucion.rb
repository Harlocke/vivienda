class Conveniosresolucion < ActiveRecord::Base
  belongs_to :convenio
  belongs_to :resolucion
  belongs_to :user
  has_many :conveniosresolintenciones, :dependent =>:destroy

  validates_presence_of :nro_resolucion, :anno, :user_coordinador, :user_profesional, :user_tecnologo, :user_interventor,:calculo

  def name
    self.nro_resolucion
  end

  acts_as_chainable :select_label => 'Resolucion',
                    :from => :convenio,
                    :order => :nro_resolucion

  def after_create
    resolucionespersonas = Resolucionespersona.find_all_by_resolucion_id(self.resolucion_id)
    resolucionespersonas.each do |resolucionespersona|
      mejoramiento = Mejoramiento.new
      mejoramiento.persona_id = resolucionespersona.persona_id
      mejoramiento.user_id = self.user_id
      mejoramiento.user_coordinador = self.user_coordinador
      mejoramiento.user_profesional = self.user_profesional
      mejoramiento.user_tecnologo = self.user_tecnologo
      mejoramiento.mejoramientosestado_id = 1 #'DIAGNOSTICO'
      mejoramiento.anno = self.anno
      mejoramiento.convenio_id = self.convenio_id
      mejoramiento.tipomejoramiento = 'LOCATIVO'
      mejoramiento.user_interventor = self.user_interventor
      mejoramiento.comuna_id = resolucionespersona.persona.comuna_id
      mejoramiento.cobama = resolucionespersona.persona.cbml
      mejoramiento.resolucion_id = resolucionespersona.resolucion_id
      mejoramiento.valor_resolucion = (resolucionespersona.subsidio_especie.to_i +
                                        resolucionespersona.subsidio_dinero.to_i +
                                        resolucionespersona.subsidio_mejoras.to_i)
      mejoramiento.calculo = self.calculo
      if self.calculo.to_s == 'EJECUCION 2015'
        mejoramiento.incremento_corregimiento = self.incremento_corregimiento
        mejoramiento.incremento_adicional = self.incremento_adicional
        mejoramiento.incluye_diagnostico = self.incluye_diagnostico
      end
      mejoramiento.especial = self.especial
      mejoramiento.save
      last_id = Mejoramiento.maximum('id')
      incluyediagnostico = ""
      conveniosmejoramientos = Conveniosmejoramiento.find(:all, :conditions=>["convenio_id = #{self.convenio_id}"])
      conveniosmejoramientos.each do |conveniosmejoramiento|
        mejoramientoselemento = Mejoramientoselemento.new
        mejoramientoselemento.mejoramiento_id = last_id
        mejoramientoselemento.mejoramientositem_id = conveniosmejoramiento.mejoramientositem_id
        mejoramientoselemento.user_id = self.user_id
        mejoramientoselemento.cantidad = 0
        mejoramientoselemento.valor_unitario = conveniosmejoramiento.valor_unitario
        if conveniosmejoramiento.mejoramientositem_id.to_i == 10043 and self.calculo.to_s == 'EJECUCION 2015'
          if  self.incluye_diagnostico.to_s == 'SI'
            mejoramientoselemento.cantidad = 1
            mejoramientoselemento.valor_unitario = Sifi.find(85).valor.to_i  rescue 0
            mejoramientoselemento.valor_total = Sifi.find(85).valor.to_i  rescue 0
            incluyediagnostico = 'S'
          else
            mejoramientoselemento.cantidad = 0
            mejoramientoselemento.valor_unitario = 0
            mejoramientoselemento.valor_total = 0
            incluyediagnostico = 'S'
          end
        elsif conveniosmejoramiento.mejoramientositem_id.to_i == 10043 and self.calculo.to_s == 'SUBSIDIO-DIAGNOSTICO'
            mejoramientoselemento.valor_total = conveniosmejoramiento.valor_unitario
        end
        mejoramientoselemento.save
      end
      if incluyediagnostico.to_s == "" and self.calculo.to_s == 'EJECUCION 2015' and self.incluye_diagnostico.to_s == 'SI'
        mejoramientoselemento = Mejoramientoselemento.new
        mejoramientoselemento.mejoramiento_id = last_id
        mejoramientoselemento.mejoramientositem_id = 10043
        mejoramientoselemento.user_id = self.user_id
        mejoramientoselemento.cantidad = 1
        mejoramientoselemento.valor_unitario = Sifi.find(85).valor.to_i  rescue 0
        mejoramientoselemento.valor_total = Sifi.find(85).valor.to_i  rescue 0
        incluyediagnostico = 'S'
        mejoramientoselemento.save
      end
      if Personaslista.exists?(["persona_id = #{resolucionespersona.persona_id}"]) == true
        ActiveRecord::Base.connection.execute(
          "insert into mejoramientoslistas (id,mejoramiento_id,listasverificacion_id,user_actualiza,estado,folios,observacion,created_at,updated_at)
          select mejoramientoslistas_seq.nextval,#{last_id},listasverificacion_id,user_actualiza,estado,folios,observacion,created_at,updated_at
          from   personaslistas where persona_id = #{resolucionespersona.persona_id}")
        ActiveRecord::Base.connection.execute(
         "insert into mejoramientoslistas (id,mejoramiento_id,listasverificacion_id,created_at,updated_at)
          select mejoramientoslistas_seq.nextval,#{last_id},id,sysdate,sysdate
          from   listasverificaciones where id > 18")
      else
        ActiveRecord::Base.connection.execute(
         "insert into mejoramientoslistas (id,mejoramiento_id,listasverificacion_id,created_at,updated_at)
          select mejoramientoslistas_seq.nextval,#{last_id},id,sysdate,sysdate
          from   listasverificaciones")
      end
    end
  end

  def after_update
    ActiveRecord::Base.connection.execute(
      "update mejoramientos set calculo = '#{self.calculo}',
                                user_coordinador = #{self.user_coordinador},
                                user_profesional = #{self.user_profesional},
                                user_tecnologo = #{self.user_tecnologo},
                                user_interventor = #{self.user_interventor},
                                especial = '#{self.especial}',
                                incremento_corregimiento = '#{self.incremento_corregimiento}',
                                incremento_adicional = '#{self.incremento_adicional}',
                                incluye_diagnostico = '#{self.incluye_diagnostico}'
       where convenio_id   = #{self.convenio_id}
       and   resolucion_id = #{self.resolucion_id}")
  end

end
