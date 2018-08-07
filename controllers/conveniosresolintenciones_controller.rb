class ConveniosresolintencionesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def new
    @conveniosresolintencion = Conveniosresolintencion.new
    @conveniosresolintencion.convenio_id = params[:convenio_id]
    @conveniosresolintencion.resolucion_id = params[:resolucion_id]
    @conveniosresolintencion.conveniosresolucion_id = params[:conveniosresolucion_id]
    @conveniosresolmejoramiento = Conveniosresolmejoramiento.new
    @conveniosresollista = Conveniosresollista.new
    render :action => "conveniosresolintencion_form"
  end

  def edit
    @conveniosresolintencion = Conveniosresolintencion.find(params[:id])
    @conveniosresolmejoramiento = Conveniosresolmejoramiento.new
    @conveniosresollista = Conveniosresollista.new
    respond_to do |format|
      format.html { render :action => "conveniosresolintencion_form" }
    end
  end

  def create
    @conveniosresolintencion = Conveniosresolintencion.new(params[:conveniosresolintencion])
    @conveniosresolintencion.user_id = is_admin
    if @conveniosresolintencion.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_conveniosresolintencion_path(@conveniosresolintencion)
    else
      @conveniosresolmejoramiento = Conveniosresolmejoramiento.new
      @conveniosresollista = Conveniosresollista.new
      render :action => "conveniosresolintencion_form"
    end
  end

  def update
    @conveniosresolintencion = Conveniosresolintencion.find(params[:id])
    @conveniosresolintencion.user_id = is_admin
      if @conveniosresolintencion.update_attributes(params[:conveniosresolintencion])
        flash[:notice] = "El registro ha sido actualizado con Exito."
        redirect_to edit_conveniosresolintencion_path(@conveniosresolintencion)
      else
        @conveniosresolmejoramiento = Conveniosresolmejoramiento.new
        @conveniosresollista = Conveniosresollista.new
        render :action => "conveniosresolintencion_form"
      end
    rescue
      flash[:notice] = "Existen inconsistencias. Verifique!!!"
      redirect_to edit_conveniosresolintencion_path(@conveniosresolintencion)
  end

  def destroy
    @conveniosresolintencion = Conveniosresolintencion.find(params[:id])
    @convenio = Convenio.find(@conveniosresolintencion.convenio_id)
    @conveniosresolintencion.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to edit_convenio_path(@convenio)
      }
      format.xml  { head :ok }
    end
  end

  def createpagos
    @conveniosresolintencion = Conveniosresolintencion.find(params[:id])
    if @conveniosresolintencion.generada.to_s == ""
      @mjs = "PAGO DE LA INTENCION NRO. "+@conveniosresolintencion.id.to_s + " DEL "+@conveniosresolintencion.conveniosforma.porcentaje.to_s+". AUTOMATICO"
      ActiveRecord::Base.connection.execute("
           insert into mejoramientospagos (id,mejoramiento_id,user_id,conveniosforma_id,fecha_pago,valor,nro_factura,descripcion,created_at,updated_at)
           select mejoramientospagos_seq.nextval,mejoramiento_id,#{is_admin},#{@conveniosresolintencion.conveniosforma_id},
                  '#{@conveniosresolintencion.fecha_pago.to_date}',valor,'#{@conveniosresolintencion.nro_factura}','#{@mjs}',sysdate,sysdate
           from   conveniosresolmejoramientos
           where  conveniosresolintencion_id = #{@conveniosresolintencion.id}
           and    estado = 'SI'")
      ActiveRecord::Base.connection.execute("update conveniosresolintenciones set generada = 'SI', fecha_gen = sysdate
                                             where id = #{params[:id]}")
      flash[:notice] = "Se ha realizado con exito el registro de los pagos de los mejoramientos"
      redirect_to edit_conveniosresolintencion_path(@conveniosresolintencion)
    else
      flash[:notice] = "Ya se genero este proceso de Pagos"
      redirect_to edit_conveniosresolintencion_path(@conveniosresolintencion)
    end
  end

  private
  def determine_layout
    if ['actaaprobacionobra'].include?(action_name)
      "atencion"
    elsif['informeoperador','informefinanciero','informeactualizacion','informepersonal','informecomuna','informeconcepto','informeseguimiento'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end

