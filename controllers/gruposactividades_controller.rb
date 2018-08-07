class GruposactividadesController < ApplicationController
  before_filter :require_user
    layout :determine_layout

  def index
    grupo   = Grupo.find(params[:grupo_id])
    @gruposactividades = grupo.gruposactividades.all
  end

  def edit
    @gruposactividad  = Gruposactividad.find(params[:id], :include => "grupo")
    @grupo  = @gruposactividad.grupo
    respond_to do |format|
      format.js { render :action => "edit_gruposactividad" }
    end
  end

  def listar
     @gruposactividades = Gruposactividad.find(:all, :conditions => [" descripcion LIKE upper('%%#{params[:search]}%%')"], :limit=>10)
  end

  def create
    @grupo  = Grupo.find(params[:grupo_id])
    @gruposactividad = Gruposactividad.new(params[:gruposactividad])
    if @gruposactividad.valid?
      @gruposactividad.user_id = is_admin
      @grupo.gruposactividades << @gruposactividad
      @grupo.save
      @gruposactividad = Gruposactividad.new
      flash[:notice] = "Creadooo"
    else
      flash[:warning] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "gruposactividades" }
    end
  end

  def update
    @gruposactividad        = Gruposactividad.new
    gruposactividad         = Gruposactividad.find(params[:id])
    @grupo        = gruposactividad.grupo
    ok = gruposactividad.update_attributes(params[:gruposactividad])
    flash[:notice] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "gruposactividades" }
    end
  end

  def destroy
    gruposactividad   = Gruposactividad.find(params[:id])
    @grupo  = gruposactividad.grupo
    @gruposactividad  = Gruposactividad.new
    gruposactividad.destroy
    respond_to do |format|
      format.js { render :action => "gruposactividades" }
    end
  end

  private
  def determine_layout
    if ['mostrar'].include?(action_name)
      "informesapu"
    else
      "application"
    end
  end
end