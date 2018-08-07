class CrucessolicitudesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @crucessolicitudes = Crucessolicitud.all(:select => ["distinct consecutivo, user_id, created_at, count(9) cantidad"], :conditions =>"estado is null", :group=>"consecutivo, user_id, created_at", :order=>"consecutivo asc")
    @crucessolicitudese = Crucessolicitud.all(:select => ["distinct consecutivo, user_id, user_atencion, updated_at, count(9) cantidad"], :conditions =>"estado = 'EN TRAMITE'", :group=>"consecutivo, user_id, updated_at, user_atencion", :order=>"consecutivo asc")
    @crucessolicitudest = Crucessolicitud.all(:select => ["distinct consecutivo, user_id, user_atencion, updated_at, count(9) cantidad"], :conditions =>"estado = 'TERMINADO'",:limit=>50, :group=>"consecutivo, user_id, updated_at, user_atencion", :order=>"updated_at desc")
  end

  def generar
    ActiveRecord::Base.connection.execute("update crucessolicitudes set user_atencion = #{is_admin}, estado = 'EN TRAMITE', updated_at = sysdate
                                           where  user_atencion is null and estado is null and clase = '#{params[:clase].to_s}'")
    flash[:notice] = "Proceso iniciado"
    redirect_to cruces_path
  end  

  def excel
    @clase = params[:clase].to_s
    if @clase == 'CRUCE'
      headers['Content-Disposition'] = 'attachment; filename="SIFI_CRUCE_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      @crucessolicitudes = Crucessolicitud.all(:conditions =>"estado = 'EN TRAMITE' and user_atencion = #{is_admin} and clase = '#{params[:clase].to_s}'")    
    elsif @clase == 'ZR'
      headers['Content-Disposition'] = 'attachment; filename="SIFI_ZR_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      @crucessolicitudes = Crucessolicitud.all(:select => ["distinct consecutivo,user_id,matricula,direccion"], :conditions =>"estado = 'EN TRAMITE' and user_atencion = #{is_admin} and clase = '#{params[:clase].to_s}'", 
                                               :group=>"consecutivo,user_id,matricula,direccion", :order=>"consecutivo asc")
    end
    respond_to do |format|
      format.xls
    end   
  end

  def terminar
    ActiveRecord::Base.connection.execute("update crucessolicitudes set estado = 'TERMINADO', updated_at = sysdate
                                           where  user_atencion = #{is_admin} and estado = 'EN TRAMITE' and clase = '#{params[:clase].to_s}'")
    flash[:notice] = "Proceso Terminado"
    redirect_to cruces_path
  end

  def vertodos
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Actividades_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"    
    @crucessolicitudest = Crucessolicitud.all(:select => ["distinct consecutivo, user_id, user_atencion, created_at, updated_at, count(9) cantidad"], :conditions =>"estado = 'TERMINADO'", :group=>"consecutivo, user_id, created_at, updated_at, user_atencion", :order=>"updated_at desc")
  end

  private
  def determine_layout
    if ['vertodos'].include?(action_name)
      "excel"
    else
      "application"
    end
  end  
end
