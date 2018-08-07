class TitulacionesespaciosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    titulacion   = Titulacion.find(params[:titulacion_id])
    @titulacionesespacios = titulacion.titulacionesespacios.all
  end

  def edit
    @titulacionesespacio  = Titulacionesespacio.find(params[:id], :include => "titulacion")
    @titulacion  = @titulacionesespacio.titulacion
    respond_to do |format|
      format.js { render :action => "edit_titulacionesespacio" }
    end
  end

  def create
    @titulacion  = Titulacion.find(params[:titulacion_id])
    @titulacionesespacio = Titulacionesespacio.new(params[:titulacionesespacio])
    @titulacionesespacio.user_id = is_admin
    if @titulacionesespacio.valid?
      @titulacion.titulacionesespacios << @titulacionesespacio
      @titulacion.save
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesespacio','I')
      @titulacionesespacio = Titulacionesespacio.new
      flash[:titulacionesespacio] = "Se guardo el registro con exito"
    else
      flash[:titulacionesespacio] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "titulacionesespacios" }
    end
  end

  def update
    @titulacionesespacio        = Titulacionesespacio.new
    titulacionesespacio         = Titulacionesespacio.find(params[:id])
    @titulacion        = titulacionesespacio.titulacion
    ok = titulacionesespacio.update_attributes(params[:titulacionesespacio])
    if ok == true
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesespacio','A')
    end
    flash[:titulacionesespacio] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "titulacionesespacios" }
    end
  end

  def destroy
    titulacionesespacio   = Titulacionesespacio.find(params[:id])
    @titulacion  = titulacionesespacio.titulacion
    @titulacionesespacio  = Titulacionesespacio.new
    titulacionesespacio.destroy
    respond_to do |format|
      format.js { render :action => "titulacionesespacios" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @titulacionesespacios = persona.titulacionesespacios.all
  end

  def atencion
    @titulacionesespacios = Titulacionesespacio.find(params[:id])
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
