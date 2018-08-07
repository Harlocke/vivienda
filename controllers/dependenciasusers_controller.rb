class DependenciasusersController < ApplicationController
  before_filter :find_dependencia_and_dependenciasuser
  before_filter :require_user

  def index
    @dependenciasusers = @dependencia.dependenciasusers.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @dependenciasusers }
    end
  end

  def show
    @dependenciasuser = Dependenciasuser.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dependenciasuser }
    end
  end

  def new
    @dependenciasuser = Dependenciasuser.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @dependenciasuser }
    end
  end

  def edit
    @dependenciasuser = Dependenciasuser.find(params[:id])
  end

  def create
    @dependenciasuser = Dependenciasuser.new(params[:dependenciasuser])
    @dependenciasuser.dependencia_id = @dependencia.id
    respond_to do |format|
      if @dependenciasuser.save
        format.html { redirect_to dependencia_dependenciasusers_path(@dependencia) }
        format.xml  { render :xml => @dependenciasuser, :status => :created, :location => @dependenciasuser }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dependenciasuser.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @dependenciasuser = Dependenciasuser.find(params[:id])
    respond_to do |format|
      if @dependenciasuser.update_attributes(params[:dependenciasuser])
        format.html { redirect_to dependencia_dependenciasusers_url(@dependencia) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dependenciasuser.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @dependenciasuser = Dependenciasuser.find(params[:id])
    @dependenciasuser.destroy
    respond_to do |format|
      format.html { redirect_to dependencia_dependenciasusers_url(@dependencia) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_dependencia_and_dependenciasuser
      @dependencia = Dependencia.find(params[:dependencia_id])
      @dependenciasuser = Dependenciasuser.find(params[:id]) if params[:id]
  end

end
