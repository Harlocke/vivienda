class FichaselementosController < ApplicationController
  
  before_filter :require_user

  def index
    @fichaselementos = Fichaselemento.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fichaselementos }
    end
  end

  # GET /fichaselementos/1
  # GET /fichaselementos/1.xml
  def show
    @fichaselemento = Fichaselemento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fichaselemento }
    end
  end

  # GET /fichaselementos/new
  # GET /fichaselementos/new.xml
  def new
    @fichaselemento = Fichaselemento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fichaselemento }
    end
  end

  # GET /fichaselementos/1/edit
  def edit
    @fichaselemento = Fichaselemento.find(params[:id])
  end

  # POST /fichaselementos
  # POST /fichaselementos.xml
  def create
    @fichaselemento = Fichaselemento.new(params[:fichaselemento])

    respond_to do |format|
      if @fichaselemento.save
        format.html { redirect_to(@fichaselemento, :notice => 'Fichaselemento was successfully created.') }
        format.xml  { render :xml => @fichaselemento, :status => :created, :location => @fichaselemento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fichaselemento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fichaselementos/1
  # PUT /fichaselementos/1.xml
  def update
    @fichaselemento = Fichaselemento.find(params[:id])

    respond_to do |format|
      if @fichaselemento.update_attributes(params[:fichaselemento])
        format.html { redirect_to(@fichaselemento, :notice => 'Fichaselemento was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fichaselemento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fichaselementos/1
  # DELETE /fichaselementos/1.xml
  def destroy
    @fichaselemento = Fichaselemento.find(params[:id])
    @fichaselemento.destroy

    respond_to do |format|
      format.html { redirect_to(fichaselementos_url) }
      format.xml  { head :ok }
    end
  end
end
