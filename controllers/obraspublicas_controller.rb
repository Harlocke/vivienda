class ObraspublicasController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    @obraspublicas = Obraspublica.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @obraspublicas }
    end
  end

  def informe
    @obraspublicas = Obraspublica.all
    respond_to do |format|
       format.xls
    end
  end

  def buscar
    @obraspublicas = Obraspublica.search(
                             params[:identificacion],
                             params[:ubicacion][:obrasproyecto_id],
                             params[:ubicacion][:estado],
                             params[:ubicacion][:pui_comuna],
                             params[:ubicacion][:pui_oriental],
                             params[:ubicacion][:opcion_vivienda],
                             params[:ubicacion][:caso_especial]
                             )
    if @obraspublicas.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_obraspublicas_path
    elsif @obraspublicas.count == 1 and params[:format] != 'xls'
      redirect_to edit_obraspublica_path(@obraspublicas)
    else
      if params[:format] != 'xls'
        respond_to do |format|
          format.html
        end
      else
        headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        headers['Content-Disposition'] = 'attachment; filename="SIFI_Obrapublica_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
        headers['Cache-Control'] = 'max-age=0'
        headers['pragma']="public"
      end
    end
  end

  def new
    @obraspublica = Obraspublica.new
    render :action => "obraspublica_form"
  end

  def edit
    @obraspublica  = Obraspublica.find(params[:id])
    @obrasradicado = Obrasradicado.new
    @obrasvendedor = Obrasvendedor.new
    @obrasobservacion = Obrasobservacion.new
    @obrasdisponibilidad = Obrasdisponibilidad.new
    respond_to do |format|
      format.html { render :action => "obraspublica_form" }
    end
  end

  def create
    @obraspublica = Obraspublica.new(params[:obraspublica])
    @obraspublica.user_id = is_admin
    if @obraspublica.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_obraspublica_path(@obraspublica)
    else
      render :action => "obraspublica_form"
    end
  end

  def update
    @obraspublica = Obraspublica.find(params[:id])
    @obraspublica.user_id = is_admin
    if @obraspublica.update_attributes(params[:obraspublica])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_obraspublica_path(@obraspublica)
    else
      @obrasradicado = Obrasradicado.new
      @obrasvendedor = Obrasvendedor.new
      @obrasobservacion = Obrasobservacion.new
      @obrasdisponibilidad = Obrasdisponibilidad.new
      render :action => "obraspublica_form"
    end
    rescue
      redirect_to edit_obraspublica_path(@obraspublica)
  end

  def destroy
    @obraspublica = Obraspublica.find(params[:id])
    @obraspublica.destroy
    respond_to do |format|
      format.html { redirect_to(obraspublicas_url) }
      format.xml  { head :ok }
    end
  end

  def show
    persona   = Persona.find(params[:obraspublica_id])
    @obraspublicas = persona.obraspublicas.all
  end

  private
  def determine_layout
    if ['import','csv_import','pendientesentrega','notificapendiente','asignar'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end