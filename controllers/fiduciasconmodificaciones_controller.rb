class FiduciasconmodificacionesController < ApplicationController

  before_filter :require_user
  before_filter :find_fiduciascontrato_and_fiduciasconmodificacion

  def index
    @fiduciasconmodificaciones = @fiduciascontrato.fiduciasconmodificaciones.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fiduciasconmodificaciones }
    end
  end

  def show
    @fiduciasconmodificacion = Fiduciasconmodificacion.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fiduciasconmodificacion }
    end
  end

  def new
    @fiduciasconmodificacion = Fiduciasconmodificacion.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fiduciasconmodificacion }
    end
  end

  def edit
    @fiduciasconmodificacion = Fiduciasconmodificacion.find(params[:id])
  end

  def create
    @fiduciasconmodificacion = Fiduciasconmodificacion.new(params[:fiduciasconmodificacion])
    @fiduciasconmodificacion.fiduciascontrato_id = @fiduciascontrato.id
    #@fiduciasconmodificacion.user_id = is_admin
    respond_to do |format|
      if @fiduciasconmodificacion.save
        format.html {  redirect_to mod_fiduciasconmodificaciones_path(@fiduciascontrato) }
        format.xml  { render :xml => @fiduciasconmodificacion, :status => :created, :location => @fiduciasconmodificacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fiduciasconmodificacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @fiduciasconmodificacion = Fiduciasconmodificacion.find(params[:id])
    #@fiduciasconmodificacion.user_actualiza = is_admin
    respond_to do |format|
      if @fiduciasconmodificacion.update_attributes(params[:fiduciasconmodificacion])
        format.html { redirect_to mod_fiduciasconmodificaciones_url(@fiduciascontrato) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fiduciasconmodificacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @fiduciasconmodificacion = Fiduciasconmodificacion.find(params[:id])
    @fiduciasconmodificacion.destroy
    respond_to do |format|
      format.html { redirect_to mod_fiduciasconmodificaciones_url(@fiduciascontrato) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_fiduciascontrato_and_fiduciasconmodificacion
      @fiduciascontrato = Fiduciascontrato.find(params[:fiduciascontrato_id])
      @fiduciasconmodificacion = Fiduciasconmodificacion.find(params[:id]) if params[:id]
  end
end