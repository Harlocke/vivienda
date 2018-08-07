class MenusController < ApplicationController

  before_filter :require_user, :checkaccess
  layout :determine_layout

  def checkaccess
    if is_activo == false
      current_user_session.destroy
      redirect_to new_user_session_url
      return false
    end
  end

  def index
    @mensajesboletines = "NO"
    @mensajesenvios = Mensajesenvio.find_all_by_user_id_and_estado(is_admin,'A')
    @mensajesenviosc = Mensajesenvio.find(:all, :conditions=>["user_id = #{is_admin} and estado = 'C'"], :order=>"created_at desc")
    if Comunicacion.exists?(["fecha = trunc(sysdate)"]) == true
      if Comunicacionesuser.exists?(["user_id = #{is_admin} and trunc(created_at) = trunc(sysdate)"]) == false
        @mensajesboletines = 'SI'
      end
    end
    if Encuesta.exists?(["user_id = #{is_admin}"]) == false
      @mensajesencuesta = 'SI'
    end
    if @mensajesenvios.count >= 1
      redirect_to :controller=>"menus", :action=>"indexsistemas"
    elsif @mensajesenviosc.count >= 1
      redirect_to :controller=>"menus", :action=>"indexarchivo"
    elsif @mensajesboletines == 'SI'
      redirect_to :controller=>"menus", :action=>"indexboletin"
    elsif @mensajesencuesta == 'SI'
      redirect_to :controller=>"menus", :action=>"indexencuesta"
    else
      @remoteadd = request.remote_addr
      @remoteenv = request.env['REMOTE_ADDR']
      @remoteip  = request.remote_ip
      @remote_ip = request.env['HTTP_X_FORWARDED_FOR']
      @remote_ip2 = request.env['REMOTE_HOST']
      @existecorrespondenciapendiente = Correspondenciasasignada.exists?(["user_id = ? and correspondenciasrecibida_id in (select id from correspondenciasrecibidas where fecha_limite <= trunc(sysdate)
                                                                                       and id not in (select correspondenciasrecibida_id from correspondenciasradicados)
                                                                                       and respuesta = 'NO')", is_admin])
      @existecorrespondenciauser      = Correspondenciasrecibidasuser.exists?(["user_id = ? and correspondenciasrecibida_id in (select id from correspondenciasrecibidas where fecha_limite <= trunc(sysdate) and id not in (select correspondenciasrecibida_id from correspondenciasradicados)
                                                                                            and respuesta != 'SI')", is_admin])
      @existecorrespondencia          = Correspondenciasasignada.exists?(["user_id = ? and correspondenciasrecibida_id not in (select correspondenciasrecibida_id from correspondenciasradicados)
                                                                                       and correspondenciasrecibida_id not in (select id from correspondenciasrecibidas where respuesta = 'SI')", is_admin])
      if !@existecorrespondencia
        @existecorrespondencia = Correspondenciasrecibidasuser.exists?(["user_id = ? and correspondenciasrecibida_id not in (select correspondenciasrecibida_id from correspondenciasradicados)
                                                                                     and correspondenciasrecibida_id not in (select id from correspondenciasrecibidas where respuesta = 'SI')", is_admin])
      end
      @correspondenciasrecibidasusers = Correspondenciasrecibidasuser.find(:all, :conditions =>["user_id = #{is_admin} and correspondenciasrecibida_id not in (select correspondenciasrecibida_id from correspondenciasradicados)
                                                                                                                       and correspondenciasrecibida_id not in (select id from correspondenciasrecibidas where correspondenciasclase_id in (10001,10003) or respuesta = 'SI')"])
      @correspondenciasasignadas = Correspondenciasasignada.find(:all, :conditions =>["user_id = #{is_admin} and correspondenciasrecibida_id not in (select correspondenciasrecibida_id from correspondenciasradicados)
                                                                                                             and correspondenciasrecibida_id not in (select id from correspondenciasrecibidas where correspondenciasclase_id in (10001,10003) or respuesta = 'SI')"])
      @usersmodulos = Usersmodulo.find_all_by_user_id(is_admin, :order => "modulo_id")
      #Verificacion de Contratos
      @existecontrato = Contrato.exists?(["estado = 'E' and (decode(fecha_masmodi,null,fecha_final,fecha_masmodi) - 30) <= trunc(sysdate)
                                          and interventorempleado_id in (select distinct id from empleados where userinterventor_id = #{is_admin})"])
    end
    # 2017-08-22 Cruces Atendidos
    @cruceslistos = Crucessolicitud.find(:all, :select =>"clase, user_id, persona_id, created_at, estado", 
                                               :conditions=>["user_id = #{is_admin} and estado in ('TERMINADO','EN TRAMITE') and trunc(updated_at) >= trunc(sysdate)-5"],
                                               :group=>'clase, user_id, persona_id, created_at, estado', :order=>"created_at asc")
    # 2017-08-24 Transporte
    @vehiculossolicitudes = Vehiculossolicitud.find(:all, :conditions=>["(user_id = #{is_admin} or user1_id = #{is_admin} or user2_id = #{is_admin} or user3_id = #{is_admin}) and trunc(updated_at) between trunc(sysdate)-5 and trunc(sysdate)+5"], :order=>"updated_at asc")
    @correspondenciasrevisas = Correspondenciasinterna.find(:all, :conditions=>["user_envia = #{is_admin} and estado ='REVISION'"])

    if !@existecorrespondenciasrevisa
      @existecorrespondenciasrevisa = Correspondenciasrecibidasuser.exists?(["user_id = ? and correspondenciasrecibida_id not in (select correspondenciasrecibida_id from correspondenciasradicados)
                                                                                   and correspondenciasrecibida_id not in (select id from correspondenciasrecibidas where respuesta = 'SI')", is_admin])
    end

    #2017-09-22 Actualizada
    @existesolvisita = Viviendasusada.exists?(['user_solicitavisita = ? and visita_tecnica = ?',is_admin,"REALIZADA"])
    if @existesolvisita
      @viviendasusadas = Viviendasusada.find(:all, :conditions=>["visita_tecnica = 'REALIZADA' and user_solicitavisita = #{is_admin}"])
    end
    if permiso("viviendasusadavisita","C").to_s == "S"
      @existependvisita = Viviendasusada.exists?(['visita_tecnica = ?',"PENDIENTE"])
      if @existependvisita
        @viviendasusadaspendientes = Viviendasusada.find(:all, :conditions=>["visita_tecnica = 'PENDIENTE'"], :order=>"fechasol_visitatecnica asc")
      end
    end
  end

  def alerta
    #Verificacion de Contratos
    ActiveRecord::Base.connection.execute("update contratos set estado = 'T' where estado = 'E' and decode(fecha_masmodi,null,fecha_final,fecha_masmodi) < trunc(sysdate)")
    @existecontrato = Contrato.exists?(["estado = 'E' and (decode(fecha_masmodi,null,fecha_final,fecha_masmodi) - 30) <= trunc(sysdate)
                                         and interventorempleado_id in (select distinct id from empleados where userinterventor_id = #{is_admin})"])
    @contratos = Contrato.find_by_sql(
      "select c.id, c.nro_contrato, c.empleado_id, e.identificacion, e.nombre, c.estado, c.fecha_inicio, decode(fecha_masmodi,null,fecha_final,fecha_masmodi) fch, (decode(fecha_masmodi,null,fecha_final,fecha_masmodi)-trunc(sysdate)) dias
       from   contratos c, empleados e
       where  c.estado = 'E'
       and    (decode(c.fecha_masmodi,null,c.fecha_final,c.fecha_masmodi) - 30) <= trunc(sysdate)
       and    c.empleado_id = e.id
       and    c.interventorempleado_id in (select id from empleados where userinterventor_id = #{is_admin})
       order by (decode(c.fecha_masmodi,null,c.fecha_final,c.fecha_masmodi) - 30)")
  end

  def correspondencia
    @existecorrespondenciapendiente = Correspondenciasasignada.exists?(["user_id = ? and correspondenciasrecibida_id in (select id from correspondenciasrecibidas
                                                                                         where fecha_limite <= trunc(sysdate)
                                                                                         and id not in (select correspondenciasrecibida_id from correspondenciasradicados)
                                                                                         and respuesta = 'NO')", is_admin])
    @existecorrespondenciauser      = Correspondenciasrecibidasuser.exists?(["user_id = ? and correspondenciasrecibida_id in (select id from correspondenciasrecibidas where fecha_limite <= trunc(sysdate) and id not in (select correspondenciasrecibida_id from correspondenciasradicados) and respuesta != 'SI')", is_admin])
    @existecorrespondencia          = Correspondenciasasignada.exists?(["user_id = ? and correspondenciasrecibida_id not in (select correspondenciasrecibida_id from correspondenciasradicados)
                                                                                     and correspondenciasrecibida_id not in (select id from correspondenciasrecibidas where respuesta = 'SI')", is_admin])
    if !@existecorrespondencia
      @existecorrespondencia = Correspondenciasrecibidasuser.exists?(["user_id = ? and correspondenciasrecibida_id not in (select correspondenciasrecibida_id from correspondenciasradicados)
                                                                                   and correspondenciasrecibida_id not in (select id from correspondenciasrecibidas where respuesta = 'SI')", is_admin])
    end
    @correspondenciasrecibidasusers = Correspondenciasrecibidasuser.find(:all, :conditions =>["user_id = #{is_admin} and correspondenciasrecibida_id not in (select correspondenciasrecibida_id from correspondenciasradicados)
                                                                                                                     and correspondenciasrecibida_id not in (select id from correspondenciasrecibidas where correspondenciasclase_id in (10001,10003) or respuesta = 'SI')"])
    @correspondenciasasignadas = Correspondenciasasignada.find(:all, :conditions =>["user_id = #{is_admin} and correspondenciasrecibida_id not in (select correspondenciasrecibida_id from correspondenciasradicados)
                                                                                                           and correspondenciasrecibida_id not in (select id from correspondenciasrecibidas where correspondenciasclase_id in (10001,10003) or respuesta = 'SI')"])
  end

#  def cruce
#    @cruceslistos = Crucessolicitud.find(:all, :conditions =>["user_id = #{is_admin} and estado = 'TERMINADO' and clase = 'CRUCE'"])
#  end

  def indexsistemas
    @mensajesenvios = Mensajesenvio.find_all_by_user_id_and_estado(is_admin,'A')
  end

  def indexarchivo
    @mensajesenviosc = Mensajesenvio.find(:all, :conditions=>["user_id = #{is_admin} and estado = 'C'"], :order=>"created_at desc")
  end

  def indexboletin
    redirect_to boletindia_comunicaciones_path
  end

  def indexencuesta
    redirect_to new_encuesta_path
  end

  private
  def determine_layout
    if ['alerta','correspondencia','cruce'].include?(action_name)
      "new2"
    elsif ['indexsistemas','indexarchivo'].include?(action_name)
      "sistemas"
    else
      "application"
    end
  end
end
