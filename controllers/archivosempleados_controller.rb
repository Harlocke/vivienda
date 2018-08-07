class ArchivosempleadosController < ApplicationController
  before_filter :require_user
  def index
    archivo   = Archivo.find(params[:archivo_id])
    @archivosempleados = archivo.archivosempleados.all
  end

  def edit
    @archivosempleado  = Archivosempleado.find(params[:id], :include => "archivo")
    @archivo  = @archivosempleado.archivo
    respond_to do |format|
      format.js { render :action => "edit_archivosempleado" }
    end
  end

  def create
    @archivo  = Archivo.find(params[:archivo_id])
    @archivosempleado = Archivosempleado.new(params[:archivosempleado])
    @archivosempleado.user_id = is_admin
    if Empleado.exists?(["id = ?", @archivosempleado.empleado_id]) == true
      #if Archivosempleado.exists?(["empleado_id = ? and archivo_id not in (select id from archivos where archivosserie_id = '10010')", @archivosempleado.empleado_id]) == false
        if Archivosempleado.exists?(["empleado_id = ? and archivo_id = ? ", @archivosempleado.empleado_id, @archivo.id]) == false
          if @archivosempleado.valid?
            @archivo.archivosempleados << @archivosempleado
            @archivo.save
            @archivosempleado = Archivosempleado.new
          else
            flash[:archivosempleado] = "Se produjo un error al guardar el registro"
          end
          respond_to do |format|
            format.js { render :action => "archivosempleados" }
          end
        else
          render :update do |page|
            page.alert "Este usuario ya esta registro en esta Carpeta... Que pasa???. Verifique!!!"
          end
        end
#      else
#        render :update do |page|
#          page.alert "Este usuario ya tiene carpeta Asignada. Verifique!!!"
#        end
#      end
    else
      render :update do |page|
        page.alert "Debe seleccionar el usuario para Asociar. Verifique!!!"
      end
    end
  end

  def update
    @archivosempleado        = Archivosempleado.new
    archivosempleado         = Archivosempleado.find(params[:id])
    @archivo        = archivosempleado.archivo
    ok = archivosempleado.update_attributes(params[:archivosempleado])
    flash[:archivosempleado] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "archivosempleados" }
    end
  end

  def destroy
    archivosempleado   = Archivosempleado.find(params[:id])
    @archivo  = archivosempleado.archivo
    @archivosempleado  = Archivosempleado.new
    archivosempleado.destroy
    respond_to do |format|
      format.js { render :action => "archivosempleados" }
    end
  end

  def show
    empleado   = Persona.find(params[:empleado_id])
    @archivosempleados = empleado.archivosempleados.all
  end
end
