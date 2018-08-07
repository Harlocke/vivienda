class IndicadoresfichasimagenesController < ApplicationController
  before_filter :require_user
  before_filter :find_indicadoresficha_and_indicadoresfichasimagen, :except=>"destroy2"

  def index
    @indicadoresfichasimagenes = @indicadoresficha.indicadoresfichasimagenes.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @indicadoresfichasimagenes }
    end
  end

  def show
    @indicadoresfichasimagen = Indicadoresfichasimagen.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @indicadoresfichasimagen }
    end
  end

  def new
    @indicadoresfichasimagen = Indicadoresfichasimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @indicadoresfichasimagen }
    end
  end

  def edit
    @indicadoresfichasimagen = Indicadoresfichasimagen.find(params[:id])
  end

  def create
    @indicadoresfichasimagen = Indicadoresfichasimagen.new(params[:indicadoresfichasimagen])
    @indicadoresfichasimagen.indicadoresficha_id = @indicadoresficha.id
    @indicadoresfichasimagen.user_id = is_admin
    respond_to do |format|
      if @indicadoresfichasimagen.save
        flash[:notice] = "Documento Cargado con Exito."
        format.html { redirect_to edit_indicador_path(@indicadoresficha.indicador_id) }
        format.xml  { render :xml => @indicadoresfichasimagen, :status => :created, :location => @indicadoresfichasimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @indicadoresfichasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @indicadoresfichasimagen = Indicadoresfichasimagen.find(params[:id])
    respond_to do |format|
      if @indicadoresfichasimagen.update_attributes(params[:indicadoresfichasimagen])
        format.html { redirect_to edit_indicador_path(@indicadoresficha) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @indicadoresfichasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @indicadoresfichasimagen = Indicadoresfichasimagen.find(params[:id])
    @indicadoresfichasimagen.destroy
    respond_to do |format|
      format.html { redirect_to img_indicadoresfichasimagenes_url(@indicadoresficha) }
      format.xml  { head :ok }
    end
  end

  def destroy2
    indicadoresfichasimagen   = Indicadoresfichasimagen.find(params[:id])
    indicadoresfichasimagen.destroy
    flash[:notice] = "Documento Eliminado con Exito."
    redirect_to :controller=>"indicadores", :action=>"edit", :id=>params[:indicador_id]
  end

  protected
  def find_indicadoresficha_and_indicadoresfichasimagen
      @indicadoresficha = Indicadoresficha.find(params[:indicadoresficha_id])
      @indicadoresfichasimagen = Indicadoresfichasimagen.find(params[:id]) if params[:id]
  end
  
  private
  def determine_layout
    if ['visualizar','visita'].include?(action_name)
      "datos"
    else
      "application"
    end
  end

end