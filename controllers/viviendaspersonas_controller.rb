class ViviendaspersonasController < ApplicationController

  before_filter :require_user

  def index
    persona   = Persona.find(params[:persona_id])
    @viviendaspersonas = persona.viviendaspersonas.all
  end

  def buscar
    if params[:buscarident].to_s != ""
      @viviendaspersonas = Viviendaspersona.find(:all, :conditions => [" persona_id = (select distinct persona_id from relaciones where identificacion = ?)
                                                                         and vivienda_id in (select id from viviendas where proyecto_id in (select proyecto_id from usersproyectos where user_id = #{is_admin}))", "#{params[:buscarident]}"])
      if @viviendaspersonas.count == 1
        @viviendaspersonas.each do |viviendaspersona|
          redirect_to edit_vivienda_path(viviendaspersona.vivienda_id)
        end
      elsif @viviendaspersonas.count == 0
        flash[:notice] = "No hay informacion de la busqueda ó Usted no tiene acceso a consultar el proyecto del usuario"
        redirect_to busqueda_viviendaspersonas_path
      end
    elsif params[:format] == 'xls'
      @viviendas = Vivienda.find(:all, :conditions =>["proyecto_id in (select proyecto_id from usersproyectos where user_id = #{is_admin})"])
      respond_to do |format|
         format.xls
      end
    end
    
#  rescue
#    flash[:notice] = "Debe digitar datos para la consulta"
#    redirect_to busqueda_viviendaspersonas_path
  end

#  def edit
#    @viviendaspersona = Viviendaspersona.find(params[:id], :include => "persona")
#    @persona  = @viviendaspersona.persona
#    respond_to do |format|
#      format.js { render :action => "edit_viviendapersona" }
#    end
#  end


  def edit
    @viviendaspersona = Viviendaspersona.find(params[:id], :include => "persona")
    vivienda = Vivienda.find(@viviendaspersona.vivienda_id)
    vivienda.inv_user = is_admin
    vivienda.inv_esc_entrega = 'SI'
    vivienda.inv_esc_fecha = Time.now
    vivienda.save
    @persona  = @viviendaspersona.persona
    redirect_to edit_persona_path(@persona.id)
#    respond_to do |format|
#      format.js { render :action => "viviendaspersonas" }
#    end
  end

  def new
    @vivienda   = Vivienda.find(params[:id])
    @viviendaspersona = @vivienda.viviendaspersonas.build
  end

  def create
    @vivienda   = Vivienda.find(params[:vivienda_id])
    @viviendaspersona = @vivienda.viviendaspersonas.build(params[:viviendaspersona])
    if Persona.exists?(["id = ?", @viviendaspersona.persona_id]) == true
      if Viviendaspersona.exists?(["persona_id = ?", @viviendaspersona.persona_id]) == false
        if @viviendaspersona.save
          vivienda = Vivienda.find(params[:vivienda_id])
          vivienda.estado = "O"
          ActiveRecord::Base.connection.execute("insert into viviendastramites (id,vivienda_id,viviendastipostramite_id,fecha_inicio,fecha_esperada,observaciones,created_at,updated_at,user_id,useract_id)
                                                 select viviendastramites_seq.nextval,#{vivienda.id},viviendastipostramite_id,fecha_inicio,fecha_esperada,observaciones,created_at,updated_at,user_id,useract_id
                                                 from   personastramites where persona_id = #{@viviendaspersona.persona_id}")
          vivienda.save
          Vivienda.clasificacion(@vivienda.id,@viviendaspersona.persona_id)
          flash[:notice] = "La Vivienda ha sido asignada con Exito y se ha registrado la Clasificacion"
          redirect_to menus_path
        else
          flash[:warning] = "Problemas con la asignación del Usuario.. Contacte al administrador!!!!"
          render :action => "new"
        end
      else
        flash[:warning] = "El usuario ya tiene asignada una vivienda. Verifique!!!!"
        render :action => "new"
      end
    else
      flash[:warning] = "El usuario no Existe. Verifique!!!"
      render :action => "new"
    end
  end

  def update
    @viviendaspersona  = Viviendaspersona.new
    vivienda           = Viviendaspersona.find(params[:id])
    @persona           = vivienda.persona
    ok = vivienda.update_attributes(params[:viviendaspersona])
    flash[:vivienda] = ok ? "Línea de factura modificada correctamente" : "Se produjo un error al guardar la línea de factura"
    respond_to do |format|
      format.js { render :action => "viviendaspersonas" }
    end
  end

  def destroy
    vivienda           = Viviendaspersona.find(params[:id])
    @persona  = vivienda.persona
    @viviendaspersona  = Viviendaspersona.new
    vivienda.destroy
    respond_to do |format|
      format.js { render :action => "viviendaspersonas" }
    end
  end

end
