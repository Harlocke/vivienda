class CorrespondenciasrecibidasController < ApplicationController

  before_filter :require_user
  layout :determine_layout
  require 'find'

  def upload
    rutaupload = Sifi.find(22).valor.to_s
    ActiveRecord::Base.connection.execute("truncate table error")
    Find.find(rutaupload) do |f|
      type = case
      when File.file?(f) then "F"
        file   = File.open(f, 'rb')
        path   = File.join(rutaupload, File.basename(f).to_s)
        nombre = File.basename(f).to_s
        nombre = nombre.gsub("comunicacion recibida ","")
        nombre = nombre.gsub("Comunicacion recibida ","")
        nombre = nombre.gsub("COMUNICACION RECIBIDA ","")
        nombre = nombre.gsub(".pdf","")
        nombre = nombre.gsub(".PDF","")
        nombre = nombre.gsub("(","")
        nombre = nombre.gsub(")","")
        begin
          @correspondenciasrecibida = Correspondenciasrecibida.find(:first, :conditions=>["nro_radicado = #{nombre} and anno = to_char(sysdate,'YYYY')"])
          if @correspondenciasrecibida
            @corresrecibidasimagen = Corresrecibidasimagen.new
            @corresrecibidasimagen.correspondenciasrecibida_id = @correspondenciasrecibida.id
            @corresrecibidasimagen.descripcion = "Recibida " + File.basename(f).to_s
            @corresrecibidasimagen.recibida = file
            @corresrecibidasimagen.save
            file.close
            File.delete(path)
          else
            ActiveRecord::Base.connection.execute("insert into error values ('No se cargo el archivo : #{File.basename(f).to_s}')")
          end
        rescue
          ActiveRecord::Base.connection.execute("insert into error values ('No se cargo el archivo : #{File.basename(f).to_s}')")
        end
      # si la ruta es un directorio -> D
      when File.directory?(f) then "D"
      # si no sabemos lo que es -> ?
      else "?"
      end
    end
    flash[:notice] = "Proceso finalizado"
    @objetos = Objeto.find_by_sql("select * from error")
    #redirect_to busqueda_correspondenciasenviadas_path
  end

  def index
    dato1  = params[:ubicacion][:correspondenciasremitente_id].to_s rescue nil
    dato2  = params[:ubicacion][:fchelainicial].to_s rescue nil
    dato3  = params[:ubicacion][:fchelafinal].to_s rescue nil
    dato4  = params[:ubicacion][:fchrecinicial].to_s rescue nil
    dato5  = params[:ubicacion][:fchrecfinal].to_s rescue nil
    dato6  = params[:ubicacion][:dependencia_id].to_s rescue nil
    dato7  = params[:ubicacion][:correspondenciasclase_id].to_s rescue nil
    dato8  = params[:ubicacion][:recibidoemail].to_s rescue nil 
    dato9  = params[:ubicacion][:clase].to_s rescue nil
    @correspondenciasrecibidas = Correspondenciasrecibida.search(params[:nro_radicado],
                                                                 params[:identificacion],
                                                                 params[:identificacionb],
                                                                 dato1,dato2,dato3,dato4,dato5,dato6,dato7,
                                                                 params[:asunto],
                                                                 params[:observacion], 
                                                                 params[:nro_externo],
                                                                 params[:empresa],
                                                                 params[:empresar],
                                                                 dato8, 
                                                                dato9, params[:page])
    if @correspondenciasrecibidas.count == 0 
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @corre+spondenciasrecibidas }
      end        
    elsif @correspondenciasrecibidas.count == 1
      redirect_to edit_correspondenciasrecibida_path(:id=>@correspondenciasrecibidas, :etapa=>'1')
    else
        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @correspondenciasrecibidas }
        end   
    end
  end

  def verrecibido
    @correspondenciasrecibida = Correspondenciasrecibida.find(params[:id])
  end

=begin
  def buscar
    @correspondenciasrecibidas = Correspondenciasrecibida.search(
                             params[:nro_radicado],
                             params[:identificacion],
                             params[:identificacionb],
                             params[:ubicacion][:correspondenciasremitente_id],
                             params[:ubicacion][:fchelainicial],
                             params[:ubicacion][:fchelafinal],
                             params[:ubicacion][:fchrecinicial],
                             params[:ubicacion][:fchrecfinal],
                             params[:ubicacion][:dependencia_id],
                             params[:ubicacion][:correspondenciasclase_id],
                             params[:asunto],
                             params[:observacion], 
                             params[:nro_externo],
                             params[:empresa],
                             params[:empresar], params[:page])
    if @correspondenciasrecibidas.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_correspondenciasrecibidas_path
    elsif @correspondenciasrecibidas.count == 1 and params[:format] != 'xls'
      redirect_to edit_correspondenciasrecibida_path(@correspondenciasrecibidas)
    else
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end
=end

  def consolidado
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="Consolidadorecibida_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @correspondenciasrecibidas = Correspondenciasrecibida.searchconsolidado(
                             params[:identificacion],
                             params[:ubicacion][:correspondenciasremitente_id],
                             params[:ubicacion][:fchelainicial],
                             params[:ubicacion][:fchelafinal],
                             params[:ubicacion][:fchrecinicial],
                             params[:ubicacion][:fchrecfinal],
                             params[:ubicacion][:dependencia_id],
                             params[:ubicacion][:correspondenciasclase_id],
                             params[:ubicacion][:entregafchelainicial],
                             params[:ubicacion][:entregafchelafinal],
                             params[:ubicacion][:userentregado_id],
                             params[:ubicacion][:userasignado_id],
                             params[:asunto],
                             params[:ubicacion][:recibidoemail]
                           )
  end

  def pendiente
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="pendientes_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @correspondenciasrecibidas = Correspondenciasrecibida.find_by_sql("select * from correspondenciasrecibidas where id not in (select correspondenciasrecibida_id from correspondenciasradicados)")
  end

  def buscarpendiente
    perpage = 0
    if params[:format] == 'xls'
      perpage = 10000
    else
      perpage = 15
    end    
    @correspondenciasrecibidas = Correspondenciasrecibida.searchpendiente(params[:ubicacion][:creainicial],
                                                                          params[:ubicacion][:creafinal],
                                                                          params[:page],perpage)
    if @correspondenciasrecibidas.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to correspondenciasrecibidas_path
    else
      if params[:format] == 'xls'
        headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        headers['Content-Disposition'] = 'attachment; filename="PendientesRecibidos_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
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
  end



#  def recordaciones
#    if Recordacion.exists?(["trunc(fecha) = trunc(sysdate)"]) == true
#      flash[:notice] = "Ya fue enviado"
#    else
#      if Time.now.strftime("%X") >= "06:00:00"
#        @correspondenciasrecibida = Correspondenciasrecibida.new
#        @correspondenciasrecibida.enviorecordaciones
#        flash[:notice] = "Recordaciones enviadas " + " - " +Time.now.strftime("%Y-%m-%d %X")
#        @recordacion = Recordacion.new
#        @recordacion.fecha = Time.now
#        @recordacion.save
#      end
#    end
#    @recordaciones = Recordacion.find(:all, :order =>"fecha desc")
#  end

  def new
    @correspondenciasrecibida = Correspondenciasrecibida.new
    @correspondenciasrecibida.etapa = '1'
    render :action => "correspondenciasrecibida_form"
  end

  def edit
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update correspondenciasrecibidas set etapa = '#{params[:etapa]}' where id = #{params[:id]}")
    end    
    @correspondenciasrecibida = Correspondenciasrecibida.find(params[:id])
    if @correspondenciasrecibida.etapa.to_s == "2"
      @correspondenciasdependencia = Correspondenciasdependencia.new
    elsif @correspondenciasrecibida.etapa.to_s == "3"
      @corresrecibidasimagen = Corresrecibidasimagen.new
    elsif @correspondenciasrecibida.etapa.to_s == "4"
      @correspondenciasrecibidasuser = Correspondenciasrecibidasuser.new
    end
    respond_to do |format|
      format.html { render :action => "correspondenciasrecibida_form" }
    end
  end

  def create
    @correspondenciasrecibida = Correspondenciasrecibida.new(params[:correspondenciasrecibida])
    if @correspondenciasrecibida.fecha_elaboracion.strftime("%Y-%m-%d") > Time.now.strftime("%Y-%m-%d")
      flash[:notice] = "ATENCIÓN: La fecha del documento no puede tener fecha superior a "+Time.now.strftime("%Y-%m-%d")
      render :action => "correspondenciasrecibida_form"
    else
      @correspondenciasrecibida.user_id = is_admin
      @correspondenciasrecibida.useract_id = is_admin
      @correspondenciasrecibida.respuesta = 'NO'
      @correspondenciasrecibida.fecha_recibido = Time.now
      @correspondenciasrecibida.etapa = '1'
      dias = Correspondenciasclase.find(@correspondenciasrecibida.correspondenciasclase_id).dias rescue nil
      begin
        festivos = Festivo.find_by_sql("select fnc_dias(to_date('#{@correspondenciasrecibida.fecha_recibido}','dd/mm/yyyy'),#{dias}) fch from dual")
        festivos.each do |festivo|
          @correspondenciasrecibida.fecha_limite = festivo.fch
        end
      rescue
        @correspondenciasrecibida.fecha_limite = ""
      end
      @correspondenciasrecibida.anno = Time.now.strftime("%Y")
      @correspondenciasrecibida.nro_radicado = is_nextrecibida
      if @correspondenciasrecibida.save
        @correspondenciasrecibida.bandejacorrespondencia
        flash[:notice] = "El registro ha sido registrado con Exito."
        redirect_to edit_correspondenciasrecibida_path(@correspondenciasrecibida)
      else
        render :action => "correspondenciasrecibida_form"
      end
    end
    rescue
      flash[:notice] = "Existen inconsistencias. Verifique!!!"
      redirect_to new_correspondenciasrecibida_path
  end

  def update
    @correspondenciasrecibida = Correspondenciasrecibida.find(params[:id])
    @correspondenciasrecibida.useract_id = is_admin
    #@correspondenciasrecibida.enviorecordaciones
    if params[:correspondenciasrecibida][:fecha_elaboracion] > Time.now.strftime("%Y-%m-%d")
      flash[:notice] = "ATENCIÓN: La fecha del documento no puede tener fecha superior a "+Time.now.strftime("%Y-%m-%d")
      @correspondenciasdependencia = Correspondenciasdependencia.new
      @corresrecibidasimagen = Corresrecibidasimagen.new
      @correspondenciasrecibidasuser = Correspondenciasrecibidasuser.new
      render :action => "correspondenciasrecibida_form"
    else
#    dias = Correspondenciasclase.find(params[:correspondenciasrecibida][:correspondenciasclase_id]).dias rescue nil
#    begin
#      festivos = Festivo.find_by_sql("select fnc_dias(to_date('#{params[:correspondenciasrecibida][:fecha_elaboracion]}','dd/mm/yyyy'),#{dias}) fch from dual")
#      festivos.each do |festivo|
#        params[:correspondenciasrecibida][:fecha_limite] = festivo.fch
#      end
#    rescue
#      params[:correspondenciasrecibida][:fecha_limite] = ""
#    end
      if @correspondenciasrecibida.update_attributes(params[:correspondenciasrecibida])
        flash[:notice] = "El registro ha sido actualizado con Exito."
        redirect_to edit_correspondenciasrecibida_path(@correspondenciasrecibida)
      else
        @correspondenciasdependencia = Correspondenciasdependencia.new
        @corresrecibidasimagen = Corresrecibidasimagen.new
        @correspondenciasrecibidasuser = Correspondenciasrecibidasuser.new
        render :action => "correspondenciasrecibida_form"
      end
#    rescue
#      flash[:notice] = "Existen inconsistencias. Verifique!!!"
#      redirect_to edit_correspondenciasrecibida_path(@correspondenciasrecibida)
    end
  end

  def destroy
    @correspondenciasrecibida = Correspondenciasrecibida.find(params[:id])
    @correspondenciasrecibida.destroy
    respond_to do |format|
       format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to correspondenciasrecibidas_path
        }
      format.xml  { head :ok }
    end
  end

  def recibida
    @correspondenciasrecibida = Correspondenciasrecibida.find(params[:id])
    @correspondenciasrecibida.userrecibida_id = is_admin
    @correspondenciasrecibida.fecharecibida = Time.now
    @correspondenciasrecibida.save
    flash[:notice] = "Registro recibido con exito."
    redirect_to edit_correspondenciasrecibida_path(@correspondenciasrecibida)
  end

  def show
    persona   = Persona.find(params[:correspondenciasrecibida_id])
    @correspondenciasrecibidas = persona.correspondenciasrecibidas.all
  end

  def stikerp
    @correspondenciasrecibidas = Correspondenciasrecibida.find(:all, :conditions=>["to_number(nro_radicado) between #{params[:inicial]} and #{params[:final]} and to_char(fecha_recibido,'YYYY') = '#{Time.now.strftime("%Y")}'"], :order=>"to_number(nro_radicado)")
    @cantidad = params[:cantidad]
  end

  def enviocorrespondencia
    @correspondenciasrecibida = Correspondenciasrecibida.find(params[:id])
    if @correspondenciasrecibida.corresrecibidasimagenes.exists? == true
      @correos = @correspondenciasrecibida.dependencia.depcorreo rescue nil
      @dependencianombre = @correspondenciasrecibida.dependencia.descripcion rescue nil
      if @correos.to_s != ""
        begin
          Notifier.deliver_correspondenciasrecibida_message(@correspondenciasrecibida, @correos, @dependencianombre)
          sleep 10
          ActiveRecord::Base.connection.execute("update correspondenciasrecibidas set fechaenvio = sysdate, user_envio = #{is_admin} where id = #{@correspondenciasrecibida.id}")
          rescue Exception => exc
            logger.error("SIFI ERROR correspondenciasrecibida - Correo NO enviado a #{@correos}")
        end
        flash[:notice] = "Correo Enviado"
        redirect_to edit_correspondenciasrecibida_path(@correspondenciasrecibida)
      else
        flash[:notice] = "No hay correos para enviar - Correo NO Enviado"
        redirect_to edit_correspondenciasrecibida_path(@correspondenciasrecibida)
      end
    else
      flash[:notice] = "No hay archivo digital para enviar en el Correo - Correo NO Enviado"
      redirect_to edit_correspondenciasrecibida_path(@correspondenciasrecibida)
    end
  end


  private
  def determine_layout
    if ['verrecibido'].include?(action_name)
      "new2"
    elsif['consolidado','pendiente'].include?(action_name)
      "excel"
    elsif['stikerp'].include?(action_name)
      "stiker"
    elsif ['stikerinforme'].include?(action_name)
      "atencion"
    elsif ['recordaciones'].include?(action_name)
      "automatic"
    else
      "application"
    end
  end
end