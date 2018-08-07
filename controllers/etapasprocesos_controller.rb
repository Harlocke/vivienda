class EtapasprocesosController < ApplicationController
  # GET /etapasprocesos
  # GET /etapasprocesos.xml
  def index
    @etapasprocesos = Etapasproceso.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @etapasprocesos }
    end
  end

  # GET /etapasprocesos/1
  # GET /etapasprocesos/1.xml
  def show
    @etapasproceso = Etapasproceso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @etapasproceso }
    end
  end

  # GET /etapasprocesos/new
  # GET /etapasprocesos/new.xml
  def new
    @etapasproceso = Etapasproceso.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @etapasproceso }
    end
  end

  # GET /etapasprocesos/1/edit
  def edit
    @etapasproceso = Etapasproceso.find(params[:id])
  end

  # POST /etapasprocesos
  # POST /etapasprocesos.xml
  def create
    @etapasproceso = Etapasproceso.new(params[:etapasproceso])

    respond_to do |format|
      if @etapasproceso.save
        flash[:notice] = 'Etapasproceso was successfully created.'
        format.html { redirect_to(@etapasproceso) }
        format.xml  { render :xml => @etapasproceso, :status => :created, :location => @etapasproceso }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @etapasproceso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /etapasprocesos/1
  # PUT /etapasprocesos/1.xml
  def update
    @etapasproceso = Etapasproceso.find(params[:id])

    respond_to do |format|
      if @etapasproceso.update_attributes(params[:etapasproceso])
        flash[:notice] = 'Etapasproceso was successfully updated.'
        format.html { redirect_to(@etapasproceso) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @etapasproceso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /etapasprocesos/1
  # DELETE /etapasprocesos/1.xml
  def destroy
    @etapasproceso = Etapasproceso.find(params[:id])
    @etapasproceso.destroy

    respond_to do |format|
      format.html { redirect_to(etapasprocesos_url) }
      format.xml  { head :ok }
    end
  end
end
