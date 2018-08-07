class MejorainformesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def nuevo
    @convenioori = params[:ubicacion1112][:convenio].to_i
    @resolori = Conveniosresolucion.find(params[:ubicacion1112][:conveniosresolucion]).resolucion_id rescue nil
    @mejorainforme = Mejorainforme.new
    @mejorainforme.convenio_id = @convenioori
    @mejorainforme.resolucion_id = @resolori
    @mejorainforme.user_id = is_admin
    @mejorainforme.save
    redirect_to edit_mejorainforme_path(@mejorainforme)
  end

  def nuevomasivo
    @convenioori = params[:ubicacion1114][:convenio].to_i
    @resolori = Conveniosresolucion.find(params[:ubicacion1114][:conveniosresolucion]).resolucion_id rescue nil
    @mejorainforme = Mejorainforme.new
    @mejorainforme.convenio_id = @convenioori
    @mejorainforme.resolucion_id = @resolori
    @mejorainforme.user_id = is_admin
    @mejorainforme.masivo = 'SI'
    @mejorainforme.save
    redirect_to edit_mejorainforme_path(@mejorainforme)
  end

  def new
    @mejorainforme = Mejorainforme.new
    @mejorainforme.convenio_id = params[:convenio_id]
    @mejorainforme.resolucion_id = params[:resolucion_id]
    @mejorainforme.user_id = is_admin
    @mejorainformeslista = Mejorainformeslista.new
    render :action => "mejorainforme_form"
  end

  def edit
    @mejorainforme = Mejorainforme.find(params[:id])
    @mejorainformeslista = Mejorainformeslista.new
    respond_to do |format|
      format.html { render :action => "mejorainforme_form" }
    end
  end

  def create
    @mejorainforme = Mejorainforme.new(params[:mejorainforme])

    if @mejorainforme.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_mejorainforme_path(@mejorainforme)
    else
      @mejorainformeslista = Mejorainformeslista.new
      render :action => "mejorainforme_form"
    end
  end

  def update
    @mejorainforme = Mejorainforme.find(params[:id])
      if @mejorainforme.update_attributes(params[:mejorainforme])
        flash[:notice] = "El registro ha sido actualizado con Exito."
        redirect_to edit_mejorainforme_path(@mejorainforme)
      else
        @mejorainformeslista = Mejorainformeslista.new
        render :action => "mejorainforme_form"
      end
    rescue
      flash[:notice] = "Existen inconsistencias. Verifique!!!"
      redirect_to edit_mejorainforme_path(@mejorainforme)
  end

  private
  def determine_layout
    if ['actaaprobacionobra'].include?(action_name)
      "atencion"
    elsif['informeoperador','informefinanciero','informeactualizacion','informepersonal','informecomuna','informeconcepto','informeseguimiento'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end

