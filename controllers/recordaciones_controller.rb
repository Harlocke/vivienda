class RecordacionesController < ApplicationController
  layout :determine_layout

  def index 
    if Recordacion.exists?(["trunc(fecha) = trunc(sysdate)"]) == true
      flash[:notice] = "Ya fue enviado"
    else
      @recordacion = Recordacion.new
      if Time.now.strftime("%X") >= "06:00:00"
        ActiveRecord::Base.connection.execute("begin prc_check; end;")
        @recordacion.e_correspondenciasrecibidas
        if Time.now.strftime("%w") == '1'
          @recordacion.e_titulacion
          # Envio de recordaciones para pendientes
          # @recordacion.e_pendiente
          # Fin del tema          
        end
        @recordacion.fecha = Time.now
        @recordacion.descripcion = "Inicio de dia"
        @recordacion.save
        flash[:notice] = "Recordaciones enviadas " + " - " +Time.now.strftime("%Y-%m-%d %X")
      end
    end
    @recordaciones = Recordacion.find(:all, :limit=> 10, :order =>"fecha desc")
  end

  private
  def determine_layout
    if ['index'].include?(action_name)
      "automatic"
    else
      "application"
    end
  end
end
