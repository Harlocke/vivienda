class Catastros2017datosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @catastros2017datos =  Catastros2017dato.search(params[:matricula],params[:cbml],params[:identificacion], params[:page])    
    if @catastros2017datos.count == 0 
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @catastros2017datos }
      end        
    elsif @catastros2017datos.count == 1
      redirect_to edit_catastros2017dato_path(:id=>@catastros2017datos)
    else
        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @catastros2017datos }
        end   
    end
  end

  def show
    @catastros2017dato = Catastros2017dato.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @catastros2017dato }
    end
  end

  #def new
  #  @catastros2017dato = Catastros2017dato.new
  #  render :action => "catastros2017dato_form"
  #end

  def edit
    @catastros2017dato = Catastros2017dato.find(params[:id])   
    respond_to do |format|
      format.html { render :action => "catastros2017dato_form" }
    end
  end

  #def create
  #  @catastros2017dato = Catastros2017dato.new(params[:catastros2017dato])
  #  if @catastros2017dato.save
  #    flash[:notice] = "El registro ha sido registrado con Exito."
  #    redirect_to edit_catastros2017dato_path(@catastros2017dato)
  #  else
  #    render :action => "catastros2017dato_form"
  #  end
  #end

  def update
    @catastros2017dato = Catastros2017dato.find(params[:id])
    #@catastros2017dato.user_id = is_admin
    if @catastros2017dato.update_attributes(params[:catastros2017dato])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_catastros2017dato_path(@catastros2017dato)
    else
      flash[:notice] = "Error al realizar la actualizacion."
      render :action => "catastros2017dato_form"
    end
    rescue
     redirect_to edit_catastros2017dato_path(@catastros2017dato)
  end

  def destroy
    @catastros2017dato = Catastros2017dato.find(params[:id])
    @catastros2017dato.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to busqueda_catastros2017datos_path
        }
      format.xml  { head :ok }
    end
  end

 private
  def determine_layout
    if ['show'].include?(action_name)
      "informes"
    else
      "application"
    end
  end
end

