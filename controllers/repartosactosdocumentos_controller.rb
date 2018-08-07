class RepartosactosdocumentosController < ApplicationController
  before_filter :require_user
  before_filter :find_repartosacto_and_repartosactosdocumento

  def index
    repartosacto   = Repartosacto.find(params[:repartosacto_id])
    @repartosactosdocumentos = repartosacto.repartosactosdocumentos.all
  end

  def new
    @repartosactosdocumento = Repartosactosdocumento.new
    @repartosactosdocumento.tiposactosdocumento_id = params[:tiposactosdocumento_id]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @repartosactosdocumento }
    end
  end

  def edit
    @repartosactosdocumento  = Repartosactosdocumento.find(params[:id], :include => "repartosacto")
    @repartosacto  = @repartosactosdocumento.repartosacto
    respond_to do |format|
      format.js { render :action => "edit_repartosactosdocumento" }
    end
  end

  def create
    @repartosactosdocumento = Repartosactosdocumento.new(params[:repartosactosdocumento])
    @repartosactosdocumento.repartosacto_id = @repartosacto.id
    @repartosactosdocumento.user_id = is_admin
    respond_to do |format|
      if @repartosactosdocumento.save
        flash[:notice] = "Documento Cargado con Exito."
        format.html { redirect_to edit_reparto_path(@repartosacto.reparto_id) }
        format.xml  { render :xml => @repartosactosdocumento, :status => :created, :location => @repartosactosdocumento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @repartosactosdocumento.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @repartosactosdocumento        = Repartosactosdocumento.new
    repartosactosdocumento         = Repartosactosdocumento.find(params[:id])
    @repartosacto        = repartosactosdocumento.repartosacto
  ok = repartosactosdocumento.update_attributes(params[:repartosactosdocumento])
  flash[:repartosactosdocumento] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
  @tit = Repartosactosdocumento.find(params[:id])
  respond_to do |format|
  format.js { render :action => "repartosactosdocumentos" }
  end
  end

  def destroy
    repartosactosdocumento   = Repartosactosdocumento.find(params[:id])
    @repartosacto         = repartosactosdocumento.repartosacto
    @repartosactosdocumento  = Repartosactosdocumento.new
    repartosactosdocumento.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end

  def find_repartosacto_and_repartosactosdocumento
      @repartosacto = Repartosacto.find(params[:repartosacto_id])
      @repartosactosdocumento = Repartosactosdocumento.find(params[:id]) if params[:id]
  end
end