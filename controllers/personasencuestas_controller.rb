class PersonasencuestasController < ApplicationController

  before_filter :require_user
 def index
    @personasencuestas = Personasencuesta.all
  end

  def new
    @personasencuesta = Personasencuesta.new
    @personasencuesta.persona_id = params[:persona_id]
    render :action => "personasencuesta_form"
  end

  def edit
    @personasencuesta = Personasencuesta.find(params[:id])
    respond_to do |format|
      format.html { render :action => "personasencuesta_form" }
    end
  end

  def rptdatos
    @personasencuestas = Personasencuesta.search(params[:ubicacion][:fchinicial],params[:ubicacion][:fchfinal])
    if @personasencuestas.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_viviendas_path
    else
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Encuesta_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
    @personasfechas = Personasencuesta.find_by_sql(["select distinct trunc(created_at) fecha, count(9) cant from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' group by trunc(created_at)"])
    @personastemas = Personasencuesta.find_by_sql(["select 'Arriendo temporal' tipo, (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and arriendo = 'SI') SI,
                                                    (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and arriendo = 'NO') NO
                                                    from dual
                                                    union
                                                    select 'Postulaciones' tipo, (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and postulacion = 'SI') SI,
                                                    (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and postulacion = 'NO') NO
                                                    from dual
                                                    union
                                                    select 'Plan retorno' tipo, (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and plan_retorno = 'SI') SI,
                                                    (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and plan_retorno = 'NO') NO
                                                    from dual
                                                    union
                                                    select 'OPV' tipo, (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and opv = 'SI') SI,
                                                    (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and opv = 'NO') NO
                                                    from dual
                                                    union
                                                    select 'Desastres' tipo, (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and desastre = 'SI') SI,
                                                    (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and desastre = 'NO') NO
                                                    from dual
                                                    union
                                                    select 'Vivienda usada' tipo, (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and vivenda_usada = 'SI') SI,
                                                    (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and vivenda_usada = 'NO') NO
                                                    from dual
                                                    union
                                                    select 'Cartera' tipo, (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and cartera = 'SI') SI,
                                                    (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and cartera = 'NO') NO
                                                    from dual
                                                    union
                                                    select 'Feria de vivienda' tipo, (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and feria = 'SI') SI,
                                                    (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and feria = 'NO') NO
                                                    from dual
                                                    union
                                                    select 'Información general' tipo, (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and inf_gral = 'SI') SI,
                                                    (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and inf_gral = 'NO') NO
                                                    from dual
                                                    union
                                                    select 'Riesgo' tipo, (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and riesgo = 'SI') SI,
                                                    (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and riesgo = 'NO') NO
                                                    from dual
                                                    union
                                                    select 'Post – ventas' tipo, (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and post_venta = 'SI') SI,
                                                    (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and post_venta = 'NO') NO
                                                    from dual
                                                    union
                                                    select 'Obra pública' tipo, (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and obra_publica = 'SI') SI,
                                                    (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and obra_publica = 'NO') NO
                                                    from dual
                                                    union
                                                    select 'Escrituración' tipo, (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and escrituracion = 'SI') SI,
                                                    (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and escrituracion = 'NO') NO
                                                    from dual
                                                    union
                                                    select 'Desplazados' tipo, (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and desplazado = 'SI') SI,
                                                    (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and desplazado = 'NO') NO
                                                    from dual
                                                    union
                                                    select 'Legalización' tipo, (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and legalizacion = 'SI') SI,
                                                    (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and legalizacion = 'NO') NO
                                                    from dual
                                                    union
                                                    select 'Vivienda nueva' tipo, (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and vivenda_nueva = 'SI') SI,
                                                    (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and vivenda_nueva = 'NO') NO
                                                    from dual
                                                    union
                                                    select 'Mejoramiento vivienda' tipo, (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and mejoramiento = 'SI') SI,
                                                    (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and mejoramiento = 'NO') NO
                                                    from dual
                                                    union
                                                    select 'Titulación' tipo, (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and titulacion = 'SI') SI,
                                                    (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and titulacion = 'NO') NO
                                                    from dual
                                                    union
                                                    select 'Otro' tipo, (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and otro = 'SI') SI,
                                                    (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and otro = 'NO') NO
                                                    from dual"])
      @personaspreguntas = Personasencuesta.find_by_sql(["
        select 'Considera que la informacion que recibio fue completa y clara' tipo, 
                (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and info_recibida = 20) puntos20,
                (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and info_recibida = 0) puntos0
        from dual
        union
        select 'Recibio por parte del personal que lo atendio un trato respetuoso y amable' tipo, 
                (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and respetuoso = 20) puntos20,
                (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and respetuoso = 0) puntos0
        from dual
        union
        select 'El tiempo que espero para ser atendio fue entre:' tipo, 
                (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and tiempo = 20) puntos20,
                (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and tiempo = 0) puntos0
        from dual
        union
        select 'Considera que las Instalaciones donde fue atendido son cómodas' tipo, 
                (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and instalaciones = 20) puntos20,
                (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and instalaciones = 0) puntos0
        from dual
        union
        select 'Se sintió satisfacho con la atención recibida' tipo, 
                (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and satisfecho = 20) puntos20,
                (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and satisfecho = 0) puntos0
        from dual
        union
        select 'En caso de haber sido atendido en el archivo se sintió satisfecho con la atención prestada' tipo, 
                (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and atencion = 20) puntos20,
                (select count(9) from personasencuestas where trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and atencion = 0) puntos0
        from dual
        "])
      respond_to do |format|
         format.xls
      end
    end        
  end

  def create
    @personasencuesta = Personasencuesta.new(params[:personasencuesta])
    @personasencuesta.user_id = is_admin
    if @personasencuesta.save
      flash[:notice] = "Creado con Exito."
      redirect_to edit_personasencuesta_path(@personasencuesta)
    else
      render :action => "personasencuesta_form"
     end
  end

  def update
    @personasencuesta = Personasencuesta.find(params[:id])
    if @personasencuesta.update_attributes(params[:personasencuesta])
     flash[:notice] = "Actualizado con Exito."
      redirect_to edit_personasencuesta_path(@personasencuesta)
    else
      render :action => "personasencuesta_form"
    end
    rescue
      redirect_to edit_personasencuesta_path(@personasencuesta)
  end

  def destroy
    @personasencuesta = Personasencuesta.find(params[:id])
    @personasencuesta.destroy
    respond_to do |format|
      format.html { redirect_to(personasencuestas_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['visualizar'].include?(action_name)
      "atencion"
    elsif['rptdatos'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end
