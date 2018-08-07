class RepartosinmueblesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    reparto   = Reparto.find(params[:reparto_id])
    @repartosinmuebles = reparto.repartosinmuebles.all
  end

  def edit
    @repartosinmueble  = Repartosinmueble.find(params[:id], :include => "reparto")
    @reparto  = @repartosinmueble.reparto
    respond_to do |format|
      format.js { render :action => "edit_repartosinmueble" }
    end
  end


  def create
    @reparto  = Reparto.find(params[:reparto_id])
    @repartosinmueble = Repartosinmueble.new(params[:repartosinmueble])
    @repartosinmueble.user_id = is_admin
    if @repartosinmueble.valid?
      @reparto.repartosinmuebles << @repartosinmueble
      @reparto.save
      if @repartosinmueble.vivienda_id
        ActiveRecord::Base.connection.execute("update repartos set zona = '#{@repartosinmueble.vivienda.esc_registrada_of.to_s}' where id = #{params[:reparto_id]}")
      elsif @repartosinmueble.corvide_id
        ActiveRecord::Base.connection.execute("update repartos set zona = 'ZONA SUR' where id = #{params[:reparto_id]} and '#{@repartosinmueble.corvide.matricula.to_s}' like '001%'")
        ActiveRecord::Base.connection.execute("update repartos set zona = 'ZONA NORTE' where id = #{params[:reparto_id]} and '#{@repartosinmueble.corvide.matricula.to_s}' like '01N%'")
      else
        ActiveRecord::Base.connection.execute("update repartos set zona = 'ZONA SUR' where id = #{params[:reparto_id]} and '#{@repartosinmueble.matricula.to_s}' like '001%'")
        ActiveRecord::Base.connection.execute("update repartos set zona = 'ZONA NORTE' where id = #{params[:reparto_id]} and '#{@repartosinmueble.matricula.to_s}' like '01N%'")
      end
      @repartosinmueble = Repartosinmueble.new
      flash[:repartosinmueble] = "Creado con exito"
    else
      flash[:repartosinmueble] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "repartosinmuebles" }
    end
  end


  def update
    @repartosinmueble        = Repartosinmueble.new
    repartosinmueble         = Repartosinmueble.find(params[:id])
    @reparto        = repartosinmueble.reparto
    ok = repartosinmueble.update_attributes(params[:repartosinmueble])
    flash[:repartosinmueble] = ok ? "asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "repartosinmuebles" }
    end
  end

  def destroy
    repartosinmueble   = Repartosinmueble.find(params[:id])
    @reparto  = repartosinmueble.reparto
    @repartosinmueble  = Repartosinmueble.new
    repartosinmueble.destroy
    respond_to do |format|
      format.js { render :action => "repartosinmuebles" }
    end
  end

  def atencion
    @repartosinmuebles = Repartosinmueble.find(params[:id])
  end

  private
  def determine_layout
    if ['atencion'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
