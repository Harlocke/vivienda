class TitulacionesfallidosController < ApplicationController
before_filter :require_user
  layout :determine_layout

  def index
    titulacion   = Titulacion.find(params[:titulacion_id])
    @titulacionesfallidos = titulacion.titulacionesfallidos.all
  end

  def edit
    @titulacionesfallido  = Titulacionesfallido.find(params[:id], :include => "titulacion")
    @titulacion  = @titulacionesfallido.titulacion
    respond_to do |format|
      format.js { render :action => "edit_titulacionesfallido" }
    end
  end

  def create
    @titulacion  = Titulacion.find(params[:titulacion_id])
    @titulacionesfallido = Titulacionesfallido.new(params[:titulacionesfallido])
    @titulacionesfallido.user_id = is_admin
    if @titulacionesfallido.valid?
      @titulacion.titulacionesfallidos << @titulacionesfallido
      @titulacion.save
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesfallido','I')
      @titulacionesfallido = Titulacionesfallido.new
      flash[:titulacionesfallido] = "Se guardo el registro con exito"
    else
      flash[:titulacionesfallido] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "titulacionesfallidos" }
    end
  end

  def update
    @titulacionesfallido        = Titulacionesfallido.new
    titulacionesfallido         = Titulacionesfallido.find(params[:id])
    @titulacion        = titulacionesfallido.titulacion
    ok = titulacionesfallido.update_attributes(params[:titulacionesfallido])
    if ok == true
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesfallido','A')
    end
    flash[:titulacionesfallido] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "titulacionesfallidos" }
    end
  end

  def destroy
    titulacionesfallido   = Titulacionesfallido.find(params[:id])
    @titulacion  = titulacionesfallido.titulacion
    @titulacionesfallido  = Titulacionesfallido.new
    titulacionesfallido.destroy
    respond_to do |format|
      format.js { render :action => "titulacionesfallidos" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @titulacionesfallidos = persona.titulacionesfallidos.all
  end

  def atencion
    @titulacionesfallidos = Titulacionesfallido.find(params[:id])
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
