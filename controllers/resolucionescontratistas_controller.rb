class ResolucionescontratistasController < ApplicationController
  before_filter :require_user

  def index
    resolucion   = Resolucion.find(params[:resolucion_id])
    @resolucionescontratistas = resolucion.resolucionescontratistas.all
  end

  def edit
    @resolucionescontratista  = Resolucionescontratista.find(params[:id], :include => "resolucion")
    @resolucion  = @resolucionescontratista.resolucion
    respond_to do |format|
      format.js { render :action => "edit_resolucionescontratista" }
    end
  end

  def create
    @resolucion  = Resolucion.find(params[:resolucion_id])
    @resolucionescontratista = Resolucionescontratista.new(params[:resolucionescontratista])
    if Resolucionescontratista.exists?(["empleado_id = ? and resolucion_id = ?", @resolucionescontratista.empleado_id, @resolucion.id]) == false
      if @resolucionescontratista.valid?
        @resolucion.resolucionescontratistas << @resolucionescontratista
        @resolucion.save
        @resolucionescontratista = Resolucionescontratista.new
        flash[:resolucionescontratista] = "Registro Almacenado Con Exito "
      else
        flash[:resolucionescontratista] = "Se produjo un error al guardar el registro"
      end
      respond_to do |format|
        format.js { render :action => "resolucionescontratistas" }
      end
    else
      respond_to do |format|
        flash[:resolucionescontratista] = "El usuario ya se encuentra en esta resolución... Verifique!!!"
        format.js { render :action => "resolucionescontratistas" }
      end
    end
  end

  def update
    @resolucionescontratista    = Resolucionescontratista.new
    resolucionescontratista     = Resolucionescontratista.find(params[:id])
    @resolucion             = resolucionescontratista.resolucion
    ok = resolucionescontratista.update_attributes(params[:resolucionescontratista])
    flash[:notice] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "resolucionescontratistas" }
    end
  end

  def destroy
    resolucionescontratista   = Resolucionescontratista.find(params[:id])
    @resolucion  = resolucionescontratista.resolucion
    @resolucionescontratista  = Resolucionescontratista.new
    resolucionescontratista.destroy
    respond_to do |format|
      format.js { render :action => "resolucionescontratistas" }
    end
  end

  def show
    contratista   = Persona.find(params[:contratista_id])
    @resolucionescontratistas = contratista.resolucionescontratistas.all
  end
end
