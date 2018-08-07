class MensajesController < ApplicationController

  before_filter :require_user

  def index
    @mensajes = Mensaje.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mensajes }
    end
  end

  def show
    @mensaje = Mensaje.find(params[:id])
    @mensajesusers  = Mensajesusers.find_by_mensaje_id(@mensaje.id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mensaje }
    end
  end

  def new
    @mensajes = Mensaje.all
    if @mensajes.length == 0
      flash[:notice] = "No hay ningún mensaje dado de alta"
      @mensaje = Mensaje.new
      #render :template => "error"
    else
      @mensaje = Mensaje.new
      render :action => "mensaje_form"
    end
  end

  def edit
    @mensaje = Mensaje.find(params[:id])
    @mensajesuser = Mensajesuser.new
    respond_to do |format|
      format.html { render :action => "mensaje_form" }
    end
  end

  def create
    @mensaje = Mensaje.new(params[:mensaje])
    if @mensaje.save
      flash[:notice] = "El registro ha sido creado con Exito."
      redirect_to edit_mensaje_path(@mensaje)
    else
      render :action => "mensaje_form"
    end
  end

  def update
    @mensaje = Mensaje.find(params[:id])
    if @mensaje.update_attributes(params[:mensaje])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_mensaje_path(@mensaje)
    else
      @mensajesuser = Mensajesuser.new
      render :action => "mensaje_form"
    end
    rescue
      redirect_to edit_mensaje_path(@mensaje)
  end

  def destroy
    @mensaje = Mensaje.find(params[:id])
    @mensaje.destroy
    respond_to do |format|
      format.html { redirect_to(mensajes_url) }
      format.xml  { head :ok }
    end
  end
end
