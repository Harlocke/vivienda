class ArrendimientospagosController < ApplicationController
  # GET /arrendimientospagos
  # GET /arrendimientospagos.xml
  def index
    @arrendimientospagos = Arrendimientospago.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @arrendimientospagos }
    end
  end

  # GET /arrendimientospagos/1
  # GET /arrendimientospagos/1.xml
  def show
    @arrendimientospago = Arrendimientospago.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @arrendimientospago }
    end
  end

  # GET /arrendimientospagos/new
  # GET /arrendimientospagos/new.xml
  def new
    @arrendimientospago = Arrendimientospago.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @arrendimientospago }
    end
  end

  # GET /arrendimientospagos/1/edit
  def edit
    @arrendimientospago = Arrendimientospago.find(params[:id])
  end

  # POST /arrendimientospagos
  # POST /arrendimientospagos.xml
  def create
    @arrendimientospago = Arrendimientospago.new(params[:arrendimientospago])

    respond_to do |format|
      if @arrendimientospago.save
        format.html { redirect_to(@arrendimientospago, :notice => 'Arrendimientospago was successfully created.') }
        format.xml  { render :xml => @arrendimientospago, :status => :created, :location => @arrendimientospago }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @arrendimientospago.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /arrendimientospagos/1
  # PUT /arrendimientospagos/1.xml
  def update
    @arrendimientospago = Arrendimientospago.find(params[:id])

    respond_to do |format|
      if @arrendimientospago.update_attributes(params[:arrendimientospago])
        format.html { redirect_to(@arrendimientospago, :notice => 'Arrendimientospago was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @arrendimientospago.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /arrendimientospagos/1
  # DELETE /arrendimientospagos/1.xml
  def destroy
    @arrendimientospago = Arrendimientospago.find(params[:id])
    @arrendimientospago.destroy

    respond_to do |format|
      format.html { redirect_to(arrendimientospagos_url) }
      format.xml  { head :ok }
    end
  end
end
