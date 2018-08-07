class AgendasprocesosusersController < ApplicationController
  before_filter :require_user

  layout :determine_layout

  def index
    agendasproceso   = Agendasproceso.find(params[:agendasproceso_id])
    @agendasprocesosusers = agendasproceso.agendasprocesosusers.all
  end

  def edit
    @agendasprocesosuser  = Agendasprocesosuser.find(params[:id], :include => "agendasproceso")
    @agendasproceso  = @agendasprocesosuser.agendasproceso
    respond_to do |format|
      format.js { render :action => "edit_agendasprocesosuser" }
    end
  end

  def create
    @agendasproceso  = Agendasproceso.find(params[:agendasproceso_id])
    @agendasprocesosuser = Agendasprocesosuser.new(params[:agendasprocesosuser])
     if @agendasprocesosuser.valid?
        @agendasproceso.agendasprocesosusers << @agendasprocesosuser
        @agendasproceso.save
        @agendasprocesosuser = Agendasprocesosuser.new
        flash[:agendasprocesosuser] = "Creado con exito"
      else
        flash[:agendasprocesosuser] = "Se produjo un error al guardar el registro"
      end
    respond_to do |format|
       format.js { render :action => "agendasprocesosusers" }
    end
  end

  def update
    @agendasprocesosuser        = Agendasprocesosuser.new
    agendasprocesosuser         = Agendasprocesosuser.find(params[:id])
    #agendasprocesosuser.user_id = is_admin
    @agendasproceso        = agendasprocesosuser.agendasproceso
    ok = agendasprocesosuser.update_attributes(params[:agendasprocesosuser])
    flash[:agendasprocesosuser] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "agendasprocesosusers" }
    end
  end

  def destroy
    agendasprocesosuser   = Agendasprocesosuser.find(params[:id])
    @agendasproceso  = agendasprocesosuser.agendasproceso
    @agendasprocesosuser  = Agendasprocesosuser.new
    agendasprocesosuser.destroy
    flash[:agendasprocesosuser] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "agendasprocesosusers" }
    end
  end

  private
  def determine_layout
    if [''].include?(action_name)
      "application" 
    end
  end
end
