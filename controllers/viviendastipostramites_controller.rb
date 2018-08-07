class ViviendastipostramitesController < ApplicationController
  before_filter :require_user

  # GET /viviendastipostramites
  # GET /viviendastipostramites.xml
  def index
    @viviendastipostramites = Viviendastipostramite.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @viviendastipostramites }
    end
  end

  # GET /viviendastipostramites/1
  # GET /viviendastipostramites/1.xml
  def show
    @viviendastipostramite = Viviendastipostramite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @viviendastipostramite }
    end
  end

  # GET /viviendastipostramites/new
  # GET /viviendastipostramites/new.xml
  def new
    @viviendastipostramite = Viviendastipostramite.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @viviendastipostramite }
    end
  end

  # GET /viviendastipostramites/1/edit
  def edit
    @viviendastipostramite = Viviendastipostramite.find(params[:id])
  end

  # POST /viviendastipostramites
  # POST /viviendastipostramites.xml
  def create
    @viviendastipostramite = Viviendastipostramite.new(params[:viviendastipostramite])

    respond_to do |format|
      if @viviendastipostramite.save
        flash[:notice] = 'Viviendastipostramite was successfully created.'
        format.html { redirect_to(@viviendastipostramite) }
        format.xml  { render :xml => @viviendastipostramite, :status => :created, :location => @viviendastipostramite }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @viviendastipostramite.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /viviendastipostramites/1
  # PUT /viviendastipostramites/1.xml
  def update
    @viviendastipostramite = Viviendastipostramite.find(params[:id])

    respond_to do |format|
      if @viviendastipostramite.update_attributes(params[:viviendastipostramite])
        flash[:notice] = 'Viviendastipostramite was successfully updated.'
        format.html { redirect_to(@viviendastipostramite) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @viviendastipostramite.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /viviendastipostramites/1
  # DELETE /viviendastipostramites/1.xml
  def destroy
    @viviendastipostramite = Viviendastipostramite.find(params[:id])
    @viviendastipostramite.destroy

    respond_to do |format|
      format.html { redirect_to(viviendastipostramites_url) }
      format.xml  { head :ok }
    end
  end
end
