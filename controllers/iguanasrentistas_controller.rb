class IguanasrentistasController < ApplicationController

  before_filter :require_user
  def index
    iguana   = Iguana.find(params[:iguana_id])
    @iguanasrentistas = iguana.iguanasrentistas.all
  end

  def edit
    @iguanasrentista  = Iguanasrentista.find(params[:id], :include => "iguana")
    @iguana  = @iguanasrentista.iguana
    respond_to do |format|
      format.js { render :action => "edit_iguanasrentista" }
    end
  end

  def create
    @iguana  = Iguana.find(params[:iguana_id])
    @iguanasrentista = Iguanasrentista.new(params[:iguanasrentista])
    if Persona.exists?(["id = ?", @iguanasrentista.persona_id]) == true
      if @iguanasrentista.valid?
        @iguana.iguanasrentistas << @iguanasrentista
        @iguana.save
        is_trigger_iguana(@iguana.id,is_admin,'iguanasrentista','I',@iguanasrentista.id)
        @iguanasrentista = Iguanasrentista.new
      else
        flash[:iguanasrentista] = "Se produjo un error al guardar el registro"
      end
      respond_to do |format|
        format.js { render :action => "iguanasrentistas" }
      end
    else
      flash[:iguanasrentista] = "Debe seleccionar el usuario para Asociar"
      respond_to do |format|
        format.js { render :action => "iguanasrentistas" }
      end
    end
  end

  def update
    @iguanasrentista        = Iguanasrentista.new
    iguanasrentista         = Iguanasrentista.find(params[:id])
    @iguana        = iguanasrentista.iguana
    ok = iguanasrentista.update_attributes(params[:iguanasrentista])
    flash[:iguanasrentista] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    if ok == true
      is_trigger_iguana(@iguana.id,is_admin,'iguanasrentista','A',@iguanasrentista.id)
    end        
    respond_to do |format|
      format.js { render :action => "iguanasrentistas" }
    end
  end

  def destroy
    iguanasrentista   = Iguanasrentista.find(params[:id])
    @iguana  = iguanasrentista.iguana
    @iguanasrentista  = Iguanasrentista.new
    iguanasrentista.destroy
    respond_to do |format|
      format.js { render :action => "iguanasrentistas" }
    end
  end

  def show
    persona   = Persona.find(params[:rentista_id])
    @iguanasrentistas = persona.iguanasrentistas.all
  end
end
