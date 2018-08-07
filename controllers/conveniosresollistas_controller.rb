class ConveniosresollistasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    conveniosresolintencion   = Conveniosresolintencion.find(params[:conveniosresolintencion_id])
    @conveniosresollistas = conveniosresolintencion.conveniosresollistas.all
  end

  def informe
    @conveniosresolintencion = Conveniosresolintencion.find(params[:id])
  end

  def edit
    @conveniosresollista  = Conveniosresollista.find(params[:id], :include => "conveniosresolintencion")
    @conveniosresollista  = @conveniosresollista.conveniosresolintencion
    respond_to do |format|
      format.js { render :action => "edit_conveniosresollista" }
    end
  end

  def update
    @conveniosresollista        = Conveniosresollista.new
    conveniosresollista         = Conveniosresollista.find(params[:id])
    params[:conveniosresollista][:user_actualiza] = is_admin
    @mejoramiento        = conveniosresollista.mejoramiento
    ok = conveniosresollista.update_attributes(params[:conveniosresollista])
    if ok == true
      is_trigger_mej(@mejoramiento.id,is_admin,'conveniosresollistas','A')
      flash[:conveniosresollista] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "conveniosresollistas" }
      end
    else
      render :update do |page|
        page.alert "El registro tiene inconsistencias por falta de campos o valor ingresado supera el subsidio. Verifique!!"
      end
    end
#    respond_to do |format|
#      format.js { render :action => "conveniosresollistas" }
#    end
  end

  def si
    @conveniosresollista        = Conveniosresollista.new
    conveniosresollista         = Conveniosresollista.find(params[:id])
    conveniosresollista.estado ='SI'
    @conveniosresolintencion       = conveniosresollista.conveniosresolintencion
    ok = conveniosresollista.update_attributes(params[:conveniosresollista])
    respond_to do |format|
      format.js { render :action => "conveniosresollistas" }
    end
  end

  def no
    @conveniosresollista        = Conveniosresollista.new
    conveniosresollista         = Conveniosresollista.find(params[:id])
    conveniosresollista.estado ='NO'
    @conveniosresolintencion       = conveniosresollista.conveniosresolintencion
    ok = conveniosresollista.update_attributes(params[:conveniosresollista])
    respond_to do |format|
      format.js { render :action => "conveniosresollistas" }
    end
  end

  def na
    @conveniosresollista        = Conveniosresollista.new
    conveniosresollista         = Conveniosresollista.find(params[:id])
    conveniosresollista.estado ='NO APLICA'
    @conveniosresolintencion       = conveniosresollista.conveniosresolintencion
    ok = conveniosresollista.update_attributes(params[:conveniosresollista])
    respond_to do |format|
      format.js { render :action => "conveniosresollistas" }
    end
  end

  private
  def determine_layout
    if ['atencion','informe'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end


#  def index
#    conveniosresolintencion   = Conveniosresolintencion.find(params[:conveniosresolintencion_id])
#    @conveniosresollista = conveniosresolintencion.conveniosresollista.all
#  end
#
#  def edit
#    @conveniosresolintencionsresollista  = Conveniosresollista.find(params[:id], :include => "conveniosresolintencion")
#    @conveniosresolintencion  = @conveniosresolintencionsresollista.conveniosresolintencion
#    respond_to do |format|
#      format.js { render :action => "edit_conveniosresolintencionsresollista" }
#    end
#  end
#
#  def create
#    @conveniosresolintencion  = Conveniosresolintencion.find(params[:conveniosresolintencion_id])
#    @conveniosresolintencionsresollista = Conveniosresollista.new(params[:conveniosresolintencionsresollista])
#    @conveniosresolintencionsresollista.user_id = is_admin
#    if @conveniosresolintencionsresollista.valid?
#      @conveniosresolintencion.conveniosresollista << @conveniosresolintencionsresollista
#      @conveniosresolintencion.save
#      @conveniosresolintencionsresollista = Conveniosresollista.new
#      flash[:conveniosresolintencionsresollista] = "Registro almacenado con Exito"
#    else
#      flash[:conveniosresolintencionsresollista] = "Se produjo un error al guardar el registro"
#    end
#    respond_to do |format|
#      format.js { render :action => "conveniosresollista" }
#    end
#  end
#
#  def update
#    @conveniosresolintencionsresollista        = Conveniosresollista.new
#    conveniosresolintencionsresollista         = Conveniosresollista.find(params[:id])
#    @conveniosresolintencion        = conveniosresolintencionsresollista.conveniosresolintencion
#    ok = conveniosresolintencionsresollista.update_attributes(params[:conveniosresolintencionsresollista])
#    flash[:conveniosresolintencionsresollista] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
#    respond_to do |format|
#      format.js { render :action => "conveniosresollista" }
#    end
#  end
#
#  def destroy
#    conveniosresolintencionsresollista   = Conveniosresollista.find(params[:id])
#    @conveniosresolintencion  = conveniosresolintencionsresollista.conveniosresolintencion
#    @conveniosresolintencionsresollista  = Conveniosresollista.new
#    conveniosresolintencionsresollista.destroy
#    respond_to do |format|
#      format.js { render :action => "conveniosresollista" }
#    end
#  end
#end
