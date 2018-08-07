class AntbeneviviendasController < ApplicationController

  before_filter :require_user

  layout :determine_layout

  def index
    persona   = Persona.find(params[:persona_id])
    @antbeneviviendas = persona.antbeneviviendas.all
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @antbeneviviendas = persona.antbeneviviendas.all
  end

 def edit
    @antbenevivienda  = Antbenevivienda.find(params[:id], :include => "persona")
    @persona  = @antbenevivienda.persona
    respond_to do |format|
      format.js { render :action => "edit_antbenevivienda" }
    end
  end

 def visualizar
    @antbenevivienda  = Antbenevivienda.find(params[:id])
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @antbenevivienda = Antbenevivienda.new(params[:antbenevivienda])
    if @antbenevivienda.valid?
      @persona.antantbeneviviendas << @antbenevivienda
      @persona.save
      @antbenevivienda = Antbenevivienda.new
      flash[:antbenevivienda] = "Creado con exito"
    else
      flash[:antbenevivienda] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "antantbeneviviendas" }
    end
  end

  def update
    @antbenevivienda   = Antbenevivienda.new
    antbenevivienda    = Antbenevivienda.find(params[:id])
    @persona        = antbenevivienda.persona
    ok = antbenevivienda.update_attributes(params[:antbenevivienda])
    flash[:antbenevivienda] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "antantbeneviviendas" }
    end
  end

  def destroy
    antbenevivienda   = Antbenevivienda.find(params[:id])
    @persona  = antbenevivienda.persona
    @antbenevivienda  = Antbenevivienda.new
    antbenevivienda.respaldo
    antbenevivienda.destroy
    flash[:antbenevivienda] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "antantbeneviviendas" }
    end
  end

  private
  def determine_layout
    if ['create'].include?(action_name)
      "application"
    end
  end
end

#  # GET /antbeneviviendas
#  # GET /antbeneviviendas.xml
#  def index
#    @antbeneviviendas = Antbenevivienda.all
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @antbeneviviendas }
#    end
#  end
#
#  # GET /antbeneviviendas/1
#  # GET /antbeneviviendas/1.xml
#  def show
#    @antbenevivienda = Antbenevivienda.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @antbenevivienda }
#    end
#  end
#
#  # GET /antbeneviviendas/new
#  # GET /antbeneviviendas/new.xml
#  def new
#    @antbenevivienda = Antbenevivienda.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @antbenevivienda }
#    end
#  end
#
#  # GET /antbeneviviendas/1/edit
#  def edit
#    @antbenevivienda = Antbenevivienda.find(params[:id])
#  end
#
#  # POST /antbeneviviendas
#  # POST /antbeneviviendas.xml
#  def create
#    @antbenevivienda = Antbenevivienda.new(params[:antbenevivienda])
#
#    respond_to do |format|
#      if @antbenevivienda.save
#        flash[:notice] = 'Antbenevivienda was successfully created.'
#        format.html { redirect_to(@antbenevivienda) }
#        format.xml  { render :xml => @antbenevivienda, :status => :created, :location => @antbenevivienda }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @antbenevivienda.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /antbeneviviendas/1
#  # PUT /antbeneviviendas/1.xml
#  def update
#    @antbenevivienda = Antbenevivienda.find(params[:id])
#
#    respond_to do |format|
#      if @antbenevivienda.update_attributes(params[:antbenevivienda])
#        flash[:notice] = 'Antbenevivienda was successfully updated.'
#        format.html { redirect_to(@antbenevivienda) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @antbenevivienda.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /antbeneviviendas/1
#  # DELETE /antbeneviviendas/1.xml
#  def destroy
#    @antbenevivienda = Antbenevivienda.find(params[:id])
#    @antbenevivienda.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(antbeneviviendas_url) }
#      format.xml  { head :ok }
#    end
#  end
#end
