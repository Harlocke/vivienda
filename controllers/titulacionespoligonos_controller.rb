class TitulacionespoligonosController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    titulacion   = Titulacion.find(params[:titulacion_id])
    @titulacionespoligonos = titulacion.titulacionespoligonos.all
  end

  def edit
    @titulacionespoligono  = Titulacionespoligono.find(params[:id], :include => "titulacion")
    @titulacion  = @titulacionespoligono.titulacion
    respond_to do |format|
      format.js { render :action => "edit_titulacionespoligono" }
    end
  end

  def create
    @titulacion  = Titulacion.find(params[:titulacion_id])
    @titulacionespoligono = Titulacionespoligono.new(params[:titulacionespoligono])
    @titulacionespoligono.user_id = is_admin
    if @titulacionespoligono.valid?
      @titulacion.titulacionespoligonos << @titulacionespoligono
      @titulacion.save
      is_trigger_tit(@titulacion.id,is_admin,'titulacionespoligono','I')
      @titulacionespoligono = Titulacionespoligono.new
      flash[:titulacionespoligono] = "Se guardo el registro con exito"
    else
      flash[:titulacionespoligono] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "titulacionespoligonos" }
    end
  end

  def update
    @titulacionespoligono        = Titulacionespoligono.new
    titulacionespoligono         = Titulacionespoligono.find(params[:id])
    @titulacion        = titulacionespoligono.titulacion
    ok = titulacionespoligono.update_attributes(params[:titulacionespoligono])
    if ok == true
      is_trigger_tit(@titulacion.id,is_admin,'titulacionespoligono','A')
      flash[:titulacionespoligono] = "Registro Creado con exito"
      respond_to do |format|
        format.js { render :action => "titulacionespoligonos" }
      end
    else
      render :update do |page|
         page.alert "El registro debe estar diligenciado completamente. Verifique!!"
      end
    end
  end

  def destroy
    titulacionespoligono   = Titulacionespoligono.find(params[:id])
    @titulacion  = titulacionespoligono.titulacion
    @titulacionespoligono  = Titulacionespoligono.new
    titulacionespoligono.destroy
    respond_to do |format|
      format.js { render :action => "titulacionespoligonos" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @titulacionespoligonos = persona.titulacionespoligonos.all
  end

  def atencion
    @titulacionespoligonos = Titulacionespoligono.find(params[:id])
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
