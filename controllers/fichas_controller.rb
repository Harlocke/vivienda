class FichasController < ApplicationController

  before_filter :require_user

  def index
    @fichas = Ficha.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fichas }
    end
  end

  def show
    @ficha = Ficha.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ficha }
    end
  end

  def new
    @ficha = Ficha.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ficha }
    end
  end

  def edit
    @ficha = Ficha.find(params[:id])
  end

  def edit_individual
      @fichas = Ficha.find(:all, :conditions => ['proyecto_id = ?', params[:proyecto_id]], :order => 'fichaselemento_id')
      #@fichaselemento = Fichaselemento.find
      #@fichas = Ficha.find_all_by_proyecto_id(params[:proyecto_id])
  end

  def update_individual
    Ficha.update(params[:fichas].keys, params[:fichas].values)
    flash[:notice] = "La Ficha ha sido Actualizada con Exito."
    redirect_to proyectos_url
  end

  def create
    @ficha = Ficha.new(params[:ficha])
    respond_to do |format|
      if @ficha.save
        format.html { redirect_to(@ficha, :notice => 'Ficha was successfully created.') }
        format.xml  { render :xml => @ficha, :status => :created, :location => @ficha }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ficha.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @ficha = Ficha.find(params[:id])
    respond_to do |format|
      if @ficha.update_attributes(params[:ficha])
        format.html { redirect_to(@ficha, :notice => 'Ficha was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ficha.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @ficha = Ficha.find(params[:id])
    @ficha.destroy
    respond_to do |format|
      format.html { redirect_to(fichas_url) }
      format.xml  { head :ok }
    end
  end
end
