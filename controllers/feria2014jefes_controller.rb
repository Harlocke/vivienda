class Feria2014jefesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def informecalificacion
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Consolidado_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @feria2014jefes = Feria2014jefe.all
  end

  def index
    @feria2014jefes = Feria2014jefe.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feria2014jefes }
    end
  end

  # GET /feria2014jefes/1
  # GET /feria2014jefes/1.xml
  def show
    @feria2014jefe = Feria2014jefe.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feria2014jefe }
    end
  end

  # GET /feria2014jefes/new
  # GET /feria2014jefes/new.xml
  def new
    @feria2014jefe = Feria2014jefe.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feria2014jefe }
    end
  end

  # GET /feria2014jefes/1/edit
  def edit
    @feria2014jefe = Feria2014jefe.find(params[:id])
  end

  # POST /feria2014jefes
  # POST /feria2014jefes.xml
  def create
    @feria2014jefe = Feria2014jefe.new(params[:feria2014jefe])

    respond_to do |format|
      if @feria2014jefe.save
        format.html { redirect_to(@feria2014jefe, :notice => 'Feria2014jefe was successfully created.') }
        format.xml  { render :xml => @feria2014jefe, :status => :created, :location => @feria2014jefe }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feria2014jefe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feria2014jefes/1
  # PUT /feria2014jefes/1.xml
  def update
    @feria2014jefe = Feria2014jefe.find(params[:id])

    respond_to do |format|
      if @feria2014jefe.update_attributes(params[:feria2014jefe])
        format.html { redirect_to(@feria2014jefe, :notice => 'Feria2014jefe was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feria2014jefe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feria2014jefes/1
  # DELETE /feria2014jefes/1.xml
  def destroy
    @feria2014jefe = Feria2014jefe.find(params[:id])
    @feria2014jefe.destroy

    respond_to do |format|
      format.html { redirect_to(feria2014jefes_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if['informecalificacion'].include?(action_name)
      "excel"
    else
      "application"
    end
  end


end
