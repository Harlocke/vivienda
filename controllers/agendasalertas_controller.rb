class AgendasalertasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @agendasalertas = Agendasalerta.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @agendasalertas }
    end
  end

  def new
   @agendasalerta = Agendasalerta.new
   @agendasalerta.persona_id = params[:persona_id]
   @agendasalerta.ayuda_id = params[:ayuda_id]
   render :action => "agendasalerta_form"
  end

  # GET /agendasalertas/1/edit
  def edit
    @agendasalerta = Agendasalerta.find(params[:id])
  end

  def create
   @agendasalerta = Agendasalerta.new(params[:agendasalerta])
   @agendasalerta.user_id = is_admin
   @agendasalerta.estado = 'PENDIENTE'
   if @agendasalerta.save
      redirect_to :controller=>"agendasalertas", :action=>"alerta", :id=>@agendasalerta.id
   else
      flash[:warning] = "Precaución: Problemas con la creacion de la Alerta"
      render :action => "agendasalerta_form"
   end
  end

  def alerta
   @agendasalerta = Agendasalerta.find(params[:id])
   @valor = "La Alerta ha sido registrada existosamente!!"
 end



  def cambioestado
     @agendasalerta = Agendasalerta.find(params[:id])
     @agendasalerta.user_desactiva = is_admin
     @agendasalerta.estado = params[:estado]
     @agendasalerta.save
     redirect_to edit_ayuda_path(:id =>params[:idayuda])
  end

 def show
   @agendasalerta = Agendasalerta.find(params[:id])
   respond_to do |format|
     format.html # show.html.erb
     format.xml  { render :xml => @agendasalerta }
   end
 end

  def update
    @agendasalerta = Agendasalerta.find(params[:id])

    respond_to do |format|
      if @agendasalerta.update_attributes(params[:agendasalerta])
        format.html { redirect_to(@agendasalerta, :notice => 'Agendasalerta was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @agendasalerta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /agendasalertas/1
  # DELETE /agendasalertas/1.xml
  def destroy
    @agendasalerta = Agendasalerta.find(params[:id])
    @agendasalerta.destroy

    respond_to do |format|
      format.html { redirect_to(agendasalertas_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['',''].include?(action_name)
      "application"
    else
      "atencion"
    end
  end
end
