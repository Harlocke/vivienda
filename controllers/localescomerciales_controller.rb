class LocalescomercialesController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    @localescomerciales = Localescomercial.all  
  end

  def buscar
    #logger.error("--------------------------------------------------------------------------")
    #ogger.error("El valor de control_int es..."+params[:ubicacion][:control_int].to_s)
    #logger.error("--------------------------------------------------------------------------")
    @localescomerciales = Localescomercial.search(params[:ubicacion][:proyecto], 
                                                  params[:ubicacion][:fecha],
                                                  params[:escritura])
    if @localescomerciales.count == 0 
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to proyectos_path
    elsif @localescomerciales.count == 1
      redirect_to edit_localescomercial_path(@localescomerciales)
    else
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end
 
  def localescons
     headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_LocalesComerciales_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @localescomerciales = Localescomercial.all
      @localesproys = Localescomercial.find(:all, :select => 'proyecto, count(proyecto) cant ',
                                            :group =>"proyecto", 
                                            :order => "proyecto")
  end

  def new
    @localescomercial = Localescomercial.new
    render :action => "localescomercial_form"
  end

  def edit
    @localescomercial = Localescomercial.find(params[:id])
    #@localescomercialesnota = Localescomercialesnota.new
      respond_to do |format|
      format.html { render :action => "localescomercial_form" }
    end
  end

  def create
    @localescomercial = Localescomercial.new(params[:localescomercial])
    #@localescomercial.user_id = is_admin
    if @localescomercial.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_localescomercial_path(@localescomercial)
    else
      render :action => "localescomercial_form"
    end
  end

  def update
    @localescomercial = Localescomercial.find(params[:id])
    #@localescomercial.user_id = is_admin
    if @localescomercial.update_attributes(params[:localescomercial])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_localescomercial_path(@localescomercial)
    else
      #@localescomercialesnota = Localescomercialesnota.new
      render :action => "localescomercial_form"
    end
  rescue
    flash[:notice] = "Existen inconsistencias. Verifique!!!"
    redirect_to edit_localescomercial_path(@localescomercial)
  end

  
  def destroy
    @localescomercial = Localescomercial.find(params[:id])
    @localescomercial.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to busqueda_localescomerciales_path
      }
      format.xml  { head :ok }
    end
  end

#  def show
#    persona   = Persona.find(params[:localescomercial_id])
#    @localescomerciales = persona.localescomerciales.all
#  end

  private
  def determine_layout
    if ['visualizar','buscarx'].include?(action_name)
      "atencion"
    elsif ['localescons'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end