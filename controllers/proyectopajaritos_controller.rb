class ProyectopajaritosController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    @proyectopajaritos = Proyectopajarito.all  
  end

  def buscar
    #logger.error("--------------------------------------------------------------------------")
    #ogger.error("El valor de control_int es..."+params[:ubicacion][:control_int].to_s)
    #logger.error("--------------------------------------------------------------------------")
    @proyectopajaritos = Proyectopajarito.search(params[:ubicacion][:proyecto],
                                                 params[:ubicacion][:unidad_gestion],
                                                 params[:ubicacion][:fecha],
                                                 params[:escritura])
    if @proyectopajaritos.count == 0 
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to proyectos_path
    elsif @proyectopajaritos.count == 1
      redirect_to edit_proyectopajarito_path(@proyectopajaritos)
    else
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end

  def proyectoscons
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_ProyectosPajarito_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @proyectopajaritos = Proyectopajarito.all
      @proyectoscons = Proyectopajarito.find(:all, :select => 'proyecto, count(proyecto) cant ',
                                          :group =>"proyecto", 
                                          :order => "proyecto")
      @unidades = Proyectopajarito.find(:all, :select => 'unidad_gestion, count(unidad_gestion) cant1 ',
                                              :group =>"unidad_gestion", 
                                              :order => "unidad_gestion")
  end

  def new
    @proyectopajarito = Proyectopajarito.new
    render :action => "proyectopajarito_form"
  end

  def edit
    @proyectopajarito = Proyectopajarito.find(params[:id])
    #@proyectopajaritosnota = Proyectopajaritosnota.new
      respond_to do |format|
      format.html { render :action => "proyectopajarito_form" }
    end
  end

  def create
    @proyectopajarito = Proyectopajarito.new(params[:proyectopajarito])
    #@proyectopajarito.user_id = is_admin
    if @proyectopajarito.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_proyectopajarito_path(@proyectopajarito)
    else
      render :action => "proyectopajarito_form"
    end
  end

  def update
    @proyectopajarito = Proyectopajarito.find(params[:id])
    #@proyectopajarito.user_id = is_admin
    if @proyectopajarito.update_attributes(params[:proyectopajarito])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_proyectopajarito_path(@proyectopajarito)
    else
      #@proyectopajaritosnota = Proyectopajaritosnota.new
      render :action => "proyectopajarito_form"
    end
  rescue
    flash[:notice] = "Existen inconsistencias. Verifique!!!"
    redirect_to edit_proyectopajarito_path(@proyectopajarito)
  end

  
  def destroy
    @proyectopajarito = Proyectopajarito.find(params[:id])
    @proyectopajarito.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to busqueda_proyectopajaritos_path
      }
      format.xml  { head :ok }
    end
  end

#  def show
#    persona   = Persona.find(params[:proyectopajarito_id])
#    @proyectopajaritos = persona.proyectopajaritos.all
#  end

  private
  def determine_layout

    if ['visualizar'].include?(action_name)
      "atencion"
    elsif['proyectoscons'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end