class ProyectosdocumentosController < ApplicationController
  before_filter :require_user
  before_filter :find_proyecto_and_proyectosdocumento

  def index
    proyecto   = Proyecto.find(params[:proyecto_id])
    @proyectosdocumentos = proyecto.proyectosdocumentos.all
  end

  def new
    @proyectosdocumento = Proyectosdocumento.new
    @proyectosdocumento.proyectostipo_id = params[:proyectostipo_id]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proyectosdocumento }
    end
  end

  def create
    @proyectosdocumento = Proyectosdocumento.new(params[:proyectosdocumento])
    @proyectosdocumento.proyecto_id = @proyecto.id
    @proyectosdocumento.user_id = is_admin
    respond_to do |format|
      if @proyectosdocumento.save
        flash[:notice] = "Documento cargado con exito"
        format.html { redirect_to edit_proyecto_path(@proyecto) }
        format.xml  { render :xml => @proyectosdocumento, :status => :created, :location => @proyectosdocumento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @proyectosdocumento.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @proyectosdocumento = Proyectosdocumento.find(params[:id])
    respond_to do |format|
      if @proyectosdocumento.update_attributes(params[:proyectosdocumento])
        format.html { redirect_to proyecto_proyectosdocumentos_path(@proyecto) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proyectosdocumento.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    proyectosdocumento   = Proyectosdocumento.find(params[:id])
    @proyecto   = proyectosdocumento.proyecto
    @proyectosdocumento  = Proyectosdocumento.new
    proyectosdocumento.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end

  def find_proyecto_and_proyectosdocumento
      @proyecto = Proyecto.find(params[:proyecto_id])
      @proyectosdocumento = Proyectosdocumento.find(params[:id]) if params[:id]
  end

end