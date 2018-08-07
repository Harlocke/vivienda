class ElementosusersController < ApplicationController
before_filter :require_user

  layout :determine_layout

  def index
    elemento   = Elemento.find(params[:elemento_id])
    @elementosusers = elemento.elementosusers.all
  end

 def edit
    @elementosuser  = Elementosuser.find(params[:id], :include => "elemento")
    @elemento  = @elementosuser.elemento
    respond_to do |format|
      format.js { render :action => "edit_elementosuser" }
    end
  end

  def create
    @elemento  = Elemento.find(params[:elemento_id])
    @elementosuser = Elementosuser.new(params[:elementosuser])
    @elementosuser.user_registra = is_admin
     if @elementosuser.valid?
        @elemento.elementosusers << @elementosuser
        @elemento.save
        @elementosuser = Elementosuser.new
        flash[:elementosuser] = "Creado con exito"
      else
        flash[:elementosuser] = "Se produjo un error al guardar el registro"
      end
    respond_to do |format|
       format.js { render :action => "elementosusers" }
    end
  end

  def update
    @elementosuser        = Elementosuser.new
    elementosuser         = Elementosuser.find(params[:id])
    @elemento        = elementosuser.elemento
    ok = elementosuser.update_attributes(params[:elementosuser])
    flash[:elementosuser] = ok ? "Actualizado con Exito " : "Se produjo un error al actualizar el registro "
    respond_to do |format|
      format.js { render :action => "elementosusers" }
    end
  end

  def destroy
    elementosuser   = Elementosuser.find(params[:id])
    @elemento  = elementosuser.elemento
    @elementosuser  = Elementosuser.new
    elementosuser.destroy
    flash[:elementosuser] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "elementosusers" }
    end
  end

  private
  def determine_layout
    if [''].include?(action_name)
      "application"
#    else
#      "basico"
    end
  end
end
