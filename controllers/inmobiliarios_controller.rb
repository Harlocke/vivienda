class InmobiliariosController < ApplicationController

   before_filter :require_user
   
  def index
    @inmobiliarios = Inmobiliario.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @inmobiliarios }
    end
  end

  def new
    @inmobiliario = Inmobiliario.new
    render :action => "inmobiliario_form"
  end

  def buscar
    @inmobiliarios = Inmobiliario.search(params[:ubicacion][:comuna_id],
                                         params[:ubicacion][:disponible],
                                         params[:ubicacion][:fchinicial],
                                         params[:ubicacion][:fchfinal],
                                         params[:buscarprecioinicial],
                                         params[:buscarpreciofinal],
                                         params[:ubicacion][:concepto_riesgo],
                                         params[:ubicacion][:resultado_concepto],
                                         params[:ubicacion][:funcionario],
                                         params[:ubicacion][:created_at],
                                         params[:buscarid])
    if @inmobiliarios.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_inmobiliarios_path
    elsif @inmobiliarios.count == 1
      redirect_to edit_inmobiliario_path(@inmobiliarios)
    else
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end

  def edit
    @inmobiliario = Inmobiliario.find(params[:id])
    @inmobiliariosimagen = Inmobiliariosimagen.new
    respond_to do |format|
      format.html { render :action => "inmobiliario_form" }
    end
  end

  def create
    @inmobiliario = Inmobiliario.new(params[:inmobiliario])
    @inmobiliario.user_id = is_admin
    if @inmobiliario.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_inmobiliario_path(@inmobiliario)
    else
      @inmobiliariosimagen = Inmobiliariosimagen.new
      render :action => "inmobiliario_form"
    end
  end

  def update
    @inmobiliario = Inmobiliario.find(params[:id])
    @inmobiliario.user_id = is_admin
    params[:inmobiliario][:user_actualiza] = is_admin
      if @inmobiliario.update_attributes(params[:inmobiliario])
        flash[:notice] = "El registro ha sido actualizado con Exito."
        redirect_to edit_inmobiliario_path(@inmobiliario)
      else
        @inmobiliariosimagen = Inmobiliariosimagen.new
        render :action => "inmobiliario_form"
      end
    rescue
      flash[:notice] = "Existen inconsistencias. Verifique!!!"
      redirect_to edit_inmobiliario_path(@inmobiliario)
  end

  def destroy
    @inmobiliario = Inmobiliario.find(params[:id])
    @inmobiliario.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to busqueda_inmobiliarios_path
      }
      format.xml  { head :ok }
    end
  end

  def show
    persona   = Persona.find(params[:inmobiliario_id])
    @inmobiliarios = persona.inmobiliarios.all
  end
end
