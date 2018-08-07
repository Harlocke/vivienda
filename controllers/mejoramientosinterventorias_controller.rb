class MejoramientosinterventoriasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    mejoramiento   = Mejoramiento.find(params[:mejoramiento_id])
    @mejoramientosinterventorias = mejoramiento.mejoramientosinterventorias.all
  end

  def edit
    @mejoramientosinterventoria  = Mejoramientosinterventoria.find(params[:id], :include => "mejoramiento")
    @mejoramiento  = @mejoramientosinterventoria.mejoramiento
    respond_to do |format|
      format.js { render :action => "edit_mejoramientosinterventoria" }
    end
  end

  def create
    @mejoramiento  = Mejoramiento.find(params[:mejoramiento_id])
    @mejoramientosinterventoria = Mejoramientosinterventoria.new(params[:mejoramientosinterventoria])
    @mejoramientosinterventoria.user_id = is_admin
    @mejoramientosinterventoria.user_coordinador = @mejoramiento.user_coordinador
    @mejoramientosinterventoria.user_profesional = @mejoramiento.user_profesional
    @mejoramientosinterventoria.user_tecnologo = @mejoramiento.user_tecnologo
    @mejoramientosinterventoria.user_interventor = @mejoramiento.user_interventor
    @mejoramientosinterventoria.responsable1 = @mejoramiento.responsable1
    @mejoramientosinterventoria.responsable2 = @mejoramiento.responsable2
    @mejoramientosinterventoria.responsable3 = @mejoramiento.responsable3
    if @mejoramientosinterventoria.valid?
      @mejoramiento.mejoramientosinterventorias << @mejoramientosinterventoria
      @mejoramiento.save
      is_trigger_mej(@mejoramiento.id,is_admin,'mejoramientosinterventorias','I')
      @mejoramientosinterventoria = Mejoramientosinterventoria.new
      flash[:mejoramientosinterventoria] = "Se guardo el registro con exito"
    else
      flash[:mejoramientosinterventoria] = "Se produjo un error al guardar el registro"
    end
##    ActiveRecord::Base.connection.execute("delete from mejoramientoselementos
#                                           where  mejoramiento_id = #{@mejoramiento.id}
#                                           and    cantidad = 0
#                                           and    mejoramientositem_id != 10043#")
    last_id = Mejoramientosinterventoria.maximum('id')
    render :update do |page|
      page.redirect_to :controller=>"mejoramientosinformes", :action=>"edit", :id=>last_id
    end
  end

  def update
    @mejoramientosinterventoria        = Mejoramientosinterventoria.new
    mejoramientosinterventoria         = Mejoramientosinterventoria.find(params[:id])
    @mejoramiento        = mejoramientosinterventoria.mejoramiento
    ok = mejoramientosinterventoria.update_attributes(params[:mejoramientosinterventoria])
    flash[:mejoramientosinterventoria] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "mejoramientosinterventorias" }
    end
  end

  def destroy
    mejoramientosinterventoria   = Mejoramientosinterventoria.find(params[:id])
    @mejoramiento  = mejoramientosinterventoria.mejoramiento
    @mejoramientosinterventoria  = Mejoramientosinterventoria.new
    mejoramientosinterventoria.destroy
    respond_to do |format|
      format.js { render :action => "mejoramientosinterventorias" }
    end
  end

  private
  def determine_layout
    if ['atencion'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
