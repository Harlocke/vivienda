class ConveniospersonasController < ApplicationController
  before_filter :require_user
  def index
    convenio   = Convenio.find(params[:convenio_id])
    @conveniospersonas = convenio.conveniospersonas.all
  end

  def edit
    @conveniospersona  = Conveniospersona.find(params[:id], :include => "convenio")
    @convenio  = @conveniospersona.convenio
    respond_to do |format|
      format.js { render :action => "edit_conveniospersona" }
    end
  end

  def create
    cantpersonas = 0
    @convenio  = Convenio.find(params[:convenio_id])
    @conveniospersona = Conveniospersona.new(params[:conveniospersona])
    @conveniospersona.user_id = is_admin
    if Persona.exists?(["id = ?", @conveniospersona.persona_id]) == true
      if Conveniospersona.exists?(["persona_id = ? and convenio_id = ? ", @conveniospersona.persona_id, @convenio.id]) == false
        cantpersonas = Convenio.count(:conditions => [" id = #{@convenio.id}"])
        cantpersonas = cantpersonas.to_i + 1
        #if cantpersonas.to_i > @convenio.nro_viviendas.to_i
          if @conveniospersona.valid?
            @convenio.conveniospersonas << @conveniospersona
            @convenio.save
            @conveniospersona = Conveniospersona.new
            respond_to do |format|
              format.js { render :action => "conveniospersonas" }
            end
          else
            flash[:conveniospersona] = "Se produjo un error al guardar el registro"
            respond_to do |format|
              format.js { render :action => "conveniospersonas" }
            end
          end
#        else
#          render :update do |page|
#            page.alert "La cantidad de personas asociadas no puede exceder el topo del Convenio. Verifique!!!"
#          end
#        end
      else
        render :update do |page|
          page.alert "Este usuario ya esta registro en este convenio... Que pasa???. Verifique!!!"
        end
      end
    else
      render :update do |page|
        page.alert "Debe seleccionar el usuario para Asociar. Verifique!!!"
      end
    end
  end

  def update
    @conveniospersona        = Conveniospersona.new
    conveniospersona         = Conveniospersona.find(params[:id])
    @convenio        = conveniospersona.convenio
    ok = conveniospersona.update_attributes(params[:conveniospersona])
    flash[:conveniospersona] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "conveniospersonas" }
    end
  end

  def destroy
    conveniospersona   = Conveniospersona.find(params[:id])
    @convenio  = conveniospersona.convenio
    @conveniospersona  = Conveniospersona.new
    conveniospersona.destroy
    respond_to do |format|
      format.js { render :action => "conveniospersonas" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @conveniospersonas = persona.conveniospersonas.all
  end
end
