class CorrespondenciasasignadasController < ApplicationController
  # GET /correspondenciasasignadas
  # GET /correspondenciasasignadas.xml
  def index
    @correspondenciasasignadas = Correspondenciasasignada.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @correspondenciasasignadas }
    end
  end

  # GET /correspondenciasasignadas/1
  # GET /correspondenciasasignadas/1.xml
  def show
    @correspondenciasasignada = Correspondenciasasignada.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @correspondenciasasignada }
    end
  end

  # GET /correspondenciasasignadas/new
  # GET /correspondenciasasignadas/new.xml
  def new
    @correspondenciasasignada = Correspondenciasasignada.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @correspondenciasasignada }
    end
  end

  # GET /correspondenciasasignadas/1/edit
  def edit
    @correspondenciasasignada = Correspondenciasasignada.find(params[:id])
  end

  # POST /correspondenciasasignadas
  # POST /correspondenciasasignadas.xml
  def create
    @correspondenciasasignada = Correspondenciasasignada.new(params[:correspondenciasasignada])

    respond_to do |format|
      if @correspondenciasasignada.save
        flash[:notice] = 'Correspondenciasasignada was successfully created.'
        format.html { redirect_to(@correspondenciasasignada) }
        format.xml  { render :xml => @correspondenciasasignada, :status => :created, :location => @correspondenciasasignada }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @correspondenciasasignada.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /correspondenciasasignadas/1
  # PUT /correspondenciasasignadas/1.xml
  def update
    @correspondenciasasignada = Correspondenciasasignada.find(params[:id])

    respond_to do |format|
      if @correspondenciasasignada.update_attributes(params[:correspondenciasasignada])
        flash[:notice] = 'Correspondenciasasignada was successfully updated.'
        format.html { redirect_to(@correspondenciasasignada) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @correspondenciasasignada.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /correspondenciasasignadas/1
  # DELETE /correspondenciasasignadas/1.xml
  def destroy
    @correspondenciasasignada = Correspondenciasasignada.find(params[:id])
    @correspondenciasasignada.destroy

    respond_to do |format|
      format.html { redirect_to(correspondenciasasignadas_url) }
      format.xml  { head :ok }
    end
  end
end
