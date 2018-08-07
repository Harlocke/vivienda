class SubsidiosController < ApplicationController

  before_filter :require_user

  layout :determine_layout

  def index
    persona   = Persona.find(params[:persona_id])
    @subsidios = persona.subsidios.all
    @tipos_subsidios = TiposSubsidio.all
  end

 def edit
    @subsidio  = Subsidio.find(params[:id], :include => "persona")
    @persona  = @subsidio.persona
    @tipos_subsidios = TiposSubsidio.all
    respond_to do |format|
      format.js { render :action => "edit_subsidio" }
    end
  end

  def visualizar
    @subsidio  = Subsidio.find(params[:id])
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @subsidio = Subsidio.new(params[:subsidio])
    @subsidio.estado_int = '0'
    tipossubsidio = TiposSubsidio.find(@subsidio.tipos_subsidio_id)
    if Subsidio.exists?(["persona_id = ? and tipos_subsidio_id = ?", @persona.id, @subsidio.tipos_subsidio_id]) == false
      if tipossubsidio.valido.to_s != "X"
        if @subsidio.valid?
          @persona.subsidios << @subsidio
          @persona.save
          @subsidio = Subsidio.new
          @tipos_subsidios = TiposSubsidio.all
          flash[:subsidio] = "Creado con exito"
        else
          flash[:subsidio] = "Se produjo un error al guardar el registro"
        end
      else
        flash[:subsidio] = "Usted no tiene autorizacion para asignar este tipo de Subsidio. Contacte a Juridica"
      end
    else
      #Se habilita la posibilidad de cargar varios subsidios nacionales
      if @subsidio.tipos_subsidio_id.to_s == '4'
        if @subsidio.valid?
          @persona.subsidios << @subsidio
          @persona.save
          @subsidio = Subsidio.new
          @tipos_subsidios = TiposSubsidio.all
          flash[:subsidio] = "Creado con exito"
        else
          flash[:subsidio] = "Se produjo un error al guardar el registro"
        end
      else
        flash[:subsidio] = "El usuario ya tiene este tipo de Resolucion Asignado... Verifique!!!"
      end
    end
    respond_to do |format|
       format.js { render :action => "subsidios" }
    end
  end

  def update
    @subsidio        = Subsidio.new
    subsidio         = Subsidio.find(params[:id])
    @persona        = subsidio.persona
    sub             = params[:subsidio][:tipos_subsidio_id]
    tipossubsidio   = TiposSubsidio.find(sub)
    if tipossubsidio.valido.to_s != "X"
      ok = subsidio.update_attributes(params[:subsidio])
      flash[:subsidio] = ok ? "Actualizado con Exito " : "Se produjo un error al actualizar el registro "
    else
      flash[:subsidio] = "Usted no tiene autorizacion para asignar este tipo de Subsidio. Contacte a Juridica"
    end
    respond_to do |format|
      format.js { render :action => "subsidios" }
    end
  end

#    def update
#    @subsidio        = Subsidio.new
#    subsidio         = Subsidio.find(params[:id])
#    @persona        = subsidio.persona
#    ok = subsidio.update_attributes(params[:subsidio])
#    if subsidio.update_attributes(params[:persona])
#      flash[:subsidio] = "Usuario Actualizado con Exito."
#      respond_to do |format|
#      format.js { render :action => "subsidios" }
#      end
#    else
#      flash[:subsidio] = "Error"
#      @subsidio  = Subsidio.find(params[:id], :include => "persona")
#    @persona  = @subsidio.persona
#    @tipos_subsidios = TiposSubsidio.all
#    respond_to do |format|
#      format.js { render :action => "edit_subsidio" }
#    end
#
#    end
#  end
  
#  def update
#    @subsidio        = Subsidio.new
#    subsidio         = Subsidio.find(params[:id])
#    @persona        = subsidio.persona
#    ok = subsidio.update_attributes(params[:subsidio])
#    if ok== true
#     respond_to do |format|
#       flash[:subsidio] = "Ok"
#          format.js { render :action => "subsidios" }
#      end
#    else
#      flash.now[:subsidio] = t("uploading_error")
#      render :update do |page|
#        flash.now[:subsidio] = t("uploading_error")
#        page[:subsidio_resolucion][:value] ="OK"
#     end
#     flash.now[:subsidio] = t("uploading_error")
#    end
#  end
#
#  def update
#  @comment = Comment.find( @params[:id] )
#  @comment.attributes = @params[:comment]
#
#  if @comment.save
#    @comment.reload
#
#    flash[:success] = "Successfully updated comment."
#    render :partial => 'show'
#  else
#    flash[:invalid] = @comment.errors.full_messages
#    render :partial =>  'edit', :status => 444
#  end
#end



  def destroy
    subsidio   = Subsidio.find(params[:id])
    @persona  = subsidio.persona
    @subsidio  = Subsidio.new
    subsidio.respaldo(is_admin)
    subsidio.destroy
    flash[:subsidio] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "subsidios" }
    end
  end

  private
  def determine_layout
    if [''].include?(action_name)
      "application"
#    else
#      "basico"
    end
  end
end
