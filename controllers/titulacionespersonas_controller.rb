class TitulacionespersonasController < ApplicationController
  layout :determine_layout
  before_filter :require_user

  def index
    titulacion   = Titulacion.find(params[:titulacion_id])
    @titulacionespersonas = titulacion.titulacionespersonas.all
  end

  def edit
    @titulacionespersona  = Titulacionespersona.find(params[:id], :include => "titulacion")
    @titulacion  = @titulacionespersona.titulacion
    respond_to do |format|
      format.js { render :action => "edit_titulacionespersona" }
    end
  end

  def reconocimiento
    @titulacionespersona        = Titulacionespersona.new
    titulacionespersona         = Titulacionespersona.find(params[:id])
    titulacionespersona.reconocimiento = 'SI'
    @titulacion        = titulacionespersona.titulacion
    ok = titulacionespersona.update_attributes(params[:titulacionespersona])
    render :update do |page|
       page.alert "Este usuario ha sido marcado como solicitante de Reconocimiento de Edificaciones."
       page.redirect_to edit_titulacion_path(@titulacion)
    end
  end

  def informe
    @titulacionespersona = Titulacionespersona.find(params[:id])
  end

  def create
    @titulacion  = Titulacion.find(params[:titulacion_id])
    @titulacionespersona = Titulacionespersona.new(params[:titulacionespersona])
    if @titulacionespersona.valid?
      @titulacion.titulacionespersonas << @titulacionespersona
      @titulacion.save
      is_trigger_tit(@titulacion.id,is_admin,'titulacionespersona','I')
      @titulacionespersona = Titulacionespersona.new
    else
      flash[:titulacionespersona] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "titulacionespersonas" }
    end
  end

  def update
    @titulacionespersona        = Titulacionespersona.new
    titulacionespersona         = Titulacionespersona.find(params[:id])
    @titulacion        = titulacionespersona.titulacion
    ok = titulacionespersona.update_attributes(params[:titulacionespersona])
    flash[:titulacionespersona] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    if ok == true
      is_trigger_tit(@titulacion.id,is_admin,'titulacionespersona','A')
    end
    respond_to do |format|
      format.js { render :action => "titulacionespersonas" }
    end
  end

  def destroy
    titulacionespersona   = Titulacionespersona.find(params[:id])
    @titulacion  = titulacionespersona.titulacion
    @titulacionespersona  = Titulacionespersona.new
    titulacionespersona.respaldo(is_admin)
    titulacionespersona.destroy
    respond_to do |format|
      format.js { render :action => "titulacionespersonas" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @titulacionespersonas = persona.titulacionespersonas.all
  end

  def documentos
    @titulacionespersona = Titulacionespersona.find(params[:id])
  end

  private
  def determine_layout
    if ['informecruce','informe'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end