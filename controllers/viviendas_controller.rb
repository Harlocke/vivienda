include ChainSelectsHelper
class ViviendasController < ApplicationController
  before_filter :require_user
  layout :determine_layout
  require 'ruby_plsql'

  def index
    persona   = Persona.find(params[:persona_id])
    @viviendas = persona.viviendas.all
  end


  def edit
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update viviendas set etapa = '#{params[:etapa]}' where id = #{params[:id]}")
    end    
    @vivienda  = Vivienda.find(params[:id])
    if @vivienda.etapa.to_s == "2"
      @viviendasposventa = Viviendasposventa.new
    elsif @vivienda.etapa.to_s == "3"
      @observavivienda = Observavivienda.new
    elsif @vivienda.etapa.to_s == "4"
      @viviendastramite = Viviendastramite.new
    elsif @vivienda.etapa.to_s == "6"
      @viviendasimagen = Viviendasimagen.new
    elsif @vivienda.etapa.to_s == "7"
      @viviendastramite = Viviendastramite.new
    end
    respond_to do |format|
      format.html { render :action => "vivienda_form" }
      format.js { render :action => "vivienda_form"   }
    end
  end

  def desvinculacion
    Vivienda.desvinculacompleto(params[:id],is_admin)
    flash[:notice] = "Desvinculacion realizada con Exito"
    redirect_to menus_path
  end

  def createrelacion
    Viviendaspersona.asociarpersona(params[:vivienda_id],params[:persona_id])
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @vivienda = Vivienda.new(params[:vivienda])
    @vivienda.etapa = '1'
    if @vivienda.valid?
      @persona.viviendas << @vivienda
      @persona.save
      @vivienda = Vivienda.new
      @observavivienda = Observavivienda.new
      flash[:notice] = "Creado con exito"
    else
      flash[:notice] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "viviendas" }
    end
  end

  def buscar
    perpage = 0
    if params[:format] == 'xls'
      perpage = 10000
    else
      perpage = 15
    end    
    @vivienda = Vivienda.new
    @vivienda.proyecto_id = params[:ubicacion][:proyecto]
    @vivienda.bloque_id = params[:ubicacion][:bloque]
    @vivienda.piso_id = params[:ubicacion][:piso]
    @vivienda.apto_id = params[:ubicacion][:apto]
    @vivienda.estado = params[:ubicacion][:estado]
    @vivienda.fonade = params[:ubicacion][:fonade]
    @vivienda.vinculado = params[:ubicacion][:vinculado]
    @vivienda.entregado = params[:ubicacion][:entregado]
    @viviendas = Vivienda.search(@vivienda,params[:ubicacion][:fchinicial],params[:ubicacion][:fchfinal],params[:page],perpage)
    if @viviendas.count == 0
      flash[:notice] = "No hay informacion de la busqueda"
      redirect_to busqueda_viviendas_path
    elsif params[:format] != 'xls'
      respond_to do |format|
        format.html
      end
    else
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_viviendas_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
    end
  end

  def informe
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_observaviviendas_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @observaviviendas = Observavivienda.search(params[:ubicacion][:usuario],
                                               params[:ubicacion][:fchinicial],
                                               params[:ubicacion][:fchfinal])
    respond_to do |format|
       format.xls
    end
  end

  def informeescrituras
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Escrituras_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @viviendas = Vivienda.find(:all, :conditions=>["trunc(fecha_recepcion) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}'"], :order=>"fecha_recepcion DESC")
  end

  def marcarrecibido
    @vivienda = Vivienda.find(params[:id])
    @vivienda.fecha_recepcion = Time.now
    @vivienda.user_recepcion = is_admin
    @vivienda.save
    flash[:notice] = "Marcacion de Recepcion de Escritura realizada con Exito!!!!"
    redirect_to edit_vivienda_path(@vivienda)
  end

  def consolidadoproyectos
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_informeconsolidado_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls'
    headers['Cache-Control'] = ''
    #headers['pragma']="public"
    @proyectos = Proyecto.find(:all, :order =>'descripcion')
  end

  def informeentregas
    headers['Content-Type'] = "application/vnd.ms-exceDl"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_informeentregas_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    #@viviendas = Vivienda.find(:all, :conditions =>["inv_caja is not null"])
    @viviendas = Vivienda.find_by_sql(["select p.descripcion proyectod, b.direccion bloquedirecion, b.descripcion bloqued, pi.descripcion pisod, 
                                               a.descripcion aptod, v.inv_consecutivo, v.inv_caja, v.inv_esc_entrega, v.inv_esc_fecha, u.nombre nombreuser,
                                               pe.identificacion, pe.primer_nombre||' '||pe.segundo_nombre||' '||pe.primer_apellido||' '||pe.segundo_apellido nombre,
                                               decode(v.entregado,'S','SI','N','NO') entregado
                                        from  viviendas v, viviendaspersonas vp, proyectos p, bloques b, pisos pi, aptos a, users u, personas pe
                                        where v.inv_caja is not null
                                        and   v.id = vp.vivienda_id
                                        and   vp.persona_id = pe.id(+)
                                        and   v.proyecto_id = p.id
                                        and   v.bloque_id = b.id
                                        and   v.piso_id = pi.id 
                                        and   v.apto_id = a.id
                                        and   v.inv_user = u.id(+)"])
  end

  def informeetapas
    userabogado = 0
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_informeetapas_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"    
    if permiso("viviendasespecialjuridica","C").to_s == "S"
      userabogado = -1
    else
      userabogado = is_admin
    end
    ActiveRecord::Base.connection.execute("begin prc_informeetapas(#{userabogado}); end;")
    @viviendastramites = Viviendastramite.find_by_sql(["select * from informeetapas order by proyecto,bloque,apto"])
    @objetos = Objeto.find_by_sql(["select distinct proyecto,etapa,tramite,count(9) cant from informeetapas group by proyecto,etapa,tramite order by proyecto,etapa,tramite"])
  end

  def informeetapase
    userabogado = 0
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_informeetapas_E_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    if permiso("viviendasespecialjuridica","C").to_s == "S"
      userabogado = -1
    else
      userabogado = is_admin
    end
    ActiveRecord::Base.connection.execute("begin prc_informeetapas(#{userabogado}); end;")
    @viviendastramites = Viviendastramite.find_by_sql(["select * from informeetapas order by proyecto,bloque,apto"])
    @objetos = Objeto.find_by_sql(["select distinct proyecto,etapa,tramite,count(9) cant from informeetapas group by proyecto,etapa,tramite order by proyecto,etapa,tramite"])
  end

  def informeetapas1
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_informeetapas1_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    ActiveRecord::Base.connection.execute("begin prc_informeconsoletapas; end;")
    @objetos = Objeto.find_by_sql(["select * from informeconsoletapas order by proyecto,bloque,apto"])
  end

  def informeetapas2
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_informevenc_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    ActiveRecord::Base.connection.execute("begin prc_informevencnum; end;")
    @objetos = Objeto.find_by_sql(["select * from informevencnum order by fecha_registro desc"])
  end

  def consolproyectos
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Consolidado_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    ActiveRecord::Base.connection.execute("begin prc_consolidado; end;")
    @viviendasreportes = Viviendasreporte.find_by_sql(
      "select *
       from viviendas_informe
       order by descripcion")
  end

  def consolproyectosesp
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Consolidado_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    ActiveRecord::Base.connection.execute("begin prc_consolidadoesp; end;")
    @viviendasreportes = Viviendasreporte.find_by_sql(
      "select descripcion,bloquedescripcion,aptos,registrados
       from viviendas_informe
       order by descripcion")
  end

  def reporte
      @viviendas = Vivienda.all(:select => "distinct(proyecto_id)", :conditions => ' proyecto_id in (1,2,13,23,5,22,8,9,10,3,6)')
      respond_to do |format|
         format.html
      end
  end

  def reportedatos
    @viviendas = Vivienda.find_all_by_proyecto_id_and_estado_padre(params[:proyecto], params[:estado_padre])
    @proyectos = Proyecto.find(params[:proyecto])
    @cant1     = Vivienda.count(:conditions => [' proyecto_id = '+"#{params[:proyecto]}"+' and estado_padre = '+"#{params[:estado_padre]}"+' and proceso_id = 1 '])
    @cant2     = Vivienda.count(:conditions => [' proyecto_id = '+"#{params[:proyecto]}"+' and estado_padre = '+"#{params[:estado_padre]}"+' and proceso_id = 2 '])
    @cant3     = Vivienda.count(:conditions => [' proyecto_id = '+"#{params[:proyecto]}"+' and estado_padre = '+"#{params[:estado_padre]}"+' and proceso_id = 3 '])
    @cant4     = Vivienda.count(:conditions => [' proyecto_id = '+"#{params[:proyecto]}"+' and estado_padre = '+"#{params[:estado_padre]}"+' and proceso_id = 4 '])
    @cant5     = Vivienda.count(:conditions => [' proyecto_id = '+"#{params[:proyecto]}"+' and estado_padre = '+"#{params[:estado_padre]}"+' and proceso_id = 5 '])
    @cant6     = Vivienda.count(:conditions => [' proyecto_id = '+"#{params[:proyecto]}"+' and estado_padre = '+"#{params[:estado_padre]}"+' and proceso_id = 6 '])
    @cant7     = Vivienda.count(:conditions => [' proyecto_id = '+"#{params[:proyecto]}"+' and estado_padre = '+"#{params[:estado_padre]}"+' and proceso_id = 7 '])
    @cant8     = Vivienda.count(:conditions => [' proyecto_id = '+"#{params[:proyecto]}"+' and estado_padre = '+"#{params[:estado_padre]}"+' and proceso_id = 8 '])
    @cant9     = Vivienda.count(:conditions => [' proyecto_id = '+"#{params[:proyecto]}"+' and estado_padre = '+"#{params[:estado_padre]}"+' and proceso_id = 9 '])
    @cant10    = Vivienda.count(:conditions => [' proyecto_id = '+"#{params[:proyecto]}"+' and estado_padre = '+"#{params[:estado_padre]}"+' and proceso_id = 10 '])
    @cant11    = Vivienda.count(:conditions => [' proyecto_id = '+"#{params[:proyecto]}"+' and estado_padre = '+"#{params[:estado_padre]}"+' and proceso_id = 11 '])
    @cant12    = Vivienda.count(:conditions => [' proyecto_id = '+"#{params[:proyecto]}"+' and estado_padre = '+"#{params[:estado_padre]}"+' and proceso_id = 12 '])
    @cant13    = Vivienda.count(:conditions => [' proyecto_id = '+"#{params[:proyecto]}"+' and estado_padre = '+"#{params[:estado_padre]}"+' and proceso_id = 13 '])
    @cant14    = Vivienda.count(:conditions => [' proyecto_id = '+"#{params[:proyecto]}"+' and estado_padre = '+"#{params[:estado_padre]}"+' and proceso_id = 14 '])
    @cant15    = Vivienda.count(:conditions => [' proyecto_id = '+"#{params[:proyecto]}"+' and estado_padre = '+"#{params[:estado_padre]}"+' and proceso_id = 15 '])
    @cant16    = Vivienda.count(:conditions => [' proyecto_id = '+"#{params[:proyecto]}"+' and estado_padre = '+"#{params[:estado_padre]}"+' and proceso_id = 16 '])
    @cant17    = Vivienda.count(:conditions => [' proyecto_id = '+"#{params[:proyecto]}"+' and estado_padre = '+"#{params[:estado_padre]}"+' and proceso_id = 17 '])
    @cant18    = Vivienda.count(:conditions => [' proyecto_id = '+"#{params[:proyecto]}"+' and estado_padre = '+"#{params[:estado_padre]}"+' and proceso_id = 18 '])
    @cant19    = Vivienda.count(:conditions => [' proyecto_id = '+"#{params[:proyecto]}"+' and estado_padre = '+"#{params[:estado_padre]}"+' and proceso_id = 19 '])
    @buscaproyecto   = @proyectos.descripcion
#   @viviendaspersonas = Viviendaspersona.find_all_by_vivienda_id(@viviendas.id)
    #@viviendas = Vivienda.all(:conditions => [' proyecto_id = ? and proceso_id = ?' , :proyecto, :proceso])
    respond_to do |format|
       format.html
    end
  end

  def asociar
      @vivienda = Vivienda.new
      @vivienda.proyecto_id = params[:ubicacion][:proyecto]
      @vivienda.bloque_id = params[:ubicacion][:bloque]
      @vivienda.piso_id = params[:ubicacion][:piso]
      @vivienda.apto_id = params[:ubicacion][:apto]
      @vivienda.estado = "D"
      @viviendas = Vivienda.searchasocia(@vivienda)
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
  end

  def update
    @vivienda = Vivienda.find(params[:id])
=begin      
    begin
      valor0 = 0
      if params[:vivienda][:valor_avaluo].to_i >= params[:vivienda][:valor_venta].to_i
        valor0 = params[:vivienda][:valor_avaluo].to_i
      else
        valor0 = params[:vivienda][:valor_venta].to_i
      end
      valor2 = (((valor0.to_i * 0.5)/100)/2).round(-2)
      valor3_0 = 0
      valor3 = 0
      @viviendaspersonas = Viviendaspersona.find_all_by_vivienda_id(params[:id])
      @viviendaspersonas.each do |viviendaspersona|
        if Credito.exists?(["persona_id = #{viviendaspersona.persona_id}"])
          @creditos = Credito.find_all_by_persona_id(viviendaspersona.persona_id)
          @creditos.each do |credito|
            valor3_0 = valor3_0 + credito.valor
          end
          begin
            valor3 = ((((valor3_0.to_i * 5)/100)*1)/100).round(-2)
          rescue
            valor3 = ((((valor3_0.to_i * 5)/100)*1)/100).to_f
            valor3 = valor3.round(-2)
          end
        end
      end      
      valor5 = 0
      valor5_1 = 0
      valor5_2 = 0
      if params[:vivienda][:afecta_vivienda].to_s == 'SI'
        valor5 = 8800
      end
      if params[:vivienda][:derecho_preferencia].to_s == 'SI'
        valor5_1 = 8800
      end
      if params[:vivienda][:prohibicion_transferencia].to_s == 'SI'
        valor5_2 = 8800
      end
      valortotal = (valor2.to_i + valor3.to_i + 8800 + valor5 + 7400 + valor5_1 + valor5_2).to_i
      params[:vivienda][:valor_prerregistro] = valortotal
      params[:vivienda][:liq_valor_registro] = params[:vivienda][:lic_certificado].to_i + params[:vivienda][:lic_registro].to_i
    rescue
       params[:vivienda][:valor_prerregistro] = nil
       params[:vivienda][:liq_valor_registro] = nil
    end
=end    
    if params[:vivienda][:inv_caja].to_i > 0 and params[:vivienda][:inv_consecutivo].to_s == ""
      consecutivo = Vivienda.maximum("inv_consecutivo", :conditions=>["proyecto_id = #{@vivienda.proyecto_id}"]).to_i
      consecutivo = consecutivo + 1
      params[:vivienda][:inv_consecutivo] = consecutivo
    end
    @vivienda.user_actualiza = is_admin
    if @vivienda.update_attributes(params[:vivienda])
      if (@vivienda.solicitar_entrega == 'S')
        flash[:notice] = "Actualizacion realizada con Exito. Email!"
        Vivienda.create2(@vivienda)
        redirect_to edit_vivienda_path(@vivienda)
      else
        Vivienda.fechavencimiento(@vivienda)
        flash[:notice] = "Actualizacion realizada con Exito"
        redirect_to edit_vivienda_path(@vivienda)
      end
    else
      @observavivienda = Observavivienda.new
      render :action => "vivienda_form"
    end
    rescue
      flash[:notice] = "Ha ocurrido un error verifique!!!"
      redirect_to edit_vivienda_path(@vivienda)
  end

  def destroy
    vivienda   = Vivienda.find(params[:id])
    @persona  = vivienda.persona
    @vivienda  = Vivienda.new
    vivienda.destroy
    respond_to do |format|
      format.js { render :action => "viviendas" }
    end
  end

  def atencion
    @vivienda  = Vivienda.find(params[:id])
  end

  def cierre
    @vivienda  = Vivienda.find(params[:id])
  end

  def informemenores
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Menores_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    ActiveRecord::Base.connection.execute("begin prc_informe_menores; end;")
    @informes = Viviendasreporte.find_by_sql("select * from informe_menores");
    respond_to do |format|
       format.xls
    end
    #ActiveRecord::Base.connection.execute("delete from informe_menores;")
  end

  private
  def determine_layout
    if ['reportedatos'].include?(action_name)
      "reportes"
    elsif['reportedatoses'].include?(action_name)
      "reportes"
    elsif['atencion','cierre'].include?(action_name)
      "atencion"
    elsif['informemenores','informeetapase','informeescrituras','informeetapas1','informeetapas','informeetapas2','consolproyectos','informeentregas','consolidadoproyectos','consolproyectosesp'].include?(action_name)
      "excel"
    else
      "application"
    end
  end

end
