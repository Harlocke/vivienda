class ElementossoportesController < ApplicationController
  before_filter :require_user
  before_filter :find_elemento_and_elementossoporte

  def index
    elemento   = Elemento.find(params[:elemento_id])
    @elementossoportes = elemento.elementossoportes.all
  end

  def new
    @elementossoporte = Elementossoporte.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @elementossoporte }
    end
  end

  def create
    @elementossoporte = Elementossoporte.new(params[:elementossoporte])
    @elementossoporte.elemento_id = @elemento.id
    @elementossoporte.user_id = is_admin
    respond_to do |format|
      if @elementossoporte.save
        is_trigger_tit(@elemento.id,is_admin,'elementossoporte','I')
        format.html { redirect_to edit_elemento_path(@elemento) }
        format.xml  { render :xml => @elementossoporte, :status => :created, :location => @elementossoporte }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @elementossoporte.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @elementossoporte = Elementossoporte.find(params[:id])
    respond_to do |format|
      if @elementossoporte.update_attributes(params[:elementossoporte])
        format.html { redirect_to elemento_elementossoportes_path(@elemento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @elementossoporte.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    elementossoporte   = Elementossoporte.find(params[:id])
    @elemento          = elementossoporte.elemento
    @elementossoporte  = Elementossoporte.new
    elementossoporte.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end

  def find_elemento_and_elementossoporte
      @elemento = Elemento.find(params[:elemento_id])
      @elementossoporte = Elementossoporte.find(params[:id]) if params[:id]
  end
end