class ObrasradicadosController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    obraspublica   = Obraspublica.find(params[:obraspublica_id])
    @obrasradicados = obraspublica.obrasradicados.all
  end

 def edit
    @obrasradicado  = Obrasradicado.find(params[:id], :include => "obraspublica")
    @obraspublica  = @obrasradicado.obraspublica
    respond_to do |format|
      format.js { render :action => "edit_obrasradicado" }
    end
  end

  def create
    @obraspublica  = Obraspublica.find(params[:obraspublica_id])
    @obrasradicado = Obrasradicado.new(params[:obrasradicado])
    @obrasradicado.user_id = is_admin
    if @obrasradicado.valid?
      @obraspublica.obrasradicados << @obrasradicado
      @obraspublica.save
      @obrasradicado = Obrasradicado.new
      flash[:obrasradicado] = "Creado con exito"
    else
      flash[:obrasradicado] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "obrasradicados" }
    end
  end

  def update
    @obrasradicado        = Obrasradicado.new
    obrasradicado         = Obrasradicado.find(params[:id])
    #obrasradicado.user_id = is_admin
    @obraspublica        = obrasradicado.obraspublica
    ok = obrasradicado.update_attributes(params[:obrasradicado])
    flash[:obrasradicado] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "obrasradicados" }
    end
  end

  def destroy
    obrasradicado   = Obrasradicado.find(params[:id])
    @obraspublica  = obrasradicado.obraspublica
    @obrasradicado  = Obrasradicado.new
    obrasradicado.destroy
    flash[:obrasradicado] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "obrasradicados" }
    end
  end
end
