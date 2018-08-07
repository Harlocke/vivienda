class TitulacionesController < ApplicationController
  layout :determine_layout
  require 'ruby_plsql'
  before_filter :require_user

  def index
    @titulacionesasignaciones = Titulacionesasignacion.find(:all, :conditions=>["user_id = #{is_admin} and tipo is not null and fecha_fin is null"])
  end

  def show
    @titulacion = Titulacion.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @titulacion }
    end
  end

  def informeactualizacion
    fch1 = params[:ubicacion][:fchinicial].to_s
    fch2 = params[:ubicacion][:fchfinal].to_s
    usr = params[:ubicacion][:usuario].to_i
    tipo = params[:ubicacion][:tipo].to_s
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Titactualizacion_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    ActiveRecord::Base.connection.execute("begin prc_informetitulacionact('#{fch1.to_date}','#{fch2.to_date}','#{usr}','#{tipo}'); end;")
    @titulacionesactualizaciones = Titulacionesactualizacion.find_by_sql("select * from informetitulacionact")
  end

  def informestitulacion
    model = params[:ubicacion][:model].to_s
    if model.to_s != ""
      @model = model
     headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      if @model.to_s == "FALLIDOS"
        headers['Content-Disposition'] = 'attachment; filename="SIFI_TitulacionFallidos_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
      elsif @model.to_s == "PERSONAS"
        headers['Content-Disposition'] = 'attachment; filename="SIFI_TitulacionPersonas_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
      elsif @model.to_s == "ASIGNACIONES"
        headers['Content-Disposition'] = 'attachment; filename="SIFI_TitulacionAsignaciones_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
      elsif @model.to_s == "DEMANDAS"
        headers['Content-Disposition'] = 'attachment; filename="SIFI_TitulacionDemandas_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
      else
        headers['Content-Disposition'] = 'attachment; filename="SIFI_TitulacionConsolidado_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
      end
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      ActiveRecord::Base.connection.execute("begin prc_informetitulacion('#{model}'); end;")    
      @titulaciones = Titulacion.find_by_sql("select * from informetitulacion")
    else
      flash[:notice] = "No hay resultados de la busquedaaaaaa"
      redirect_to titulaciones_path
    end
  end

  def buscarcoba
    if params[:ubicacion][:estado].to_s == "" or params[:ubicacion][:tipoproceso].to_s == "" or params[:coba].to_s == ""
      flash[:warning] = "No hay resultados de la busqueda"
      redirect_to titulaciones_path
    else
      @titulacion  = Titulacion.new
      @titulacion.estado = params[:ubicacion][:estado]
      @titulacion.tipoproceso = params[:ubicacion][:tipoproceso]
      @titulaciones = Titulacion.searchgeo(@titulacion, params[])
      if @titulaciones.count == 0
        flash[:notice] = "No hay resultados de la busqueda"
        redirect_to titulaciones_path
      elsif params[:format] != 'xls'
        respond_to do |format|
          format.html
        end
      else
        headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        headers['Content-Disposition'] = 'attachment; filename="SIFI_Datos_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
        headers['Cache-Control'] = 'max-age=0'
        headers['pragma']="public"
      end
    end
  end

  def buscar
    perpage = 0
    if params[:format] == 'xls'
      perpage = 10000
    else
      perpage = 15
    end    
    @titulacion  = Titulacion.new
    @titulacion.id =  params[:id]
    @titulacion.cobama =  params[:cobama]
    @titulacion.manzana =  params[:manzana]
    @titulacion.lote =  params[:lote]
    @titulacion.comuna_id = params[:ubicacion][:comuna_id]
    #@titulacion.estado_visita = params[:ubicacion][:estado_visita]
    @titulacion.estado = params[:ubicacion][:estado]
    @titulacion.user_juridico = params[:ubicacion][:user_juridico]
    @titulacion.gestion_caja = params[:caja]
    @titulacion.tipoproceso = params[:ubicacion][:tipoproceso]
    @titulacion.situacionproceso = params[:ubicacion][:situacionproceso]
    @titulacion.procedimiento = params[:ubicacion][:procedimiento]
    @titulaciones = Titulacion.search(@titulacion,
                                      params[:identificacion],
                                      params[:matricula],
                                      params[:demanda],
                                      params[:ubicacion][:estado_visita],
                                      params[:coba],
                                      params[:ubicacion][:fchinicial],
                                      params[:ubicacion][:fchfinal],params[:page],perpage)
    if @titulaciones.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to titulaciones_path
    elsif params[:format] != 'xls' and params[:format] != 'Asignaciones'
      if @titulaciones.count == 1
        redirect_to edit_titulacion_path(:id => @titulaciones, :etapa=>"1")
      else
        respond_to do |format|
          format.html
        end
      end
    else
      @formato = params[:format].to_s
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Titulaciones_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
    end
  end

  def prestamo
    fch1 = params[:ubicacion][:fchinicial].to_s
    fch2 = params[:ubicacion][:fchfinal].to_s
    if params[:ubicacion][:user]
      @user = User.find(params[:ubicacion][:user])
      if fch1.to_s != "" and fch2.to_s != ""
        @titulaciones = Titulacion.find(:all, :conditions=>["id in (select titulacion_id
                                                                    from   titulacionesprestamos
                                                                    where  userprestamo = #{params[:ubicacion][:user]}
                                                                    and    trunc(created_at) between '#{fch1.to_date}' and '#{fch2.to_date}'
                                                                    and    fecha_devolucion is null)"])
      else
        @titulaciones = Titulacion.find(:all, :conditions=>["id in (select titulacion_id
                                                                    from   titulacionesprestamos
                                                                    where  userprestamo = #{params[:ubicacion][:user]}
                                                                    and    fecha_devolucion is null)"])
      end
      #@titulacionesprestamos = Titulacionesprestamo.find(:all, :conditions=>["userprestamo = #{params[:ubicacion][:user]} and fecha_devolucion is null"])
      respond_to do |format|
        format.html
      end
    else
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to titulaciones_path
    end
  end

  def busqueda
    @titulacionesasignaciones = Titulacionesasignacion.find(:all, :conditions=>["user_id = #{is_admin} and tipo is not null and fecha_fin is null"])
  end

  def prestamostotal
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_TitulacionPrestamos_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @titulaciones = Titulacion.find_by_sql("select t.id,
                                                     t.cobama,
                                                     (select nombre from users where id = p.userregistro) registro,
                                                     p.created_at fechasolicitud,
                                                     (select nombre from users where id = p.userprestamo) prestadoa,
                                                     p.fecha_vence fechavence
                                              from   titulaciones t, titulacionesprestamos p
                                              where  t.id = p.titulacion_id
                                              and    p.fecha_devolucion is null
                                              order by p.userprestamo")
  end

  def pertenencia
    @titulacion   = Titulacion.new
    @titulacion.titulacionesbarrio_id = params[:ubicacion][:titulacionesbarrio_id]
    @observacion  = params[:jornada]
    @titulaciones = Titulacion.find(:all, :conditions=>["(estado in ('EN PROCESO','FALLIDO','HABILITADO','POSITVO') or estado is null)
                                                        and titulacionesbarrio_id = #{params[:ubicacion][:titulacionesbarrio_id]}
                                                        and id in (select distinct titulacion_id from titulacionespersonas)"], :order=>"cobama")
    if @titulaciones.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to titulaciones_path
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def poder
    @titulacion   = Titulacion.new
    @titulacion.titulacionesbarrio_id = params[:ubicacion][:titulacionesbarrio_id]
    @titulaciones = Titulacion.find(:all, :conditions=>["(estado in ('EN PROCESO','FALLIDO','HABILITADO','POSITVO') or estado is null)
                                                        and titulacionesbarrio_id = #{params[:ubicacion][:titulacionesbarrio_id]}
                                                        and id in (select distinct titulacion_id from titulacionespersonas)"], :order=>"cobama")
    if @titulaciones.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to titulaciones_path
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def informe
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="titulacioninforme_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @titulacionesobservaciones = Titulacionsobservacion.search(params[:ubicacion][:usuario],
                                                               params[:ubicacion][:fchinicial],
                                                               params[:ubicacion][:fchfinal])
  end

  def informeseguimiento
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Titulacionesseguimiento_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @titulaciones = Titulacion.all
  end

  def informesasignacion
    if params[:ubicacion][:usuario].to_s == "" and params[:ubicacion][:fchinicial].to_s == "" and params[:ubicacion][:fchfinal].to_s == ""
      flash[:warning] = "No hay resultados de la busqueda"
      redirect_to titulaciones_path
    else
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_TitAsignaciones_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @titulacionesasignaciones = Titulacionesasignacion.search(params[:ubicacion][:usuario],
                                                                params[:ubicacion][:fchinicial],
                                                                params[:ubicacion][:fchfinal])
      @titulacionesdoctipos = Titulacionesdoctipo.find(:all,:conditions=>["id in (1,2,3,4,5,6,7,8,9)"], :order=>"id")
    end
  end

  def informesasignaciond
    if params[:ubicacion][:usuario].to_s == "" and params[:ubicacion][:fchinicial].to_s == "" and params[:ubicacion][:fchfinal].to_s == ""
      flash[:warning] = "No hay resultados de la busqueda"
      redirect_to titulaciones_path
    else
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_TitAsignaciones_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @titulacionesasignaciones = Titulacionesasignacion.searchd(params[:ubicacion][:usuario],
                                                                params[:ubicacion][:fchinicial],
                                                                params[:ubicacion][:fchfinal])
    end
  end

  def informesasignacions
    if params[:ubicacion][:usuario].to_s == "" and params[:ubicacion][:fchinicial].to_s == "" and params[:ubicacion][:fchfinal].to_s == ""
      flash[:warning] = "No hay resultados de la busqueda"
      redirect_to titulaciones_path
    else
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_TitAsigSantaElena_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @titulacionesasignaciones = Titulacionesasignacion.searchs(params[:ubicacion][:usuario],
                                                                params[:ubicacion][:fchinicial],
                                                                params[:ubicacion][:fchfinal])
    end
  end

  def informesasignacionf
    if params[:ubicacion][:usuario].to_s == "" and params[:ubicacion][:fchinicial].to_s == "" and params[:ubicacion][:fchfinal].to_s == ""
      flash[:warning] = "No hay resultados de la busqueda"
      redirect_to titulaciones_path
    else
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_TitAsigFiscales_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @titulacionesasignaciones = Titulacionesasignacion.searchf(params[:ubicacion][:usuario],
                                                                params[:ubicacion][:fchinicial],
                                                                params[:ubicacion][:fchfinal])
    end
  end

  def informexls
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Asignaciones_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @titulacionesasignaciones = Titulacionesasignacion.find(:all, :conditions=>["user_id = #{is_admin} and fecha_fin is null"])
  end

  def new
    @titulacion = Titulacion.new
    @titulacion.etapa = '1'
    @titulacionesdocumento = Titulacionesdocumento.new
    @titulacionesprofesional = Titulacionesprofesional.new
    @titulacionesuser = Titulacionesuser.new
    @titulacionesfallido = Titulacionesfallido.new
    render :action => "titulacion_form"
  end

  def edit
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update titulaciones set etapa = '#{params[:etapa]}' where id = #{params[:id].to_i}")
    end    
    @titulacion = Titulacion.find(params[:id])
    @archivospersona = Archivospersona.new
    @titulacionesvecino = Titulacionesvecino.new
    #@titulacionessueno = Titulacionessueno.new
    if @titulacion.titulacionespersonas.exists?
      @existearchivo = Archivospersona.exists?(["persona_id in (select persona_id from titulacionespersonas where titulacion_id = #{@titulacion.id})"])
      @existefase2censo = Fase2censo.exists?(["persona_id in (select persona_id from titulacionespersonas where titulacion_id = #{@titulacion.id})"])
    end
    if @titulacion.catastro_id.to_i > 0
      @existecatastrodatos = Catastrosdato.exists?(["catastro_id = #{@titulacion.catastro_id}"])
      @catastrosdatos = Catastrosdato.find_all_by_catastro_id(@titulacion.catastro_id)
    end
    if @titulacion.etapa.to_s == '1'
      @titulacionesdocumento = Titulacionesdocumento.new
      @titulacionesprofesional = Titulacionesprofesional.new
      @titulacionesuser = Titulacionesuser.new
      @titulacionesfallido = Titulacionesfallido.new
    elsif @titulacion.etapa.to_s == '2'
      @titulacionespersona = Titulacionespersona.new
    elsif @titulacion.etapa.to_s == '3'
      @titulacionesasignacion = Titulacionesasignacion.new
    elsif @titulacion.etapa.to_s == '4'
      @titulacionesobservacion = Titulacionesobservacion.new
    elsif @titulacion.etapa.to_s == '6'
      @titulacionesimagen = Titulacionesimagen.new
    elsif @titulacion.etapa.to_s == '7'
      @titulacionesprestamo = Titulacionesprestamo.new
    elsif @titulacion.etapa.to_s == '8'
      @titulacionesdemanda = Titulacionesdemanda.new
    elsif @titulacion.etapa.to_s == '23'
    elsif @titulacion.etapa.to_s == '24'
    elsif @titulacion.etapa.to_s == '35'
    elsif @titulacion.etapa.to_s == '36'
      @titulacionesvisita = Titulacionesvisita.new
    elsif @titulacion.etapa.to_s == '9'
      @titulacionespoligono = Titulacionespoligono.new
      @titulacionesriesgo = Titulacionesriesgo.new
      @titulacionesespacio = Titulacionesespacio.new
      @titulacionesafecta = Titulacionesafecta.new
    end
    respond_to do |format|
      format.html { render :action => "titulacion_form" }
    end
  end

  def create
    @titulacion = Titulacion.new(params[:titulacion])
    @titulacion.user_id = is_admin
    @titulacion.etapa = '1'
    if Catastro.exists?(["cbml = '#{@titulacion.cobama.to_s}'"])
      @titulacion.catastro_id = Catastro.find_by_cbml(@titulacion.cobama.to_s).id
    end
    if @titulacion.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      is_trigger_tit(@titulacion.id,is_admin,'titulacion','I')
      redirect_to edit_titulacion_path(:id => @titulacion, :etapa=>"1")
    else
      @titulacionesdocumento = Titulacionesdocumento.new
      @titulacionesprofesional = Titulacionesprofesional.new
      @titulacionesuser = Titulacionesuser.new
      @titulacionesfallido = Titulacionesfallido.new
      if @titulacion.catastro_id.to_i > 0
        @existecatastrodatos = Catastrosdato.exists?(["catastro_id = #{@titulacion.catastro_id}"])
        @catastrosdatos = Catastrosdato.find_all_by_catastro_id(@titulacion.catastro_id)
      end
      render :action => "titulacion_form"
    end
  end

  def update
    @titulacion = Titulacion.find(params[:id])
    @titulacion.user_actualiza = is_admin
    if @titulacion.update_attributes(params[:titulacion])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      is_trigger_tit(@titulacion.id,is_admin,'titulacion','A')
      redirect_to edit_titulacion_path(@titulacion)
    else
      @titulacionesdocumento = Titulacionesdocumento.new
      @titulacionesprofesional = Titulacionesprofesional.new
      @titulacionesuser = Titulacionesuser.new
      @titulacionesfallido = Titulacionesfallido.new
      if @titulacion.titulacionespersonas.exists?
        @existearchivo = Archivospersona.exists?(["persona_id in (select persona_id from titulacionespersonas where titulacion_id = #{@titulacion.id})"])
        @existefase2censo = Fase2censo.exists?(["persona_id in (select persona_id from titulacionespersonas where titulacion_id = #{@titulacion.id})"])
      end
      if @titulacion.catastro_id.to_i > 0
        @existecatastrodatos = Catastrosdato.exists?(["catastro_id = #{@titulacion.catastro_id}"])
        @catastrosdatos = Catastrosdato.find_all_by_catastro_id(@titulacion.catastro_id)
      end
      render :action => "titulacion_form"
    end
    rescue
      redirect_to edit_titulacion_path(@titulacion)
  end

  def seguimiento
    @titulacion = Titulacion.find(params[:id])
  end
  
  def seguimientomatricula
    @titulacion = Titulacion.find(params[:id])
    @matricula = params[:matricula].to_s
  end


  def seguimientoreco
    @titulacion = Titulacion.find(params[:id])
  end

  def seguimientopot
    @titulacion = Titulacion.find(params[:id])
  end

  def seguimientoelena
    @titulacion = Titulacion.find(params[:id])
    if @titulacion.catastro_id.to_i > 0
      @existecatastrodatos = Catastrosdato.exists?(["catastro_id = #{@titulacion.catastro_id}"])
      @catastrosdatos = Catastrosdato.find_all_by_catastro_id(@titulacion.catastro_id)
    end
  end

  def seguimientorecomasivo
    @titulaciones = Titulacion.find(:all, :conditions=>["id in (select titulacion_id from titulacionesasignaciones where fecha_fin is null and trunc(fecha_asignacion) = trunc(sysdate) and user_id = #{params[:user_id]})"])
  end

  def pendientesentrega
#    @users = User.all(:include => :titulacionesprestamo, :conditions => { :titulacionesprestamos => { :fecha_devolucion => nil }, :users => {:user_id => is_admin}}, :order=>"modulos.mensaje")
    @users = User.find(:all, :conditions=>[" id in (select distinct userprestamo from titulacionesprestamos where fecha_devolucion is null)"], :order =>"nombre")
    #@archivosprestamos = Archivosprestamo.find(:all, :conditions =>["fecha_devolucion is null and trunc(fecha_vence) <= trunc(sysdate)"], :order => ["userprestamo, fecha_vence ASC"])
  end


  def destroy
    @titulacion = Titulacion.find(params[:id])
    @titulacion.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to titulaciones_path
        }
      format.xml  { head :ok }
    end
  end

  def buscacobama
    cobamaid = ""
    valor = params[:valor].to_s  #valor digitado en la variable
    if valor.to_s != ""
      if Comuna.exists?(["codigo_barrio = '#{valor.to_s[0,4]}'"]) == true
        comuna = Comuna.find_by_codigo_barrio(valor.to_s[0,4])
        cobamaid = comuna.id
        if Titulacion.exists?(["cobama = '#{valor}'"])
          render :update do |page|
            #page.alert "Este Cobama ya se encuentra registrado....."
            @titulacion = Titulacion.find(:first, :conditions=>["cobama = '#{valor}'"])
            page.redirect_to :controller=>"titulaciones", :action=>"edit", :id=>@titulacion.id
          end
        else
          if Catastro.exists?(["cbml = '#{valor}'"])
            @catastro = Catastro.find_by_cbml(valor)
            render :update do |page|
              page[:titulacion_direccion][:value] = @catastro.direccion.to_s
              page[:titulacion_unidades][:value] = @catastro.nropropietarios.to_s
              page[:titulacion_comuna_id][:value] = cobamaid.to_s
              page[:titulacion_manzana][:value] = valor.to_s[4,3]
              page[:titulacion_lote][:value] = valor.to_s[7,4]
            end
          else
            render :update do |page|
              page[:titulacion_direccion][:value] = nil
              page[:titulacion_unidades][:value] = nil
              page[:titulacion_comuna_id][:value] = cobamaid
              page[:titulacion_manzana][:value] = valor.to_s[4,3]
              page[:titulacion_lote][:value] = valor.to_s[7,4]
            end
          end
        end
      else
        render :update do |page|
          page[:titulacion_direccion][:value] = nil
          page[:titulacion_unidades][:value] = nil
          page[:titulacion_comuna_id][:value] = nil
          page[:titulacion_manzana][:value] = nil
          page[:titulacion_lote][:value] = nil
          #page.alert "Cobama invalido. Verifique!!"
        end
      end
    end
  end

  def registroobservacion
    titulaciones = Titulacion.find(:all, :conditions=>["cobama in (select cobama from tmpc)"])
    titulaciones.each do |titulacion|
      titulacionesobservacion = Titulacionesobservacion.new
      titulacionesobservacion.titulacion_id = titulacion.id
      titulacionesobservacion.tipo_atencion = 4
      titulacionesobservacion.observacion = 'SE REVISO POR PARTE DEL AREA JURIDICA Y SE IDENTIFICO QUE LA VIVIENDA NO INGRESA AL PROGRAMA DE RECONOCIMIENTO DE EDIFICACIONES DEBIDO A QUE EXISTE UNA DIFERENCIA ENTRE EL AREA DEL CERTIFICADO DE LIBERTAD Y LA FICHA CATASTRAL (SUPERIOR AL 15 PORCIENTO). REQUIERE ACLARACIÓN DE AREA POR PARTE DE CATASTRO MUNICIPAL, LA CUAL NO ES COMPETENCIA DEL ISVIMED.'
      titulacionesobservacion.user_id = is_admin
      titulacionesobservacion.save
    end
    redirect_to menus_path
  end

  def cartanotificacion
    @titulaciones = Titulacion.find(:all, :conditions=>["id in (#{params[:ids].to_s})"], :order=>"cobama")
    respond_to do |format|
      format.pdf  { render :layout => false }
    end
  end
  
  def cartanotificacione
    @titulaciones = Titulacion.find(:all, :conditions=>["cobama in (select cobama from tmpm where tipo = '#{params[:ids].to_s}')"], :order=>"cobama")
    respond_to do |format|
      format.pdf  { render :layout => false }
    end    
  end

  def cartacobama
    @titulaciones = Titulacion.find(:all, :conditions=>["id in (#{params[:ids].to_s})"], :order=>"cobama")
  end

  def rotulo
    @titulaciones = Titulacion.find(:all, :conditions=>["id in (#{params[:ids].to_s})"], :order=>"cobama")
  end

  def cartanotificacionpdf
    @titulaciones = Titulacion.find(:all, :conditions=>["id in (#{params[:ids].to_s})"], :order=>"cobama")
    respond_to do |format|
      format.pdf  { render :layout => false }
    end
  end

  def informesvisitas
    @titulaciones = Titulacion.seachvisit(
                             params[:ubicacion][:fchinicial],
                             params[:ubicacion][:fchfinal],
                             params[:ubicacion][:tipo],
                             params[:ubicacion][:clase],
                             params[:ubicacion][:user_id]
                             )
    if @titulaciones.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to titulaciones_path
    else
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Titulaciones_Visitas_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
    end
   end
#
#  def cartanotificacion
#    @titulaciones = Titulacion.find(:all, :conditions=>["cobama in (...)"], :order=>"cobama")
#    respond_to do |format|
#      format.pdf  { render :layout => false }
#    end
#  end


#  def cartanotificacionmasiva_ori
#    logger.error("Inicia Carga Masiva....")
#    array = params[:titulaciones]
#    i = 1
#    while i < array.size
#      if i == 1
#        ids = array[i].to_s
#      else
#        ids = ids +','+ array[i].to_s
#      end
#      logger.error("Cantidaddd..."+ids.to_s)
#      i = i + 1
#    end
#    @titulaciones = Titulacion.find(:all, :conditions=>["id in (#{ids})"], :order=>"cobama")
#  end

  private
  def determine_layout
    if ['informe','informeseguimiento','informestitulacion','prestamostotal','informesasignacions','informesasignacionf','informesvisitas'].include?(action_name)
      "excel"
    elsif['cartanotcobamamasiva','cartacobama','cartanotificacione','cartanotificacion','cartanotificacionmasiva','rotulo','seguimientomatricula','seguimientopot','seguimientoelena','pertenencia','poder','seguimiento','prestamo','seguimientoreco','prepara','envia','pendientesentrega'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
