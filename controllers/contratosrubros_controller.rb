class ContratosrubrosController < ApplicationController

  before_filter :require_user
  before_filter :find_contrato_and_contratosrubro

  def index
    @contratosrubros = @contrato.contratosrubros.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contratosrubros }
    end
  end

  def show
    @contratosrubro = Contratosrubro.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contratosrubro }
    end
  end

  def new
    @contratosrubro = Contratosrubro.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contratosrubro }
    end
  end

  def edit
    @contratosrubro = Contratosrubro.find(params[:id])
  end

  def create
    @contratosrubro = Contratosrubro.new(params[:contratosrubro])
    @contratosrubro.contrato_id = @contrato.id
    @contratosrubro.user_id = is_admin
    respond_to do |format|
      if @contratosrubro.save
        format.html { redirect_to rub_contratosrubros_path(@contrato) }
        format.xml  { render :xml => @contratosrubro, :status => :created, :location => @contratosrubro }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contratosrubro.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @contratosrubro = Contratosrubro.find(params[:id])
    @contratosrubro.user_actualiza = is_admin
    respond_to do |format|
      if @contratosrubro.update_attributes(params[:contratosrubro])
        format.html { redirect_to rub_contratosrubros_url(@contrato) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contratosrubro.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @contratosrubro = Contratosrubro.find(params[:id])
    @contratosrubro.destroy
    respond_to do |format|
      format.html { redirect_to rub_contratosrubros_url(@contrato) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_contrato_and_contratosrubro
      @contrato = Contrato.find(params[:contrato_id])
      @contratosrubro = Contratosrubro.find(params[:id]) if params[:id]
  end
end

  #  # GET /contratosrubros
#  # GET /contratosrubros.xml
#  def index
#    @contratosrubros = Contratosrubro.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @contratosrubros }
#    end
#  end
#
#  # GET /contratosrubros/1
#  # GET /contratosrubros/1.xml
#  def show
#    @contratosrubro = Contratosrubro.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @contratosrubro }
#    end
#  end
#
#  # GET /contratosrubros/new
#  # GET /contratosrubros/new.xml
#  def new
#    @contratosrubro = Contratosrubro.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @contratosrubro }
#    end
#  end
#
#  # GET /contratosrubros/1/edit
#  def edit
#    @contratosrubro = Contratosrubro.find(params[:id])
#  end
#
#  # POST /contratosrubros
#  # POST /contratosrubros.xml
#  def create
#    @contratosrubro = Contratosrubro.new(params[:contratosrubro])
#
#    respond_to do |format|
#      if @contratosrubro.save
#        format.html { redirect_to(@contratosrubro, :notice => 'Contratosrubro was successfully created.') }
#        format.xml  { render :xml => @contratosrubro, :status => :created, :location => @contratosrubro }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @contratosrubro.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /contratosrubros/1
#  # PUT /contratosrubros/1.xml
#  def update
#    @contratosrubro = Contratosrubro.find(params[:id])
#
#    respond_to do |format|
#      if @contratosrubro.update_attributes(params[:contratosrubro])
#        format.html { redirect_to(@contratosrubro, :notice => 'Contratosrubro was successfully updated.') }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @contratosrubro.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /contratosrubros/1
#  # DELETE /contratosrubros/1.xml
#  def destroy
#    @contratosrubro = Contratosrubro.find(params[:id])
#    @contratosrubro.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(contratosrubros_url) }
#      format.xml  { head :ok }
#    end
#  end
#end
