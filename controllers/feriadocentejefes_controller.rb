class FeriadocentejefesController < ApplicationController
  before_filter :require_user

  def index
    @feriadocentejefes = Feriadocentejefe.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feriadocentejefes }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @feriadocentejefes = persona.feriadocentejefes.all
  end

  def new
    @feriadocentejefe = Feriadocentejefe.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feriadocentejefe }
    end
  end

  def edit
    @feriadocentejefe = Feriadocentejefe.find(params[:id])
  end

  def create
    @feriadocentejefe = Feriadocentejefe.new(params[:feriadocentejefe])
    respond_to do |format|
      if @feriadocentejefe.save
        format.html { redirect_to(@feriadocentejefe, :notice => 'Feriadocentejefe was successfully created.') }
        format.xml  { render :xml => @feriadocentejefe, :status => :created, :location => @feriadocentejefe }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feriadocentejefe.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @feriadocentejefe = Feriadocentejefe.find(params[:id])
    respond_to do |format|
      if @feriadocentejefe.update_attributes(params[:feriadocentejefe])
        format.html { redirect_to(@feriadocentejefe, :notice => 'Feriadocentejefe was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feriadocentejefe.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @feriadocentejefe = Feriadocentejefe.find(params[:id])
    @feriadocentejefe.destroy
    respond_to do |format|
      format.html { redirect_to(feriadocentejefes_url) }
      format.xml  { head :ok }
    end
  end
end
