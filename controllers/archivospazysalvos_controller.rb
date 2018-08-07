class ArchivospazysalvosController < ApplicationController
  before_filter :require_user
  layout :determine_layout
  # GET /archivospazysalvos
  # GET /archivospazysalvos.xml
  def index
    @archivospazysalvos = Archivospazysalvo.find(:all, :order => "created_at desc")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @archivospazysalvos }
    end
  end

  # GET /archivospazysalvos/1
  # GET /archivospazysalvos/1.xml
  def show
    @archivospazysalvo = Archivospazysalvo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @archivospazysalvo }
    end
  end

  # GET /archivospazysalvos/new
  # GET /archivospazysalvos/new.xml
  def new
    @archivospazysalvo = Archivospazysalvo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @archivospazysalvo }
    end
  end

  # GET /archivospazysalvos/1/edit
  def edit
    @archivospazysalvo = Archivospazysalvo.find(params[:id])
  end

  # POST /archivospazysalvos
  # POST /archivospazysalvos.xml
  def create
    @archivospazysalvo = Archivospazysalvo.new(params[:archivospazysalvo])

    respond_to do |format|
      if @archivospazysalvo.save
        format.html { redirect_to(@archivospazysalvo, :notice => 'Archivospazysalvo was successfully created.') }
        format.xml  { render :xml => @archivospazysalvo, :status => :created, :location => @archivospazysalvo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @archivospazysalvo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /archivospazysalvos/1
  # PUT /archivospazysalvos/1.xml
  def update
    @archivospazysalvo = Archivospazysalvo.find(params[:id])

    respond_to do |format|
      if @archivospazysalvo.update_attributes(params[:archivospazysalvo])
        format.html { redirect_to(@archivospazysalvo, :notice => 'Archivospazysalvo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @archivospazysalvo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /archivospazysalvos/1
  # DELETE /archivospazysalvos/1.xml
  def destroy
    @archivospazysalvo = Archivospazysalvo.find(params[:id])
    @archivospazysalvo.destroy

    respond_to do |format|
      format.html { redirect_to(archivospazysalvos_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['index'].include?(action_name)
      "application"
    end
  end
end
