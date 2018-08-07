class ContratosobservacionesController < ApplicationController
  before_filter :require_user
  before_filter :find_contrato_and_contratosobservacion

  def index
    @contratosobservaciones = @contrato.contratosobservaciones.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contratosobservaciones }
    end
  end

  def show
    @contratosobservacion = Contratosobservacion.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contratosobservacion }
    end
  end

  def new
    @contratosobservacion = Contratosobservacion.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contratosobservacion }
    end
  end

  def edit
    @contratosobservacion = Contratosobservacion.find(params[:id])
  end

  def create
    @contratosobservacion = Contratosobservacion.new(params[:contratosobservacion])
    @contratosobservacion.contrato_id = @contrato.id
    @contratosobservacion.user_id = is_admin
    respond_to do |format|
      if @contratosobservacion.save
        format.html { redirect_to obs_contratosobservaciones_path(@contrato) }
        format.xml  { render :xml => @contratosobservacion, :status => :created, :location => @contratosobservacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contratosobservacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @contratosobservacion = Contratosobservacion.find(params[:id])
    @contratosobservacion.user_actualiza = is_admin
    respond_to do |format|
      if @contratosobservacion.update_attributes(params[:contratosobservacion])
        format.html { redirect_to obs_contratosobservaciones_url(@contrato) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contratosobservacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @contratosobservacion = Contratosobservacion.find(params[:id])
    @contratosobservacion.destroy
    respond_to do |format|
      format.html { redirect_to obs_contratosobservaciones_url(@contrato) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_contrato_and_contratosobservacion
      @contrato = Contrato.find(params[:contrato_id])
      @contratosobservacion = Contratosobservacion.find(params[:id]) if params[:id]
  end
end
