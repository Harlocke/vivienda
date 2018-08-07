class ArchivosseriesdocsController < ApplicationController

  before_filter :require_user

  def index
    archivosserie   = Archivosserie.find(params[:archivosserie_id])
    @archivosseriesdocs = archivosserie.archivosseriesdocs.all
  end

  def edit
    @archivosseriesdoc  = Archivosseriesdoc.find(params[:id], :include => "archivosserie")
    @archivosserie  = @archivosseriesdoc.archivosserie
    respond_to do |format|
      format.js { render :action => "edit_archivosseriesdoc" }
    end
  end

  def create
    @archivosserie  = Archivosserie.find(params[:archivosserie_id])
    @archivosseriesdoc = Archivosseriesdoc.new(params[:archivosseriesdoc])
    if @archivosseriesdoc.valid?
      @archivosserie.archivosseriesdocs << @archivosseriesdoc
      @archivosserie.save
      @archivosseriesdoc = Archivosseriesdoc.new
    else
      flash[:warning] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "archivosseriesdocs" }
    end
  end

  def update
    @archivosseriesdoc        = Archivosseriesdoc.new
    archivosseriesdoc         = Archivosseriesdoc.find(params[:id])
    @archivosserie        = archivosseriesdoc.archivosserie
    ok = archivosseriesdoc.update_attributes(params[:archivosseriesdoc])
    flash[:notice] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "archivosseriesdocs" }
    end
  end

  def destroy
    archivosseriesdoc   = Archivosseriesdoc.find(params[:id])
    @archivosserie  = archivosseriesdoc.archivosserie
    @archivosseriesdoc  = Archivosseriesdoc.new
    archivosseriesdoc.destroy
    respond_to do |format|
      format.js { render :action => "archivosseriesdocs" }
    end
  end
end

