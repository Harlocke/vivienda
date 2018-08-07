class AlmacenesentradasController < ApplicationController

  before_filter :require_user
  
  def index
    @almacenesentradas = Almacenesentrada.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @almacenesentradas }
    end
  end

  def buscar
    @almacenesentradas = Almacenesentrada.search(params[:ubicacion][:producto_id],
                             params[:ubicacion][:empresa],
                             params[:nro_factura],
                             params[:nro_remision],
                             params[:ubicacion][:inicial],
                             params[:ubicacion][:final])
    if @almacenesentradas.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_almacenesentradas_path
    elsif @almacenesentradas.count == 1 and params[:format] != 'xls'
      redirect_to edit_almacenesentrada_path(@almacenesentradas)
    else
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end

  def informe4
    if params[:ubicacion][:anno].to_s == ""
      flash[:notice] = "No hay informacion para generar el proceso. Verifique!!!"
      redirect_to reporte_almacenes_path
    else
      @anno = params[:ubicacion][:anno]
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_InformeCompleto_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"      
      respond_to do |format|
         format.xls
      end
    end

  end

  def new
    @almacenesentrada = Almacenesentrada.new
    if params[:id]
      @alm = Almacenesentrada.find(params[:id])
      @almacenesentrada.nro_factura = @alm.nro_factura
      @almacenesentrada.nro_remision = @alm.nro_remision
      @almacenesentrada.fecha_factura = @alm.fecha_factura
      @almacenesentrada.empleado_id = @alm.empleado_id
    end
    render :action => "almacenesentrada_form"
  end
  
  def edit
    @almacenesentrada = Almacenesentrada.find(params[:id])
    respond_to do |format|
      format.html { render :action => "almacenesentrada_form" }
    end
  end

  def create
    @almacenesentrada = Almacenesentrada.new(params[:almacenesentrada])
    @almacenesentrada.user_id = is_admin
    if @almacenesentrada.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_almacenesentrada_path(@almacenesentrada)
    else
      render :action => "almacenesentrada_form"
    end
  end

  def update
    @almacenesentrada = Almacenesentrada.find(params[:id])
     params[:almacenesentrada][:user_actualiza] = is_admin
    if @almacenesentrada.update_attributes(params[:almacenesentrada])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_almacenesentrada_path(@almacenesentrada)
    else
      render :action => "almacenesentrada_form"
    end
    rescue
      redirect_to edit_almacenesentrada_path(@almacenesentrada)
  end

  def destroy
    @almacenesentrada = Almacenesentrada.find(params[:id])
    @almacenesentrada.destroy
    respond_to do |format|
      format.html { redirect_to(almacenesentradas_url) }
      format.xml  { head :ok }
    end
  end

  def valorunitario
     valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     valor = valor.to_f * pvr2.to_f
     render :update do |page|
       page[:almacenesentrada_valor_total][:value] = valor
     end
  end

  def cantidad
     valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     valor = valor.to_f * pvr2.to_f
     render :update do |page|
       page[:almacenesentrada_valor_total][:value] = valor
     end
  end
end