class ObrasvendedoresController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    obraspublica   = Obraspublica.find(params[:obraspublica_id])
    @obrasvendedores = obraspublica.obrasvendedores.all
  end

 def edit
    @obrasvendedor  = Obrasvendedor.find(params[:id], :include => "obraspublica")
    @obraspublica  = @obrasvendedor.obraspublica
    respond_to do |format|
      format.js { render :action => "edit_obrasvendedor" }
    end
  end

  def create
    @obraspublica  = Obraspublica.find(params[:obraspublica_id])
    @obrasvendedor = Obrasvendedor.new(params[:obrasvendedor])
    @obrasvendedor.user_id = is_admin
    if @obrasvendedor.valid?
      @obraspublica.obrasvendedores << @obrasvendedor
      @obraspublica.save
      @obrasvendedor = Obrasvendedor.new
      flash[:obrasvendedor] = "Creado con exito"
    else
      flash[:obrasvendedor] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "obrasvendedores" }
    end
  end

  def update
    @obrasvendedor        = Obrasvendedor.new
    obrasvendedor         = Obrasvendedor.find(params[:id])
    #obrasvendedor.user_id = is_admin
    @obraspublica        = obrasvendedor.obraspublica
    ok = obrasvendedor.update_attributes(params[:obrasvendedor])
    flash[:obrasvendedor] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "obrasvendedores" }
    end
  end

  def destroy
    obrasvendedor   = Obrasvendedor.find(params[:id])
    @obraspublica  = obrasvendedor.obraspublica
    @obrasvendedor  = Obrasvendedor.new
    obrasvendedor.destroy
    flash[:obrasvendedor] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "obrasvendedores" }
    end
  end
end
