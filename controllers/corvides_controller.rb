class CorvidesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index     
  end

  def new
    @corvide = Corvide.new
    render :action => "corvide_form"
  end

  def create
     @corvide = Corvide.new(params[:corvide])
     @corvide.user_id = is_admin
     if @corvide.save
       flash[:notice] = "corvide Creado con Exito."
       redirect_to edit_corvide_path(@corvide)
     else
       @corvidesdocumento = Corvidesdocumento.new
       @corvidesobservacion = Corvidesobservacion.new
       @corvidespersona = Corvidespersona.new
       flash[:warning] = "Problemas con la creacion del registro."
       render :action => "corvide_form"
      end
  end

  def buscar
    @corvide  = Corvide.new
    @corvide.nro_expediente =  params[:nro_expediente]
    @corvide.comuna_id = params[:ubicacion][:comuna_id]
    @corvide.cbml =  params[:cbml]
    @corvide.matricula =  params[:matricula]
    @corvide.transferencia =  params[:ubicacion][:transferencia]
    @corvide.estado =  params[:ubicacion][:estado]
    @corvide.cbml =  params[:cbml]
    @corvides = Corvide.search(@corvide,params[:poseedor],params[:adjudicatario])
    if @corvides.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to corvides_path
    elsif params[:format] != 'xls'
      if @corvides.count == 1
        redirect_to edit_corvide_path(@corvides)
      else
        respond_to do |format|
          format.html
        end
      end
    else
      @formato = params[:format].to_s
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Corvides_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
    end
  end

 def show
   @corvide = Corvide.find(params[:id])
   respond_to do |format|
     format.html # show.html.erb
     format.xml  { render :xml => @corvide }
   end
 end

 def edit
   @corvide = Corvide.find(params[:id])
   @corvidesdocumento = Corvidesdocumento.new
   @corvidesobservacion = Corvidesobservacion.new
   @corvidespersona = Corvidespersona.new
   respond_to do |format|
     format.html { render :action => "corvide_form" }
   end
 end

 def update
   @corvide = Corvide.find(params[:id])
   @corvideuser_actualiza = is_admin
   if @corvide.update_attributes(params[:corvide])
     flash[:notice] = "Corvide actualizado correctamente."
     redirect_to edit_corvide_path(@corvide)
   else
     @corvidesdocumento = Corvidesdocumento.new
     @corvidesobservacion = Corvidesobservacion.new
     @corvidespersona = Corvidespersona.new
     render :action => "corvide_form"
   end
   rescue
   redirect_to edit_corvide_path(@corvide)
 end

 def informedetallado
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_CorvideDetallado_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @corvides = Corvide.find(:all, :order=>"id asc")
  end

  def informeconsolidado
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_CorvideProyecto_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @corvides  = Corvide.find_by_sql(["select transferencia, count(9) cant from corvides where estado != 'CANCELACION DE HIPOTECAS' group by transferencia"])
      @corvidess = Corvide.find_by_sql(["select transferencia, count(9) cant from corvides where estado = 'CANCELACION DE HIPOTECAS' group by transferencia"])
  end
  
  def informeconsolidado2
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_CorvideEstado_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @corvides = Corvide.find_by_sql(["select estado, count(9) cant from corvides group by estado order by estado "])
      @corvidesa = Corvide.find_by_sql(["select comuna_id, count(9) cant from corvides where propietario = '900014480-8 ISVIMED' group by comuna_id order by comuna_id "])
      @corvidesb = Corvide.find_by_sql(["select comuna_id, count(9) cant from corvides where propietario = '890905211-1 MUNICIPIO DE MEDELLÍN' group by comuna_id order by comuna_id "])
  end

 def destroy
   @corvide = Corvide.find(params[:id])
   @corvide.destroy
   respond_to do |format|
     format.html { redirect_to corvides_path }
     format.xml  { head :ok }
   end
 end

  private
  def determine_layout
    if ['visualizar'].include?(action_name)
      "atencion"
    elsif['informeconsolidado','informedetallado','informeconsolidado2'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end