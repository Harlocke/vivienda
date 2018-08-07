class AyudastemporalesController < ApplicationController

  before_filter :require_user

  require 'csv'

   def csv_import
     @parsed_file=CSV::Reader.parse(params[:dump][:file], ';')
     n=0
     #Ayudastemporal.delete_all
     ActiveRecord::Base.connection.execute("truncate table ayudastemporales")
     @parsed_file.each  do |row|
       c = Ayudastemporal.new
       c.identificacion_jefe   = row[0]
       c.identificacion_bene   = row[1]
       c.nombre                = row[2]
       c.apellido              = row[3]
       c.parentesco            = row[4]
       c.estado_atencion       = row[5]
       c.fecha_remision        = row[6]
       c.nro_ficha_simpad      = row[7]
       c.nro_carpeta           = row[8]
       c.tipo_evacuacion       = row[9]
       c.evento                = row[10]
       c.direccion_evento      = row[11]
       c.telefono_evento       = row[12]
       c.barrio_evento         = row[13]
       c.direccion_nueva_viv   = row[14]
       c.telefono_nueva_viv    = row[15]
       c.fecha_contrato        = row[16]
       c.save
       n=n+1
     end
     ActiveRecord::Base.connection.execute("delete from ayudastemporales where identificacion_bene is null")
     @ayudastemporales = Ayudastemporal.all
     #ActiveRecord::Base.connection.execute()
     flash.now[:notice]="Archivo importado con Exito,  #{n} registros cargados Ayudastemporalmente"
   end

#   def cargar
#     ayudastemporales = Ayudastemporal.all
#     n=0
#     t=0
#     ayudastemporales.each do |data|
#       if data.resolucion_id.nil? == false
#         if data.persona_id.nil? == true
#           persona = Persona.new
#           persona.identificacion = data.identificacion
#           persona.primer_nombre = data.primer_nombre
#           persona.segundo_nombre = data.segundo_nombre
#           persona.primer_apellido = data.primer_apellido
#           persona.segundo_apellido = data.segundo_apellido
#           persona.save
#           n=n+1
#         end
#         if Persona.exists?(["identificacion = ?", data.identificacion]) == true
#           persona = Persona.find_by_identificacion(data.identificacion)
#           if Resolucionespersona.exists?(["persona_id = ? and resolucion_id = ?", persona.id, data.resolucion_id]) == false
#             resolucionespersona = Resolucionespersona.new
#             resolucionespersona.persona_id = persona.id
#             resolucionespersona.resolucion_id = data.resolucion_id
#             resolucionespersona.proyecto = data.proyecto
#             resolucionespersona.subsidio_nacional  = data.subsidio_nacional
#             resolucionespersona.subsidio_mpal  = data.subsidio_mpal
#             resolucionespersona.subsidio_mpal_lote  = data.subsidio_mpal_lote
#             resolucionespersona.aporte_viva  = data.aporte_viva
#             resolucionespersona.recono_mejoras  = data.recono_mejoras
#             resolucionespersona.otros  = data.otros
#             resolucionespersona.save
#             t=t+1
#             # Insercion del Subsidio Municipal
#             if Subsidio.exists?(["persona_id = ? and tipos_subsidio_id = 1", persona.id]) == false
#               if data.subsidio_mpal.nil? == false
#                 subsidio = Subsidio.new
#                 subsidio.persona_id = persona.id
#                 subsidio.tipos_subsidio_id = 1
#                 subsidio.valor  = data.subsidio_mpal
#                 subsidio.resolucion = data.nro_resolucion
#                 subsidio.save
#               end
#             end
#             # Insercion del Aporte Viva
#             if Subsidio.exists?(["persona_id = ? and tipos_subsidio_id = 2", persona.id]) == false
#               if data.aporte_viva.nil? == false
#               subsidio = Subsidio.new
#               subsidio.persona_id = persona.id
#               subsidio.tipos_subsidio_id = 2
#               subsidio.valor  = data.aporte_viva
#               subsidio.resolucion = data.nro_resolucion
#               subsidio.save
#                end
#             end
#             # Insercion del Reconocimiento de Mejoras
#             if Subsidio.exists?(["persona_id = ? and tipos_subsidio_id = 3", persona.id]) == false
#               if data.recono_mejoras.nil? == false
#               subsidio = Subsidio.new
#               subsidio.persona_id = persona.id
#               subsidio.tipos_subsidio_id = 3
#               subsidio.valor  = data.recono_mejoras
#               subsidio.resolucion = data.nro_resolucion
#               subsidio.save
#                end
#             end
#             # Insercion del Subsidio Nacional
#             if Subsidio.exists?(["persona_id = ? and tipos_subsidio_id = 4", persona.id]) == false
#               if data.subsidio_nacional.nil? == false
#               subsidio = Subsidio.new
#               subsidio.persona_id = persona.id
#               subsidio.tipos_subsidio_id = 4
#               subsidio.valor  = data.subsidio_nacional
#               subsidio.resolucion = data.nro_resolucion
#               subsidio.save
#                end
#             end
#             # Insercion del Otros .----
#             if Subsidio.exists?(["persona_id = ? and tipos_subsidio_id = 5", persona.id]) == false
#               if data.otros.nil? == false
#               subsidio = Subsidio.new
#               subsidio.persona_id = persona.id
#               subsidio.tipos_subsidio_id = 5
#               subsidio.valor  = data.otros
#               subsidio.resolucion = data.nro_resolucion
#               subsidio.save
#                end
#             end
#             # Insercion del Subsidio Municipal en Lote
#             if Subsidio.exists?(["persona_id = ? and tipos_subsidio_id = 6", persona.id]) == false
#               if data.subsidio_mpal_lote.nil? == false
#               subsidio = Subsidio.new
#               subsidio.persona_id = persona.id
#               subsidio.tipos_subsidio_id = 6
#               subsidio.valor  = data.subsidio_mpal_lote
#               subsidio.resolucion = data.nro_resolucion
#               subsidio.save
#                end
#             end
#           end
#         end
#       end
#     end
#     flash.now[:notice]="Archivo cargado a la base de datos,  #{n} personas registradas y  #{t} personas vinculadas a la resolucion "
#   end

  def index
    @ayudastemporales = Ayudastemporal.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ayudastemporales }
    end
  end

  # GET /ayudastemporales/1
  # GET /ayudastemporales/1.xml
  def show
    @ayudastemporal = Ayudastemporal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ayudastemporal }
    end
  end

  # GET /ayudastemporales/new
  # GET /ayudastemporales/new.xml
  def new
    @ayudastemporal = Ayudastemporal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ayudastemporal }
    end
  end

  # GET /ayudastemporales/1/edit
  def edit
    @ayudastemporal = Ayudastemporal.find(params[:id])
  end

  # POST /ayudastemporales
  # POST /ayudastemporales.xml
  def create
    @ayudastemporal = Ayudastemporal.new(params[:ayudastemporal])

    respond_to do |format|
      if @ayudastemporal.save
        flash[:notice] = 'Ayudastemporal was successfully created.'
        format.html { redirect_to(@ayudastemporal) }
        format.xml  { render :xml => @ayudastemporal, :status => :created, :location => @ayudastemporal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ayudastemporal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ayudastemporales/1
  # PUT /ayudastemporales/1.xml
  def update
    @ayudastemporal = Ayudastemporal.find(params[:id])

    respond_to do |format|
      if @ayudastemporal.update_attributes(params[:ayudastemporal])
        flash[:notice] = 'Ayudastemporal was successfully updated.'
        format.html { redirect_to(@ayudastemporal) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ayudastemporal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ayudastemporales/1
  # DELETE /ayudastemporales/1.xml
  def destroy
    @ayudastemporal = Ayudastemporal.find(params[:id])
    @ayudastemporal.destroy

    respond_to do |format|
      format.html { redirect_to(ayudastemporales_url) }
      format.xml  { head :ok }
    end
  end
end
