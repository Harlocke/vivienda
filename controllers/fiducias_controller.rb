class FiduciasController < ApplicationController
  layout :determine_layout
  before_filter :require_user

 def index
    @fiducias =  Fiducia.search(params[:nombre],
                                params[:nro_fondo],
                                params[:nro_contrato],
                                params[:page])    
    if @fiducias.count == 1
    redirect_to edit_fiducia_path(:id=>@fiducias, :etapa=>"1") 
    elsif @fiducias.count == 0
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @fiducias }
      end        
    end
  end

  def show
    @fiducia = Fiducia.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @fiducia }
    end
  end

  def new
    @fiducia = Fiducia.new
    @fiducia.etapa = '1'
    render :action => "fiducia_form"
  end

  def edit
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update fiducias set etapa = '#{params[:etapa]}' where id = #{params[:id]}")
    end
    @fiducia = Fiducia.find(params[:id])
    if @fiducia.etapa.to_s == '2'
      @fiduciascontrato = Fiduciascontrato.new
    elsif @fiducia.etapa.to_s == '3'
      @fiduciaspago = Fiduciaspago.new
    elsif @fiducia.etapa.to_s == '4'
      @fiduciasnota = Fiduciasnota.new
    elsif @fiducia.etapa.to_s == '5'
      @fiduciasdocumento = Fiduciasdocumento.new
    end
    respond_to do |format|
      format.html { render :action => "fiducia_form" }
    end
  end

  def create
    @fiducia = Fiducia.new(params[:fiducia])
    @fiducia.etapa = "1"
    @fiducia.user_id = is_admin
    if @fiducia.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_fiducia_path(@fiducia)
    else
      render :action => "fiducia_form"
    end
  end

  def update
    @fiducia = Fiducia.find(params[:id])
      if @fiducia.update_attributes(params[:fiducia])
        flash[:notice] = "El registro ha sido actualizado con Exito."
        redirect_to edit_fiducia_path(@fiducia, :etapa => "1")
      else
        flash[:notice] = "Error al realizar la actualizacion."
        render :action => "fiducia_form"
      end
  end

  def destroy
    @fiducia = Fiducia.find(params[:id])
    @fiducia.destroy

    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to fiducias_path
        }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if [''].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
