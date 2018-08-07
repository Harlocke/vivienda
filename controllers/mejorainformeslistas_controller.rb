class MejorainformeslistasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def informe
    mejorainforme   = Mejorainforme.find(params[:id])
    @mejorainformeslistas = mejorainforme.mejorainformeslistas.all
  end

  def index
    mejorainforme   = Mejorainforme.find(params[:mejorainforme_id])
    @mejorainformeslistas = mejorainforme.mejorainformeslistas.all
  end

  def create
    @mejorainforme  = Mejorainforme.find(params[:mejorainforme_id])
    @mejorainformeslista = Mejorainformeslista.new(params[:mejorainformeslista])
    @valor = params[:mejorainformeslista][:mejoramiento_id]
    if @valor.to_s != ""
      i = 0
      while i < @valor.size
        ActiveRecord::Base.connection.execute("insert into mejorainformeslistas (id,mejorainforme_id,mejoramiento_id,created_at,updated_at)
                                               values (mejorainformeslistas_seq.nextval,#{@mejorainforme.id},#{@valor[i]},sysdate,sysdate)")
        i = i + 1
      end
    end
    @mejorainformeslista = Mejorainformeslista.new
    respond_to do |format|
      format.js { render :action => "mejorainformeslistas" }
    end
  end


  def destroy
    mejorainformeslista   = Mejorainformeslista.find(params[:id])
    @mejorainforme  = mejorainformeslista.mejorainforme
    @mejorainformeslista  = Mejorainformeslista.new
    mejorainformeslista.destroy
    respond_to do |format|
      format.js { render :action => "mejorainformeslistas" }
    end
  end

  private
  def determine_layout
    if ['informe','actacambioobra','actaterminaobra','actareciboobra','actaaprobacionobra'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
