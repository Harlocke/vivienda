class ViviendastramitesController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    vivienda   = Vivienda.find(params[:vivienda_id])
    @viviendastramites = vivienda.viviendastramites.all
  end

  def edit
    @viviendastramite  = Viviendastramite.find(params[:id], :include => "vivienda")
    @vivienda  = @viviendastramite.vivienda
    respond_to do |format|
      format.js { render :action => "edit_viviendastramite" }
    end
  end

  def buscar
    respond_to do |format|
       format.html
       format.xls if params[:format] == 'xls'
    end
  end

  def create
    @vivienda  = Vivienda.find(params[:vivienda_id])
    @viviendastramite = Viviendastramite.new(params[:viviendastramite])
    @viviendastramite.user_id = is_admin
    if ((@viviendastramite.viviendastipostramite_id == '10106') or
       (@viviendastramite.viviendastipostramite_id == '10076') or
       (@viviendastramite.viviendastipostramite_id == '10075') or
       (@viviendastramite.viviendastipostramite_id == '10086'))
        @viviendastramite.fecha_esperada = ""
    end
    if @viviendastramite.valid?
      @vivienda.viviendastramites << @viviendastramite
      @vivienda.save
      @viviendastramite = Viviendastramite.new
      flash[:viviendastramite] = "Registro almacenado con Exito"
    else
      flash[:viviendastramite] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "viviendastramites" }
    end
  end

  def update
    @viviendastramite        = Viviendastramite.new
    viviendastramite         = Viviendastramite.find(params[:id])
#    if ((params[:viviendastramite][:viviendastipostramite_id].to_s == '10106') or
#       (params[:viviendastramite][:viviendastipostramite_id].to_s == '10076') or
#       (params[:viviendastramite][:viviendastipostramite_id].to_s == '10075') or
#       (params[:viviendastramite][:viviendastipostramite_id].to_s == '10086'))
#        params[:viviendastramite][:fecha_esperada] = ""
#    end
    viviendastramite.useract_id = is_admin
    @vivienda        = viviendastramite.vivienda
    ok = viviendastramite.update_attributes(params[:viviendastramite])
    flash[:viviendastramite] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "viviendastramites" }
    end
  end

  def destroy
    viviendastramite   = Viviendastramite.find(params[:id])
    @vivienda  = viviendastramite.vivienda
    @viviendastramite  = Viviendastramite.new
    viviendastramite.destroy
    respond_to do |format|
      format.js { render :action => "viviendastramites" }
    end
  end

 def devolucion
   viviendastramite = Viviendastramite.find(params[:id])
   fecha = Time.now
   viviendastramite.devolucion ='S'
   valorant = viviendastramite.observaciones.to_s
   viviendastramite.observaciones = "DEVOLUCION MARCADA EL #{fecha} POR EL USUARIO #{User.find(is_admin).nombre} --- " + valorant
   viviendastramite.save
   flash[:devolucion] = 'Devolucion Registrada con Exito.'
 end

 def verificacion
   viviendastramite = Viviendastramite.find(params[:id])
   fecha = Time.now
   viviendastramite.verificacion ='S'
   valorant = viviendastramite.observaciones.to_s
   viviendastramite.observaciones = "VERIFICACION TRASLADO DE APORTE MARCADA EL #{fecha} POR EL USUARIO #{User.find(is_admin).nombre} --- " + valorant
   viviendastramite.save
   flash[:verificacion] = 'Verificacion Registrada con Exito.'
 end

  private
  def determine_layout
    if ['devolucion'].include?(action_name)
      "basico"
    else
      "application"
    end
  end
end
