class ProyectoscopdocumentosController < ApplicationController
  before_filter :require_user
  before_filter :find_proyectoscopropiedad_and_proyectoscopdocumento

  def index
    proyectoscopropiedad   = Proyectoscopropiedad.find(params[:proyectoscopropiedad_id])
    @proyectoscopdocumentos = proyectoscopropiedad.proyectoscopdocumentos.all
  end

  def new
    @proyectoscopdocumento = Proyectoscopdocumento.new
    @proyectoscopdocumento.proyectostipo_id = params[:proyectostipo_id]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proyectoscopdocumento }
    end
  end

  def create
    @proyectoscopdocumento = Proyectoscopdocumento.new(params[:proyectoscopdocumento])
    @proyectoscopdocumento.proyectoscopropiedad_id = @proyectoscopropiedad.id
    @proyectoscopdocumento.user_id = is_admin
    respond_to do |format|
      if @proyectoscopdocumento.save
        flash[:notice] = "Documento cargado con exito"
        format.html { redirect_to edit_proyectoscopropiedad_path(@proyectoscopropiedad) }
        format.xml  { render :xml => @proyectoscopdocumento, :status => :created, :location => @proyectoscopdocumento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @proyectoscopdocumento.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @proyectoscopdocumento = Proyectoscopdocumento.find(params[:id])
    respond_to do |format|
      if @proyectoscopdocumento.update_attributes(params[:proyectoscopdocumento])
        format.html { redirect_to proyectoscopropiedad_proyectoscopdocumentos_path(@proyectoscopropiedad) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proyectoscopdocumento.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    proyectoscopdocumento   = Proyectoscopdocumento.find(params[:id])
    @proyectoscopropiedad   = proyectoscopdocumento.proyectoscopropiedad
    @proyectoscopdocumento  = Proyectoscopdocumento.new
    proyectoscopdocumento.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end

  def find_proyectoscopropiedad_and_proyectoscopdocumento
      @proyectoscopropiedad = Proyectoscopropiedad.find(params[:proyectoscopropiedad_id])
      @proyectoscopdocumento = Proyectoscopdocumento.find(params[:id]) if params[:id]
  end

end