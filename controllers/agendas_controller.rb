include ChainSelectsHelper
class AgendasController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    @agendasprocesos = Agendasproceso.find(:all, :conditions=>["id in (select agendasproceso_id from agendasprocesosusers where user_id = #{is_admin})"], :order=>"descripcion")
    @e = ""
    if Agenda.exists?(["useratencion_id = #{is_admin} and estado = 'INICIAR' and agendasfecha in (select id from agendasfechas where fecha = trunc(sysdate))"])
      @e = 'SI'
      @agendas = Agenda.find(:all, :conditions=>["useratencion_id = #{is_admin} and estado = 'INICIAR' and agendasfecha in (select id from agendasfechas where fecha = trunc(sysdate))"])
    else
      @e = 'NO'
    end
  end

  def agendadia
    @agendasprocesos = Agendasproceso.find(:all, :conditions=>["id in (select agendasproceso_id from agendasprocesosusers where user_id = #{is_admin})"], :order=>"descripcion")
    if params[:fecha].to_s == ""
      @fecha = Time.now
    else
      @fecha = params[:fecha].to_date
    end
  end

  def buscaragendadia
    if params[:ubicacion][:fecha].to_s == ""
      @fecha = Time.now
    else
      @fecha = params[:ubicacion][:fecha].to_date
    end
    redirect_to :controller=>"agendas", :action=>"agendadia", :fecha=>@fecha.to_date
  end


  def indexc
    
  end
  
  def busqueda
    @agendas = Agenda.searchidentifi(params[:search], params[:page])
    if @agendas.count.to_i == 0
      respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @agendas }
     end
    else
     flash[:notice] = "Se encontraron varios resultados"
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @agendas }
      end
    end
  end

  def reportecitas
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Agendas_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = ''
    if params[:proceso].to_s != ""
      @agendas = Agenda.find(:all, :conditions=>["agendasproceso = #{params[:proceso].to_s} and agendasfecha in (select id from agendasfechas where fecha = '#{params[:fecha]}')"], :order=>"agendasproceso, agendasfecha, agendashorario asc")
    else
      @agendas = Agenda.find(:all, :conditions=>["agendasfecha in (select id from agendasfechas where fecha = '#{params[:fecha]}')"], :order=>"agendasproceso, agendasfecha, agendashorario asc")
    end
  end

 def indexa
   @agendas = Agenda.search(params[:search],params[:searchn], params[:page])
    if @agendas.count == 0
      #flash[:notice] = "No hay resultados de la consulta"
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @agendas }
      end
    elsif @agendas.count == 1
      #flash[:notice] = "Dato localizado"
      redirect_to edit_agenda_path(@agendas)
    else
      #flash[:notice] = "Se encontraron varios resultados"
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @agendas }
      end
    end
  end


  def visualizar
    @agenda = Agenda.find(params[:id])
  end

  def rptdatos
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="Participantes_datos_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @agendas = Agenda.all
  end

  def new
   @agenda = Agenda.new
   @agenda.persona_id = params[:persona_id]
   @agenda.ayuda_id = params[:ayuda_id]
   render :action => "agenda_form"
  end


 def create
   @agenda = Agenda.new(params[:agenda])
   @agenda.user_id = is_admin
   @agenda.estado = 'PENDIENTE'
   if @agenda.save
      redirect_to :controller=>"agendas", :action=>"alerta", :id=>@agenda.id
   else
      flash[:warning] = "Precaución: Problemas con la creacion del registro, verifique los campos obligatorios"
      render :action => "agenda_form"
   end
 end

 def alerta
   @agenda = Agenda.find(params[:id])
   @valor = "La cita ha sido registrada existosamente!!"
 end

 def show
   @agenda = Agenda.find(params[:id])
   respond_to do |format|
     format.html # show.html.erb
     format.xml  { render :xml => @agenda }
   end
 end

 def edit
   @agenda = Agenda.find(params[:id])
   respond_to do |format|
     format.html { render :action => "agenda_form" }
   end
 end

  def update
    @aler = ""
    @agenda = Agenda.find(params[:id])
    if params[:agenda][:pregunta1].to_s != ""
      params[:agenda][:encuesta] = 'SI'
      @aler = 'X'
    end
    if @agenda.update_attributes(params[:agenda])
      if @aler.to_s == 'X'
        flash[:notice] = "Gracias por participar en la elaboración de la encuesta...."
        redirect_to :controller=>"agendas", :action=>"indexc"
      else
        flash[:notice] = "Registro actualizado correctamente."
        redirect_to edit_agenda_path(@agenda)
      end
    else
      flash[:warning] = "Precaución: Debe registrar todos los datos obligatorios"
      render :action => "agenda_form"
    end
  end

  def destroy    
    if params[:clase].to_s != ""
      if params[:clase].to_s == 'INICIAR'
        ActiveRecord::Base.connection.execute("update agendas set estado = 'INICIAR', useratencion_id = #{is_admin}, fch_inicio_atencion=sysdate where id = #{params[:id]}")
        flash[:notice] = "Proceso Iniciado correctamente."
        render :update do |page|
          page.redirect_to agendas_path
        end        
      elsif params[:clase].to_s == 'ATENDIDO'
        ActiveRecord::Base.connection.execute("update agendas set estado = 'ATENDIDO', useratencion_id = #{is_admin}, fch_fin_atencion=sysdate where id = #{params[:id]}")
        flash[:notice] = "Proceso finalizado correctamente."
        agenda = Agenda.find(params[:id])
        ayudasobs = Ayudasobservacion.new
        ayudasobs.tipo_atencion = '1'
        ayudasobs.observacion = agenda.registrogestion_atencion
        ayudasobs.ayuda_id = agenda.ayuda_id
        ayudasobs.user_id = is_admin
        ayudasobs.save
        redirect_to ayudas_path
      elsif  params[:clase].to_s == 'PENDIENTE'
        ActiveRecord::Base.connection.execute("update agendas set estado = 'PENDIENTE', useratencion_id = null, fch_inicio_atencion=null where id = #{params[:id]}")
        flash[:notice] = "Proceso Reactivado correctamente."
        redirect_to ayudas_path
      elsif  params[:clase].to_s == 'CANCELAR'
        ActiveRecord::Base.connection.execute("update agendas set estado = 'CANCELAR', useratencion_id = #{is_admin} where id = #{params[:id]}")
        flash[:notice] = "Agenda Cancelada correctamente."
        agenda = Agenda.find(params[:id])
        ayudasobs = Ayudasobservacion.new
        ayudasobs.tipo_atencion = '1'
        ayudasobs.observacion = agenda.registrogestion_cancelada
        ayudasobs.ayuda_id = agenda.ayuda_id
        ayudasobs.user_id = is_admin
        ayudasobs.save        
      end
    else
      @agenda = Agenda.find(params[:id])
      @agenda.destroy
      respond_to do |format|
        format.html { redirect_to(agendas_url) }
        format.xml  { head :ok }
      end
    end
  end

  def atencion    
    if params[:clase].to_s == 'INICIAR'
      ActiveRecord::Base.connection.execute("update agendas set estado = 'INICIAR', useratencion_id = #{is_admin}, fch_inicio_atencion=sysdate where id = #{params[:id]}")
      flash[:notice] = "Proceso Iniciado correctamente."
      redirect_to agendas_path
    elsif  params[:clase].to_s == 'ATENDIDO'
      ActiveRecord::Base.connection.execute("update agendas set estado = 'ATENDIDO', useratencion_id = #{is_admin}, fch_fin_atencion=sysdate where id = #{params[:id]}")
      flash[:notice] = "Proceso finalizado correctamente."
      agenda = Agenda.find(params[:id])
      ayudasobs = Ayudasobservacion.new
      ayudasobs.tipo_atencion = '1'
      ayudasobs.observacion = agenda.registrogestion_atencion
      ayudasobs.ayuda_id = agenda.ayuda_id
      ayudasobs.user_id = is_admin
      ayudasobs.save
      redirect_to ayudas_path
    elsif  params[:clase].to_s == 'PENDIENTE'
      ActiveRecord::Base.connection.execute("update agendas set estado = 'PENDIENTE', useratencion_id = null, fch_inicio_atencion=null where id = #{params[:id]}")
      flash[:notice] = "Proceso Reactivado correctamente."
      redirect_to ayudas_path
    elsif  params[:clase].to_s == 'CANCELAR'
      ActiveRecord::Base.connection.execute("update agendas set estado = 'CANCELAR', useratencion_id = #{is_admin} where id = #{params[:id]}")
      flash[:notice] = "Agenda Cancelada correctamente."
      agenda = Agenda.find(params[:id])
      ayudasobs = Ayudasobservacion.new
      ayudasobs.tipo_atencion = '1'
      ayudasobs.observacion = agenda.registrogestion_cancelada
      ayudasobs.ayuda_id = agenda.ayuda_id
      ayudasobs.user_id = is_admin
      ayudasobs.save      
      redirect_to ayudas_path
    elsif  params[:clase].to_s == 'NO ASISTIO'
      ActiveRecord::Base.connection.execute("update agendas set estado = 'NO ASISTIO', useratencion_id = #{is_admin} where id = #{params[:id]}")
      flash[:notice] = "Realizado correctamente."
      agenda = Agenda.find(params[:id])
      ayudasobs = Ayudasobservacion.new
      ayudasobs.tipo_atencion = '1'
      ayudasobs.observacion = agenda.registrogestion_noasistio
      ayudasobs.ayuda_id = agenda.ayuda_id
      ayudasobs.user_id = is_admin
      ayudasobs.save      
      redirect_to ayudas_path
    elsif  params[:clase].to_s == 'PRESENTE'
      ActiveRecord::Base.connection.execute("update agendas set presente = 'SI', updated_at = sysdate where id = #{params[:id]}")
      flash[:notice] = "Presente marcado correctamente."
      redirect_to busqueda_agendas_path
    end
  end  

  private
  def determine_layout
    if ['visualizar','rptdatos'].include?(action_name)
      "informes"
    elsif ['indexc','indexa'].include?(action_name)
      "application"
    elsif ['index','busqueda','agendadia'].include?(action_name)
      "boletin"
    elsif ['reportecitas'].include?(action_name)
      "excel"      
    else
      "atencion"
    end
  end
end