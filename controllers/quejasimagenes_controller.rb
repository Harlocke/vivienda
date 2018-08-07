class QuejasimagenesController < ApplicationController

  before_filter :require_user
  before_filter :find_queja_and_quejasimagen

  def index
    queja   = Queja.find(params[:queja_id])
    @quejasimagenes = queja.quejasimagenes.all
  end

  def new
    @quejasimagen = Quejasimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quejasimagen }
    end
  end

  def create
    @quejasimagen = Quejasimagen.new(params[:quejasimagen])
    @quejasimagen.queja_id = @queja.id
    @quejasimagen.user_id = is_admin
    respond_to do |format|
      if @quejasimagen.save
        format.html { redirect_to edit_queja_path(@queja) }
        format.xml  { render :xml => @quejasimagen, :status => :created, :location => @quejasimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quejasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @quejasimagen = Quejasimagen.find(params[:id])
    respond_to do |format|
      if @quejasimagen.update_attributes(params[:quejasimagen])
        format.html { redirect_to queja_quejasimagenes_path(@queja) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quejasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    quejasimagen   = Quejasimagen.find(params[:id])
    @queja         = quejasimagen.queja
    @quejasimagen  = Quejasimagen.new
    quejasimagen.destroy
    respond_to do |format|
      format.js { render :action => "quejasimagenes" }
    end
  end

  def find_queja_and_quejasimagen
      @queja = Queja.find(params[:queja_id])
      @quejasimagen = Quejasimagen.find(params[:id]) if params[:id]
  end

end
