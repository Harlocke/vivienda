class LotesController < ApplicationController
  before_filter :require_user
  def index
    @lotes = Lote.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lotes }
    end
  end

  def show
    @lote = Lote.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lote }
    end
  end

  def new
    @lote = Lote.new
    render :action => "lote_form"
  end

  def edit
    @lote = Lote.find(params[:id])
    @lotesobservacion = Lotesobservacion.new
    @lotesimagen = Lotesimagen.new    
    respond_to do |format|
      format.html { render :action => "lote_form" }
    end
  end

  def create
    @lote = Lote.new(params[:lote])
    @lote.user_id = is_admin
    if @lote.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_lote_path(@lote)
    else
      render :action => "lote_form"
    end
  end

  def update
    @lote = Lote.find(params[:id])
    @lote.user_id = is_admin
    if @lote.update_attributes(params[:lote])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_lote_path(@lote)
    else
      @lotesobservacion = Lotesobservacion.new
      @lotesimagen = Lotesimagen.new
      flash[:notice] = "Error al realizar la actualizacion."
      render :action => "lote_form"
    end
    rescue
     redirect_to edit_lote_path(@lote)
  end

  def destroy
    @lote = Lote.find(params[:id])
    @lote.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to busqueda_lotes_path
        }
      format.xml  { head :ok }
    end
  end

  def arealote
     valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     resta = valor.to_f - pvr2.to_f
     pvr3 = params[:pvr3] # lote_municipal_indiceconstruccion
     valorrst3 = pvr3.to_f * resta.to_f
     pvr4 = params[:pvr4] # lote_nacional_indiceconstruccion
     valorrst4 = pvr4.to_f * resta.to_f
     pvr5 = params[:pvr5] # lote_municipal_indiceocupacion
     valorrst5 = (pvr5.to_f * resta.to_f)/100
     pvr6 = params[:pvr6] # lote_nacional_indiceocupacion
     valorrst6 = (pvr6.to_f * resta.to_f)/100
     pvr7 = params[:pvr7] # lote_municipal_densidadvivienda
     valorrst7 = ((pvr7.to_f * resta.to_f)/10000).to_i
     pvr8 = params[:pvr8] # lote_nacional_densidadvivienda
     valorrst8 = ((pvr8.to_f * resta.to_f)/10000).to_i
     pvr9 = params[:pvr9] # lote_nacional_vivienda
     valorrst9 = ((pvr9.to_f * resta.to_f)/100).to_i
     pvr10 = params[:pvr10] # lote_municipal_minimoverdes
     valorrst10 = (pvr10.to_f * valor.to_f)/100
     render :update do |page|
       page[:lote_areanetalote][:value] = resta
       page[:lote_municipal_solicitarvias][:value] = valor
       page[:lote_municipal_solicitarvias_valor][:value] = resta
       page[:lote_municipal_indiceconstru_valor][:value] = valorrst3.to_s
       page[:lote_nacional_indiceconstrun_valor][:value] = valorrst4.to_s
       page[:lote_municipal_indiceocupa_valor][:value] = valorrst5.to_s
       page[:lote_nacional_indiceocupacion_valor][:value] = valorrst6.to_s
       page[:lote_municipal_densidadvivi_valor][:value] = valorrst7.to_s
       page[:lote_nacional_densidadvivi_valor][:value] = valorrst8.to_s
       page[:lote_nacional_vivienda_valor][:value] = valorrst9.to_s
       page[:lote_municipal_minimoverdes_valor][:value] = valorrst10.to_s
     end
  end

  def cesionvial
     valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     resta = pvr2.to_f - valor.to_f
     pvr3 = params[:pvr3] # lote_municipal_indiceconstruccion
     valorrst3 = pvr3.to_f * resta.to_f
     pvr4 = params[:pvr4] # lote_nacional_indiceconstruccion
     valorrst4 = pvr4.to_f * resta.to_f
     pvr5 = params[:pvr5] # lote_municipal_indiceocupacion
     valorrst5 = (pvr5.to_f * resta.to_f)/100
     pvr6 = params[:pvr6] # lote_nacional_indiceocupacion
     valorrst6 = (pvr6.to_f * resta.to_f)/100
     pvr7 = params[:pvr7] # lote_municipal_densidadvivienda
     valorrst7 = ((pvr7.to_f * resta.to_f)/10000).to_i
     pvr8 = params[:pvr8] # lote_nacional_densidadvivienda
     valorrst8 = ((pvr8.to_f * resta.to_f)/10000).to_i
     pvr9 = params[:pvr9] # lote_nacional_vivienda
     valorrst9 = ((pvr9.to_f * resta.to_f)/100).to_i
     render :update do |page|
       page[:lote_areanetalote][:value] = resta
       page[:lote_municipal_solicitarvias][:value] = valor
       page[:lote_municipal_solicitarvias_valor][:value] = resta
       page[:lote_municipal_indiceconstru_valor][:value] = valorrst3.to_s
       page[:lote_nacional_indiceconstrun_valor][:value] = valorrst4.to_s
       page[:lote_municipal_indiceocupa_valor][:value] = valorrst5.to_s
       page[:lote_nacional_indiceocupacion_valor][:value] = valorrst6.to_s
       page[:lote_municipal_densidadvivi_valor][:value] = valorrst7.to_s
       page[:lote_nacional_densidadvivi_valor][:value] = valorrst8.to_s
       page[:lote_nacional_vivienda_valor][:value] = valorrst9.to_s
     end
  end

  def municipal_indiceconstruccion
     valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     valorrst = pvr2.to_f * valor.to_f
     render :update do |page|
       page[:lote_municipal_indiceconstru_valor][:value] = valorrst.to_s
     end
  end

  def nacional_indiceconstruccion
     valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     valorrst = pvr2.to_f * valor.to_f
     render :update do |page|
       page[:lote_nacional_indiceconstrun_valor][:value] = valorrst.to_s
     end
  end

  def municipal_indiceocupacion
     valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     valorrst = (pvr2.to_f * valor.to_f)/100
     render :update do |page|
       page[:lote_municipal_indiceocupa_valor][:value] = valorrst.to_s
     end
  end

  def nacional_indiceocupacion
     valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     valorrst = (pvr2.to_f * valor.to_f)/100
     render :update do |page|
       page[:lote_nacional_indiceocupacion_valor][:value] = valorrst.to_s
     end
  end

  def municipal_densidadvivienda
     valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     valorrst = ((pvr2.to_f * valor.to_f)/10000).to_i
     valorrst00 = valorrst.to_f
     pvr3 = params[:pvr3]  # lote_municipal_bvivienda
     valorrst3 = pvr3.to_f * valorrst00.to_f
     pvr4 = params[:pvr4]  # lote_municipal_privadosminimo
     if pvr4.to_s == "" or pvr4.to_s == "0"
       valorrst4 = ""
     else
       valorrst4 = (valorrst00.to_f / pvr4.to_f)
     end
     pvr5 = params[:pvr5]  # lote_municipal_privadosmaximo
     if pvr5.to_s == "" or pvr5.to_s == "0"
        valorrst5 = ""
     else
       valorrst5 = (valorrst00.to_f / pvr5.to_f)
     end
     pvr6 = params[:pvr6]  # lote_municipal_visitantes
     if pvr6.to_s == "" or pvr6.to_s == "0"
        valorrst6 = ""
     else
       valorrst6 = (valorrst00.to_f / pvr6.to_f)
     end
     pvr7 = params[:pvr7]  # lote_municipal_motos
     if pvr7.to_s == "" or pvr7.to_s == "0"
        valorrst7 = ""
     else
       valorrst7 = (valorrst00.to_f / pvr7.to_f)
     end
     render :update do |page|
       page[:lote_municipal_densidadvivi_valor][:value] = valorrst.to_s
       page[:lote_municipal_bvivienda_valor][:value] = valorrst3.to_s
       page[:lote_municipal_privadosmin_valor][:value] = valorrst4.to_s
       page[:lote_municipal_privadosmax_valor][:value] = valorrst5.to_s
       page[:lote_municipal_visitantes_valor][:value] = valorrst6.to_s
       page[:lote_municipal_motos_valor][:value] = valorrst7.to_s
     end
  end

  def nacional_densidadvivienda
     valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     valorrst = ((pvr2.to_f * valor.to_f)/10000).to_i
     valorrst00 = valorrst.to_f
     pvr3 = params[:pvr3]  # lote_nacional_bvivienda
     valorrst3 = pvr3.to_f * valorrst00.to_f
     pvr4 = params[:pvr4]  # lote_nacional_privadosminimo
     if pvr4.to_s == "" or pvr4.to_s == "0"
       valorrst4 = ""
     else
       valorrst4 = (valorrst00.to_f / pvr4.to_f)
     end
     pvr5 = params[:pvr5]  # lote_nacional_privadosmaximo
     if pvr5.to_s == "" or pvr5.to_s == "0"
        valorrst5 = ""
     else
       valorrst5 = (valorrst00.to_f / pvr5.to_f)
     end
     pvr6 = params[:pvr6]  # lote_nacional_visitantes
     if pvr6.to_s == "" or pvr6.to_s == "0"
        valorrst6 = ""
     else
       valorrst6 = (valorrst00.to_f / pvr6.to_f)
     end
     pvr7 = params[:pvr7]  # lote_nacional_motos
     if pvr7.to_s == "" or pvr7.to_s == "0"
        valorrst7 = ""
     else
       valorrst7 = (valorrst00.to_f / pvr7.to_f)
     end
     render :update do |page|
       page[:lote_nacional_densidadvivi_valor][:value] = valorrst.to_s
       page[:lote_nacional_bvivienda_valor][:value] = valorrst3.to_s
       page[:lote_nacional_privadosmin_valor][:value] = valorrst4.to_s
       page[:lote_nacional_privadosmax_valor][:value] = valorrst5.to_s
       page[:lote_nacional_visitantes_valor][:value] = valorrst6.to_s
       page[:lote_nacional_motos_valor][:value] = valorrst7.to_s
     end
  end

  def municipal_vivienda
     valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     pvr3 = params[:pvr3]
     valorrst = (pvr2.to_f * valor.to_f * pvr3.to_f)
     render :update do |page|
       page[:lote_municipal_vivienda_valor][:value] = valorrst.to_s
     end
  end

  def nacional_vivienda
     valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     valorrst = ((pvr2.to_f * valor.to_f)/100).to_i
     render :update do |page|
       page[:lote_nacional_vivienda_valor][:value] = valorrst.to_s
     end
  end

  def municipal_otrosusos
     valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     valorrst = (pvr2.to_f * valor.to_f)/100
     render :update do |page|
       page[:lote_municipal_otrosusos_valor][:value] = valorrst.to_s
     end
  end

  def nacional_otrosusos
     valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     valorrst = (pvr2.to_f * valor.to_f)/100
     render :update do |page|
       page[:lote_nacional_otrosusos_valor][:value] = valorrst.to_s
     end
  end

  def municipal_minimoverdes
    valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     valorrst = (pvr2.to_f * valor.to_f)/100
     render :update do |page|
       page[:lote_municipal_minimoverdes_valor][:value] = valorrst.to_s
     end
  end

  def municipal_bvivienda
    valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     valorrst = pvr2.to_f * valor.to_f
     render :update do |page|
       page[:lote_municipal_bvivienda_valor][:value] = valorrst.to_s
     end
  end

  def nacional_bvivienda
    valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     valorrst = pvr2.to_f * valor.to_f
     render :update do |page|
       page[:lote_nacional_bvivienda_valor][:value] = valorrst.to_s
     end
  end

  def municipal_botrosusos
    valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     valorrst = (pvr2.to_f * valor.to_f)/100
     render :update do |page|
       page[:lote_municipal_botrosusos_valor][:value] = valorrst.to_s
     end
  end

  def municipal_privadosminimo
    valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     if valor.to_s == "" or valor.to_s == "0"
        valorrst = ""
     else
       valorrst = (pvr2.to_f / valor.to_f)
     end
     render :update do |page|
       page[:lote_municipal_privadosmin_valor][:value] = valorrst.to_s
     end
  end

  def nacional_privadosminimo
    valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     if valor.to_s == "" or valor.to_s == "0"
        valorrst = ""
     else
       valorrst = (pvr2.to_f / valor.to_f)
     end
     render :update do |page|
       page[:lote_nacional_privadosmin_valor][:value] = valorrst.to_s
     end
  end

  def municipal_privadosmaximo
    valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     if valor.to_s == "" or valor.to_s == "0"
        valorrst = ""
     else
       valorrst = (pvr2.to_f / valor.to_f)
     end
     render :update do |page|
       page[:lote_municipal_privadosmax_valor][:value] = valorrst.to_s
     end
  end

  def nacional_privadosmaximo
    valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     if valor.to_s == "" or valor.to_s == "0"
        valorrst = ""
     else
       valorrst = (pvr2.to_f / valor.to_f)
     end
     render :update do |page|
       page[:lote_nacional_privadosmax_valor][:value] = valorrst.to_s
     end
  end

  def municipal_visitantes
     valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     if valor.to_s == "" or valor.to_s == "0"
        valorrst = ""
     else
       valorrst = (pvr2.to_f / valor.to_f)
     end
     render :update do |page|
       page[:lote_municipal_visitantes_valor][:value] = valorrst.to_s
     end
  end

  def nacional_visitantes
    valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     if valor.to_s == "" or valor.to_s == "0"
        valorrst = ""
     else
       valorrst = (pvr2.to_f / valor.to_f)
     end
     render :update do |page|
       page[:lote_nacional_visitantes_valor][:value] = valorrst.to_s
     end
  end

  def municipal_motos
    valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     if valor.to_s == "" or valor.to_s == "0"
        valorrst = ""
     else
       valorrst = (pvr2.to_f / valor.to_f)
     end
     render :update do |page|
       page[:lote_municipal_motos_valor][:value] = valorrst.to_s
     end
  end

  def nacional_motos
    valor = params[:valor]  #valor digitado en la variable
     pvr2 = params[:pvr2]
     if valor.to_s == "" or valor.to_s == "0"
        valorrst = ""
     else
       valorrst = (pvr2.to_f / valor.to_f)
     end
     render :update do |page|
       page[:lote_nacional_motos_valor][:value] = valorrst.to_s
     end
  end
end
