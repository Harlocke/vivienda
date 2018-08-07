class ConveniosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    if permiso("conveniosmejoramiento","C").to_s == "S"
      @convenios = Convenio.find(:all, :conditions=>["tipo_solucion='MEJORAMIENTO'"], :order=>"nro_convenio")
    elsif permiso("conveniosotro","C").to_s == "S"
      @convenios = Convenio.find(:all, :conditions=>["tipo_solucion!='MEJORAMIENTO' or id = 116"], :order=>"nro_convenio")
    elsif permiso("conveniossocial","C").to_s == "S"
      @convenios = Convenio.find(:all, :conditions=>["tipo_solucion='MEJORAMIENTO'"], :order=>"nro_convenio")
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @convenios }
    end
  end

  def new
    @convenio = Convenio.new
    @convenio.etapa = '1'    
    render :action => "convenio_form"
  end

  def actaaprobacionobra
    ActiveRecord::Base.connection.execute("begin prc_conveniosmejoramientos(#{params[:id].to_i}); end;")
    @convenio = Convenio.find(params[:id])
  end

  def edit
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update convenios set etapa = '#{params[:etapa]}' where id = #{params[:id]}")
    end        
    @convenio = Convenio.find(params[:id])
    if @convenio.etapa.to_s == "2"
      @conveniospersona = Conveniospersona.new
    elsif @convenio.etapa.to_s == "3"
      @conveniospago = Conveniospago.new
    elsif @convenio.etapa.to_s == "4"
      @conveniosetapa = Conveniosetapa.new
    elsif @convenio.etapa.to_s == "5"
      @conveniosobservacion = Conveniosobservacion.new
    elsif @convenio.etapa.to_s == "6"
      @conveniosimagen = Conveniosimagen.new
    elsif @convenio.etapa.to_s == "7"
      @convenioscontrato = Convenioscontrato.new
    elsif @convenio.etapa.to_s == "8"
      @conveniosmejoramiento = Conveniosmejoramiento.new
    elsif @convenio.etapa.to_s == "9"
      @conveniosresolucion = Conveniosresolucion.new
    elsif @convenio.etapa.to_s == "10"
      @conveniosforma = Conveniosforma.new
    elsif @convenio.etapa.to_s == "11"
      @conveniosresolucion = Conveniosresolucion.new
    end
    respond_to do |format|
      format.html { render :action => "convenio_form" }
    end
  end

  def create    
    @convenio = Convenio.new(params[:convenio])
    @convenio.user_id = is_admin
    @convenio.usercrea = is_admin
    @convenio.etapa = '1'
    if @convenio.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_convenio_path(@convenio)
    else
      render :action => "convenio_form"
    end
  end

  def update
    @convenio = Convenio.find(params[:id])
    @convenio.user_id = is_admin
      if @convenio.update_attributes(params[:convenio])
        flash[:notice] = "El registro ha sido actualizado con Exito."
        redirect_to edit_convenio_path(@convenio)
      else
        render :action => "convenio_form"
      end
    rescue
      flash[:notice] = "Existen inconsistencias. Verifique!!!"
      redirect_to edit_convenio_path(@convenio)
  end

  def destroy
    @convenio = Convenio.find(params[:id])
    @convenio.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to convenios_path
      }
      format.xml  { head :ok }
    end
  end

  def show
    persona   = Persona.find(params[:convenio_id])
    @convenios = persona.convenios.all
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