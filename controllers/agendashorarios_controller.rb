class AgendashorariosController < ApplicationController
  before_filter :require_user
#  layout :determine_layout

  def index
    @agendasfecha = Agendasfecha.find(params[:id])
    @agendashorarios = @agendasfecha.agendashorarios.find(:all, :order=>"id asc")
  end

  def act
    @agendashorario = Agendashorario.find(params[:id])
    @agendashorario.estado = 'ACTIVO'
    @agendashorario.save
    flash[:notice] = "Activado"
    redirect_to agendashorarios_path(:id =>@agendashorario.agendasfecha_id)
  end

  def bact
    @agendashorario = Agendashorario.find(params[:id])
    @agendashorario.estado = 'INACTIVO'
    @agendashorario.save
    flash[:notice] = "Inactivado"
    redirect_to agendashorarios_path(:id =>@agendashorario.agendasfecha_id)
  end    


  # GET /agendashorarios/new
  # GET /agendashorarios/new.xml
  def new
    @agendashorario = Agendashorario.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @agendashorario }
    end
  end

  # GET /agendashorarios/1/edit
  def edit
    @agendashorario = Agendashorario.find(params[:id])
  end

  # POST /agendashorarios
  # POST /agendashorarios.xml
  def create
    @agendashorario = Agendashorario.new(params[:agendashorario])

    respond_to do |format|
      if @agendashorario.save
        format.html { redirect_to(@agendashorario, :notice => 'Agendashorario was successfully created.') }
        format.xml  { render :xml => @agendashorario, :status => :created, :location => @agendashorario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @agendashorario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /agendashorarios/1
  # PUT /agendashorarios/1.xml
  def update
    @agendashorario = Agendashorario.find(params[:id])

    respond_to do |format|
      if @agendashorario.update_attributes(params[:agendashorario])
        format.html { redirect_to(@agendashorario, :notice => 'Agendashorario was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @agendashorario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /agendashorarios/1
  # DELETE /agendashorarios/1.xml
  def destroy
    @agendashorario = Agendashorario.find(params[:id])
    @agendashorario.destroy

    respond_to do |format|
      format.html { redirect_to(agendashorarios_url) }
      format.xml  { head :ok }
    end
  end
end
