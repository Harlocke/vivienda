class IguanaspersonasController < ApplicationController

  before_filter :require_user
  def index
    iguana   = Iguana.find(params[:iguana_id])
    @iguanaspersonas = iguana.iguanaspersonas.all
  end

  def edit
    @iguanaspersona  = Iguanaspersona.find(params[:id], :include => "iguana")
    @iguana  = @iguanaspersona.iguana
    respond_to do |format|
      format.js { render :action => "edit_iguanaspersona" }
    end
  end

  def create
    @iguana  = Iguana.find(params[:iguana_id])
    @iguanaspersona = Iguanaspersona.new(params[:iguanaspersona])
    #@iguanaspersona.user_id = is_admin
    if Persona.exists?(["id = ?", @iguanaspersona.persona_id]) == true
      if @iguanaspersona.valid?
        @iguana.iguanaspersonas << @iguanaspersona
        @iguana.save
        is_trigger_iguana(@iguana.id,is_admin,'iguanaspersona','I',@iguanaspersona.id)
        @iguanaspersona = Iguanaspersona.new
      else
        flash[:iguanaspersona] = "Se produjo un error al guardar el registro"
      end
      respond_to do |format|
        format.js { render :action => "iguanaspersonas" }
      end
    else
      flash[:iguanaspersona] = "Debe seleccionar el usuario para Asociar"
      respond_to do |format|
        format.js { render :action => "iguanaspersonas" }
      end
    end
  end

  def update
    @iguanaspersona        = Iguanaspersona.new
    iguanaspersona         = Iguanaspersona.find(params[:id])
    @iguana        = iguanaspersona.iguana
    #params[:iguanaspersona][:useract_id] = is_admin
    ok = iguanaspersona.update_attributes(params[:iguanaspersona])
    flash[:iguanaspersona] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    if ok == true
      is_trigger_iguana(@iguana.id,is_admin,'iguanaspersona','A',@iguanaspersona.id)
    end    
    respond_to do |format|
      format.js { render :action => "iguanaspersonas" }
    end
  end

  def destroy
    iguanaspersona   = Iguanaspersona.find(params[:id])
    @iguana  = iguanaspersona.iguana
    @iguanaspersona  = Iguanaspersona.new
    iguanaspersona.destroy
    respond_to do |format|
      format.js { render :action => "iguanaspersonas" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @iguanaspersonas = persona.iguanaspersonas.all
  end
end
