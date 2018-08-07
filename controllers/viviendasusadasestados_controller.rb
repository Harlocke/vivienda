class ViviendasusadasestadosController < ApplicationController

  before_filter :require_user
  # GET /viviendasusadasestados
  # GET /viviendasusadasestados.xml
  def index
    @viviendasusadasestados = Viviendasusadasestado.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @viviendasusadasestados }
    end
  end

  # GET /viviendasusadasestados/1
  # GET /viviendasusadasestados/1.xml
  def show
    @viviendasusadasestado = Viviendasusadasestado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @viviendasusadasestado }
    end
  end

  # GET /viviendasusadasestados/new
  # GET /viviendasusadasestados/new.xml
  def new
    @viviendasusadasestado = Viviendasusadasestado.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @viviendasusadasestado }
    end
  end

  # GET /viviendasusadasestados/1/edit
  def edit
    @viviendasusadasestado = Viviendasusadasestado.find(params[:id])
  end

  # POST /viviendasusadasestados
  # POST /viviendasusadasestados.xml
  def create
    @viviendasusadasestado = Viviendasusadasestado.new(params[:viviendasusadasestado])

    respond_to do |format|
      if @viviendasusadasestado.save
        format.html { redirect_to(@viviendasusadasestado, :notice => 'Viviendasusadasestado was successfully created.') }
        format.xml  { render :xml => @viviendasusadasestado, :status => :created, :location => @viviendasusadasestado }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @viviendasusadasestado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /viviendasusadasestados/1
  # PUT /viviendasusadasestados/1.xml
  def update
    @viviendasusadasestado = Viviendasusadasestado.find(params[:id])

    respond_to do |format|
      if @viviendasusadasestado.update_attributes(params[:viviendasusadasestado])
        format.html { redirect_to(@viviendasusadasestado, :notice => 'Viviendasusadasestado was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @viviendasusadasestado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /viviendasusadasestados/1
  # DELETE /viviendasusadasestados/1.xml
  def destroy
    @viviendasusadasestado = Viviendasusadasestado.find(params[:id])
    @viviendasusadasestado.destroy

    respond_to do |format|
      format.html { redirect_to(viviendasusadasestados_url) }
      format.xml  { head :ok }
    end
  end
end
