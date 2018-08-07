class ComitesresponsablesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    comite   = Comite.find(params[:comite_id])
    @comitesresponsables = comite.comitesresponsables.all
  end

 def edit
    @comitesresponsable  = Comitesresponsable.find(params[:id], :include => "comite")
    @comite  = @comitesresponsable.comite
    respond_to do |format|
      format.js { render :action => "edit_comitesresponsable" }
    end
  end

  def create
    @comite  = Comite.find(params[:comite_id])
    @comitesresponsable = Comitesresponsable.new(params[:comitesresponsable])
    if @comitesresponsable.valid?
      @comite.comitesresponsables << @comitesresponsable
      @comite.save
      @comitesresponsable = Comitesresponsable.new
      flash[:comitesresponsable] = "Creado con exito"
    else
      flash[:comitesresponsable] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "comitesresponsables" }
    end
  end

  def update
    @comitesresponsable        = Comitesresponsable.new
    comitesresponsable         = Comitesresponsable.find(params[:id])
    @comite        = comitesresponsable.comite
    ok = comitesresponsable.update_attributes(params[:comitesresponsable])
    if ok == true
      flash[:benevivienda] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "comitesresponsables" }
      end
    else
      render :update do |page|
         page.alert "El registro tiene inconsistencias. Verifique!!"
      end
    end
  end

  def destroy
    comitesresponsable   = Comitesresponsable.find(params[:id])
    @comite  = comitesresponsable.comite
    @comitesresponsable  = Comitesresponsable.new
    comitesresponsable.destroy
    flash[:comitesresponsable] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "comitesresponsables" }
    end
  end
end
