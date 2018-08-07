class UserSessionsController < ApplicationController

  layout 'basico'

  def new
    @remoteenv = request.env['REMOTE_ADDR']
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      #ip = request.env['HTTP_X_FORWARDED_FOR']
      ip = request.env['REMOTE_ADDR']
      #remoteip  = request.remote_ip
      #remote_ip = request.env['HTTP_X_FORWARDED_FOR']
      #remote_ip2 = request.env['REMOTE_HOST']
      #dato = remoteip.to_s + " - " +remote_ip.to_s + " - " +remote_ip2.to_s

      usuario = @user_session.try(:record)
      @user = User.find(usuario.id)
      if @user.activo == "S"
        if @user.acceso_remoto == "S"
          nombre = @user_session.user.nombre
          flash[:notice] = "Has Iniciado Sesión Correctamente. Bienvenido al Sistema de Informacion de ISVIMED - "+nombre.upcase.to_s
          redirect_to menus_path
        else
          if Acceso.exists?(["ip = ?", ip]) == true
            nombre = @user_session.user.nombre
            flash[:notice] = "Has Iniciado Sesión Correctamente. Bienvenido al Sistema de Informacion de ISVIMED - "+nombre.upcase.to_s+"..."
            redirect_to menus_path
          else
            current_user_session.destroy
            #flash[:notice] = "Usuario sin perfil para conexiones remotas o su IP no se encuentra registrada. Contacte al Administrador.."
            redirect_back_or_default new_user_session_url
          end
        end
      else
        t = current_user_session.record
        current_user_session.destroy
        #flash[:notice] = "Usuario Inactivo. Contacte al Administrador"
        redirect_back_or_default new_user_session_url
      end
    else
      render :action => :new
    end
  end



#      #ip = request.env['REMOTE_ADDR']
#      ip = request.env['HTTP_X_FORWARDED_FOR']
#      #ip2 = request.env["HTTP_X_FORWARDED_FOR"]
#      usuario = @user_session.try(:record)
#      @user = User.find(usuario.id)
#      if @user.acceso_remoto == "S"
#        if @user.estado == "A"
#          tim = Time.now
#          flash[:notice] = "Has Iniciado Sesión Correctamente... " + tim.strftime("%m/%d/%Y %I:%M:%S") + " --- " +ip.to_s
#          u = Usersingreso.new
#          t = @user_session.try(:record)
#          u.tipo= "E"
#          u.user_id = t.id
#          u.fecha = Time.now
#          u.save
#          redirect_to menus_path
#        else
#          t = current_user_session.record
#          current_user_session.destroy
#          flash[:notice] = "Usuario Inactivo. Contacte al Administrador"
#          redirect_back_or_default new_user_session_url
#        end
#      else
#        if @user.estado == "A"
#          @existeip = Acceso.exists?(["ip = ?", ip.to_s])
#          if @existeip
#            tim = Time.now
#            flash[:notice] = "Has Iniciado Sesión Correctamente... " + tim.strftime("%m/%d/%Y %I:%M:%S") + " --- " +ip.to_s
#            u = Usersingreso.new
#            t = @user_session.try(:record)
#            u.tipo= "E"
#            u.user_id = t.id
#            u.fecha = Time.now
#            u.save
#            redirect_to menus_path
#          else
#            t = current_user_session.record
#            current_user_session.destroy
#            flash[:notice] = "No tiene acceso al SIC o la IP (#{ip.to_s}) no se encuentra registrada en el Sistema. Contacte al Administrador"
#            redirect_back_or_default new_user_session_url
#          end
#        else
#          t = current_user_session.record
#          current_user_session.destroy
#          flash[:notice] = "Usuario Inactivo. Contacte al Administrador"
#          redirect_back_or_default new_user_session_url
#        end
#      end


  def destroy
    current_user_session.destroy
    #flash[:notice] = "Has Cerrado Sesión Correctamente"
    redirect_back_or_default new_user_session_url
  end
end