class AntobservaviviendasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

#  def index
#    @antobservaviviendas = Antobservavivienda.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @antobservaviviendas }
#    end
#  end
#
#  # GET /antobservaviviendas/1
#  # GET /antobservaviviendas/1.xml
#  def show
#    @antobservavivienda = Antobservavivienda.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @antobservavivienda }
#    end
#  end
#
#  # GET /antobservaviviendas/new
#  # GET /antobservaviviendas/new.xml
#  def new
#    @antobservavivienda = Antobservavivienda.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @antobservavivienda }
#    end
#  end
#
#  # GET /antobservaviviendas/1/edit
#  def edit
#    @antobservavivienda = Antobservavivienda.find(params[:id])
#  end
#
#  # POST /antobservaviviendas
#  # POST /antobservaviviendas.xml
#  def create
#    @antobservavivienda = Antobservavivienda.new(params[:antobservavivienda])
#
#    respond_to do |format|
#      if @antobservavivienda.save
#        flash[:notice] = 'Antobservavivienda was successfully created.'
#        format.html { redirect_to(@antobservavivienda) }
#        format.xml  { render :xml => @antobservavivienda, :status => :created, :location => @antobservavivienda }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @antobservavivienda.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /antobservaviviendas/1
#  # PUT /antobservaviviendas/1.xml
#  def update
#    @antobservavivienda = Antobservavivienda.find(params[:id])
#
#    respond_to do |format|
#      if @antobservavivienda.update_attributes(params[:antobservavivienda])
#        flash[:notice] = 'Antobservavivienda was successfully updated.'
#        format.html { redirect_to(@antobservavivienda) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @antobservavivienda.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /antobservaviviendas/1
#  # DELETE /antobservaviviendas/1.xml
#  def destroy
#    @antobservavivienda = Antobservavivienda.find(params[:id])
#    @antobservavivienda.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(antobservaviviendas_url) }
#      format.xml  { head :ok }
#    end
#  end
end
