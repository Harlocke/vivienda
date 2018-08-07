class AntviviendastramitesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

#  def index
#    @antviviendastramites = Antviviendastramite.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @antviviendastramites }
#    end
#  end
#
#  # GET /antviviendastramites/1
#  # GET /antviviendastramites/1.xml
#  def show
#    @antviviendastramite = Antviviendastramite.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @antviviendastramite }
#    end
#  end
#
#  # GET /antviviendastramites/new
#  # GET /antviviendastramites/new.xml
#  def new
#    @antviviendastramite = Antviviendastramite.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @antviviendastramite }
#    end
#  end
#
#  # GET /antviviendastramites/1/edit
#  def edit
#    @antviviendastramite = Antviviendastramite.find(params[:id])
#  end
#
#  # POST /antviviendastramites
#  # POST /antviviendastramites.xml
#  def create
#    @antviviendastramite = Antviviendastramite.new(params[:antviviendastramite])
#
#    respond_to do |format|
#      if @antviviendastramite.save
#        flash[:notice] = 'Antviviendastramite was successfully created.'
#        format.html { redirect_to(@antviviendastramite) }
#        format.xml  { render :xml => @antviviendastramite, :status => :created, :location => @antviviendastramite }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @antviviendastramite.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /antviviendastramites/1
#  # PUT /antviviendastramites/1.xml
#  def update
#    @antviviendastramite = Antviviendastramite.find(params[:id])
#
#    respond_to do |format|
#      if @antviviendastramite.update_attributes(params[:antviviendastramite])
#        flash[:notice] = 'Antviviendastramite was successfully updated.'
#        format.html { redirect_to(@antviviendastramite) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @antviviendastramite.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /antviviendastramites/1
#  # DELETE /antviviendastramites/1.xml
#  def destroy
#    @antviviendastramite = Antviviendastramite.find(params[:id])
#    @antviviendastramite.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(antviviendastramites_url) }
#      format.xml  { head :ok }
#    end
#  end
end
