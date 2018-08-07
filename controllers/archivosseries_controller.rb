class ArchivosseriesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @archivosseries = Archivosserie.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @archivosseries }
    end
  end

  def new
    @archivosserie = Archivosserie.new
    render :action => "archivosserie_form"
  end

  def edit
    @archivosserie = Archivosserie.find(params[:id])
    @archivosseriesdoc= Archivosseriesdoc.new
    respond_to do |format|
      format.html { render :action => "archivosserie_form" }
    end
  end

  def create
    @archivosserie = Archivosserie.new(params[:archivosserie])
    if @archivosserie.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_archivosserie_path(@archivosserie)
    else
      @archivosseriesdoc= Archivosseriesdoc.new
      render :action => "archivosserie_form"
    end
  end

  def update
    @archivosserie = Archivosserie.find(params[:id])
      if @archivosserie.update_attributes(params[:archivosserie])
        @archivosserie.actualizacion(is_admin)
        flash[:notice] = "El registro ha sido actualizado con Exito."
        redirect_to edit_archivosserie_path(@archivosserie)
      else
        @archivosseriesdoc= Archivosseriesdoc.new
        render :action => "archivosserie_form"
      end
    rescue
      flash[:notice] = "Existen inconsistencias. Verifique!!!"
      redirect_to edit_archivosserie_path(@archivosserie)
  end

  def destroy
    @archivosserie = Archivosserie.find(params[:id])
    @archivosserie.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to archivosseries_path
      }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['import','csv_import','pendientesentrega','notificapendiente','asignar','stiker','rotulo','vigentesentrega'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end