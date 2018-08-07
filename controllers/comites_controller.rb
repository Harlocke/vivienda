class ComitesController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    @comites = Comite.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comites }
    end
  end

  def visualizar
    @comite    = Comite.find(params[:id])
  end

  def buscar
    @valor = ""
    if permiso("comision","C").to_s == "S"
      @valor = 'C'
    end
    @comites = Comite.search(
      params[:ubicacion][:creainicial],
      params[:ubicacion][:creafinal],
      params[:ubicacion][:comitestipo_id],
      params[:temas],
      params[:ubicacion][:vencinicial],
      params[:ubicacion][:vencfinal],
      params[:nrocomision],
      params[:concejal],
      @valor)
    if @comites.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_comites_path
    elsif @comites.count == 1 and params[:format] != 'xls'
      redirect_to edit_comite_path(@comites)
    else
      respond_to do |format|
        format.html
        format.xls if params[:format] == 'xls'
      end
    end
  end

  def buscarx
    @valor = ""
    if permiso("comision","C").to_s == "S"
      @valor = 'C'
    end
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_informe_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @comitesactividades = Comitesactividad.search(params[:ubicacion][:dependencia_id],
                                                  params[:ubicacion][:estado],
                                                  @valor)
    if @comitesactividades.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_comites_path
    end
  end

  def new
    @comite = Comite.new
    render :action => "comite_form"
  end

  def edit
    @comite = Comite.find(params[:id])
    @comitesactividad= Comitesactividad.new
    @comitesobservacion= Comitesobservacion.new
    @comitesuser= Comitesuser.new
    @comitesresponsable = Comitesresponsable.new
    @comitesimagen= Comitesimagen.new
    @existependiente = Comitesactividad.exists?(["estado= 'PENDIENTE' and comite_id != #{@comite.id} and comite_id in (select id from comites where comitestipo_id = #{@comite.comitestipo_id})"])
    respond_to do |format|
      format.html { render :action => "comite_form" }
    end
  end

  def create
    @comite = Comite.new(params[:comite])
    @comite.user_id = is_admin
    if @comite.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_comite_path(@comite)
    else
      render :action => "comite_form"
    end
  end

  def update
    @comite = Comite.find(params[:id])
    @comite.user_id = is_admin
    if @comite.update_attributes(params[:comite])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_comite_path(@comite)
    else
      @comitesactividad= Comitesactividad.new
      @comitesobservacion= Comitesobservacion.new
      @comitesuser= Comitesuser.new
      @comitesimagen= Comitesimagen.new
      @comitesresponsable = Comitesresponsable.new
      render :action => "comite_form"
    end
  rescue
    flash[:notice] = "Existen inconsistencias. Verifique!!!"
    redirect_to edit_comite_path(@comite)
  end

  def enviomensaje
    @comite = Comite.find(params[:id])
    Comite.mensaje(@comite)
    flash[:notice] = "La informacion ha sido enviada con Exito via Electronica."
    redirect_to edit_comite_path(@comite)
  end

  def enviomensajejefe
    @comite = Comite.find(params[:id])
    Comite.mensajejefe(@comite)
    flash[:notice] = "La informacion ha sido enviada con Exito via Electronica."
    redirect_to edit_comite_path(@comite)
  end

  def envioinvitacion
    @comite = Comite.find(params[:id])
    Comite.invitacion(@comite)
    flash[:notice] = "La informacion ha sido enviada con Exito via Electronica."
    redirect_to edit_comite_path(@comite)
  end

  def destroy
    @comite = Comite.find(params[:id])
    @comite.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to busqueda_comites_path
      }
      format.xml  { head :ok }
    end
  end

#  def show
#    persona   = Persona.find(params[:comite_id])
#    @comites = persona.comites.all
#  end

  private
  def determine_layout
    if ['visualizar','buscarx'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end