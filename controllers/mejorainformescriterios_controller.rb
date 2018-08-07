class MejorainformescriteriosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    mejorainformeselemento   = Mejorainformeselemento.find(params[:mejorainformeselemento_id])
    @mejorainformescriterios = mejorainformeselemento.mejorainformescriterios.all
  end

  def edit
    @mejorainformescriterio  = Mejorainformescriterio.find(params[:id], :include => "mejorainformeselemento")
    @mejorainformeselemento  = @mejorainformescriterio.mejorainformeselemento
    respond_to do |format|
      format.js { render :action => "edit_mejorainformescriterio" }
    end
  end

  def create
    @mejorainformeselemento  = Mejorainformeselemento.find(params[:mejorainformeselemento_id])
    @mejorainformescriterio = Mejorainformescriterio.new(params[:mejorainformescriterio])
    @mejorainformescriterio.user_id = is_admin
    if @mejorainformescriterio.valid?
      @mejorainformeselemento.mejorainformescriterios << @mejorainformescriterio
      @mejorainformeselemento.save
      is_trigger_mej(@mejorainformeselemento.mejoramientosinforme.mejoramiento_id,is_admin,'mejorainformescriterios','I')
      @mejorainformescriterio = Mejorainformescriterio.new
      flash[:mejorainformescriterio] = "Se guardo el registro con exito"
    else
      flash[:mejorainformescriterio] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "mejorainformescriterios" }
    end
  end

  def update
    @mejorainformescriterio        = Mejorainformescriterio.new
    mejorainformescriterio         = Mejorainformescriterio.find(params[:id])
    params[:mejorainformescriterio][:user_actualiza] = is_admin
    @mejorainformeselemento        = mejorainformescriterio.mejorainformeselemento
    ok = mejorainformescriterio.update_attributes(params[:mejorainformescriterio])
    is_trigger_mej(@mejorainformeselemento.mejoramientosinforme.mejoramiento_id,is_admin,'mejorainformescriterios','A')
    flash[:mejorainformescriterio] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "mejorainformescriterios" }
    end
  end

  def destroy
    mejorainformescriterio   = Mejorainformescriterio.find(params[:id])
    @mejorainformeselemento  = mejorainformescriterio.mejorainformeselemento
    @mejorainformescriterio  = Mejorainformescriterio.new
    mejorainformescriterio.destroy
    respond_to do |format|
      format.js { render :action => "mejorainformescriterios" }
    end
  end

  def descargar
    mejorainformescriterio   = Mejorainformescriterio.find(params[:id])
    ActiveRecord::Base.connection.execute("update mejorainformescriterios set realizado = 'SI', updated_at = sysdate, user_actualiza = #{is_admin}
                                           where  id in (select ic.id
                                                         from   mejorainformescriterios ic, mejorainformeselementos ie, mejoramientosinformes i, mejoramientosinterventorias it
                                                         where  ic.mejorainformeselemento_id = ie.id
                                                         and    ie.mejoramientosinforme_id = i.id
                                                         and    ie.mejoramientoselemento_id = #{mejorainformescriterio.mejorainformeselemento.mejoramientoselemento_id}
                                                         and    i.mejoramientosinterventoria_id = it.id
                                                         and    it.mejoramiento_id = #{mejorainformescriterio.mejorainformeselemento.mejoramientosinforme.mejoramientosinterventoria.mejoramiento_id}
                                                         and    ic.realizado is null
                                                         and    ic.capituloscriterio_id = #{mejorainformescriterio.capituloscriterio_id})")
    flash[:notice] = "Marcada la solución con exito"
    redirect_to :controller=>"mejoramientosinformes", :action=>"edit", :id=>mejorainformescriterio.mejorainformeselemento.mejoramientosinforme_id
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
