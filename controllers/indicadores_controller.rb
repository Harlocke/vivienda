class IndicadoresController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    #@indicadores = Indicador.find(:all, :conditions=>["useranalisis = #{is_admin} or userreporte = #{is_admin} "], :order=>"nombreindicador")
    #@indicadores = Indicador.find(:all, :conditions=>["useranalisis = #{is_admin} or userreporte = #{is_admin} "], :order=>"nombreindicador")
    @indicadores = Indicador.find(:all, :order => "proceso" , :select => "distinct proceso")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @indicadores }
    end
  end

  def estadoindicador
    @indicador = Indicador.find(params[:id])
    if @indicador.activo == 'SI'
      @indicador.activo = 'NO'
    else
      @indicador.activo = 'SI'
    end
    @indicador.save
    flash[:notice] = "Actualizado estado con exito...."
    redirect_to edit_indicador_path(@indicador)
  end

  def informe
    @indicadores = Indicador.all
  end

  def informec
    @indicadores = Indicador.find_by_sql("select distinct proceso from indicadores group by proceso")
  end

  def buscar
    @indicadores  = Indicador.buscar(params[:ubicacion][:proceso],
                                     params[:ubicacion][:userresponsable_id],
                                     params[:nombre],
                                     params[:ubicacion][:dependencia_id])
    if @indicadores.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to indicadores_path
    elsif @indicadores.count == 1
      redirect_to edit_indicador_path(:id=>@indicadores, :etapa=>'1')
    else
      respond_to do |format|
         format.html
      end
    end
  end

 def new
    @indicador = Indicador.new
    @indicadoresficha = Indicadoresficha.new
    @indicadoresactualizacion = Indicadoresactualizacion.new
    @indicadoresvariable = Indicadoresvariable.new
    @indicador.etapa ='1'
    render :action => "indicador_form"
  end

  def create
    @indicador = Indicador.new(params[:indicador])   
    if @indicador.clase_indicador.to_s == 'SIMPLE'
      @indicador.numerador = @indicador.numerador1.to_s      
    elsif @indicador.clase_indicador.to_s == 'ESPECIFICO'
      @indicador.numerador = @indicador.numerador2.to_s
      @indicador.denominador = @indicador.denominador1.to_s
    end    
    @indicador.activo = 'SI'
    if @indicador.save
      ActiveRecord::Base.connection.execute("insert into indicadoresvariables (id,indicador_id,tipo,created_at,updated_at)
                                             values (indicadoresvariables_seq.nextval,#{@indicador.id},'NUMERADOR',sysdate,sysdate)")
      ActiveRecord::Base.connection.execute("insert into indicadoresvariables (id,indicador_id,tipo,created_at,updated_at)
                                             values (indicadoresvariables_seq.nextval,#{@indicador.id},'DENOMINADOR',sysdate,sysdate)")
      flash[:notice] = "Indicador Creado con Exito."
      redirect_to edit_indicador_path(@indicador)
    else
      flash[:warning] = "Problemas con la creacion del registro."
      render :action => "indicador_form"
     end
  end

  def show
    @indicador = Indicador.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @indicador }
    end
  end

  def edit
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update indicadores set etapa = '#{params[:etapa]}' where id = #{params[:id]}")
    end    
    @indicador = Indicador.find(params[:id])
    if @indicador.etapa.to_s == "2"
      @indicadoresficha = Indicadoresficha.new
    elsif @indicador.etapa.to_s == "3"
      @indicadoresactualizacion = Indicadoresactualizacion.new
    end
    #@indicadoresvariable = Indicadoresvariable.new
    respond_to do |format|
      format.html { render :action => "indicador_form" }
    end
  end

  def cambioanno
    indicadores = Indicador.all
    indicadores.each do |indicador|
      if indicador.medicion.to_s == 'MENSUAL'
        #Para el 2017
        i = 1
        while (i <= 12)
            ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                                   values (indicadoresfichas_seq.nextval,#{indicador.id},'#{i}','2017',sysdate,sysdate)")
            i = i + 1
        end
      elsif indicador.medicion.to_s == 'ANUAL'
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{indicador.id},'1','2017',sysdate,sysdate)")
      elsif indicador.medicion.to_s == 'SEMESTRAL'
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{indicador.id},'6','2017',sysdate,sysdate)")
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{indicador.id},'12','2017',sysdate,sysdate)")
      elsif indicador.medicion.to_s == 'TRIMESTRAL'
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{indicador.id},'3','2017',sysdate,sysdate)")
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{indicador.id},'6','2017',sysdate,sysdate)")
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{indicador.id},'9','2017',sysdate,sysdate)")
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{indicador.id},'12','2017',sysdate,sysdate)")
      elsif indicador.medicion.to_s == 'BIMENSUAL'
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{indicador.id},'2','2017',sysdate,sysdate)")
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{indicador.id},'4','2017',sysdate,sysdate)")
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{indicador.id},'6','2017',sysdate,sysdate)")
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{indicador.id},'8','2017',sysdate,sysdate)")      
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{indicador.id},'10','2017',sysdate,sysdate)")      
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{indicador.id},'12','2017',sysdate,sysdate)")   
      elsif indicador.medicion.to_s == 'BIANUAL'
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{indicador.id},'12','2017',sysdate,sysdate)")
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{indicador.id},'12','2017',sysdate,sysdate)")     
      end
    end   
    redirect_to indicadores_path 
  end

 def update
    @indicador = Indicador.find(params[:id])
    if @indicador.medicion.to_s != params[:indicador][:medicion].to_s
      begin
        Indicadoresficha.destroy_all("indicador_id = #{@indicador.id} and anno = '2017'")
      rescue
        a = "no Existe"
      end
      if params[:indicador][:medicion].to_s == 'MENSUAL'
        #Para el 2017
        i = 1
        while (i <= 12)
          ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                                 values (indicadoresfichas_seq.nextval,#{@indicador.id},'#{i}','2017',sysdate,sysdate)")
          i = i + 1
        end
      elsif params[:indicador][:medicion].to_s == 'ANUAL'
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{@indicador.id},'1','2017',sysdate,sysdate)")
      elsif params[:indicador][:medicion].to_s == 'SEMESTRAL'
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{@indicador.id},'6','2017',sysdate,sysdate)")
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{@indicador.id},'12','2017',sysdate,sysdate)")
      elsif params[:indicador][:medicion].to_s == 'TRIMESTRAL'
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{@indicador.id},'3','2017',sysdate,sysdate)")
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{@indicador.id},'6','2017',sysdate,sysdate)")
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{@indicador.id},'9','2017',sysdate,sysdate)")
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{@indicador.id},'12','2017',sysdate,sysdate)")
      elsif params[:indicador][:medicion].to_s == 'BIMENSUAL'
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{@indicador.id},'2','2017',sysdate,sysdate)")
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{@indicador.id},'4','2017',sysdate,sysdate)")
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{@indicador.id},'6','2017',sysdate,sysdate)")
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{@indicador.id},'8','2017',sysdate,sysdate)")      
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{@indicador.id},'10','2017',sysdate,sysdate)")      
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{@indicador.id},'12','2017',sysdate,sysdate)")   
      elsif params[:indicador][:medicion].to_s == 'BIANUAL'
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{@indicador.id},'12','2017',sysdate,sysdate)")
        ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                               values (indicadoresfichas_seq.nextval,#{@indicador.id},'12','2017',sysdate,sysdate)")     
      end
    end
#    @indicador.user_actualiza = is_admin
    if params[:indicador][:clase_indicador].to_s == 'SIMPLE'
      params[:indicador][:numerador] = params[:indicador][:numerador1]
    elsif params[:indicador][:clase_indicador].to_s == 'ESPECIFICO'
      params[:indicador][:numerador] = params[:indicador][:numerador2]
      params[:indicador][:denominador] = params[:indicador][:denominador1]
    end
    if @indicador.update_attributes(params[:indicador])
      flash[:notice] = "Indicador actualizado correctamente."
      redirect_to edit_indicador_path(@indicador)
    else
      #@indicadoresficha = Indicadoresficha.new
      #@indicadoresactualizacion = Indicadoresactualizacion.new
      #@indicadoresvariable = Indicadoresvariable.new
      render :action => "indicador_form"
    end
    #rescue
    #redirect_to edit_indicador_path(@indicador)
  end

  def destroy
    @indicador = Indicador.find(params[:id])
    @indicador.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to indicadores_path
      }
    end
  end

  def visualizar
    @indicador = Indicador.find(params[:id])
  end

  private
  def determine_layout
    if ['buscarx','buscary','buscari','edit2','update2','informe','informec'].include?(action_name)
      "informes"
    elsif ['ubicacion','ubicacion2'].include?(action_name)
      "frontend"
    elsif ['visualizar'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
