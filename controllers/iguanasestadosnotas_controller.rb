class IguanasestadosnotasController < ApplicationController
before_filter :require_user

  def index
    iguanasestado   = Iguanasestado.find(params[:iguanasestado_id])
    @iguanasestadosnotas = iguanasestado.iguanasestadosnotas.all
  end

  def edit
    @iguanasestadosnota  = Iguanasestadosnota.find(params[:id], :include => "iguanasestado")
    @iguanasestado  = @iguanasestadosnota.iguanasestado
    respond_to do |format|
      format.js { render :action => "edit_iguanasestadosnota" }
    end
  end

  def create
    @iguanasestado  = Iguanasestado.find(params[:iguanasestado_id])
    @iguanasestadosnota = Iguanasestadosnota.new(params[:iguanasestadosnota])
    @iguanasestadosnota.user_id = is_admin
    if @iguanasestadosnota.valid?
      @iguanasestado.iguanasestadosnotas << @iguanasestadosnota
      @iguanasestado.save
      is_trigger_iguana(@iguana.id,is_admin,'iguanasestadosnota','I',@iguanasestadosnota.id)
      @iguanasestadosnota = Iguanasestadosnota.new
      flash[:iguanasestadosnota] = "Se guardo el registro con exito"
    else
      flash[:iguanasestadosnota] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "iguanasestadosnotas" }
    end
  end

  def update
    @iguanasestadosnota        = Iguanasestadosnota.new
    iguanasestadosnota         = Iguanasestadosnota.find(params[:id])
    @iguanasestado        = iguanasestadosnota.iguanasestado
    ok = iguanasestadosnota.update_attributes(params[:iguanasestadosnota])
    flash[:iguanasestadosnota] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    if ok == true
      is_trigger_iguana(@iguana.id,is_admin,'iguanasestadosnota','A',@iguanasestadosnota.id)
    end     
    respond_to do |format|
      format.js { render :action => "iguanasestadosnotas" }
    end
  end

  def destroy
    iguanasestadosnota   = Iguanasestadosnota.find(params[:id])
    @iguanasestado  = iguanasestadosnota.iguanasestado
    @iguanasestadosnota  = Iguanasestadosnota.new
    iguanasestadosnota.destroy
    respond_to do |format|
      format.js { render :action => "iguanasestadosnotas" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @iguanasestadosnotas = persona.iguanasestadosnotas.all
  end
end
