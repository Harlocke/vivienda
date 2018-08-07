class IndicadoresvariablesController < ApplicationController
  layout :determine_layout
  before_filter :require_user

  def new
    @indicadoresvariable = Indicadoresvariable.new
    render :action => "indicadoresvariable_form"
  end

  def valida
    if Indicadoresvariable.exists?(["indicador_id = #{params[:indicadorid]} and tipo = '#{params[:tipo]}'"])
      @indicadoresvariable  = Indicadoresvariable.find(:first, :conditions=>["indicador_id = #{params[:indicadorid]} and tipo = '#{params[:tipo]}'"])
      redirect_to edit_indicadoresvariable_path(@indicadoresvariable.id)
    else
      ActiveRecord::Base.connection.execute("insert into indicadoresvariables (id,indicador_id,tipo,created_at,updated_at)
                                             values (indicadoresvariables_seq.nextval,#{params[:indicadorid].to_i},'#{params[:tipo].to_s}',sysdate,sysdate)")
      @indicadoresvariable  = Indicadoresvariable.find(:first, :conditions=>["indicador_id = #{params[:indicadorid]} and tipo = '#{params[:tipo]}'"])
      redirect_to edit_indicadoresvariable_path(@indicadoresvariable.id)
    end
  end

  def edit
    @indicadoresvariable  = Indicadoresvariable.find(params[:id])
     respond_to do |format|
      format.html { render :action => "indicadoresvariable_form" }
    end
  end

  def create
    @indicadoresvariable = Indicadoresvariable.new(params[:indicadoresvariable])
    if @indicadoresvariable.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_indicadoresvariable_path(@indicadoresvariable)
    else
      render :action => "indicadoresvariable_form"
    end
  end

  def update
    @indicadoresvariable = Indicadoresvariable.find(params[:id])
#    params[:indicadoresvariable][:user_actualiza] = is_admin
    if @indicadoresvariable.update_attributes(params[:indicadoresvariable])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_indicadoresvariable_path(@indicadoresvariable)
    else
      render :action => "indicadoresvariable_form"
    end
    rescue
      redirect_to edit_indicadoresvariable_path(@indicadoresvariable)
  end

  private
  def determine_layout
    if ['visualizar','ver'].include?(action_name)
      "atencion"
    elsif['informeconsolidado','informedetallado','informeconsolidado2'].include?(action_name)
      "excel"
    else
      "atencion"
    end
  end
end