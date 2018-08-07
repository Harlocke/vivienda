class CapituloscriteriosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    capitulo   = Capitulo.find(params[:capitulo_id])
    @capituloscriterios = capitulo.capituloscriterios.all
  end

 def edit
    @capituloscriterio  = Capituloscriterio.find(params[:id], :include => "capitulo")
    @capitulo  = @capituloscriterio.capitulo
    respond_to do |format|
      format.js { render :action => "edit_capituloscriterio" }
    end
  end

  def create
    @capitulo  = Capitulo.find(params[:capitulo_id])
    @capituloscriterio = Capituloscriterio.new(params[:capituloscriterio])
    #@capituloscriterio.user_id = is_admin
    if @capituloscriterio.valid?
      @capitulo.capituloscriterios << @capituloscriterio
      @capitulo.save
      @capituloscriterio = Capituloscriterio.new
      flash[:capituloscriterio] = "Creado con exito"
    else
      flash[:capituloscriterio] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "capituloscriterios" }
    end
  end

  def update
    @capituloscriterio        = Capituloscriterio.new
    capituloscriterio         = Capituloscriterio.find(params[:id])
    @capitulo        = capituloscriterio.capitulo
    ok = capituloscriterio.update_attributes(params[:capituloscriterio])
    if ok == true
      flash[:benevivienda] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "capituloscriterios" }
      end
    else
      render :update do |page|
         page.alert "El registro tiene inconsistencias. Verifique!!"
      end
    end
  end

  def destroy
    capituloscriterio   = Capituloscriterio.find(params[:id])
    @capitulo  = capituloscriterio.capitulo
    @capituloscriterio  = Capituloscriterio.new
    capituloscriterio.destroy
    flash[:capituloscriterio] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "capituloscriterios" }
    end
  end
end
