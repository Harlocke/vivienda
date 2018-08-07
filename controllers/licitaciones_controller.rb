class LicitacionesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @licitaciones = Licitacion.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @licitaciones }
    end
  end

  def show
    @licitacion = Licitacion.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @licitacion }
    end
  end

  def mostrar
    @licitacion = Licitacion.find(params[:id])
    if params[:format] == 'xls'
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="Presupuesto_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      respond_to do |format|
         format.xls
      end
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def mostrarconsolidado
    @licitacion = Licitacion.find_by_sql(
         "select distinct g.grupo_id, l.licitacion_id
          from  licitacionesenlaces l, analisisprecios a, gruposactividades g
          where l.licitacion_id = #{params[:id]}
          and   l.analisisprecio_id = a.id
          and   a.gruposactividad_id = g.id
          order by g.grupo_id")
    @objeto = Licitacion.find(params[:id])
    if params[:format] == 'xls'
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="PresupuestoConsolidado_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      respond_to do |format|
         format.xls
      end
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def new
    @licitacion = Licitacion.new
    render :action => "licitacion_form"
  end

  def edit
    @licitacion = Licitacion.find(params[:id])
    @licitacionesenlace = Licitacionesenlace.new
    @licitacionesimagen = Licitacionesimagen.new
    @licitacionesobservacion = Licitacionesobservacion.new
    @licitacionesinforme = Licitacionesinforme.new
    @licitacionespago = Licitacionespago.new
    respond_to do |format|
      format.html { render :action => "licitacion_form" }
    end
  end

  def create
    @licitacion = Licitacion.new(params[:licitacion])
    @licitacion.user_id = is_admin
    if Resolucion.exists?(["modalidad = 'MEJORAMIENTO' and id in (select resolucion_id from resolucionespersonas where persona_id = #{@licitacion.persona_id})"]) == true
      @resol = Resolucionespersona.find(:first, :conditions=>["persona_id = #{@licitacion.persona_id} and resolucion_id in (select id from resoluciones where modalidad = 'MEJORAMIENTO')"])
      @licitacion.resolucion_id = @resol.resolucion_id
      @licitacion.valor_resolucion = (@resol.subsidio_especie.to_i +
                                        @resol.subsidio_dinero.to_i +
                                        @resol.subsidio_mejoras.to_i)
      if @licitacion.save
        flash[:notice] = "Registro Creado con Exito."
        redirect_to edit_licitacion_path(@licitacion)
      else
        render :action => "licitacion_form"
      end
    else
      flash[:warning] = "La persona no tiene resolución de Mejoramientos. Verifique!!!"
      render :action => "licitacion_form"
    end
  end

  def update
    @licitacion = Licitacion.find(params[:id])
    @licitacion.user_actualiza = is_admin
    if @licitacion.update_attributes(params[:licitacion])
      flash[:notice] = "Registro Actualizado con Exito."
      redirect_to edit_licitacion_path(@licitacion)
    else
      @licitacionesenlace = Licitacionesenlace.new
      @licitacionesimagen = Licitacionesimagen.new
      @licitacionesobservacion = Licitacionesobservacion.new
      @licitacionesinforme = Licitacionesinforme.new
      @licitacionespago = Licitacionespago.new
      render :action => "licitacion_form"
    end
  end

  def destroy
    @licitacion = Licitacion.find(params[:id])
    @licitacion.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro ha sido eliminado con Exito."
        redirect_to busqueda_licitaciones_path
      }
      format.xml  { head :ok }
    end
  end

  def copiar
    @licitacion = Licitacion.find(params[:id])
     #Licitacion Primero...
    lic = Licitacion.new
    lic.aiu = @licitacion.aiu
    lic.descripcion = @licitacion.descripcion.to_s + " - Copia"
    lic.save
    last_id = Licitacion.maximum('id')
    @licitacion.licitacionesenlaces.each do |licitacionesenlace|
      licenlace = Licitacionesenlace.new
      licenlace.licitacion_id = last_id
      #licenlace.grupo_id = licitacionesenlace.grupo_id
      licenlace.analisisprecio_id = licitacionesenlace.analisisprecio_id
      licenlace.valorunitario = licenlace.analisisprecio.valor.to_f
      licenlace.valortotal = licitacionesenlace.cantidad.to_f * licenlace.analisisprecio.valor.to_f
      licenlace.cantidad = licitacionesenlace.cantidad
      licenlace.save
    end
    flash[:notice] = "Presupuesto Duplicado Exitosamente"
    redirect_to edit_licitacion_path(last_id)
  end

  def informe
    @licitacion = Licitacion.find(params[:id])
  end

  private
  def determine_layout
    if ['mostrar','mostrarconsolidado','informe'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
