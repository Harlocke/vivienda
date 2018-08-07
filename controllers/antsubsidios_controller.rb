class AntsubsidiosController < ApplicationController

  before_filter :require_user

  layout :determine_layout

  def index
    persona   = Persona.find(params[:persona_id])
    @antsubsidios = persona.antsubsidios.all
    @tipos_subsidios = TiposSubsidio.all
  end

 def edit
    @antsubsidio  = Antsubsidio.find(params[:id], :include => "persona")
    @persona  = @antsubsidio.persona
    @tipos_subsidios = TiposSubsidio.all
    respond_to do |format|
      format.js { render :action => "edit_antsubsidio" }
    end
  end

  def visualizar
    @antsubsidio  = Antsubsidio.find(params[:id])
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @antsubsidio = Antsubsidio.new(params[:antsubsidio])
    @antsubsidio.estado_int = '0'
    if @antsubsidio.valid?
      @persona.antsubsidios << @antsubsidio
      @persona.save
      @antsubsidio = Antsubsidio.new
      @tipos_subsidios = TiposSubsidio.all
      flash[:antsubsidio] = "Creado con exito"
    else
      flash[:antsubsidio] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "antsubsidios" }
    end
  end

  def update
    @antsubsidio        = Antsubsidio.new
    antsubsidio         = Antsubsidio.find(params[:id])
    @persona        = antsubsidio.persona
    ok = antsubsidio.update_attributes(params[:antsubsidio])
    flash[:antsubsidio] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro "
    respond_to do |format|
      format.js { render :action => "antsubsidios" }
    end
  end

  def destroy
    antsubsidio   = Antsubsidio.find(params[:id])
    @persona      = antsubsidio.persona
    @antsubsidio  = Antsubsidio.new
    antsubsidio.respaldo
    antsubsidio.destroy
    flash[:antsubsidio] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "antsubsidios" }
    end
  end

  private
  def determine_layout
    if [''].include?(action_name)
      "application"
#    else
#      "basico"
    end
  end
end
  
  #
#  # GET /antsubsidios
#  # GET /antsubsidios.xml
#  def index
#    @antsubsidios = Antsubsidio.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @antsubsidios }
#    end
#  end
#
#  # GET /antsubsidios/1
#  # GET /antsubsidios/1.xml
#  def show
#    @antsubsidio = Antsubsidio.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @antsubsidio }
#    end
#  end
#
#  # GET /antsubsidios/new
#  # GET /antsubsidios/new.xml
#  def new
#    @antsubsidio = Antsubsidio.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @antsubsidio }
#    end
#  end
#
#  # GET /antsubsidios/1/edit
#  def edit
#    @antsubsidio = Antsubsidio.find(params[:id])
#  end
#
#  # POST /antsubsidios
#  # POST /antsubsidios.xml
#  def create
#    @antsubsidio = Antsubsidio.new(params[:antsubsidio])
#
#    respond_to do |format|
#      if @antsubsidio.save
#        flash[:notice] = 'Antsubsidio was successfully created.'
#        format.html { redirect_to(@antsubsidio) }
#        format.xml  { render :xml => @antsubsidio, :status => :created, :location => @antsubsidio }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @antsubsidio.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /antsubsidios/1
#  # PUT /antsubsidios/1.xml
#  def update
#    @antsubsidio = Antsubsidio.find(params[:id])
#
#    respond_to do |format|
#      if @antsubsidio.update_attributes(params[:antsubsidio])
#        flash[:notice] = 'Antsubsidio was successfully updated.'
#        format.html { redirect_to(@antsubsidio) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @antsubsidio.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /antsubsidios/1
#  # DELETE /antsubsidios/1.xml
#  def destroy
#    @antsubsidio = Antsubsidio.find(params[:id])
#    @antsubsidio.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(antsubsidios_url) }
#      format.xml  { head :ok }
#    end
#  end
#end
