class ActividadesController < ApplicationController

  layout :determine_layout

  before_filter :find_requerimiento_actividad

  def index
    @actividades = @requerimiento.actividades.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @actividades }
    end
  end

  def show
    @actividad = Actividad.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @actividad }
    end
  end

  def new
    @actividad = Actividad.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @actividad }
    end
  end

  def edit
    @actividad = Actividad.find(params[:id])
    @actividades   = @requerimiento.actividades.all
  end

  def create
    @actividad = Actividad.new(params[:actividad])
    @actividad = @requerimiento.actividades.build(params[:actividad])
    @actividad.user_id = is_admin
    respond_to do |format|
      if @actividad.save
        #flash[:notice] = 'Actividad was successfully created.'
        format.html { redirect_to requerimiento_actividades_path(@requerimiento) }
        format.xml  { render :xml => @actividad, :status => :created, :location => @actividad }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @actividad.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @actividad = Actividad.find(params[:id])
    respond_to do |format|
      if @actividad.update_attributes(params[:actividad])
        #flash[:notice] = 'Actividad was successfully updated.'
        format.html { redirect_to requerimiento_actividades_path(@requerimiento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @actividad.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @actividad = Actividad.find(params[:id])
    @actividad.destroy

    respond_to do |format|
      format.html { redirect_to requerimiento_actividades_path(@requerimiento) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_requerimiento_actividad
      @requerimiento = Requerimiento.find(params[:requerimiento_id])
      @actividad     = Actividad.find(params[:id]) if params[:id]
  end

  private
  def determine_layout
    if ['create'].include?(action_name)
      "application"
    else
      "basico"
    end
  end
end
