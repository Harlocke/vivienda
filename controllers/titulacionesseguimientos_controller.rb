class TitulacionesseguimientosController < ApplicationController

  before_filter :require_user
  before_filter :find_titulacionesdemanda_and_titulacionesseguimiento

  def index
    @titulacionesseguimientos = @titulacionesdemanda.titulacionesseguimientos.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @titulacionesseguimientos }
    end
  end

  def show
    @titulacionesseguimiento = Titulacionesseguimiento.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @titulacionesseguimiento }
    end
  end

  def new
    @titulacionesseguimiento = Titulacionesseguimiento.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @titulacionesseguimiento }
    end
  end

  def edit
    @titulacionesseguimiento = Titulacionesseguimiento.find(params[:id])
  end

  def create
    @titulacionesseguimiento = Titulacionesseguimiento.new(params[:titulacionesseguimiento])
    @titulacionesseguimiento.titulacionesdemanda_id = @titulacionesdemanda.id
    @titulacionesseguimiento.user_id = is_admin
    respond_to do |format|
      if @titulacionesseguimiento.save
        is_trigger_tit(@titulacionesdemanda.titulacion_id,is_admin,'titulacionesseguimiento','I')
        flash[:notice] = "La observacion ha sido registrada con Exito."
        format.html {  redirect_to edit_titulacion_path(@titulacionesdemanda.titulacion_id) }
        format.xml  { render :xml => @titulacionesseguimiento, :status => :created, :location => @titulacionesseguimiento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @titulacionesseguimiento.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @titulacionesseguimiento = Titulacionesseguimiento.find(params[:id])
    @titulacionesseguimiento.user_actualiza = is_admin
    respond_to do |format|
      if @titulacionesseguimiento.update_attributes(params[:titulacionesseguimiento])
        format.html { redirect_to nota_titulacionesseguimientos_url(@titulacionesdemanda) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @titulacionesseguimiento.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @titulacionesseguimiento = Titulacionesseguimiento.find(params[:id])
    @titulacionesseguimiento.destroy
    respond_to do |format|
      format.html { redirect_to nota_titulacionesseguimientos_url(@titulacionesdemanda) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_titulacionesdemanda_and_titulacionesseguimiento
      @titulacionesdemanda = Titulacionesdemanda.find(params[:titulacionesdemanda_id])
      @titulacionesseguimiento = Titulacionesseguimiento.find(params[:id]) if params[:id]
  end
end
