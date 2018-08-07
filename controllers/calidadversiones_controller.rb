class CalidadversionesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @calidadversiones = Calidadversion.find(:all, :order=>"id")
    #flash[:notice] = "Se encontraron varios resultados"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @calidadversiones }
    end
  end

  def listar
      @calidadversiones = Calidadversion.find(:all, :conditions => [' identificacion = ?', "#{params[:search]}"])
      #@calidadversiones = Calidadversion.find(:all, :conditions => [' autobuscar LIKE ?', "%#{params[:search]}%"])
  end

  def new
    @calidadversion = Calidadversion.new
    render :action => "calidadversion_form"
  end

  def edit
    @calidadversion = Calidadversion.find(params[:id])
    respond_to do |format|
      format.html { render :action => "calidadversion_form" }
    end
  end

  def create
    @calidadversion = Calidadversion.new(params[:calidadversion])
    if @calidadversion.save
      flash[:notice] = "Usuario Creado con Exito."
      redirect_to edit_calidadversion_path(@calidadversion)
    else
      render :action => "calidadversion_form"
     end
  end

  def update
    @calidadversion = Calidadversion.find(params[:id])
    if @calidadversion.update_attributes(params[:calidadversion])
     flash[:notice] = "Usuario Actualizado con Exito."
      redirect_to edit_calidadversion_path(@calidadversion)
    else
      render :action => "calidadversion_form"
    end
  end

  def destroy
    @calidadversion = Calidadversion.find(params[:id])
    @calidadversion.destroy
    respond_to do |format|
      format.html { redirect_to(calidadversiones_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['visualizar'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
