class InmobiliariosimagenesController < ApplicationController

  before_filter :require_user
  before_filter :find_inmobiliario_and_inmobiliariosimagen

  def index
    inmobiliario   = Inmobiliario.find(params[:inmobiliario_id])
    @inmobiliariosimagenes = inmobiliario.inmobiliariosimagenes.all
  end

  def new
    @inmobiliariosimagen = Inmobiliariosimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @inmobiliariosimagen }
    end
  end

  def create
    @inmobiliariosimagen = Inmobiliariosimagen.new(params[:inmobiliariosimagen])
    @inmobiliariosimagen.inmobiliario_id = @inmobiliario.id
    @inmobiliariosimagen.user_id = is_admin
    respond_to do |format|
      if @inmobiliariosimagen.save
        format.html { redirect_to edit_inmobiliario_path(@inmobiliario) }
        format.xml  { render :xml => @inmobiliariosimagen, :status => :created, :location => @inmobiliariosimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @inmobiliariosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @inmobiliariosimagen = Inmobiliariosimagen.find(params[:id])
    respond_to do |format|
      if @inmobiliariosimagen.update_attributes(params[:inmobiliariosimagen])
        format.html { redirect_to inmobiliario_inmobiliariosimagenes_path(@inmobiliario) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inmobiliariosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    inmobiliariosimagen   = Inmobiliariosimagen.find(params[:id])
    @inmobiliario         = inmobiliariosimagen.inmobiliario
    @inmobiliariosimagen  = Inmobiliariosimagen.new
    inmobiliariosimagen.destroy
    respond_to do |format|
      format.js { render :action => "inmobiliariosimagenes" }
    end
  end

  def find_inmobiliario_and_inmobiliariosimagen
      @inmobiliario = Inmobiliario.find(params[:inmobiliario_id])
      @inmobiliariosimagen = Inmobiliariosimagen.find(params[:id]) if params[:id]
  end

end
