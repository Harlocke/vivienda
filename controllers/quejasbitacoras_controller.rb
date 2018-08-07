class QuejasbitacorasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    queja   = Queja.find(params[:queja_id])
    @quejasbitacoras = queja.quejasbitacoras.all
  end

  def edit
    @quejasbitacora  = Quejasbitacora.find(params[:id], :include => "queja")
    @queja  = @quejasbitacora.queja
    respond_to do |format|
      format.js { render :action => "edit_quejasbitacora" }
    end
  end

  def create
    @queja  = Queja.find(params[:queja_id])
    @quejasbitacora = Quejasbitacora.new(params[:quejasbitacora])
    @quejasbitacora.user_id = is_admin
    if @quejasbitacora.valid?
      @queja.quejasbitacoras << @quejasbitacora
      @queja.save
      @quejasbitacora = Quejasbitacora.new
      flash[:quejasbitacora] = "Se guardo el registro con exito"
    else
      flash[:quejasbitacora] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "quejasbitacoras" }
    end
  end

  def update
    @quejasbitacora        = Quejasbitacora.new
    quejasbitacora         = Quejasbitacora.find(params[:id])
    @queja        = quejasbitacora.queja
    ok = quejasbitacora.update_attributes(params[:quejasbitacora])
    flash[:quejasbitacora] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "quejasbitacoras" }
    end
  end

  def destroy
    quejasbitacora   = Quejasbitacora.find(params[:id])
    @queja  = quejasbitacora.queja
    @quejasbitacora  = Quejasbitacora.new
    quejasbitacora.destroy
    respond_to do |format|
      format.js { render :action => "quejasbitacoras" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @quejasbitacoras = persona.quejasbitacoras.all
  end

  def atencion
    @quejasbitacoras = Quejasbitacora.find(params[:id])
  end

  private
  def determine_layout
    if ['atencion'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
