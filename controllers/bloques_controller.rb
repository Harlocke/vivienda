class BloquesController < ApplicationController
before_filter :require_user
  before_filter :find_proyecto_and_bloque

  def index
    @bloques = @proyecto.bloques.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bloques }
    end
  end

  def show
    @bloque = Bloque.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bloque }
    end
  end

  def new
    @bloque = Bloque.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bloque }
    end
  end

  def edit
    @bloque = Bloque.find(params[:id])
  end

  def create
    @bloque = Bloque.new(params[:bloque])
    @bloque.proyecto_id = @proyecto.id
    respond_to do |format|
      if @bloque.save
        format.html { redirect_to proyecto_bloques_path(@proyecto) }
        format.xml  { render :xml => @bloque, :status => :created, :location => @bloque }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bloque.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @bloque = Bloque.find(params[:id])
    respond_to do |format|
      if @bloque.update_attributes(params[:bloque])
        format.html { redirect_to proyecto_bloques_url(@proyecto) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bloque.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @bloque = Bloque.find(params[:id])
    @bloque.destroy
    respond_to do |format|
      format.html { redirect_to proyecto_bloques_url(@proyecto) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_proyecto_and_bloque
      @proyecto = Proyecto.find(params[:proyecto_id])
      @bloque = Bloque.find(params[:id]) if params[:id]
  end

end

#  before_filter :require_user
#
#  def index
#    @bloques = Bloque.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @bloques }
#    end
#  end
#
#  # GET /bloques/1
#  # GET /bloques/1.xml
#  def show
#    @bloque = Bloque.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @bloque }
#    end
#  end
#
#  # GET /bloques/new
#  # GET /bloques/new.xml
#  def new
#    @bloque = Bloque.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @bloque }
#    end
#  end
#
#  # GET /bloques/1/edit
#  def edit
#    @bloque = Bloque.find(params[:id])
#  end
#
#  # POST /bloques
#  # POST /bloques.xml
#  def create
#    @bloque = Bloque.new(params[:bloque])
#
#    respond_to do |format|
#      if @bloque.save
#        flash[:notice] = 'Bloque was successfully created.'
#        format.html { redirect_to(@bloque) }
#        format.xml  { render :xml => @bloque, :status => :created, :location => @bloque }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @bloque.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /bloques/1
#  # PUT /bloques/1.xml
#  def update
#    @bloque = Bloque.find(params[:id])
#
#    respond_to do |format|
#      if @bloque.update_attributes(params[:bloque])
#        flash[:notice] = 'Bloque was successfully updated.'
#        format.html { redirect_to(@bloque) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @bloque.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /bloques/1
#  # DELETE /bloques/1.xml
#  def destroy
#    @bloque = Bloque.find(params[:id])
#    @bloque.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(bloques_url) }
#      format.xml  { head :ok }
#    end
#  end
#end
