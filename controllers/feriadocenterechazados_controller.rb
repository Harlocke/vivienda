class FeriadocenterechazadosController < ApplicationController
  before_filter :require_user
  # GET /feriadocenterechazados
  # GET /feriadocenterechazados.xml
  def index
    @feriadocenterechazados = Feriadocenterechazado.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feriadocenterechazados }
    end
  end

  # GET /feriadocenterechazados/1
  # GET /feriadocenterechazados/1.xml
  def show
    @feriadocenterechazado = Feriadocenterechazado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feriadocenterechazado }
    end
  end

  # GET /feriadocenterechazados/new
  # GET /feriadocenterechazados/new.xml
  def new
    @feriadocenterechazado = Feriadocenterechazado.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feriadocenterechazado }
    end
  end

  # GET /feriadocenterechazados/1/edit
  def edit
    @feriadocenterechazado = Feriadocenterechazado.find(params[:id])
  end

  # POST /feriadocenterechazados
  # POST /feriadocenterechazados.xml
  def create
    @feriadocenterechazado = Feriadocenterechazado.new(params[:feriadocenterechazado])

    respond_to do |format|
      if @feriadocenterechazado.save
        format.html { redirect_to(@feriadocenterechazado, :notice => 'Feriadocenterechazado was successfully created.') }
        format.xml  { render :xml => @feriadocenterechazado, :status => :created, :location => @feriadocenterechazado }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feriadocenterechazado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feriadocenterechazados/1
  # PUT /feriadocenterechazados/1.xml
  def update
    @feriadocenterechazado = Feriadocenterechazado.find(params[:id])

    respond_to do |format|
      if @feriadocenterechazado.update_attributes(params[:feriadocenterechazado])
        format.html { redirect_to(@feriadocenterechazado, :notice => 'Feriadocenterechazado was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feriadocenterechazado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feriadocenterechazados/1
  # DELETE /feriadocenterechazados/1.xml
  def destroy
    @feriadocenterechazado = Feriadocenterechazado.find(params[:id])
    @feriadocenterechazado.destroy

    respond_to do |format|
      format.html { redirect_to(feriadocenterechazados_url) }
      format.xml  { head :ok }
    end
  end
end
