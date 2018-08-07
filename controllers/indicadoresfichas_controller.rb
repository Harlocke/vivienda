class IndicadoresfichasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    indicador   = Indicador.find(params[:indicador_id])
    @indicadoresfichas = indicador.indicadoresfichas.all
  end

  def edit
    @indicadoresficha  = Indicadoresficha.find(params[:id], :include => "indicador")
    @indicador  = @indicadoresficha.indicador
    respond_to do |format|
      format.js { render :action => "edit_indicadoresficha" }
    end
  end
  
#  def visualizar
#    indicador   = Indicador.find(params[:indicador_id])
#    @indicadoresfichas = indicador.indicadoresfichas.all
#  end

  def limpia
    @indicadoresficha = Indicadoresficha.new
    indicadoresficha  = Indicadoresficha.find(params[:id])
    @indicador        = indicadoresficha.indicador
    ActiveRecord::Base.connection.execute("update indicadoresfichas set valor_numerador = null, valor_denominador = null, accion=null, resultado = null
                                           where  id  = #{params[:id]}")
    respond_to do |format|
      format.js { render :action => "indicadoresfichas" }
    end
  end

   def visualizar
     @indicador   = Indicador.find(params[:indicador_id])
   end

  def create
    @indicador  = Indicador.find(params[:indicador_id])
    @indicadoresficha = Indicadoresficha.new(params[:indicadoresficha])
    @indicadoresficha.user_id = is_admin
    if @indicadoresficha.valid?
      @indicador.indicadoresfichas << @indicadoresficha
      @indicador.save
      @indicadoresficha = Indicadoresficha.new
      flash[:indicadoresficha] = "Creado con exito"
    else
      flash[:indicadoresficha] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "indicadoresfichas" }
    end
  end

  def update
    @indicadoresficha        = Indicadoresficha.new
    indicadoresficha         = Indicadoresficha.find(params[:id])
    #indicadoresficha.user_actualiza = is_admin
    @indicador        = indicadoresficha.indicador
    ok = indicadoresficha.update_attributes(params[:indicadoresficha])
    if ok == true
        flash[:indicadoresficha] = "Actualizado con Exito"
        respond_to do |format|
          format.js { render :action => "indicadoresfichas" }
        end
    else
      flash[:indicadoresficha] = "Se produjo un error al guardar el registro"
      render :update do |page|
        page.alert "ATENCIÓN: El Registro presenta inconsistencias y no se permite Actualizar. Verifique los campos obligatorios"
      end
    end
  end

  def destroy
    indicadoresficha   = Indicadoresficha.find(params[:id])
    @indicador  = indicadoresficha.indicador
    @indicadoresficha  = Indicadoresficha.new
    indicadoresficha.destroy
    flash[:indicadoresficha] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "indicadoresfichas" }
    end
  end

  private
  def determine_layout
    if ['visita'].include?(action_name)
      "basico"
    elsif ['visualizar'].include?(action_name)
      "indicador"
    else
      "application"
    end
  end
end