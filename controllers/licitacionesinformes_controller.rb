class LicitacionesinformesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    licitacion   = Licitacion.find(params[:licitacion_id])
    @licitacionesinformes = licitacion.licitacionesinformes.all
  end

  def edit
    @licitacionesinforme  = Licitacionesinforme.find(params[:id], :include => "licitacion")
    @licitacion  = @licitacionesinforme.licitacion
    respond_to do |format|
      format.js { render :action => "edit_licitacionesinforme" }
    end
  end

  def ver
    @licitacionesinforme  = Licitacionesinforme.find(params[:id])
    @licitacionesinformesdetalle = Licitacionesinformesdetalle.new
  end

  def informe
    @licitacionesinforme  = Licitacionesinforme.find(params[:id])
  end


  def create
    @licitacion  = Licitacion.find(params[:licitacion_id])
    @licitacionesinforme = Licitacionesinforme.new(params[:licitacionesinforme])
    @licitacionesinforme.user_id = is_admin
    if @licitacionesinforme.valid?
      @licitacion.licitacionesinformes << @licitacionesinforme
      @licitacion.save
      #is_trigger_mej(@licitacion.id,is_admin,'licitacionesinformes','I')
      @licitacionesinforme = Licitacionesinforme.new
      flash[:licitacionesinforme] = "Se guardo el registro con exito"
    else
      flash[:licitacionesinforme] = "Se produjo un error al guardar el registro"
    end
    last_id = Licitacionesinforme.maximum('id')
    render :update do |page|
      page.redirect_to :controller=>"licitacionesinformes", :action=>"ver", :id=>last_id
    end
  end

  def update
    @licitacionesinforme        = Licitacionesinforme.new
    licitacionesinforme         = Licitacionesinforme.find(params[:id])
    @licitacion        = licitacionesinforme.licitacion
    ok = licitacionesinforme.update_attributes(params[:licitacionesinforme])
    flash[:licitacionesinforme] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "licitacionesinformes" }
    end
  end

  def destroy
    licitacionesinforme   = Licitacionesinforme.find(params[:id])
    @licitacion  = licitacionesinforme.licitacion
    @licitacionesinforme  = Licitacionesinforme.new
    licitacionesinforme.destroy
    respond_to do |format|
      format.js { render :action => "licitacionesinformes" }
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