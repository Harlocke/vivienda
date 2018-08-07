class ObrasproyectosController < ApplicationController
  # GET /obrasproyectos
  # GET /obrasproyectos.xml
  def index
    @obrasproyectos = Obrasproyecto.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @obrasproyectos }
    end
  end

  # GET /obrasproyectos/1
  # GET /obrasproyectos/1.xml
  def show
    @obrasproyecto = Obrasproyecto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @obrasproyecto }
    end
  end

  # GET /obrasproyectos/new
  # GET /obrasproyectos/new.xml
  def new
    @obrasproyecto = Obrasproyecto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @obrasproyecto }
    end
  end

  # GET /obrasproyectos/1/edit
  def edit
    @obrasproyecto = Obrasproyecto.find(params[:id])
  end

  # POST /obrasproyectos
  # POST /obrasproyectos.xml
  def create
    @obrasproyecto = Obrasproyecto.new(params[:obrasproyecto])

    respond_to do |format|
      if @obrasproyecto.save
        flash[:notice] = 'Obrasproyecto was successfully created.'
        format.html { redirect_to(@obrasproyecto) }
        format.xml  { render :xml => @obrasproyecto, :status => :created, :location => @obrasproyecto }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @obrasproyecto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /obrasproyectos/1
  # PUT /obrasproyectos/1.xml
  def update
    @obrasproyecto = Obrasproyecto.find(params[:id])

    respond_to do |format|
      if @obrasproyecto.update_attributes(params[:obrasproyecto])
        flash[:notice] = 'Obrasproyecto was successfully updated.'
        format.html { redirect_to(@obrasproyecto) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @obrasproyecto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /obrasproyectos/1
  # DELETE /obrasproyectos/1.xml
  def destroy
    @obrasproyecto = Obrasproyecto.find(params[:id])
    @obrasproyecto.destroy

    respond_to do |format|
      format.html { redirect_to(obrasproyectos_url) }
      format.xml  { head :ok }
    end
  end
end
