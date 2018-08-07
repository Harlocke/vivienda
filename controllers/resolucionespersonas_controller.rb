class ResolucionespersonasController < ApplicationController

  before_filter :require_user

  def index
    resolucion   = Resolucion.find(params[:resolucion_id])
    @resolucionespersonas = resolucion.resolucionespersonas.all
  end

  def edit
    @resolucionespersona  = Resolucionespersona.find(params[:id], :include => "resolucion")
    @resolucion  = @resolucionespersona.resolucion
    respond_to do |format|
      format.js { render :action => "edit_resolucionespersona" }
    end
  end

  def create
    @resolucion  = Resolucion.find(params[:resolucion_id])
    @resolucionespersona = Resolucionespersona.new(params[:resolucionespersona])
    @resolucionespersona.user_id = is_admin
    if permiso("resolucionesespecial","C").to_s == "S"
      if @resolucionespersona.valid?
        @resolucion.resolucionespersonas << @resolucionespersona
        @resolucion.save
        @resolucionespersona = Resolucionespersona.new
        flash[:resolucionespersona] = "Registro Almacenado Con Exito "
      else
        flash[:resolucionespersona] = "Se produjo un error al guardar el registro"
      end
      respond_to do |format|
        format.js { render :action => "resolucionespersonas" }
      end
    else
      if Resolucionespersona.exists?(["persona_id = ? and resolucion_id = ?", @resolucionespersona.persona_id, @resolucion.id]) == false
        # Valida que Tenga NO Resolucion de --> 10004 REVOCATORIA, 10020 PERDIDADEVIGENCIA, 10005 aclaracion
        if Resolucion.exists?(["resolucionesclase_id in (10004,10020) and id in (select resolucion_id from resolucionespersonas where persona_id =?)", @resolucionespersona.persona_id]) == false
          # Valida que Tenga Resolucion de --> 10000 SUBSIDIOS Y MEJORAS, 10023 SUBSIDIO, 10024 MEJORAS
          if Viviendaspersona.exists?(["persona_id = ? and vivienda_id in (select id from viviendas where esc_nro_escritura is not null and nro_matricula is not null)", @resolucionespersona.persona_id]) == false
            # Valida que Tenga Resolucion de --> 10000 SUBSIDIOS Y MEJORAS, 10023 SUBSIDIO, 10024 MEJORAS
            if Resolucion.exists?(["resolucionesclase_id in (10000,10023,10024) and id in (select resolucion_id from resolucionespersonas where persona_id =?)", @resolucionespersona.persona_id]) == false
              if @resolucionespersona.valid?
                @resolucion.resolucionespersonas << @resolucionespersona
                @resolucion.save
                @resolucionespersona = Resolucionespersona.new
                flash[:resolucionespersona] = "Registro Almacenado Con Exito "
              else
                flash[:resolucionespersona] = "Se produjo un error al guardar el registro"
              end
              respond_to do |format|
                format.js { render :action => "resolucionespersonas" }
              end
            elsif @resolucion.resolucionesclase_id.to_s == '10023' and @resolucion.modalidad.to_s == 'ARRENDAMIENTO'
              if @resolucionespersona.valid?
                @resolucion.resolucionespersonas << @resolucionespersona
                @resolucion.save
                @resolucionespersona = Resolucionespersona.new
                flash[:resolucionespersona] = "Registro Almacenado Con Exito "
              else
                flash[:resolucionespersona] = "Se produjo un error al guardar el registro"
              end
              respond_to do |format|
                format.js { render :action => "resolucionespersonas" }
              end         
            else
              #Resolucion permitida de modificacion o aclaracion
              if @resolucion.resolucionesclase_id.to_s == '10005' or @resolucion.resolucionesclase_id.to_s == '10040' or @resolucion.resolucionesclase_id.to_s == '10021' or @resolucion.resolucionesclase_id.to_s == '10004'
                if @resolucionespersona.valid?
                  @resolucion.resolucionespersonas << @resolucionespersona
                  @resolucion.save
                  @resolucionespersona = Resolucionespersona.new
                  flash[:resolucionespersona] = "Registro Almacenado Con Exito "
                else
                  flash[:resolucionespersona] = "Se produjo un error al guardar el registro"
                end
                respond_to do |format|
                  format.js { render :action => "resolucionespersonas" }
                end
              else
                render :update do |page|
                  page.alert "ATENCIÓN: El usuario ya tiene Resolucion... Verifique!!! - " + @resolucion.resolucionesclase_id.to_s
                end
              end
            end
          else
            if @resolucion.resolucionesclase_id.to_s == '10004' or @resolucion.resolucionesclase_id.to_s == '10020' or @resolucion.resolucionesclase_id.to_s == '10040'
              if @resolucionespersona.valid?
                @resolucion.resolucionespersonas << @resolucionespersona
                @resolucion.save
                @resolucionespersona = Resolucionespersona.new
                flash[:resolucionespersona] = "Registro Almacenado Con Exito "
              else
                flash[:resolucionespersona] = "Se produjo un error al guardar el registro"
              end
              respond_to do |format|
                format.js { render :action => "resolucionespersonas" }
              end
            else
              render :update do |page|
                 page.alert "ATENCIÓN: El usuario ya tiene vivienda Escriturada imposible registrar otra Resolucion... Verifique!!!" + @resolucion.resolucionesclase_id.to_s
              end
            end
          end
        else
          render :update do |page|
             page.alert "ATENCIÓN: El usuario tiene resolucion de revocatoria o de perdida de vigencia - Usuario Bloqueado... Verifique!!!"
          end
        end
      else
        render :update do |page|
           page.alert "ATENCIÓN: El usuario ya se encuentra en esta resolución... Verifique!!!"
        end
      end
    end
  end

  def update
    @resolucionespersona    = Resolucionespersona.new
    resolucionespersona     = Resolucionespersona.find(params[:id])
    @resolucion             = resolucionespersona.resolucion
    ok = resolucionespersona.update_attributes(params[:resolucionespersona])
    flash[:notice] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "resolucionespersonas" }
    end
  end

  def destroy
    resolucionespersona   = Resolucionespersona.find(params[:id])
    @resolucion  = resolucionespersona.resolucion
    @resolucionespersona  = Resolucionespersona.new
    resolucionespersona.destroy
    respond_to do |format|
      format.js { render :action => "resolucionespersonas" }
    end
  end

  def destroybeneficiario
    idresol = params[:idresol]
    idbene  = params[:idbene]
    ActiveRecord::Base.connection.execute(
      "insert into antbeneviviendas (id, persona_id, documento_id, identificacion, primer_nombre,
                                     segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento,
                                     parentesco_id, especial_id, autobuscar, ocupacion_id, estado_civil_id,
                                     ingresos, created_at, updated_at, user_id, resolucion_id)
       select antbeneviviendas_seq.nextval, persona_id, documento_id, identificacion, primer_nombre,
              segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento,
              parentesco_id, especial_id, autobuscar, ocupacion_id, estado_civil_id,
              ingresos, sysdate, sysdate, #{is_admin}, #{idresol}
       from   beneviviendas
       where  id = #{idbene}")
    ActiveRecord::Base.connection.execute("delete from beneviviendas where id = #{idbene}")
    flash[:notice] = "Beneficiario Desvinculado con exito de la Resolucion."
    respond_to do |format|
       format.html { redirect_to edit_resolucion_path(idresol) }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @resolucionespersonas = persona.resolucionespersonas.all
  end
end
