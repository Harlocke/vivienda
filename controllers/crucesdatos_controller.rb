class CrucesdatosController < ApplicationController
  layout :determine_layout
  before_filter :require_user

  def marcar
    @crucesdato = Crucesdato.find(params[:id])
    @crucesdato.ratifica = 'SI'
    @crucesdato.user_ratifica = is_admin
    @crucesdato.save
    flash[:notice] = 'Marcado con exito'
    redirect_to :controller=>"cruces", :action=>"mostrar", :persona_id =>@crucesdato.cruce.persona_id, :id=>1
  end

  def index
    @crucesdatos = Crucesdato.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @crucesdatos }
    end
  end

  def edit
    @crucesdato = Crucesdato.find(params[:id])
    respond_to do |format|
      format.html { render :action => "crucesdato_form" }
    end
  end

  def create
    @crucesdato = Crucesdato.new(params[:crucesdato])
    @crucesdato.user_id = is_admin
    if @crucesdato.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_crucesdato_path(@crucesdato)
    else
      render :action => "crucesdato_form"
    end
  end

  def update
    @crucesdato = Crucesdato.find(params[:id])
    @crucesdato.ratifica = "NO"
    @crucesdato.user_levanta = is_admin
    if @crucesdato.update_attributes(params[:crucesdato])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to :controller=>"cruces", :action=>"mostrar", :persona_id =>@crucesdato.cruce.persona_id, :id=>1
      #redirect_to edit_crucesdato_path(@crucesdato)
    else
      render :action => "crucesdato_form"
    end
    rescue
      redirect_to edit_crucesdato_path(@crucesdato)
  end

  def destroy
    @crucesdato = Crucesdato.find(params[:id])
    @crucesdato.destroy
    respond_to do |format|
      format.html { redirect_to(crucesdatos_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['informecruce','informe'].include?(action_name)
      "atencion"
    else
      "vistacruce"
    end
  end
end