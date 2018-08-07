class Feria2010calificacionrecursosController < ApplicationController
  before_filter :require_user
  # GET /feria2010calificacionrecursos
  # GET /feria2010calificacionrecursos.xml
  def index
    @feria2010calificacionrecursos = Feria2010calificacionrecurso.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feria2010calificacionrecursos }
    end
  end

  # GET /feria2010calificacionrecursos/1
  # GET /feria2010calificacionrecursos/1.xml
  def show
    @feria2010calificacionrecurso = Feria2010calificacionrecurso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feria2010calificacionrecurso }
    end
  end

  # GET /feria2010calificacionrecursos/new
  # GET /feria2010calificacionrecursos/new.xml
  def new
    @feria2010calificacionrecurso = Feria2010calificacionrecurso.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feria2010calificacionrecurso }
    end
  end

  # GET /feria2010calificacionrecursos/1/edit
  def edit
    @feria2010calificacionrecurso = Feria2010calificacionrecurso.find(params[:id])
  end

  # POST /feria2010calificacionrecursos
  # POST /feria2010calificacionrecursos.xml
  def create
    @feria2010calificacionrecurso = Feria2010calificacionrecurso.new(params[:feria2010calificacionrecurso])

    respond_to do |format|
      if @feria2010calificacionrecurso.save
        format.html { redirect_to(@feria2010calificacionrecurso, :notice => 'Feria2010calificacionrecurso was successfully created.') }
        format.xml  { render :xml => @feria2010calificacionrecurso, :status => :created, :location => @feria2010calificacionrecurso }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feria2010calificacionrecurso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feria2010calificacionrecursos/1
  # PUT /feria2010calificacionrecursos/1.xml
  def update
    @feria2010calificacionrecurso = Feria2010calificacionrecurso.find(params[:id])

    respond_to do |format|
      if @feria2010calificacionrecurso.update_attributes(params[:feria2010calificacionrecurso])
        format.html { redirect_to(@feria2010calificacionrecurso, :notice => 'Feria2010calificacionrecurso was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feria2010calificacionrecurso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feria2010calificacionrecursos/1
  # DELETE /feria2010calificacionrecursos/1.xml
  def destroy
    @feria2010calificacionrecurso = Feria2010calificacionrecurso.find(params[:id])
    @feria2010calificacionrecurso.destroy

    respond_to do |format|
      format.html { redirect_to(feria2010calificacionrecursos_url) }
      format.xml  { head :ok }
    end
  end
end
