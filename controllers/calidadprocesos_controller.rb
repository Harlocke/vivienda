class CalidadprocesosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @hab = Sifi.find(93).valor.to_s
    if params[:search].to_s != "" or params[:searchn].to_s != ""
      @calidaddocumentos = Calidaddocumento.search(params[:search],params[:searchn], params[:page])
      if @calidaddocumentos.count == 0
        #flash[:notice] = "No hay resultados de la consulta "+params[:search].to_s
        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @calidaddocumentos }
        end
      else
        #flash[:notice] = "Se encontraron varios resultados"
        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @calidaddocumentos }
        end
      end
    end
  end

  def new
    @calidadproceso = Calidadproceso.new
    @calidadproceso.etapa = '1'
#    @calidadprocesosfuncionario  = Calidadprocesosfuncionario.new
    render :action => "calidadproceso_form"
  end

  def buscarx
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="informeasesorias_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @capacitaciones = Capacitacion.search(
                             params[:ubicacion][:fchinicial],
                             params[:ubicacion][:fchfinal],
                             params[:ubicacion][:user_id],
                             params[:ubicacion][:region_id])
    if @capacitaciones.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to calidadprocesos_path
    end
  end

  def datosproceso
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Calidadtotal_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @calidadprocesos = Calidadproceso.find(:all, :order=>"tipoproceso") 
  end

  def maestroreporte
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Maestroreporte_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @calidadproceso = Calidadproceso.find(params[:id])
    @calidaddocumentos  = Calidaddocumento.find(:all, :conditions=>["calidadproceso_id = #{params[:id]} and calidadtiposdocumento_id in (3,4,5,7,8,15,16) and activo = 'ACTIVO'"], :order=>"codigo")
  end

  def maestroregistro
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_MaestroRegistros_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @calidadproceso = Calidadproceso.find(params[:id])
    @calidaddocumentos  = Calidaddocumento.find(:all, :conditions=>["calidadproceso_id = #{params[:id]} and calidadtiposdocumento_id not in (3,4,5,7,8,15,16) and activo = 'ACTIVO'"], :order=>"codigo")
  end

  def proceso
    @calidadproceso = Calidadproceso.find(params[:id])
    @calidaddocumentos  = Calidaddocumento.find_all_by_calidadproceso_id(params[:id])
  end

  def create
    @calidadproceso = Calidadproceso.new(params[:calidadproceso])
    @calidadproceso.user_id = is_admin
    @calidadproceso.user_actualiza = is_admin
    if @calidadproceso.save
      flash[:notice] = "Calidadproceso Creado con Exito."
      redirect_to edit_calidadproceso_path(@calidadproceso)
    else
      flash[:warning] = "Problemas con la creacion del registro."
      render :action => "calidadproceso_form"
     end
  end

  def show
    @calidadproceso = Calidadproceso.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @calidadproceso }
    end
  end

  def edit
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update calidadprocesos set etapa = '#{params[:etapa]}' where id = #{params[:id]}")
    end    
    @calidadproceso = Calidadproceso.find(params[:id])
    if @calidadproceso.etapa.to_s == "2"
      @calidaddocumento = Calidaddocumento.new
    elsif @calidadproceso.etapa.to_s == "3"
      @existenormograma = Calidadnormogramasproceso.exists?(["calidadproceso_id = ?", @calidadproceso.id])
      if @existenormograma
         @calidadnormogramas = Calidadnormograma.find_by_sql("select * from calidadnormogramas
                                                              where id in (select calidadnormograma_id
                                                                           from calidadnormogramasprocesos
                                                                           where calidadproceso_id = #{@calidadproceso.id})")
      end
    end
    respond_to do |format|
      format.html { render :action => "calidadproceso_form" }
    end
  end

  def update
    @calidadproceso = Calidadproceso.find(params[:id])
    @calidadproceso.user_actualiza = is_admin
    if @calidadproceso.update_attributes(params[:calidadproceso])
      flash[:notice] = "Calidadproceso actualizado correctamente."
      redirect_to edit_calidadproceso_path(@calidadproceso)
    else
      #@calidaddocumento = Calidaddocumento.new
      #@existenormograma = Calidadnormogramasproceso.exists?(["calidadproceso_id = ?", @calidadproceso.id])
      render :action => "calidadproceso_form"
    end
    rescue
    redirect_to edit_calidadproceso_path(@calidadproceso)
  end

  private
  def determine_layout
    if ['buscarx'].include?(action_name)
      "informes"
    elsif ['datosproceso','maestroreporte','maestroregistro','imagen'].include?(action_name)
      "excel"
    elsif ['proceso'].include?(action_name)
      "basico"
    else
      "application"
    end
  end
end