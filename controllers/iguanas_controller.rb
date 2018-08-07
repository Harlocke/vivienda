class IguanasController < ApplicationController
  layout :determine_layout
  before_filter :require_user

  def index
    dato  = params[:ubicacion][:proyecto].to_s rescue nil
    dato2 = params[:ubicacion][:tipo].to_s rescue nil
    perpage = 0
    if params[:format] == 'xls'
      perpage = 10000
    else
      perpage = 15
    end          
    @iguanas =  Iguana.search(dato,
                              params[:nro_registro],
                              params[:encuesta],
                              params[:cobama],
                              dato2,
                              params[:identificacion],
                              params[:inmueble],
                              params[:ficticia],                              
                              params[:page],perpage)    
    if @iguanas.count == 0 and params[:format] != 'xls'
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @iguanas }
      end        
    elsif @iguanas.count == 1 and params[:format] != 'xls'
      redirect_to edit_iguana_path(:id=>@iguanas, :etapa=>"1")
    else
      if params[:format] == 'xls'
        headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        headers['Content-Disposition'] = 'attachment; filename="SIFI_Reasentamiento_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
        headers['Cache-Control'] = 'max-age=0'
        headers['pragma']="public"
        respond_to do |format|
           format.xls
        end
      else
        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @iguanas }
        end   
      end
    end
  end

  def cierre
    @iguana = Iguana.find(params[:id])
  end

  def show
    @iguana = Iguana.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @iguana }
    end
  end

  def buscar
    @iguana  = Iguana.new
    @iguana.proyecto =  params[:ubicacion][:proyecto]
    @iguana.nro_registro =  params[:nro_registro]
    @iguana.encuesta =  params[:encuesta]
    @iguana.cobama =  params[:cobama]
    @iguana.clasereasentamiento =  params[:ubicacion][:tipo]
    @iguanas = Iguana.search(@iguana, params[:identificacion], params[:page])    
    if @iguanas.count == 0 and params[:format] != 'xls'
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @iguanas }
      end        
    elsif @iguanas.count == 1 and params[:format] != 'xls'
      redirect_to edit_iguana_path(:id=>@iguanas, :etapa=>"1")
    else
      if params[:format] == 'xls'
        headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        headers['Content-Disposition'] = 'attachment; filename="SIFI_Reasentamiento_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
        headers['Cache-Control'] = 'max-age=0'
        headers['pragma']="public"
        respond_to do |format|
           format.xls
        end
      else
        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @iguanas }
        end   
      end
    end
  end

  def informe
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="iguanainforme_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @iguanasobservaciones = Iguanasobservacion.search(params[:ubicacion][:usuario],
                             params[:ubicacion][:fchinicial],
                             params[:ubicacion][:fchfinal])
    respond_to do |format|
       format.xls
    end
  end

  def consolidado
    if params[:ubicacion][:proyecto] != ""
      @proyecto = params[:ubicacion][:proyecto].to_s
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="'+"#{@proyecto}"+'_consolidado_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @iguanas = Iguana.find(:all, :conditions=>["proyecto = '#{params[:ubicacion][:proyecto]}'"])
    else
      flash[:notice] = "Debe seleccionar el Proyecto"
      redirect_to iguanas_path
    end

  end

  def informespago
    if params[:ubicacion][:proyecto] != ""
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="'+"#{params[:ubicacion][:proyecto]}"+'_pagos_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @iguanas = Iguana.find(:all, :conditions=>["proyecto = '#{params[:ubicacion][:proyecto]}'"])
      @iguanaspagos = Iguanaspago.find(:all, :conditions=>["iguana_id in (select id from iguanas where proyecto = '#{params[:ubicacion][:proyecto]}')"])
      respond_to do |format|
         format.xls
      end
    else
      flash[:notice] = "Debe seleccionar el Proyecto"
      redirect_to iguanas_path
    end
  end

  def new
    @iguana = Iguana.new
    @iguana.clasereasentamiento = params[:tipo]
    @iguana.etapa = '1'
    render :action => "iguana_form"
  end

  def edit
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update iguanas set etapa = '#{params[:etapa]}' where id = #{params[:id]}")
    end        
    @iguana = Iguana.find(params[:id])
    if @iguana.etapa.to_s == "2"
      @iguanaspersona = Iguanaspersona.new
    elsif @iguana.etapa.to_s == "3"
      @iguanaspago  = Iguanaspago.new
    elsif @iguana.etapa.to_s == "4"
      @iguanasobservacion = Iguanasobservacion.new
    elsif @iguana.etapa.to_s == "5"
      @iguanasimagen = Iguanasimagen.new
    elsif @iguana.etapa.to_s == "6"
      @iguanasmejora = Iguanasmejora.new
    elsif @iguana.etapa.to_s == "7"
      @iguanasrentista = Iguanasrentista.new      
    end
    respond_to do |format|
      format.html { render :action => "iguana_form" }
    end
  end

  def create
    @iguana = Iguana.new(params[:iguana])
    @iguana.fecha_limite = fechaprog(@iguana.fecha_sol_rev_avaluo, 214)
    @iguana.user_id = is_admin
    @iguana.etapa = '1'
    if @iguana.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      is_trigger_iguana(@iguana.id,is_admin,'iguana','I',@iguana.id)
      redirect_to edit_iguana_path(@iguana)
    else
      render :action => "iguana_form"
    end
  end

  def update
    @iguana = Iguana.find(params[:id])
    params[:iguana][:useract_id] = is_admin
    if @iguana.update_attributes(params[:iguana])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      is_trigger_iguana(@iguana.id,is_admin,'iguana','A',@iguana.id)
      redirect_to edit_iguana_path(@iguana)
    else
      flash[:notice] = "Error al realizar la actualizacion."
      render :action => "iguana_form"
    end
    rescue
     redirect_to edit_iguana_path(@iguana)
  end

  def destroy
    @iguana = Iguana.find(params[:id])
    @iguana.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to iguanas_path
        }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['cierre'].include?(action_name)
      "atencion"
    elsif ['consolidado'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end
