class Feria2010jefesController < ApplicationController
before_filter :require_user
  def index
    @feria2010jefes = Feria2010jefe.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feria2010jefes }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @feria2010jefes = persona.feria2010jefes.all
  end

#
#  def show
#    @feria2010jefe = Feria2010jefe.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @feria2010jefe }
#    end
#  end

  def new
    @feria2010jefe = Feria2010jefe.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feria2010jefe }
    end
  end

  def edit
    @feria2010jefe = Feria2010jefe.find(params[:id])
  end

  def create
    @feria2010jefe = Feria2010jefe.new(params[:feria2010jefe])
    respond_to do |format|
      if @feria2010jefe.save
        format.html { redirect_to(@feria2010jefe, :notice => 'Feria2010jefe was successfully created.') }
        format.xml  { render :xml => @feria2010jefe, :status => :created, :location => @feria2010jefe }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feria2010jefe.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @feria2010jefe = Feria2010jefe.find(params[:id])
    respond_to do |format|
      if @feria2010jefe.update_attributes(params[:feria2010jefe])
        format.html { redirect_to(@feria2010jefe, :notice => 'Feria2010jefe was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feria2010jefe.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @feria2010jefe = Feria2010jefe.find(params[:id])
    @feria2010jefe.destroy
    respond_to do |format|
      format.html { redirect_to(feria2010jefes_url) }
      format.xml  { head :ok }
    end
  end
end
