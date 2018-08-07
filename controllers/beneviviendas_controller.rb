class BeneviviendasController < ApplicationController

  before_filter :require_user

  layout :determine_layout

  def index
    persona   = Persona.find(params[:persona_id])
    @beneviviendas = persona.beneviviendas.all
  end

  def edit
    @benevivienda  = Benevivienda.find(params[:id], :include => "persona")
    @persona  = @benevivienda.persona
    respond_to do |format|
      format.js { render :action => "edit_benevivienda" }
    end
  end

  def visualizar
    @benevivienda  = Benevivienda.find(params[:id])
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @benevivienda = Benevivienda.new(params[:benevivienda])
    #@benevivienda.identificacion = (params[:benevivienda][:identificacion].to_i).to_s.strip
    @benevivienda.user_id = is_admin
    if params[:benevivienda][:fecha_nacimiento].to_s != ""
      if params[:benevivienda][:fecha_nacimiento].to_d <= '1970-01-01'.to_d
        fecha = params[:benevivienda][:fecha_nacimiento]
      end
    end
    if @benevivienda.valid?
      @persona.beneviviendas << @benevivienda
      @persona.save
      if fecha
        ActiveRecord::Base.connection.execute("update beneviviendas set fecha_nacimiento = '#{fecha}' where id = #{@benevivienda.id}")
      end
      @benevivienda = Benevivienda.new
      flash[:benevivienda] = "Creado con exito"
    else
      flash[:benevivienda] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "beneviviendas" }
    end
  end

  def update
    @benevivienda   = Benevivienda.new
    benevivienda    = Benevivienda.find(params[:id])
    #identi = (params[:benevivienda][:identificacion].to_i).to_s.strip
    #params[:benevivienda][:identificacion] = identi
    params[:benevivienda][:useract_id] = is_admin
    if params[:benevivienda][:fecha_nacimiento].to_s != ""
      if params[:benevivienda][:fecha_nacimiento].to_d <= '1970-01-01'.to_d
        fecha = params[:benevivienda][:fecha_nacimiento]
      end
    end
    @persona        = benevivienda.persona
    ok = benevivienda.update_attributes(params[:benevivienda])
    if ok == true
      if fecha
        ActiveRecord::Base.connection.execute("update beneviviendas set fecha_nacimiento = '#{fecha}' where id = #{params[:benevivienda][:id]}")
      end
      flash[:benevivienda] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "beneviviendas" }
      end
    else
      render :update do |page|
         page.alert "El registro tiene inconsistencias. Verifique!!"
      end
    end
  end

  def listar
      @beneviviendas = Benevivienda.find(:all, :conditions => [' identificacion =  ?', "#{params[:search2]}"])
      #@personas = Persona.find(:all, :conditions => [' autobuscar LIKE ?', "%#{params[:search]}%"])
  end

  def destroy
    benevivienda   = Benevivienda.find(params[:id])
    @persona  = benevivienda.persona
    @benevivienda  = Benevivienda.new
    benevivienda.respaldo(is_admin)
    benevivienda.destroy
    flash[:benevivienda] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "beneviviendas" }
    end
  end

  private
  def determine_layout
    if ['create'].include?(action_name)
      "application"
#    else
#      "basico"
    end
  end
end
