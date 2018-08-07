class ContratospagosController < ApplicationController
  before_filter :require_user
  before_filter :find_contrato_and_contratospago

  def index
    @contratospagos = @contrato.contratospagos.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contratospagos }
    end
  end

  def show
    @contratospago = Contratospago.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contratospago }
    end
  end

  def new
    tipopago = params[:tipo]
    @contratospago = Contratospago.new
    @contratospago.tipo_pago =tipopago
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contratospago }
    end
  end

  def edit
    @contratospago = Contratospago.find(params[:id])
  end

  def create
    @contratospago = Contratospago.new(params[:contratospago])
    @contratospago.contrato_id = @contrato.id
    @contratospago.user_id = is_admin
    respond_to do |format|
      if @contratospago.save
        format.html { redirect_to pag_contratospagos_path(@contrato) }
        format.xml  { render :xml => @contratospago, :status => :created, :location => @contratospago }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contratospago.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @contratospago = Contratospago.find(params[:id])
    @contratospago.user_actualiza = is_admin
    respond_to do |format|
      if @contratospago.update_attributes(params[:contratospago])
        format.html { redirect_to pag_contratospagos_url(@contrato) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contratospago.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @contratospago = Contratospago.find(params[:id])
    @contratospago.destroy
    respond_to do |format|
      format.html { redirect_to pag_contratospagos_url(@contrato) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_contrato_and_contratospago
      @contrato = Contrato.find(params[:contrato_id])
      @contratospago = Contratospago.find(params[:id]) if params[:id]
  end
end
