class IndicadoresresultadosController < ApplicationController
  # GET /indicadoresresultados
  # GET /indicadoresresultados.xml
  def index
    @indicadoresresultados = Indicadoresresultado.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @indicadoresresultados }
    end
  end

  # GET /indicadoresresultados/1
  # GET /indicadoresresultados/1.xml
  def show
    @indicadoresresultado = Indicadoresresultado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @indicadoresresultado }
    end
  end

  # GET /indicadoresresultados/new
  # GET /indicadoresresultados/new.xml
  def new
    @indicadoresresultado = Indicadoresresultado.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @indicadoresresultado }
    end
  end

  # GET /indicadoresresultados/1/edit
  def edit
    @indicadoresresultado = Indicadoresresultado.find(params[:id])
  end

  # POST /indicadoresresultados
  # POST /indicadoresresultados.xml
  def create
    @indicadoresresultado = Indicadoresresultado.new(params[:indicadoresresultado])

    respond_to do |format|
      if @indicadoresresultado.save
        format.html { redirect_to(@indicadoresresultado, :notice => 'Indicadoresresultado was successfully created.') }
        format.xml  { render :xml => @indicadoresresultado, :status => :created, :location => @indicadoresresultado }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @indicadoresresultado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /indicadoresresultados/1
  # PUT /indicadoresresultados/1.xml
  def update
    @indicadoresresultado = Indicadoresresultado.find(params[:id])

    respond_to do |format|
      if @indicadoresresultado.update_attributes(params[:indicadoresresultado])
        format.html { redirect_to(@indicadoresresultado, :notice => 'Indicadoresresultado was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @indicadoresresultado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /indicadoresresultados/1
  # DELETE /indicadoresresultados/1.xml
  def destroy
    @indicadoresresultado = Indicadoresresultado.find(params[:id])
    @indicadoresresultado.destroy

    respond_to do |format|
      format.html { redirect_to(indicadoresresultados_url) }
      format.xml  { head :ok }
    end
  end
end
