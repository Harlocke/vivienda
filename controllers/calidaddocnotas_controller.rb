class CalidaddocnotasController < ApplicationController

  before_filter :require_user
  before_filter :find_calidaddocumento_and_calidaddocnota

  def index
    @calidaddocnotas = @calidaddocumento.calidaddocnotas.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @calidaddocnotas }
    end
  end

  def show
    @calidaddocnota = Calidaddocnota.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @calidaddocnota }
    end
  end

  def new
    @calidaddocnota = Calidaddocnota.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @calidaddocnota }
    end
  end

  def edit
    @calidaddocnota = Calidaddocnota.find(params[:id])
  end

  def create
    @calidaddocnota = Calidaddocnota.new(params[:calidaddocnota])
    @calidaddocnota.calidaddocumento_id = @calidaddocumento.id
    @calidaddocnota.user_id = is_admin
    calidaddocumento = Calidaddocumento.find(@calidaddocnota.calidaddocumento_id)
    valor = '- DOCUMENTO: ' + @calidaddocumento.nombre.to_s
    valor1 = ""
    if calidaddocumento.version
       valor1 = 'Versión ('+calidaddocumento.version.to_s+')'
    end
    valor = valor.to_s + ' ' + valor1.to_s
    @calidaddocnota.observaciones = @calidaddocnota.observaciones.to_s + ' ' + valor.to_s
    respond_to do |format|
      if @calidaddocnota.save
        flash[:notice] = "La observacion ha sido registrada con Exito."
        format.html {  redirect_to edit_calidadproceso_path(@calidaddocumento.calidadproceso_id) }
        format.xml  { render :xml => @calidaddocnota, :status => :created, :location => @calidaddocnota }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @calidaddocnota.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @calidaddocnota = Calidaddocnota.find(params[:id])
    @calidaddocnota.user_actualiza = is_admin
    respond_to do |format|
      if @calidaddocnota.update_attributes(params[:calidaddocnota])
        format.html { redirect_to nota_calidaddocnotas_url(@calidaddocumento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @calidaddocnota.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @calidaddocnota = Calidaddocnota.find(params[:id])
    @calidaddocnota.destroy
    respond_to do |format|
      format.html { redirect_to nota_calidaddocnotas_url(@calidaddocumento) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_calidaddocumento_and_calidaddocnota
      @calidaddocumento = Calidaddocumento.find(params[:calidaddocumento_id])
      @calidaddocnota = Calidaddocnota.find(params[:id]) if params[:id]
  end
end
