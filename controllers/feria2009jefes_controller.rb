class Feria2009jefesController < ApplicationController
  before_filter :require_user

  def index
    @feria2009jefes = Feria2009jefe.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feria2009jefes }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @feria2009jefes = persona.feria2009jefes.all
  end

#  def show
#    @feria2009jefe = Feria2009jefe.find(params[:id])
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @feria2009jefe }
#    end
#  end

  def new
    @feria2009jefe = Feria2009jefe.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feria2009jefe }
    end
  end

  def create
    @feria2009jefe = Feria2009jefe.new(params[:feria2009jefe])
    respond_to do |format|
      if @feria2009jefe.save
        format.html { redirect_to(@feria2009jefe, :notice => 'Feria2009jefe was successfully created.') }
        format.xml  { render :xml => @feria2009jefe, :status => :created, :location => @feria2009jefe }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feria2009jefe.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @feria2009jefe = Feria2009jefe.find(params[:id])
    respond_to do |format|
      if @feria2009jefe.update_attributes(params[:feria2009jefe])
        format.html { redirect_to(@feria2009jefe, :notice => 'Feria2009jefe was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feria2009jefe.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @feria2009jefe = Feria2009jefe.find(params[:id])
    @feria2009jefe.destroy

    respond_to do |format|
      format.html { redirect_to(feria2009jefes_url) }
      format.xml  { head :ok }
    end
  end
end
