class SeguimientoslicitacionesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    seguimiento   = Seguimiento.find(params[:seguimiento_id])
    @seguimientoslicitaciones = seguimiento.seguimientoslicitaciones.all
  end

  def edit
    @seguimientoslicitacion  = Seguimientoslicitacion.find(params[:id], :include => "seguimiento")
    @seguimiento  = @seguimientoslicitacion.seguimiento
    respond_to do |format|
      format.js { render :action => "edit_seguimientoslicitacion" }
    end
  end

  def mostrar
    @seguimientoslicitacion  = Seguimientoslicitacion.find(params[:id])
  end

  def create
    @seguimiento  = Seguimiento.find(params[:seguimiento_id])
    @seguimientoslicitacion = Seguimientoslicitacion.new(params[:seguimientoslicitacion])
    if @seguimientoslicitacion.valid?
        @seguimientoslicitacion.user_id = is_admin
        @seguimientoslicitacion.subtotal = @seguimientoslicitacion.licitacion.licitacionesenlaces.sum("valortotal")
        @seguimientoslicitacion.valoraiu = ((@seguimientoslicitacion.licitacion.licitacionesenlaces.sum("valortotal") * @seguimientoslicitacion.licitacion.aiu)/100)
        @seguimientoslicitacion.valor = (@seguimientoslicitacion.subtotal + @seguimientoslicitacion.valoraiu)
        @seguimiento.seguimientoslicitaciones << @seguimientoslicitacion
        @seguimiento.save
        @seguimientoslicitacion = Seguimientoslicitacion.new
    else
      flash[:warning] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "seguimientoslicitaciones" }
    end
  end

  def update
    @seguimientoslicitacion        = Seguimientoslicitacion.new
    seguimientoslicitacion         = Seguimientoslicitacion.find(params[:id])
    @seguimiento        = seguimientoslicitacion.seguimiento
    ok = seguimientoslicitacion.update_attributes(params[:seguimientoslicitacion])
    flash[:notice] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "seguimientoslicitaciones" }
    end
  end

  def destroy
    seguimientoslicitacion   = Seguimientoslicitacion.find(params[:id])
    @seguimiento  = seguimientoslicitacion.seguimiento
    @seguimientoslicitacion  = Seguimientoslicitacion.new
    seguimientoslicitacion.destroy
    respond_to do |format|
      format.js { render :action => "seguimientoslicitaciones" }
    end
  end

  private
  def determine_layout
    if ['mostrar','mostrarconsolidado'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end