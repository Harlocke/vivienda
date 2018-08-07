class ViviendasusadasController < ApplicationController
  layout :determine_layout
  before_filter :require_user

  def index
    if permiso("viviendasusadavisita","C").to_s == "S"
      @existependvisita = Viviendasusada.exists?(['visita_tecnica = ?',"PENDIENTE"])
      if @existependvisita
        @viviendasusadas = Viviendasusada.find(:all, :conditions=>["visita_tecnica = 'PENDIENTE'"], :order=>"fechasol_visitatecnica asc")
      end
    end
  end

  def show
    @viviendasusada = Viviendasusada.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @viviendasusada }
    end
  end

  def buscar
    perpage = 0
    if params[:format] == 'xls'
      perpage = 10000
    else
      perpage = 15
    end    
    @viviendasusada  = Viviendasusada.new
    @viviendasusadasestados = Viviendasusadasestado.all
    @viviendasusada.tipospoblacion_id =  params[:ubicacion][:tipospoblacion_id]
    @viviendasusada.viviendasusadasestado_id =  params[:ubicacion][:viviendasusadasestado_id]
    @viviendasusada.tipospoblacion_id =  params[:ubicacion][:tipospoblacion_id]
    @viviendasusada.familiar_id =  params[:ubicacion][:familiar_id]
    @viviendasusada.sector = params[:sector]
    @viviendasusada.resultado_concepto = params[:ubicacion][:resultado_concepto]
    @viviendasusada.resultado_estudio = params[:ubicacion][:resultado_estudio]
    @viviendasusada.modo_adquisicion = params[:ubicacion][:modo_adquisicion]
    @viviendasusada.entregada = params[:ubicacion][:entregada]
    @viviendasusadas = Viviendasusada.search(@viviendasusada,
                                             params[:identificacion],
                                             params[:codigo],
                                             params[:ubicacion][:visitainicial],
                                             params[:ubicacion][:visitafinal],
                                             params[:ubicacion][:escriturainicial],
                                             params[:ubicacion][:escriturafinal],
                                             params[:ubicacion][:fchinicial],
                                             params[:ubicacion][:fchfinal],
                                             params[:buscarprecioinicial],
                                             params[:buscarpreciofinal],params[:page],perpage)
    @buscadorpoblacion     = params[:ubicacion][:tipospoblacion_id]
    @buscadorestado        = params[:ubicacion][:viviendasusadasestado_id]
    if @viviendasusadas.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to viviendasusadas_path
    elsif params[:format] != 'xls'
      if @viviendasusadas.count == 1
        redirect_to edit_viviendasusada_path(:id => @viviendasusadas, :etapa=>"1")
      else
        respond_to do |format|
           format.html
        end
      end
    elsif params[:format] == 'xls'
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_ViviendasUsadas_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
    end
  end

  def informe
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="viviendausadainforme_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @viviendasusadasnotas = Viviendasusadasnota.search(params[:ubicacion][:usuario],
                                               params[:ubicacion][:fchinicial],
                                               params[:ubicacion][:fchfinal])
    respond_to do |format|
       format.xls
    end
  end  

  def new
    @viviendasusada = Viviendasusada.new
    @viviendasusada.etapa = "1"
#    @familiares = Familiar.all
    render :action => "viviendasusada_form"
  end

  def edit
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update viviendasusadas set etapa = '#{params[:etapa]}' where id = #{params[:id]}")
    end    
    @viviendasusada = Viviendasusada.find(params[:id])
    if @viviendasusada.etapa.to_s == "2"
      @viviendasusadaspersona = Viviendasusadaspersona.new
    elsif @viviendasusada.etapa.to_s == "3"
      @viviendasusadastramite  = Viviendasusadastramite.new
    elsif @viviendasusada.etapa.to_s == "4"
      @viviendasusadaspago  = Viviendasusadaspago.new
    elsif @viviendasusada.etapa.to_s == "5"
      @viviendasusadasnota  = Viviendasusadasnota.new
    elsif @viviendasusada.etapa.to_s == "6"
      @viviendasusadasimagen  = Viviendasusadasimagen.new
    end
    #@familiares      = Familiar.all
    respond_to do |format|
      format.html { render :action => "viviendasusada_form" }
    end
  end

  def create
    @viviendasusada = Viviendasusada.new(params[:viviendasusada])
    @viviendasusada.user_id = is_admin
    if @viviendasusada.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_viviendasusada_path(@viviendasusada)
    else
      render :action => "viviendasusada_form"
    end
  end

  def update
    @viviendasusada = Viviendasusada.find(params[:id])
    params[:viviendasusada][:useract_id] = is_admin
    if @viviendasusada.update_attributes(params[:viviendasusada])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_viviendasusada_path(:id=>@viviendasusada, :etapa=>'1')
    else
      render :action => "viviendasusada_form"
    end
    rescue
      redirect_to edit_viviendasusada_path(@viviendasusada)
  end

  def solicitarvisita
    @viviendasusada = Viviendasusada.find(params[:id])
    @correos = Sifi.find(104).valor.to_s
    @solicitante = User.find(is_admin).responsable rescue nil
    begin
      Notifier.deliver_solicitudvisita_message(@correos, @viviendasusada, params[:nombre].to_s, @solicitante)
      ActiveRecord::Base.connection.execute("update viviendasusadas set visita_tecnica = 'PENDIENTE', fechasol_visitatecnica = sysdate, user_solicitavisita = #{is_admin} 
                                             where id = #{params[:id]}")
      rescue Exception => exc
         logger.error("SIFI ERROR solicitarvisita - Correo No enviado a #{@correos}")
    end
    flash[:notice] = "La solicitud de Visita Tecnica enviada con exito"
    redirect_to edit_viviendasusada_path(@viviendasusada)
  end

  def cambioestado
    ActiveRecord::Base.connection.execute("update viviendasusadas set visita_tecnica = '#{params[:estado].to_s}'
                                           where id = #{params[:id]}")
    flash[:notice] = "Visita tecnica - Cambio realizado "
    redirect_to viviendasusadas_path
  end  

  def informevisita
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_InformeVisitas_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @viviendasusadas = Viviendasusada.find(:all, :conditions=>["visita_tecnica = 'PENDIENTE'"])
    respond_to do |format|
       format.xls
    end    
  end

  def destroy
    @viviendasusada = Viviendasusada.find(params[:id])
    @viviendasusada.destroy
    respond_to do |format|
      format.html { 
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to viviendasusadas_path 
        }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['informevisita'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end
