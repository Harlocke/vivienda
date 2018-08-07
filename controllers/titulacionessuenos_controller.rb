class TitulacionessuenosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    titulacion   = Titulacion.find(params[:titulacion_id])
    @titulacionessuenos = titulacion.titulacionessuenos.all
  end

  def edit
    @titulacionessueno  = Titulacionessueno.find(params[:id], :include => "titulacion")
    @titulacion  = @titulacionessueno.titulacion
    respond_to do |format|
      format.js { render :action => "edit_titulacionessueno" }
    end
  end

  def create
    @titulacion  = Titulacion.find(params[:titulacion_id])
    @titulacionessueno = Titulacionessueno.new(params[:titulacionessueno])
    @titulacionessueno.user_id = is_admin
    if @titulacionessueno.valid?
      @titulacion.titulacionessuenos << @titulacionessueno
      @titulacion.save
      is_trigger_tit(@titulacion.id,is_admin,'titulacionessueno','I')
      @titulacionessueno = Titulacionessueno.new
      flash[:titulacionessueno] = "Se guardo el registro con exito"
    else
      flash[:titulacionessueno] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "titulacionessuenos" }
    end
  end

  def update
    @titulacionessueno        = Titulacionessueno.new
    titulacionessueno         = Titulacionessueno.find(params[:id])
    @titulacion        = titulacionessueno.titulacion
    ok = titulacionessueno.update_attributes(params[:titulacionessueno])
    if ok == true
      is_trigger_tit(@titulacion.id,is_admin,'titulacionessueno','A')
    end
    flash[:titulacionessueno] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "titulacionessuenos" }
    end
  end

  def destroy
    titulacionessueno   = Titulacionessueno.find(params[:id])
    @titulacion  = titulacionessueno.titulacion
    @titulacionessueno  = Titulacionessueno.new
    titulacionessueno.destroy
    respond_to do |format|
      format.js { render :action => "titulacionessuenos" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @titulacionessuenos = persona.titulacionessuenos.all
  end

  def atencion
    @titulacionessuenos = Titulacionessueno.find(params[:id])
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