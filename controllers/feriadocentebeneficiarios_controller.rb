class FeriadocentebeneficiariosController < ApplicationController
  before_filter :require_user
  # GET /feriadocentebeneficiarios
  # GET /feriadocentebeneficiarios.xml
  def index
    @feriadocentebeneficiarios = Feriadocentebeneficiario.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feriadocentebeneficiarios }
    end
  end

  # GET /feriadocentebeneficiarios/1
  # GET /feriadocentebeneficiarios/1.xml
  def show
    @feriadocentebeneficiario = Feriadocentebeneficiario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feriadocentebeneficiario }
    end
  end

  # GET /feriadocentebeneficiarios/new
  # GET /feriadocentebeneficiarios/new.xml
  def new
    @feriadocentebeneficiario = Feriadocentebeneficiario.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feriadocentebeneficiario }
    end
  end

  # GET /feriadocentebeneficiarios/1/edit
  def edit
    @feriadocentebeneficiario = Feriadocentebeneficiario.find(params[:id])
  end

  # POST /feriadocentebeneficiarios
  # POST /feriadocentebeneficiarios.xml
  def create
    @feriadocentebeneficiario = Feriadocentebeneficiario.new(params[:feriadocentebeneficiario])

    respond_to do |format|
      if @feriadocentebeneficiario.save
        format.html { redirect_to(@feriadocentebeneficiario, :notice => 'Feriadocentebeneficiario was successfully created.') }
        format.xml  { render :xml => @feriadocentebeneficiario, :status => :created, :location => @feriadocentebeneficiario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feriadocentebeneficiario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feriadocentebeneficiarios/1
  # PUT /feriadocentebeneficiarios/1.xml
  def update
    @feriadocentebeneficiario = Feriadocentebeneficiario.find(params[:id])

    respond_to do |format|
      if @feriadocentebeneficiario.update_attributes(params[:feriadocentebeneficiario])
        format.html { redirect_to(@feriadocentebeneficiario, :notice => 'Feriadocentebeneficiario was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feriadocentebeneficiario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feriadocentebeneficiarios/1
  # DELETE /feriadocentebeneficiarios/1.xml
  def destroy
    @feriadocentebeneficiario = Feriadocentebeneficiario.find(params[:id])
    @feriadocentebeneficiario.destroy

    respond_to do |format|
      format.html { redirect_to(feriadocentebeneficiarios_url) }
      format.xml  { head :ok }
    end
  end
end
