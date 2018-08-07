class ProyfactnotasController < ApplicationController
  before_filter :require_user
  before_filter :find_proyectosfactibilidad_and_proyfactnota

  def index
    @proyfactnotas = @proyectosfactibilidad.proyfactnotas.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @proyfactnotas }
    end
  end

  def show
    @proyfactnota = Proyfactnota.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @proyfactnota }
    end
  end

  def new
    @proyfactnota = Proyfactnota.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proyfactnota }
    end
  end

  def edit
    @proyfactnota = Proyfactnota.find(params[:id])
  end

  def create
    @proyfactnota = Proyfactnota.new(params[:proyfactnota])
    @proyfactnota.proyectosfactibilidad_id = @proyectosfactibilidad.id
    @proyfactnota.user_id = is_admin
    @proyfactnota.observaciones = @proyfactnota.observaciones.to_s
    respond_to do |format|
      if @proyfactnota.save
        flash[:notice] = "La observacion ha sido registrada con Exito."
        format.html {  redirect_to edit_proyecto_path(@proyectosfactibilidad.proyecto_id) }
        format.xml  { render :xml => @proyfactnota, :status => :created, :location => @proyfactnota }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @proyfactnota.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @proyfactnota = Proyfactnota.find(params[:id])
    respond_to do |format|
      if @proyfactnota.update_attributes(params[:proyfactnota])
        format.html { redirect_to nota_proyfactnotas_url(@proyectosfactibilidad) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proyfactnota.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @proyfactnota = Proyfactnota.find(params[:id])
    @proyfactnota.destroy
    respond_to do |format|
      format.html { redirect_to nota_proyfactnotas_url(@proyectosfactibilidad) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_proyectosfactibilidad_and_proyfactnota
      @proyectosfactibilidad = Proyectosfactibilidad.find(params[:proyectosfactibilidad_id])
      @proyfactnota = Proyfactnota.find(params[:id]) if params[:id]
  end
end
