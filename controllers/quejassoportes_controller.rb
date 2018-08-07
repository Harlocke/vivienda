class QuejassoportesController < ApplicationController
  before_filter :require_user
  before_filter :find_quejasobservacion_and_quejassoporte

  def index
    @quejassoportes = @quejasobservacion.quejassoportes.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quejassoportes }
    end
  end

  def show
    @quejassoporte = Quejassoporte.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quejassoporte }
    end
  end

  def new
    @quejassoporte = Quejassoporte.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quejassoporte }
    end
  end

  def edit
    @quejassoporte = Quejassoporte.find(params[:id])
  end

  def create
    @quejassoporte = Quejassoporte.new(params[:quejassoporte])
    @quejassoporte.quejasobservacion_id = @quejasobservacion.id
    @quejassoporte.user_id = is_admin
    respond_to do |format|
      if @quejassoporte.save
        format.html { redirect_to edit_queja_path(@quejasobservacion.queja_id) }
        format.xml  { render :xml => @quejassoporte, :status => :created, :location => @quejassoporte }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quejassoporte.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @quejassoporte = Quejassoporte.find(params[:id])
    @quejassoporte.user_actualiza = is_admin
    respond_to do |format|
      if @quejassoporte.update_attributes(params[:quejassoporte])
        format.html { redirect_to ima_quejassoportes_url(@quejasobservacion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quejassoporte.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @quejassoporte = Quejassoporte.find(params[:id])
    @quejassoporte.destroy
    respond_to do |format|
      format.html { redirect_to ima_quejassoportes_url(@quejasobservacion) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_quejasobservacion_and_quejassoporte
      @quejasobservacion = Quejasobservacion.find(params[:quejasobservacion_id])
      @quejassoporte = Quejassoporte.find(params[:id]) if params[:id]
  end
end
