class CorrespondenciasrecibidasusersController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    correspondenciasrecibida   = Correspondenciasrecibida.find(params[:correspondenciasrecibida_id])
    @correspondenciasrecibidasusers = correspondenciasrecibida.correspondenciasrecibidasusers.all
  end

 def edit
    @correspondenciasrecibidasuser  = Correspondenciasrecibidasuser.find(params[:id], :include => "correspondenciasrecibida")
    @correspondenciasrecibida  = @correspondenciasrecibidasuser.correspondenciasrecibida
    respond_to do |format|
      format.js { render :action => "edit_correspondenciasrecibidasuser" }
    end
  end

  def recibido
    @correspondenciasrecibidasuser  = Correspondenciasrecibidasuser.new
    correspondenciasrecibidasuser   = Correspondenciasrecibidasuser.find(params[:id])
    correspondenciasrecibidasuser.userrecibido  = is_admin
    correspondenciasrecibidasuser.fecharecibida = Time.now
    @correspondenciasrecibida       = correspondenciasrecibidasuser.correspondenciasrecibida
    ok = correspondenciasrecibidasuser.update_attributes(params[:correspondenciasrecibidasuser])
    respond_to do |format|
      format.js { render :action => "correspondenciasrecibidasusers" }
    end
  end 

 def visualizar
    @correspondenciasrecibidasuser  = Correspondenciasrecibidasuser.find(params[:id])
  end

  def create
    @correspondenciasrecibida  = Correspondenciasrecibida.find(params[:correspondenciasrecibida_id])
    @correspondenciasrecibidasuser = Correspondenciasrecibidasuser.new(params[:correspondenciasrecibidasuser])
    #@correspondenciasrecibidasuser.user_id = is_admin
    if @correspondenciasrecibidasuser.valid?
      @correspondenciasrecibida.correspondenciasrecibidasusers << @correspondenciasrecibidasuser
      @correspondenciasrecibida.save
      @correspondenciasrecibidasuser = Correspondenciasrecibidasuser.new
      #@correspondenciasrecibidasuser.bandejacorrespondenciausuario
      flash[:correspondenciasrecibidasuser] = "Creado con exito"
    else
      flash[:correspondenciasrecibidasuser] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "correspondenciasrecibidasusers" }
    end
  end

  def update
    @correspondenciasrecibidasuser   = Correspondenciasrecibidasuser.new
    correspondenciasrecibidasuser    = Correspondenciasrecibidasuser.find(params[:id])
    @correspondenciasrecibida        = correspondenciasrecibidasuser.correspondenciasrecibida
    ok = correspondenciasrecibidasuser.update_attributes(params[:correspondenciasrecibidasuser])
    flash[:correspondenciasrecibidasuser] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "correspondenciasrecibidasusers" }
    end
  end

  def destroy
    correspondenciasrecibidasuser   = Correspondenciasrecibidasuser.find(params[:id])
    @correspondenciasrecibida  = correspondenciasrecibidasuser.correspondenciasrecibida
    @correspondenciasrecibidasuser  = Correspondenciasrecibidasuser.new
    correspondenciasrecibidasuser.destroy
    flash[:correspondenciasrecibidasuser] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "correspondenciasrecibidasusers" }
    end
  end

  private
  def determine_layout
    if ['create'].include?(action_name)
      "application"
    end
  end

end
