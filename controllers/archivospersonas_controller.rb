class ArchivospersonasController < ApplicationController
  before_filter :require_user
  def index
    archivo   = Archivo.find(params[:archivo_id])
    @archivospersonas = archivo.archivospersonas.all
  end

  def edit
    @archivospersona  = Archivospersona.find(params[:id], :include => "archivo")
    @archivo  = @archivospersona.archivo
    respond_to do |format|
      format.js { render :action => "edit_archivospersona" }
    end
  end

  def create
    @archivo  = Archivo.find(params[:archivo_id])
    @archivospersona = Archivospersona.new(params[:archivospersona])
    @archivospersona.user_id = is_admin
    if Persona.exists?(["id = ?", @archivospersona.persona_id]) == true
      if Archivospersona.exists?(["persona_id = ? and archivo_id not in (select id from archivos where archivosserie_id = '10010')", @archivospersona.persona_id]) == false
        if Archivospersona.exists?(["persona_id = ? and archivo_id = ? ", @archivospersona.persona_id, @archivo.id]) == false
          if @archivospersona.valid?
            @archivo.archivospersonas << @archivospersona
            @archivo.save
            @archivospersona = Archivospersona.new
            flash[:archivospersona] = "Registro Almacenado Con Exito "
          else
            flash[:archivospersona] = "Se produjo un error al guardar el registro"
          end
          respond_to do |format|
            format.js { render :action => "archivospersonas" }
          end
        else
          render :update do |page|
            page.alert "Este usuario ya esta registrado en esta Carpeta... Que pasa???. Verifique!!!"
          end
        end
      else
        if permiso("archivospersonasespecial","C").to_s == "S"
          if @archivospersona.valid?
            @archivo.archivospersonas << @archivospersona
            @archivo.save
            @archivospersona = Archivospersona.new
            flash[:archivospersona] = "Registro Almacenado Con Exito "
          else
            flash[:archivospersona] = "Se produjo un error al guardar el registro"
          end
          respond_to do |format|
            format.js { render :action => "archivospersonas" }
          end
        else
          render :update do |page|
            page.alert "Este usuario ya tiene carpeta Asignada. Verifique!!!"
          end
        end
      end
    else
      render :update do |page|
        page.alert "Debe seleccionar el usuario para Asociar. Verifique!!!"
      end
    end
  end

  def update
    @archivospersona        = Archivospersona.new
    archivospersona         = Archivospersona.find(params[:id])
    @archivo        = archivospersona.archivo
    ok = archivospersona.update_attributes(params[:archivospersona])
    flash[:archivospersona] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "archivospersonas" }
    end
  end

  def destroy
    archivospersona   = Archivospersona.find(params[:id])
    @archivo  = archivospersona.archivo
    @archivospersona  = Archivospersona.new
    archivospersona.destroy
    respond_to do |format|
      format.js { render :action => "archivospersonas" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @archivospersonas = persona.archivospersonas.all
  end
end
