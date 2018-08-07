class MejoramientoslistasController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    mejoramiento   = Mejoramiento.find(params[:mejoramiento_id])
    @mejoramientoslistas = mejoramiento.mejoramientoslistas.all
  end

 def edit
    @mejoramientoslista  = Mejoramientoslista.find(params[:id], :include => "mejoramiento")
    @mejoramiento  = @mejoramientoslista.mejoramiento
    respond_to do |format|
      format.js { render :action => "edit_mejoramientoslista" }
    end
  end

 def informe
    @mejoramiento = Mejoramiento.find(params[:id])
    if params[:format] == 'xls'
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Presupuestos_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      respond_to do |format|
         format.xls
      end
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def create
    @mejoramiento  = Mejoramiento.find(params[:mejoramiento_id])
    @mejoramientoslista = Mejoramientoslista.new(params[:mejoramientoslista])
    if @mejoramientoslista.valid?
      @mejoramiento.mejoramientoslistas << @mejoramientoslista
      @mejoramiento.save
      @mejoramientoslista = Mejoramientoslista.new
      flash[:mejoramientoslista] = "Creado con exito"
    else
      flash[:mejoramientoslista] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "mejoramientoslistas" }
    end
  end

  def update
    @mejoramientoslista        = Mejoramientoslista.new
    mejoramientoslista         = Mejoramientoslista.find(params[:id])
    @mejoramiento        = mejoramientoslista.mejoramiento
    params[:mejoramientoslista][:user_actualiza] = is_admin
    ok = mejoramientoslista.update_attributes(params[:mejoramientoslista])
    if ok == true
      is_trigger_mej(@mejoramiento.id,is_admin,'mejoramientoslistas','A')
      flash[:mejoramientoslista] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "mejoramientoslistas" }
      end
    else
       render :update do |page|
        page.alert "El registro tiene inconsistencias. Verifique!!"
      end
    end
  end

  def destroy
    mejoramientoslista   = Mejoramientoslista.find(params[:id])
    @mejoramiento  = mejoramientoslista.mejoramiento
    @mejoramientoslista  = Mejoramientoslista.new
    mejoramientoslista.destroy
    flash[:mejoramientoslista] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "mejoramientoslistas" }
    end
  end

  def atencion
    @mejoramientoslistas = Mejoramientoslista.find(params[:id])
  end

  private
  def determine_layout
    if ['informe'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
