class Feria2014puntajesController < ApplicationController
  # GET /feria2014puntajes
  # GET /feria2014puntajes.xml
  def index
    @feria2014puntajes = Feria2014puntaje.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feria2014puntajes }
    end
  end

  # GET /feria2014puntajes/1
  # GET /feria2014puntajes/1.xml
  def show
    @feria2014puntaje = Feria2014puntaje.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feria2014puntaje }
    end
  end

  # GET /feria2014puntajes/new
  # GET /feria2014puntajes/new.xml
  def new
    @feria2014puntaje = Feria2014puntaje.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feria2014puntaje }
    end
  end

  # GET /feria2014puntajes/1/edit
  def edit
    @feria2014puntaje = Feria2014puntaje.find(params[:id])
  end

  # POST /feria2014puntajes
  # POST /feria2014puntajes.xml
  def create
    @feria2014puntaje = Feria2014puntaje.new(params[:feria2014puntaje])

    respond_to do |format|
      if @feria2014puntaje.save
        format.html { redirect_to(@feria2014puntaje, :notice => 'Feria2014puntaje was successfully created.') }
        format.xml  { render :xml => @feria2014puntaje, :status => :created, :location => @feria2014puntaje }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feria2014puntaje.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feria2014puntajes/1
  # PUT /feria2014puntajes/1.xml
  def update
    @feria2014puntaje = Feria2014puntaje.find(params[:id])

    respond_to do |format|
      if @feria2014puntaje.update_attributes(params[:feria2014puntaje])
        format.html { redirect_to(@feria2014puntaje, :notice => 'Feria2014puntaje was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feria2014puntaje.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feria2014puntajes/1
  # DELETE /feria2014puntajes/1.xml
  def destroy
    @feria2014puntaje = Feria2014puntaje.find(params[:id])
    @feria2014puntaje.destroy

    respond_to do |format|
      format.html { redirect_to(feria2014puntajes_url) }
      format.xml  { head :ok }
    end
  end
end
