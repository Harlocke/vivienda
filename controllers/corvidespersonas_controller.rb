class CorvidespersonasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    corvide   = Corvide.find(params[:corvide_id])
    @corvidespersonas = corvide.corvidespersonas.all
  end

 def edit
    @corvidespersona  = Corvidespersona.find(params[:id], :include => "corvide")
    @corvide  = @corvidespersona.corvide
    respond_to do |format|
      format.js { render :action => "edit_corvidespersona" }
    end
  end

  def create
    @corvide  = Corvide.find(params[:corvide_id])
    @corvidespersona = Corvidespersona.new(params[:corvidespersona])
    @corvidespersona.user_id = is_admin
    if @corvidespersona.valid?
      @corvide.corvidespersonas << @corvidespersona
      @corvide.save
      @corvidespersona = Corvidespersona.new
      flash[:corvidespersona] = "Creado con exito"
    else
      flash[:corvidespersona] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "corvidespersonas" }
    end
  end

  def update
    @corvidespersona        = Corvidespersona.new
    corvidespersona         = Corvidespersona.find(params[:id])
    @corvide        = corvidespersona.corvide
    ok = corvidespersona.update_attributes(params[:corvidespersona])
    if ok == true
      flash[:benevivienda] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "corvidespersonas" }
      end
    else
      render :update do |page|
         page.alert "El registro tiene inconsistencias. Verifique!!"
      end
    end
  end

  def destroy
    corvidespersona   = Corvidespersona.find(params[:id])
    @corvide  = corvidespersona.corvide
    @corvidespersona  = Corvidespersona.new
    corvidespersona.destroy
    flash[:corvidespersona] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "corvidespersonas" }
    end
  end
end