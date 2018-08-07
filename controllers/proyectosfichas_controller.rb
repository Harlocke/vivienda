class ProyectosfichasController < ApplicationController

  before_filter :require_user
  layout :determine_layout
  # GET /proyectosfichas
  # GET /proyectosfichas.xml
  def index
    @proyectosfichas = Proyectosficha.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @proyectosfichas }
    end
  end

  # GET /proyectosfichas/1
  # GET /proyectosfichas/1.xml
  def show
    @proyectosficha = Proyectosficha.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def visualizar
    @proyectosficha = Proyectosficha.find(params[:id])
  end

  def export
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="report.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @proyectosficha = Proyectosficha.find(params[:id])
  end

  # GET /proyectosfichas/new
  # GET /proyectosfichas/new.xml
  def new
    @proyectosficha = Proyectosficha.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proyectosficha }
    end
  end

  def edit
    @proyectosficha = Proyectosficha.find_by_proyecto_id(params[:proyecto_id])
    @proyecto = Proyecto.find(params[:proyecto_id])
  end

  def edit2
    #@proyectosficha = Persona.find(params[:id])
    @proyectosficha = Proyectosficha.find_by_proyecto_id(params[:id])
    #@proyectosfichas = Proyectosficha.find(:all, :conditions => ['proyecto_id = ?', params[:proyecto_id]])
  end

  # POST /proyectosfichas
  # POST /proyectosfichas.xml
  def create
    @proyectosficha = Proyectosficha.new(params[:proyectosficha])
    respond_to do |format|
      if @proyectosficha.save
        flash[:notice] = 'Proyectosficha was successfully created.'
        format.html { redirect_to(@proyectosficha) }
        format.xml  { render :xml => @proyectosficha, :status => :created, :location => @proyectosficha }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @proyectosficha.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update2
    @proyectosficha = Proyectosficha.find(params[:id])
    @proyectosficha.user_id = is_admin
    if @proyectosficha.update_attributes(params[:proyectosficha])
      flash[:notice] = "Ficha Actualizada con Exito."
      redirect_to edit2_proyectosficha_path(@proyectosficha.proyecto_id)
    else
      render :action => "edit2"
      #redirect_to edit2_persona_path(@persona)
    end
    rescue
      redirect_to edit2_proyectosficha_path(@proyectosficha.proyecto_id)
  end

  # PUT /proyectosfichas/1
  # PUT /proyectosfichas/1.xml
  def update
    @proyectosficha = Proyectosficha.find(params[:id])
    @proyectosficha.user_id = is_admin
    respond_to do |format|
      if @proyectosficha.update_attributes(params[:proyectosficha])
        flash[:notice] = 'Proyectosficha was successfully updated.'
        format.html { redirect_to edit_ficha_proyecto_proyectosfichas(@proyectosficha) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proyectosficha.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /proyectosfichas/1
  # DELETE /proyectosfichas/1.xml
  def destroy
    @proyectosficha = Proyectosficha.find(params[:id])
    @proyectosficha.destroy

    respond_to do |format|
      format.html { redirect_to(proyectosfichas_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['show','export','visualizar'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end

end
