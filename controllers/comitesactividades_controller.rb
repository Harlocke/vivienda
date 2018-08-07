class ComitesactividadesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    comite   = Comite.find(params[:comite_id])
    @comitesactividades = comite.comitesactividades.all
  end

 def edit
    @comitesactividad  = Comitesactividad.find(params[:id], :include => "comite")
    @comite  = @comitesactividad.comite
    respond_to do |format|
      format.js { render :action => "edit_comitesactividad" }
    end
  end

  def create
    @comite  = Comite.find(params[:comite_id])
    @comitesactividad = Comitesactividad.new(params[:comitesactividad])
    @comitesactividad.user_id = is_admin
    if @comitesactividad.valid?
      @comite.comitesactividades << @comitesactividad
      @comite.save
      @comitesactividad = Comitesactividad.new
      flash[:comitesactividad] = "Creado con exito"
    else
      flash[:comitesactividad] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "comitesactividades" }
    end
  end

  def update
    @comitesactividad        = Comitesactividad.new
    comitesactividad         = Comitesactividad.find(params[:id])
    @comite        = comitesactividad.comite
    ok = comitesactividad.update_attributes(params[:comitesactividad])
    if ok == true
      flash[:benevivienda] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "comitesactividades" }
      end
    else
      render :update do |page|
         page.alert "El registro tiene inconsistencias. Verifique!!"
      end
    end
  end

  def destroy
    comitesactividad   = Comitesactividad.find(params[:id])
    @comite  = comitesactividad.comite
    @comitesactividad  = Comitesactividad.new
    comitesactividad.destroy
    flash[:comitesactividad] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "comitesactividades" }
    end
  end
end
