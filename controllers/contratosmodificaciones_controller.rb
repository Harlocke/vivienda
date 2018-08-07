class ContratosmodificacionesController < ApplicationController

  before_filter :require_user
  before_filter :find_contrato_and_contratosmodificacion

  def index
    @contratosmodificaciones = @contrato.contratosmodificaciones.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contratosmodificaciones }
    end
  end

  def show
    @contratosmodificacion = Contratosmodificacion.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contratosmodificacion }
    end
  end

  def new
    @contratosmodificacion = Contratosmodificacion.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contratosmodificacion }
    end
  end

  def edit
    @contratosmodificacion = Contratosmodificacion.find(params[:id])
  end

  def create
    @contratosmodificacion = Contratosmodificacion.new(params[:contratosmodificacion])
    @contratosmodificacion.contrato_id = @contrato.id
    @contratosmodificacion.user_id = is_admin
    respond_to do |format|
      if @contratosmodificacion.save
        format.html {  redirect_to mod_contratosmodificaciones_path(@contrato) }
        format.xml  { render :xml => @contratosmodificacion, :status => :created, :location => @contratosmodificacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contratosmodificacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @contratosmodificacion = Contratosmodificacion.find(params[:id])
    @contratosmodificacion.user_actualiza = is_admin
    respond_to do |format|
      if @contratosmodificacion.update_attributes(params[:contratosmodificacion])
        format.html { redirect_to mod_contratosmodificaciones_url(@contrato) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contratosmodificacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @contratosmodificacion = Contratosmodificacion.find(params[:id])
    @contratosmodificacion.destroy
    respond_to do |format|
      format.html { redirect_to mod_contratosmodificaciones_url(@contrato) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_contrato_and_contratosmodificacion
      @contrato = Contrato.find(params[:contrato_id])
      @contratosmodificacion = Contratosmodificacion.find(params[:id]) if params[:id]
  end
end
