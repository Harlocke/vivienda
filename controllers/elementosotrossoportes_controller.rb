class ElementosotrossoportesController < ApplicationController
  before_filter :require_user
  before_filter :find_elementosotro_and_elementosotrossoporte

  def index
    @elementosotrossoportes = @elementosotro.elementosotrossoportes.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @elementosotrossoportes }
    end
  end

  def show
    @elementosotrossoporte = Elementosotrossoporte.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @elementosotrossoporte }
    end
  end

  def new
    @elementosotrossoporte = Elementosotrossoporte.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @elementosotrossoporte }
    end
  end

  def edit
    @elementosotrossoporte = Elementosotrossoporte.find(params[:id])
  end

  def create
    @elementosotrossoporte = Elementosotrossoporte.new(params[:elementosotrossoporte])
    @elementosotrossoporte.elementosotro_id = @elementosotro.id
    @elementosotrossoporte.user_id = is_admin
    respond_to do |format|
      if @elementosotrossoporte.save
        format.html { redirect_to img_elementosotrossoportes_path(@elementosotro) }
        format.xml  { render :xml => @elementosotrossoporte, :status => :created, :location => @elementosotrossoporte }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @elementosotrossoporte.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @elementosotrossoporte = Elementosotrossoporte.find(params[:id])
    respond_to do |format|
      if @elementosotrossoporte.update_attributes(params[:elementosotrossoporte])
        format.html { redirect_to img_elementosotrossoportes_url(@elementosotro) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @elementosotrossoporte.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @elementosotrossoporte = Elementosotrossoporte.find(params[:id])
    @elementosotrossoporte.destroy
    respond_to do |format|
      format.html { redirect_to img_elementosotrossoportes_url(@elementosotro) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_elementosotro_and_elementosotrossoporte
      @elementosotro = Elementosotro.find(params[:elementosotro_id])
      @elementosotrossoporte = Elementosotrossoporte.find(params[:id]) if params[:id]
  end
end
