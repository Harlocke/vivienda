class TitulacionesdemandasController < ApplicationController
  layout :determine_layout
  before_filter :require_user

  def index
    titulacion   = Titulacion.find(params[:titulacion_id])
    @titulacionesdemandas = titulacion.titulacionesdemandas.all
  end

  def edit
    @titulacionesdemanda  = Titulacionesdemanda.find(params[:id], :include => "titulacion")
    @titulacion  = @titulacionesdemanda.titulacion
    respond_to do |format|
      format.js { render :action => "edit_titulacionesdemanda" }
    end
  end

  def informe
    @titulacionesdemanda = Titulacionesdemanda.find(params[:id])
  end

  def create
    @titulacion  = Titulacion.find(params[:titulacion_id])
    @titulacionesdemanda = Titulacionesdemanda.new(params[:titulacionesdemanda])
      if @titulacionesdemanda.valid?
        @titulacion.titulacionesdemandas << @titulacionesdemanda
        @titulacion.save
        is_trigger_tit(@titulacion.id,is_admin,'titulacionesdemanda','I')
        @titulacionesdemanda = Titulacionesdemanda.new
      else
        flash[:titulacionesdemanda] = "Se produjo un error al guardar el registro"
      end
      respond_to do |format|
        format.js { render :action => "titulacionesdemandas" }
      end
  end

  def update
    @titulacionesdemanda        = Titulacionesdemanda.new
    titulacionesdemanda         = Titulacionesdemanda.find(params[:id])
    @titulacion        = titulacionesdemanda.titulacion
    ok = titulacionesdemanda.update_attributes(params[:titulacionesdemanda])
    if ok == true
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesdemanda','A')
    end
    flash[:titulacionesdemanda] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "titulacionesdemandas" }
    end
  end

  def destroy
    titulacionesdemanda   = Titulacionesdemanda.find(params[:id])
    @titulacion  = titulacionesdemanda.titulacion
    @titulacionesdemanda  = Titulacionesdemanda.new
    #titulacionesdemanda.respaldo(is_admin)
    titulacionesdemanda.destroy
    respond_to do |format|
      format.js { render :action => "titulacionesdemandas" }
    end
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