class AyudastiposeventosController < ApplicationController
  # GET /ayudastiposeventos
  # GET /ayudastiposeventos.xml
  def index
    @ayudastiposeventos = Ayudastiposevento.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ayudastiposeventos }
    end
  end

  # GET /ayudastiposeventos/1
  # GET /ayudastiposeventos/1.xml
  def show
    @ayudastiposevento = Ayudastiposevento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ayudastiposevento }
    end
  end

  # GET /ayudastiposeventos/new
  # GET /ayudastiposeventos/new.xml
  def new
    @ayudastiposevento = Ayudastiposevento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ayudastiposevento }
    end
  end

  # GET /ayudastiposeventos/1/edit
  def edit
    @ayudastiposevento = Ayudastiposevento.find(params[:id])
  end

  # POST /ayudastiposeventos
  # POST /ayudastiposeventos.xml
  def create
    @ayudastiposevento = Ayudastiposevento.new(params[:ayudastiposevento])

    respond_to do |format|
      if @ayudastiposevento.save
        flash[:notice] = 'Ayudastiposevento was successfully created.'
        format.html { redirect_to(@ayudastiposevento) }
        format.xml  { render :xml => @ayudastiposevento, :status => :created, :location => @ayudastiposevento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ayudastiposevento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ayudastiposeventos/1
  # PUT /ayudastiposeventos/1.xml
  def update
    @ayudastiposevento = Ayudastiposevento.find(params[:id])

    respond_to do |format|
      if @ayudastiposevento.update_attributes(params[:ayudastiposevento])
        flash[:notice] = 'Ayudastiposevento was successfully updated.'
        format.html { redirect_to(@ayudastiposevento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ayudastiposevento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ayudastiposeventos/1
  # DELETE /ayudastiposeventos/1.xml
  def destroy
    @ayudastiposevento = Ayudastiposevento.find(params[:id])
    @ayudastiposevento.destroy

    respond_to do |format|
      format.html { redirect_to(ayudastiposeventos_url) }
      format.xml  { head :ok }
    end
  end
end
