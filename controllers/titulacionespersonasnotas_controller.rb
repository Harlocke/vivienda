class TitulacionespersonasnotasController < ApplicationController

  before_filter :require_user
  before_filter :find_titulacionespersona_and_titulacionespersonasnota

  def index
    @titulacionespersonasnotas = @titulacionespersona.titulacionespersonasnotas.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @titulacionespersonasnotas }
    end
  end

  def show
    @titulacionespersonasnota = Titulacionespersonasnota.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @titulacionespersonasnota }
    end
  end

  def new
    @titulacionespersonasnota = Titulacionespersonasnota.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @titulacionespersonasnota }
    end
  end

  def edit
    @titulacionespersonasnota = Titulacionespersonasnota.find(params[:id])
  end

  def create
    @titulacionespersonasnota = Titulacionespersonasnota.new(params[:titulacionespersonasnota])
    @titulacionespersonasnota.titulacionespersona_id = @titulacionespersona.id
    @titulacionespersonasnota.user_id = is_admin
    respond_to do |format|
      if @titulacionespersonasnota.save
        is_trigger_tit(@titulacionespersona.titulacion_id,is_admin,'titulacionespersonasnota','A')
        flash[:notice] = "La observacion ha sido registrada con Exito."
        format.html {  redirect_to edit_titulacion_path(@titulacionespersona.titulacion_id) }
        format.xml  { render :xml => @titulacionespersonasnota, :status => :created, :location => @titulacionespersonasnota }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @titulacionespersonasnota.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @titulacionespersonasnota = Titulacionespersonasnota.find(params[:id])
    @titulacionespersonasnota.user_actualiza = is_admin
    respond_to do |format|
      if @titulacionespersonasnota.update_attributes(params[:titulacionespersonasnota])
        format.html { redirect_to nota_titulacionespersonasnotas_url(@titulacionespersona) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @titulacionespersonasnota.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @titulacionespersonasnota = Titulacionespersonasnota.find(params[:id])
    @titulacionespersonasnota.destroy
    respond_to do |format|
      format.html { redirect_to nota_titulacionespersonasnotas_url(@titulacionespersona) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_titulacionespersona_and_titulacionespersonasnota
      @titulacionespersona = Titulacionespersona.find(params[:titulacionespersona_id])
      @titulacionespersonasnota = Titulacionespersonasnota.find(params[:id]) if params[:id]
  end
end
