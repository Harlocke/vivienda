class ImpresorasconsumosController < ApplicationController
  before_filter :require_user
  layout :determine_layout
  
  def informe
    @error = ""
    if params[:ubicacion][:mes].to_s == "" or params[:ubicacion][:anno].to_s == ""
       flash[:notice] = "No hay informacion para generar el proceso. Verifique!!!"
       redirect_to busqueda_viviendas_path
    else
      if Impresorasconsumo.exists?(["anno = #{params[:ubicacion][:anno].to_i} and mes = #{params[:ubicacion][:mes].to_i} and clase = 'A'"])         
          headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
          headers['Content-Disposition'] = 'attachment; filename="SIFI_Impresora_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
          headers['Cache-Control'] = 'max-age=0'
          headers['pragma']="public"
          @mes = descmesmin(params[:ubicacion][:mes].to_i).to_s + ' -- ' + params[:ubicacion][:anno].to_s
          @impresorasconsumos = Impresorasconsumo.find(:all, :conditions=>["anno = #{params[:ubicacion][:anno].to_i} and mes = #{params[:ubicacion][:mes].to_i} and clase = 'A' and dependencia_id = decode(#{params[:ubicacion][:dependencia_id].to_i},0,dependencia_id,#{params[:ubicacion][:dependencia_id].to_i})"])
          @imps = Impresorasconsumo.find(:all,
                                         :select => 'sum(acum_ante_copias) dat1, sum(acum_ante_impresion) dat2, 
                                                  sum(cant_copias) dat4, sum(acum_copias) dat5, sum(cant_impresion) dat6,
                                                  sum(acum_impresion) dat7, sum(total_mes) dat8, sum(total_acumulado) dat9,
                                                  sum(part_acumulado) dat10, sum(part_mes) dat11, sum(valor_mes) dat12,
                                                  sum(valor_acumulado) dat13',
                                       :conditions => ["anno = #{params[:ubicacion][:anno].to_i} and mes = #{params[:ubicacion][:mes].to_i} and clase = 'A' and dependencia_id = decode(#{params[:ubicacion][:dependencia_id].to_i},0,dependencia_id,#{params[:ubicacion][:dependencia_id].to_i})"])
          @impsdep = Impresorasconsumo.find(:all,
                                         :select => 'dependencia_id, sum(acum_ante_copias) dat1, sum(acum_ante_impresion) dat2, 
                                                  sum(cant_copias) dat4, sum(acum_copias) dat5, sum(cant_impresion) dat6,
                                                  sum(acum_impresion) dat7, sum(total_mes) dat8, sum(total_acumulado) dat9,
                                                  sum(part_acumulado) dat10, sum(part_mes) dat11, sum(valor_mes) dat12,
                                                  sum(valor_acumulado) dat13',
                                       :conditions => ["anno = #{params[:ubicacion][:anno].to_i} and mes = #{params[:ubicacion][:mes].to_i} and clase = 'A' and dependencia_id = decode(#{params[:ubicacion][:dependencia_id].to_i},0,dependencia_id,#{params[:ubicacion][:dependencia_id].to_i})"],
                                       :group =>"dependencia_id")

          @impresorasconsumosp = Impresorasconsumo.find(:all, :conditions=>["anno = #{params[:ubicacion][:anno].to_i} and mes = #{params[:ubicacion][:mes].to_i} and clase = 'P' and dependencia_id = decode(#{params[:ubicacion][:dependencia_id].to_i},0,dependencia_id,#{params[:ubicacion][:dependencia_id].to_i})"])
          @impsp = Impresorasconsumo.find(:all,
                                         :select => 'sum(acum_ante_copias) dat1, sum(acum_ante_impresion) dat2, 
                                                  sum(cant_copias) dat4, sum(acum_copias) dat5, sum(cant_impresion) dat6,
                                                  sum(acum_impresion) dat7, sum(total_mes) dat8, sum(total_acumulado) dat9,
                                                  sum(part_acumulado) dat10, sum(part_mes) dat11, sum(valor_mes) dat12,
                                                  sum(valor_acumulado) dat13',
                                       :conditions => ["anno = #{params[:ubicacion][:anno].to_i} and mes = #{params[:ubicacion][:mes].to_i} and clase = 'P' and dependencia_id = decode(#{params[:ubicacion][:dependencia_id].to_i},0,dependencia_id,#{params[:ubicacion][:dependencia_id].to_i})"])
          @impsdepp = Impresorasconsumo.find(:all,
                                         :select => 'dependencia_id, sum(acum_ante_copias) dat1, sum(acum_ante_impresion) dat2, 
                                                  sum(cant_copias) dat4, sum(acum_copias) dat5, sum(cant_impresion) dat6,
                                                  sum(acum_impresion) dat7, sum(total_mes) dat8, sum(total_acumulado) dat9,
                                                  sum(part_acumulado) dat10, sum(part_mes) dat11, sum(valor_mes) dat12,
                                                  sum(valor_acumulado) dat13',
                                       :conditions => ["anno = #{params[:ubicacion][:anno].to_i} and mes = #{params[:ubicacion][:mes].to_i} and clase = 'P' and dependencia_id = decode(#{params[:ubicacion][:dependencia_id].to_i},0,dependencia_id,#{params[:ubicacion][:dependencia_id].to_i})"],
                                       :group =>"dependencia_id")

      else
        flash[:notice] = "No hay informacion para generar el proceso. Verifique!!!"
        redirect_to busqueda_viviendas_path
      end
    end
  end
  
 def index
   @impresorasconsumo = Impresorasconsumo.all
   respond_to do |format|
     format.html # index.html.erb
     format.xml  { render :xml => @impresoras }
   end
 end
 
 def new
   @impresorasconsumo = Impresorasconsumo.new
   render :action => "impresorasconsumo_form"
 end

 def create
   @impresorasconsumo = Impresorasconsumo.new(params[:impresorasconsumo])
   if @impresorasconsumo.save
     flash[:notice] = "impresorasconsumo Creado con Exito."
     redirect_to edit_impresorasconsumo_path(@impresorasconsumo)
   else
     flash[:warning] = "Problemas con la creacion del registro."
     render :action => "impresorasconsumo_form"
   end
 end

 def show
   @impresorasconsumo = Impresorasconsumo.find(params[:id])
   respond_to do |format|
     format.html # show.html.erb
     format.xml  { render :xml => @impresorasconsumo }
   end
 end

 def edit
   @impresorasconsumo = Impresorasconsumo.find(params[:id])
   respond_to do |format|
     format.html { render :action => "impresorasconsumo_form" }
   end
 end

 def update
   @impresorasconsumo = Impresorasconsumo.find(params[:id])
   if @impresorasconsumo.update_attributes(params[:impresorasconsumo])
     flash[:notice] = "Impresorasconsumo actualizado correctamente."
     redirect_to edit_impresorasconsumo_path(@impresorasconsumo)
   else
     render :action => "impresorasconsumo_form"
   end
   rescue
   redirect_to edit_impresorasconsumo_path(@impresorasconsumo)
 end

 def destroy
   @impresorasconsumo = Impresorasconsumo.find(params[:id])
   @impresorasconsumo.destroy
   respond_to do |format|
     format.html { redirect_to impresorasconsumos_path }
     format.xml  { head :ok }
   end
 end

  private
  def determine_layout
    if ['ver'].include?(action_name)
      "boletin"
    elsif ['informe'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end