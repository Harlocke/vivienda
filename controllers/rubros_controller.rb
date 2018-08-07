class RubrosController < ApplicationController
  before_filter :require_user
  layout :determine_layout
  
  def index
    @rubros = Rubro.searchv(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rubros }
    end
  end


  def new
    @rubro = Rubro.new
    render :action => "rubro_form"
  end


  def edit
    @rubro = Rubro.find(params[:id])
    respond_to do |format|
      format.html { render :action => "rubro_form" }
    end
  end

  def create
    @rubro = Rubro.new(params[:rubro])
    if params[:rubro][:fecha_nacimiento].to_d <= '1970-01-01'.to_d
      fecha = params[:rubro][:fecha_nacimiento]
    end
    if @rubro.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_rubro_path(@rubro)
    else
      render :action => "rubro_form"
    end
  end

  def update
    @rubro = Rubro.find(params[:id])
    if @rubro.update_attributes(params[:rubro])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_rubro_path(@rubro)
    else
      render :action => "rubro_form"
    end
    #rescue
     # redirect_to edit_rubro_path(@rubro)
  end

  def destroy
    @rubro = Rubro.find(params[:id])
    @rubro.destroy
    respond_to do |format|
      format.html { redirect_to(rubros_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['certificado'].include?(action_name)
      "new2"
    else
      "application"
    end
  end

end
