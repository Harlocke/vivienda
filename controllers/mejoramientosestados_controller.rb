class MejoramientosestadosController < ApplicationController
  # GET /mejoramientosestados
  # GET /mejoramientosestados.xml
  def index
    @mejoramientosestados = Mejoramientosestado.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mejoramientosestados }
    end
  end

  # GET /mejoramientosestados/1
  # GET /mejoramientosestados/1.xml
  def show
    @mejoramientosestado = Mejoramientosestado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mejoramientosestado }
    end
  end

  # GET /mejoramientosestados/new
  # GET /mejoramientosestados/new.xml
  def new
    @mejoramientosestado = Mejoramientosestado.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mejoramientosestado }
    end
  end

  # GET /mejoramientosestados/1/edit
  def edit
    @mejoramientosestado = Mejoramientosestado.find(params[:id])
  end

  # POST /mejoramientosestados
  # POST /mejoramientosestados.xml
  def create
    @mejoramientosestado = Mejoramientosestado.new(params[:mejoramientosestado])

    respond_to do |format|
      if @mejoramientosestado.save
        flash[:notice] = 'Mejoramientosestado was successfully created.'
        format.html { redirect_to(@mejoramientosestado) }
        format.xml  { render :xml => @mejoramientosestado, :status => :created, :location => @mejoramientosestado }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mejoramientosestado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mejoramientosestados/1
  # PUT /mejoramientosestados/1.xml
  def update
    @mejoramientosestado = Mejoramientosestado.find(params[:id])

    respond_to do |format|
      if @mejoramientosestado.update_attributes(params[:mejoramientosestado])
        flash[:notice] = 'Mejoramientosestado was successfully updated.'
        format.html { redirect_to(@mejoramientosestado) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mejoramientosestado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mejoramientosestados/1
  # DELETE /mejoramientosestados/1.xml
  def destroy
    @mejoramientosestado = Mejoramientosestado.find(params[:id])
    @mejoramientosestado.destroy

    respond_to do |format|
      format.html { redirect_to(mejoramientosestados_url) }
      format.xml  { head :ok }
    end
  end
end
