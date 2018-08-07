include ChainSelectsHelper
class AyudasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def certificacionprograma
    @ayuda = Ayuda.find(params[:id])
     respond_to do |format|
      format.pdf  { render :layout => false }
    end
  end

  def index
    if Agenda.exists?(["useratencion_id = #{is_admin} and estado = 'INICIAR' and agendasfecha in (select id from agendasfechas where fecha = trunc(sysdate))"]) 
      id = Agenda.find(:first, :conditions=>["useratencion_id = #{is_admin} and estado = 'INICIAR' and agendasfecha in (select id from agendasfechas where fecha = trunc(sysdate))"]).ayuda_id
      redirect_to edit_ayuda_path(:id =>id, :etapa=>'1')
    end
  end

  def informe
    @ayudas = Ayuda.all
    respond_to do |format|
       format.xls
    end
  end
=begin
  def buscar
    @ayudas = Ayuda.search(params[:identificacion],
                           params[:ubicacion][:tipoevacuacion],
                           params[:ubicacion][:categoriaisvimed],
                           params[:ubicacion][:fchinicial],
                           params[:ubicacion][:fchfinal],
                           params[:nroficha],
                           params[:ubicacion][:ayudastiposevento_id]
                       )
    if @ayudas.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to ayudas_path
    elsif @ayudas.count == 1 and params[:format] != 'xls'
       redirect_to edit_ayuda_path(:id => @ayudas, :etapa=>"1")
    else
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end
=end

#REQ-0 Arrendamiento temporal - harlynton.castano - 22/03/2018

  def buscar
    @ayudas = Ayuda.search(params[:identificacion],
                           params[:nombre],
                           params[:tiporelacion],
                           params[:carpeta],
                           params[:direccion],
                           params[:nroficha]
                       )
    if @ayudas.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to ayudas_path
    elsif @ayudas.count == 1 and params[:format] != 'xls'
       redirect_to edit_ayuda_path(:id => @ayudas, :etapa=>"1")
    else
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end

  def new
    @ayuda = Ayuda.new
    @ayuda.etapa = "1"
    render :action => "ayuda_form"
  end

  def edit
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update ayudas set etapa = '#{params[:etapa]}' where id = #{params[:id]}")
    end
    @ayuda  = Ayuda.find(params[:id])
    if @ayuda.etapa.to_s == "1"
      @mejoramientosconcepto = Mejoramientosconcepto.new  
    elsif @ayuda.etapa.to_s == "2"
      @ayudasficha = Ayudasficha.new
    elsif @ayuda.etapa.to_s == "3"
      @ayudaspago = Ayudaspago.new
    elsif @ayuda.etapa.to_s == "4"
      @ayudasnovedad = Ayudasnovedad.new
    elsif @ayuda.etapa.to_s == "5"
      @ayudasvivienda = Ayudasvivienda.new
    elsif @ayuda.etapa.to_s == "6"
      @ayudasobservacion = Ayudasobservacion.new
    elsif @ayuda.etapa.to_s == "7"
      @ayudastaller = Ayudastaller.new
    elsif @ayuda.etapa.to_s == "8"
      @ayudasadicional = Ayudasadicional.new
    elsif @ayuda.etapa.to_s == "9"
      @ayudassocial = Ayudassocial.new
    elsif @ayuda.etapa.to_s == "10"
      @ayudascontrato = Ayudascontrato.new
    elsif @ayuda.etapa.to_s == "11"
      @ayudasorientacion = Ayudasorientacion.new
    elsif @ayuda.etapa.to_s == "18"
      @ayudasetapa = Ayudasetapa.new
    elsif @ayuda.etapa.to_s == "19"
      @ayudasdocumento = Ayudasdocumento.new
    end
    @existeresolucionespersona = @ayuda.persona.resolucionespersonas.exists?
    @existecruce = Cruce.exists?(["persona_id = ? or benevivienda_id in (select id from beneviviendas where persona_id = ?)", @ayuda.persona.id, @ayuda.persona.id])
    @existerecibida = @ayuda.persona.correspondenciasrecibidas.exists?
    @existeenviada = @ayuda.persona.correspondenciasenviadas.exists?
    @agendasalertas = Agendasalerta.find(:all, :conditions=>["persona_id = #{@ayuda.persona_id} and estado = 'PENDIENTE'"])
    respond_to do |format|
      format.html { render :action => "ayuda_form" }
    end
  end

  def create
    @ayuda = Ayuda.new(params[:ayuda])
    @ayuda.etapa = "1"
    @ayuda.user_id = is_admin
    if @ayuda.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_ayuda_path(@ayuda)
    else
      render :action => "ayuda_form"
    end
  end

  def update
    @ayuda = Ayuda.find(params[:id])
    @ayuda.user_id = is_admin
    if @ayuda.update_attributes(params[:ayuda])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_ayuda_path(@ayuda)
    else
      @mejoramientosconcepto = Mejoramientosconcepto.new    
      @existeresolucionespersona = @ayuda.persona.resolucionespersonas.exists?
      @existecruce = Cruce.exists?(["persona_id = ? or benevivienda_id in (select id from beneviviendas where persona_id = ?)", @ayuda.persona.id, @ayuda.persona.id])
      @existerecibida = @ayuda.persona.correspondenciasrecibidas.exists?
      @existeenviada = @ayuda.persona.correspondenciasenviadas.exists?
      render :action => "ayuda_form"
    end
    rescue
      redirect_to edit_ayuda_path(@ayuda)
  end

  def destroy
    @ayuda = Ayuda.find(params[:id])
    @ayuda.destroy
    respond_to do |format|
      format.html { redirect_to(ayudas_url) }
      format.xml  { head :ok }
    end
  end

  def show
    persona   = Persona.find(params[:ayuda_id])
    @ayudas = persona.ayudas.all
  end

  private
  def determine_layout
    if ['import','csv_import','pendientesentrega','notificapendiente','asignar','certificacionprograma'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
