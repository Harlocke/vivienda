class CreditosController < ApplicationController
  
  before_filter :require_user
  layout :determine_layout

  def index
    persona   = Persona.find(params[:persona_id])
    @creditos = persona.creditos.all
  end

 def edit
    @credito  = Credito.find(params[:id], :include => "persona")
    @persona  = @credito.persona
    respond_to do |format|
      format.js { render :action => "edit_credito" }
    end
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @credito = Credito.new(params[:credito])
    if @credito.valid?
      @persona.creditos << @credito
      @persona.save
      @credito = Credito.new
      flash[:credito] = "Creado con exito"
    else
      flash[:credito] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "creditos" }
    end
  end

  def update
    @credito        = Credito.new
    credito         = Credito.find(params[:id])
    @persona        = credito.persona
    ok = credito.update_attributes(params[:credito])
    if ok == true
      flash[:benevivienda] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "creditos" }
      end
    else
      render :update do |page|
         page.alert "El registro tiene inconsistencias. Verifique!!"
      end
    end
  end

  def destroy
    credito   = Credito.find(params[:id])
    @persona  = credito.persona
    @credito  = Credito.new
    credito.respaldo(is_admin)
    credito.destroy
    flash[:credito] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "creditos" }
    end
  end
end
