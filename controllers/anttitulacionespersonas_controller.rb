class AnttitulacionespersonasController < ApplicationController
  # GET /anttitulacionespersonas
  # GET /anttitulacionespersonas.xml
  def index
    @anttitulacionespersonas = Anttitulacionespersona.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @anttitulacionespersonas }
    end
  end

  # GET /anttitulacionespersonas/1
  # GET /anttitulacionespersonas/1.xml
  def show
    @anttitulacionespersona = Anttitulacionespersona.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @anttitulacionespersona }
    end
  end

  # GET /anttitulacionespersonas/new
  # GET /anttitulacionespersonas/new.xml
  def new
    @anttitulacionespersona = Anttitulacionespersona.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @anttitulacionespersona }
    end
  end

  # GET /anttitulacionespersonas/1/edit
  def edit
    @anttitulacionespersona = Anttitulacionespersona.find(params[:id])
  end

  # POST /anttitulacionespersonas
  # POST /anttitulacionespersonas.xml
  def create
    @anttitulacionespersona = Anttitulacionespersona.new(params[:anttitulacionespersona])

    respond_to do |format|
      if @anttitulacionespersona.save
        flash[:notice] = 'Anttitulacionespersona was successfully created.'
        format.html { redirect_to(@anttitulacionespersona) }
        format.xml  { render :xml => @anttitulacionespersona, :status => :created, :location => @anttitulacionespersona }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @anttitulacionespersona.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /anttitulacionespersonas/1
  # PUT /anttitulacionespersonas/1.xml
  def update
    @anttitulacionespersona = Anttitulacionespersona.find(params[:id])

    respond_to do |format|
      if @anttitulacionespersona.update_attributes(params[:anttitulacionespersona])
        flash[:notice] = 'Anttitulacionespersona was successfully updated.'
        format.html { redirect_to(@anttitulacionespersona) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @anttitulacionespersona.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /anttitulacionespersonas/1
  # DELETE /anttitulacionespersonas/1.xml
  def destroy
    @anttitulacionespersona = Anttitulacionespersona.find(params[:id])
    @anttitulacionespersona.destroy

    respond_to do |format|
      format.html { redirect_to(anttitulacionespersonas_url) }
      format.xml  { head :ok }
    end
  end
end
