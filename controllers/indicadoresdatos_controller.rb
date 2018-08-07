class IndicadoresdatosController < ApplicationController
  before_filter :require_user
  layout :determine_layout  

  def index

  end

  def ver
    fch1 = params[:ubicacion][:fchinicial].to_s
    fch2 = params[:ubicacion][:fchfinal].to_s
    indicador = params[:ubicacion][:indicador_id].to_i
    if fch1.to_s != "" and fch2.to_s != "" and indicador > 0
      ActiveRecord::Base.connection.execute("begin prc_indicadordatos(#{indicador.to_i},'#{fch1.to_s}','#{fch2.to_s}'); end;") 
      if indicador.to_i == 17
        @indicadoresdatos = Indicadoresdato.find(:all, :order => "indicador_id" , :select => "distinct indicador_id, nombre_indicador
          ", :conditions => "indicador_id in (17,65)" )
      else
        @indicadoresdatos = Indicadoresdato.find(:all, :order => "indicador_id" , :select => "distinct indicador_id, nombre_indicador
          ", :conditions => "indicador_id = #{indicador}" )
      end
    else
      flash[:notice] = "Debe registrar todos los datos"
      redirect_to indicadoresdatos_path
    end 
  end

  def mostrar
    @nombreindicador = Indicadoresdato.find(:first, :conditions => "indicador_id = #{params[:indicador_id].to_i}").nombre_indicador.to_s
    if params[:variable].to_s == 'numerador' or params[:variable].to_s == 'denominador'
      @indicadoresdatos = Indicadoresdato.find(:all, :conditions=>["indicador_id = #{params[:indicador_id].to_i} and #{params[:variable]} = '1'"])
      @indicador = params[:indicador_id].to_i
      @totalvariable = Indicadoresdato.sum("#{params[:variable].to_s}",:conditions=>["indicador_id = #{params[:indicador_id].to_i}"])
    else
      @indicadoresdatos = Indicadoresdato.find(:all, :conditions=>["indicador_id = #{params[:indicador_id].to_i} and #{params[:variable]} = 'SI'"])
      @indicador = params[:indicador_id].to_i
      @totalvariable = params[:total].to_i      
    end    

    if params[:variable].to_s == 'edad1'
      @variable = "Edad 14-28 años"
    elsif params[:variable].to_s == 'edad2'
      @variable = "Edad 29-54 años"
    elsif params[:variable].to_s == 'edad3'
      @variable = "Edad Más de 55 años"
    elsif params[:variable].to_s == 'edad0'
      @variable = "Edad sin informacion"
    elsif params[:variable].to_s == 'edadtotal'
      @variable = "Edad Total"
    elsif params[:variable].to_s == 'genero1'
      @variable = "Genero Hombres"
    elsif params[:variable].to_s == 'genero2'
      @variable = "Genero Mujeres"
    elsif params[:variable].to_s == 'genero0'
      @variable = "Genero sin informacion"
    elsif params[:variable].to_s == 'generototal'
      @variable = "Genero Total"
    elsif params[:variable].to_s == 'afro1'
      @variable = "Afrocolombianos Hombre"
    elsif params[:variable].to_s == 'afro2'
      @variable = "Afrocolombianos Mujer"
    elsif params[:variable].to_s == 'afrototal'
      @variable = "Afrocolombianos Total"
    elsif params[:variable].to_s == 'indi1'
      @variable = "Indigenas Hombre"
    elsif params[:variable].to_s == 'indi2'
      @variable = "Indigenas Mujer"
    elsif params[:variable].to_s == 'inditotal'
      @variable = "Indigenas Total"
    elsif params[:variable].to_s == 'rom1'
      @variable = "ROM Hombre"
    elsif params[:variable].to_s == 'rom2'
      @variable = "ROM Mujer"
    elsif params[:variable].to_s == 'romtotal'
      @variable = "ROM Total"
    elsif params[:variable].to_s == 'disc1'
      @variable = "Discapacitados Hombre"
    elsif params[:variable].to_s == 'disc2'
      @variable = "Discapacitados Mujer"
    elsif params[:variable].to_s == 'disc0'
      @variable = "Discapacitados Sin Información"
    elsif params[:variable].to_s == 'disctotal'
      @variable = "Discapacitados Total"
    elsif params[:variable].to_s == 'comuna1'
      @variable = "Comuna 01"
    elsif params[:variable].to_s == 'comuna2'
      @variable = "Comuna 02"
    elsif params[:variable].to_s == 'comuna3'
      @variable = "Comuna 03"
    elsif params[:variable].to_s == 'comuna4'
      @variable = "Comuna 04"
    elsif params[:variable].to_s == 'comuna5'
      @variable = "Comuna 05"
    elsif params[:variable].to_s == 'comuna6'
      @variable = "Comuna 06"
    elsif params[:variable].to_s == 'comuna7'
      @variable = "Comuna 07"
    elsif params[:variable].to_s == 'comuna8'
      @variable = "Comuna 08"
    elsif params[:variable].to_s == 'comuna9'
      @variable = "Comuna 09"
    elsif params[:variable].to_s == 'comuna10'
      @variable = "Comuna 10"
    elsif params[:variable].to_s == 'comuna11'
      @variable = "Comuna 11"
    elsif params[:variable].to_s == 'comuna12'
      @variable = "Comuna 12"
    elsif params[:variable].to_s == 'comuna13'
      @variable = "Comuna 13"
    elsif params[:variable].to_s == 'comuna14'
      @variable = "Comuna 14"
    elsif params[:variable].to_s == 'comuna15'
      @variable = "Comuna 15"
    elsif params[:variable].to_s == 'comuna16'
      @variable = "Comuna 16"
    elsif params[:variable].to_s == 'comuna50'
      @variable = "Comuna 50"
    elsif params[:variable].to_s == 'comuna60'
      @variable = "Comuna 60"
    elsif params[:variable].to_s == 'comuna70'
      @variable = "Comuna 70"
    elsif params[:variable].to_s == 'comuna80'
      @variable = "Comuna 80"
    elsif params[:variable].to_s == 'comuna90'
      @variable = "Comuna 90"
    elsif params[:variable].to_s == 'sincomuna'
      @variable = "Sin Comuna"
    elsif params[:variable].to_s == 'comunatotal'
      @variable = "Comuna Total"
    else
      @variable = params[:variable].to_s
    end  
  end

  private
  def determine_layout
    if ['mostrar'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end  
end
