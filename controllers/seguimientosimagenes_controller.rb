class SeguimientosimagenesController < ApplicationController

  before_filter :require_user
  before_filter :find_seguimiento_and_seguimientosimagen

  def index
    seguimiento   = Seguimiento.find(params[:seguimiento_id])
    @seguimientosimagenes = seguimiento.seguimientosimagenes.all
  end

  def new
    @seguimientosimagen = Seguimientosimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @seguimientosimagen }
    end
  end

  def create
    @seguimientosimagen = Seguimientosimagen.new(params[:seguimientosimagen])
    @seguimientosimagen.seguimiento_id = @seguimiento.id
    respond_to do |format|
      if @seguimientosimagen.save
        format.html { redirect_to edit_seguimiento_path(@seguimiento) }
        format.xml  { render :xml => @seguimientosimagen, :status => :created, :location => @seguimientosimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @seguimientosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @seguimientosimagen = Seguimientosimagen.find(params[:id])
    respond_to do |format|
      if @seguimientosimagen.update_attributes(params[:seguimientosimagen])
        format.html { redirect_to seguimiento_seguimientosimagenes_path(@seguimiento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @seguimientosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    seguimientosimagen   = Seguimientosimagen.find(params[:id])
    @seguimiento         = seguimientosimagen.seguimiento
    @seguimientosimagen  = Seguimientosimagen.new
    seguimientosimagen.destroy
    respond_to do |format|
      format.js { render :action => "seguimientosimagenes" }
    end
  end

  def find_seguimiento_and_seguimientosimagen
      @seguimiento = Seguimiento.find(params[:seguimiento_id])
      @seguimientosimagen = Seguimientosimagen.find(params[:id]) if params[:id]
  end

end
