class ArrendamientosprorrogasController < ApplicationController
  # GET /arrendamientosprorrogas
  # GET /arrendamientosprorrogas.xml
  def index
    @arrendamientosprorrogas = Arrendamientosprorroga.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @arrendamientosprorrogas }
    end
  end

  # GET /arrendamientosprorrogas/1
  # GET /arrendamientosprorrogas/1.xml
  def show
    @arrendamientosprorroga = Arrendamientosprorroga.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @arrendamientosprorroga }
    end
  end

  # GET /arrendamientosprorrogas/new
  # GET /arrendamientosprorrogas/new.xml
  def new
    @arrendamientosprorroga = Arrendamientosprorroga.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @arrendamientosprorroga }
    end
  end

  # GET /arrendamientosprorrogas/1/edit
  def edit
    @arrendamientosprorroga = Arrendamientosprorroga.find(params[:id])
  end

  # POST /arrendamientosprorrogas
  # POST /arrendamientosprorrogas.xml
  def create
    @arrendamientosprorroga = Arrendamientosprorroga.new(params[:arrendamientosprorroga])

    respond_to do |format|
      if @arrendamientosprorroga.save
        format.html { redirect_to(@arrendamientosprorroga, :notice => 'Arrendamientosprorroga was successfully created.') }
        format.xml  { render :xml => @arrendamientosprorroga, :status => :created, :location => @arrendamientosprorroga }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @arrendamientosprorroga.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /arrendamientosprorrogas/1
  # PUT /arrendamientosprorrogas/1.xml
  def update
    @arrendamientosprorroga = Arrendamientosprorroga.find(params[:id])

    respond_to do |format|
      if @arrendamientosprorroga.update_attributes(params[:arrendamientosprorroga])
        format.html { redirect_to(@arrendamientosprorroga, :notice => 'Arrendamientosprorroga was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @arrendamientosprorroga.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /arrendamientosprorrogas/1
  # DELETE /arrendamientosprorrogas/1.xml
  def destroy
    @arrendamientosprorroga = Arrendamientosprorroga.find(params[:id])
    @arrendamientosprorroga.destroy

    respond_to do |format|
      format.html { redirect_to(arrendamientosprorrogas_url) }
      format.xml  { head :ok }
    end
  end
end
