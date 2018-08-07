class ComunasController < ApplicationController
  before_filter :require_user

  def listar
    @comunas = Comuna.find(:all, :conditions => [" descripcion2 like '%%#{is_replacespace(params[:search].upcase.to_s)}%%'"], :order=>"descripcion2")
  end

  def index
    @comunas = Comuna.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comunas }
    end
  end

  def show
    @comuna = Comuna.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comuna }
    end
  end

  def new
    @comuna = Comuna.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comuna }
    end
  end

  def edit
    @comuna = Comuna.find(params[:id])
  end

  def create
    @comuna = Comuna.new(params[:comuna])
    respond_to do |format|
      if @comuna.save
        flash[:notice] = 'Comuna was successfully created.'
        format.html { redirect_to(@comuna) }
        format.xml  { render :xml => @comuna, :status => :created, :location => @comuna }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comuna.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @comuna = Comuna.find(params[:id])
    respond_to do |format|
      if @comuna.update_attributes(params[:comuna])
        flash[:notice] = 'Comuna was successfully updated.'
        format.html { redirect_to(@comuna) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comuna.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @comuna = Comuna.find(params[:id])
    @comuna.destroy
    respond_to do |format|
      format.html { redirect_to(comunas_url) }
      format.xml  { head :ok }
    end
  end
end
