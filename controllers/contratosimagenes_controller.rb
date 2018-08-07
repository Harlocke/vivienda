class ContratosimagenesController < ApplicationController

  before_filter :require_user
  before_filter :find_contrato_and_contratosimagen

  def index
    @contratosimagenes = @contrato.contratosimagenes.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contratosimagenes }
    end
  end

  def show
    @contratosimagen = Contratosimagen.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contratosimagen }
    end
  end

  def new
    @contratosimagen = Contratosimagen.new
    @contratosimagen.contrato_id = params[:contrato_id]
    @contratosimagen.descripcion = params[:descripcion]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contratosimagen }
    end
  end

  def edit
    @contratosimagen = Contratosimagen.find(params[:id])
  end

  def create
    @contratosimagen = Contratosimagen.new(params[:contratosimagen])
    @contratosimagen.contrato_id = @contrato.id
    @contratosimagen.user_id = is_admin
    respond_to do |format|
      if @contratosimagen.save
        #format.html { redirect_to img_contratosimagenes_path(@contrato) }
        format.html { redirect_to interventorias_path }
        format.xml  { render :xml => @contratosimagen, :status => :created, :location => @contratosimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contratosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @contratosimagen = Contratosimagen.find(params[:id])
    respond_to do |format|
      if @contratosimagen.update_attributes(params[:contratosimagen])
        format.html { redirect_to img_contratosimagenes_url(@contrato) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contratosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @contratosimagen = Contratosimagen.find(params[:id])
    @contratosimagen.destroy
    respond_to do |format|
      format.html { redirect_to img_contratosimagenes_url(@contrato) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_contrato_and_contratosimagen
      @contrato = Contrato.find(params[:contrato_id])
      @contratosimagen = Contratosimagen.find(params[:id]) if params[:id]
  end
end

#  # GET /contratosimagenes
#  # GET /contratosimagenes.xml
#  def index
#    @contratosimagenes = Contratosimagen.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @contratosimagenes }
#    end
#  end
#
#  # GET /contratosimagenes/1
#  # GET /contratosimagenes/1.xml
#  def show
#    @contratosimagen = Contratosimagen.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @contratosimagen }
#    end
#  end
#
#  # GET /contratosimagenes/new
#  # GET /contratosimagenes/new.xml
#  def new
#    @contratosimagen = Contratosimagen.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @contratosimagen }
#    end
#  end
#
#  # GET /contratosimagenes/1/edit
#  def edit
#    @contratosimagen = Contratosimagen.find(params[:id])
#  end
#
#  # POST /contratosimagenes
#  # POST /contratosimagenes.xml
#  def create
#    @contratosimagen = Contratosimagen.new(params[:contratosimagen])
#
#    respond_to do |format|
#      if @contratosimagen.save
#        format.html { redirect_to(@contratosimagen, :notice => 'Contratosimagen was successfully created.') }
#        format.xml  { render :xml => @contratosimagen, :status => :created, :location => @contratosimagen }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @contratosimagen.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /contratosimagenes/1
#  # PUT /contratosimagenes/1.xml
#  def update
#    @contratosimagen = Contratosimagen.find(params[:id])
#
#    respond_to do |format|
#      if @contratosimagen.update_attributes(params[:contratosimagen])
#        format.html { redirect_to(@contratosimagen, :notice => 'Contratosimagen was successfully updated.') }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @contratosimagen.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /contratosimagenes/1
#  # DELETE /contratosimagenes/1.xml
#  def destroy
#    @contratosimagen = Contratosimagen.find(params[:id])
#    @contratosimagen.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(contratosimagenes_url) }
#      format.xml  { head :ok }
#    end
#  end
#end
