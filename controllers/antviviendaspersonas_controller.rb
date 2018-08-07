class AntviviendaspersonasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

#  def index
#    @antviviendaspersonas = Antviviendaspersona.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @antviviendaspersonas }
#    end
#  end
#
#  # GET /antviviendaspersonas/1
#  # GET /antviviendaspersonas/1.xml
#  def show
#    @antviviendaspersona = Antviviendaspersona.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @antviviendaspersona }
#    end
#  end
#
#  # GET /antviviendaspersonas/new
#  # GET /antviviendaspersonas/new.xml
#  def new
#    @antviviendaspersona = Antviviendaspersona.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @antviviendaspersona }
#    end
#  end
#
#  # GET /antviviendaspersonas/1/edit
#  def edit
#    @antviviendaspersona = Antviviendaspersona.find(params[:id])
#  end
#
#  # POST /antviviendaspersonas
#  # POST /antviviendaspersonas.xml
#  def create
#    @antviviendaspersona = Antviviendaspersona.new(params[:antviviendaspersona])
#
#    respond_to do |format|
#      if @antviviendaspersona.save
#        flash[:notice] = 'Antviviendaspersona was successfully created.'
#        format.html { redirect_to(@antviviendaspersona) }
#        format.xml  { render :xml => @antviviendaspersona, :status => :created, :location => @antviviendaspersona }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @antviviendaspersona.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /antviviendaspersonas/1
#  # PUT /antviviendaspersonas/1.xml
#  def update
#    @antviviendaspersona = Antviviendaspersona.find(params[:id])
#
#    respond_to do |format|
#      if @antviviendaspersona.update_attributes(params[:antviviendaspersona])
#        flash[:notice] = 'Antviviendaspersona was successfully updated.'
#        format.html { redirect_to(@antviviendaspersona) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @antviviendaspersona.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /antviviendaspersonas/1
#  # DELETE /antviviendaspersonas/1.xml
#  def destroy
#    @antviviendaspersona = Antviviendaspersona.find(params[:id])
#    @antviviendaspersona.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(antviviendaspersonas_url) }
#      format.xml  { head :ok }
#    end
#  end
end
