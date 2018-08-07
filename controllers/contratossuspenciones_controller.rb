class ContratossuspencionesController < ApplicationController

  before_filter :require_user
  before_filter :find_contrato_and_contratossuspencion

  def index
    @contratossuspenciones = @contrato.contratossuspenciones.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contratossuspenciones }
    end
  end

  def show
    @contratossuspencion = Contratossuspencion.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contratossuspencion }
    end
  end

  def new
    @contratossuspencion = Contratossuspencion.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contratossuspencion }
    end
  end

  def edit
    @contratossuspencion = Contratossuspencion.find(params[:id])
  end

  def create
    @contratossuspencion = Contratossuspencion.new(params[:contratossuspencion])
    @contratossuspencion.contrato_id = @contrato.id
    @contratossuspencion.user_id = is_admin
    respond_to do |format|
      if @contratossuspencion.save
        format.html { redirect_to sus_contratossuspenciones_path(@contrato) }
        format.xml  { render :xml => @contratossuspencion, :status => :created, :location => @contratossuspencion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contratossuspencion.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @contratossuspencion = Contratossuspencion.find(params[:id])
    @contratossuspencion.user_actualiza = is_admin
    respond_to do |format|
      if @contratossuspencion.update_attributes(params[:contratossuspencion])
        format.html { redirect_to sus_contratossuspenciones_url(@contrato) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contratossuspencion.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @contratossuspencion = Contratossuspencion.find(params[:id])
    @contratossuspencion.destroy
    respond_to do |format|
      format.html { redirect_to sus_contratossuspenciones_url(@contrato) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_contrato_and_contratossuspencion
      @contrato = Contrato.find(params[:contrato_id])
      @contratossuspencion = Contratossuspencion.find(params[:id]) if params[:id]
  end
end

#
#  # GET /contratossuspenciones
#  # GET /contratossuspenciones.xml
#  def index
#    @contratossuspenciones = Contratossuspencion.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @contratossuspenciones }
#    end
#  end
#
#  # GET /contratossuspenciones/1
#  # GET /contratossuspenciones/1.xml
#  def show
#    @contratossuspencion = Contratossuspencion.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @contratossuspencion }
#    end
#  end
#
#  # GET /contratossuspenciones/new
#  # GET /contratossuspenciones/new.xml
#  def new
#    @contratossuspencion = Contratossuspencion.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @contratossuspencion }
#    end
#  end
#
#  # GET /contratossuspenciones/1/edit
#  def edit
#    @contratossuspencion = Contratossuspencion.find(params[:id])
#  end
#
#  # POST /contratossuspenciones
#  # POST /contratossuspenciones.xml
#  def create
#    @contratossuspencion = Contratossuspencion.new(params[:contratossuspencion])
#
#    respond_to do |format|
#      if @contratossuspencion.save
#        flash[:notice] = 'Contratossuspencion was successfully created.'
#        format.html { redirect_to(@contratossuspencion) }
#        format.xml  { render :xml => @contratossuspencion, :status => :created, :location => @contratossuspencion }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @contratossuspencion.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /contratossuspenciones/1
#  # PUT /contratossuspenciones/1.xml
#  def update
#    @contratossuspencion = Contratossuspencion.find(params[:id])
#
#    respond_to do |format|
#      if @contratossuspencion.update_attributes(params[:contratossuspencion])
#        flash[:notice] = 'Contratossuspencion was successfully updated.'
#        format.html { redirect_to(@contratossuspencion) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @contratossuspencion.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /contratossuspenciones/1
#  # DELETE /contratossuspenciones/1.xml
#  def destroy
#    @contratossuspencion = Contratossuspencion.find(params[:id])
#    @contratossuspencion.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(contratossuspenciones_url) }
#      format.xml  { head :ok }
#    end
#  end
#end
