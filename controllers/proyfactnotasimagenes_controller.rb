class ProyfactnotasimagenesController < ApplicationController
  before_filter :require_user
  before_filter :find_proyfactnota_and_proyfactnotasimagen

  def index
    @proyfactnotasimagenes = @proyfactnota.proyfactnotasimagenes.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @proyfactnotasimagenes }
    end
  end

  def show
    @proyfactnotasimagen = Proyfactnotasimagen.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @proyfactnotasimagen }
    end
  end

  def new
    @proyfactnotasimagen = Proyfactnotasimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proyfactnotasimagen }
    end
  end

  def edit
    @proyfactnotasimagen = Proyfactnotasimagen.find(params[:id])
  end

  def create
    @proyfactnotasimagen = Proyfactnotasimagen.new(params[:proyfactnotasimagen])
    @proyfactnotasimagen.proyfactnota_id = @proyfactnota.id
    @proyfactnotasimagen.user_id = is_admin
    respond_to do |format|
      if @proyfactnotasimagen.save
        format.html { redirect_to edit_proyecto_path(@proyfactnotasimagen.proyfactnota.proyectosfactibilidad.proyecto_id) }
        format.xml  { render :xml => @proyfactnotasimagen, :status => :created, :location => @proyfactnotasimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @proyfactnotasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @proyfactnotasimagen = Proyfactnotasimagen.find(params[:id])
    @proyfactnotasimagen.user_actualiza = is_admin
    respond_to do |format|
      if @proyfactnotasimagen.update_attributes(params[:proyfactnotasimagen])
        format.html { redirect_to edit_proyecto_path(@proyfactnotasimagen.proyfactnota.proyectosfactibilidad.proyecto_id) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proyfactnotasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @proyfactnotasimagen = Proyfactnotasimagen.find(params[:id])
    @proyfactnotasimagen.destroy
    respond_to do |format|
      format.html { redirect_to edit_proyecto_path(@proyfactnota.proyectosfactibilidad.proyecto_id) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_proyfactnota_and_proyfactnotasimagen
      @proyfactnota = Proyfactnota.find(params[:proyfactnota_id])
      @proyfactnotasimagen = Proyfactnotasimagen.find(params[:id]) if params[:id]
  end
end
