class Feria2014imagenesController < ApplicationController

  before_filter :require_user
  before_filter :find_persona_and_feria2014imagen

  def index
    persona   = Persona.find(params[:persona_id])
    @feria2014imagenes = persona.feria2014imagenes.all
  end

  def new
    @feria2014imagen = Feria2014imagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feria2014imagen }
    end
  end

  def create
    @feria2014imagen = Feria2014imagen.new(params[:feria2014imagen])
    @feria2014imagen.persona_id = @persona.id
    @feria2014imagen.user_id = is_admin
    respond_to do |format|
      if @feria2014imagen.save
        flash[:notice] = "Documento cargado con exito"
        format.html { redirect_to edit_persona_path(@persona) }
        format.xml  { render :xml => @feria2014imagen, :status => :created, :location => @feria2014imagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feria2014imagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @feria2014imagen = Feria2014imagen.find(params[:id])
    respond_to do |format|
      if @feria2014imagen.update_attributes(params[:feria2014imagen])
        format.html { redirect_to persona_feria2014imagenes_path(@persona) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feria2014imagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    feria2014imagen   = Feria2014imagen.find(params[:id])
    @persona         = feria2014imagen.persona
    @feria2014imagen  = Feria2014imagen.new
    feria2014imagen.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end

  def find_persona_and_feria2014imagen
      @persona = Persona.find(params[:persona_id])
      @feria2014imagen = Feria2014imagen.find(params[:id]) if params[:id]
  end
end
