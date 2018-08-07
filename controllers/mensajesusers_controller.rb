class MensajesusersController < ApplicationController

  before_filter :require_user
  
  def index
    mensaje   = Mensaje.find(params[:mensaje_id])
    @mensajesusers = mensaje.mensajesusers.all
  end

  def edit
    @mensajesuser  = Mensajesuser.find(params[:id], :include => "mensaje")
    @mensaje  = @mensajesuser.mensaje
    respond_to do |format|
      format.js { render :action => "edit_mensajesuser" }
    end
  end

  def create
    @mensaje  = Mensaje.find(params[:mensaje_id])
    @mensajesuser = Mensajesuser.new(params[:mensajesuser])
    if @mensajesuser.valid?
      @mensaje.mensajesusers << @mensajesuser
      @mensaje.save
      @mensajesuser = Mensajesuser.new
    else
      flash[:warning] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "mensajesusers" }
    end
  end

  def update
    @mensajesuser        = Mensajesuser.new
    mensajesuser         = Mensajesuser.find(params[:id])
    @mensaje        = mensajesuser.mensaje
    ok = mensajesuser.update_attributes(params[:mensajesuser])
    flash[:notice] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "mensajesusers" }
    end
  end

  def destroy
    mensajesuser   = Mensajesuser.find(params[:id])
    @mensaje  = mensajesuser.mensaje
    @mensajesuser  = Mensajesuser.new
    mensajesuser.destroy
    respond_to do |format|
      format.js { render :action => "mensajesusers" }
    end
  end
end
