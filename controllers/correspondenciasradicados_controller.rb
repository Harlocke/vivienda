class CorrespondenciasradicadosController < ApplicationController
before_filter :require_user
  layout :determine_layout

  def index
    correspondenciasenviada   = Correspondenciasenviada.find(params[:correspondenciasenviada_id])
    @correspondenciasradicados = correspondenciasenviada.correspondenciasradicados.all
  end

 def edit
    @correspondenciasradicado  = Correspondenciasradicado.find(params[:id], :include => "correspondenciasenviada")
    @correspondenciasenviada  = @correspondenciasradicado.correspondenciasenviada
    respond_to do |format|
      format.js { render :action => "edit_correspondenciasradicado" }
    end
  end

 def visualizar
    @correspondenciasradicado  = Correspondenciasradicado.find(params[:id])
  end

  def create
    @correspondenciasenviada  = Correspondenciasenviada.find(params[:correspondenciasenviada_id])
    @correspondenciasradicado = Correspondenciasradicado.new(params[:correspondenciasradicado])
    if Correspondenciasrecibida.exists?(["nro_radicado = ? and anno = ?", params[:correspondenciasradicado][:radicado], params[:correspondenciasradicado][:anno]]) == true
      @correspondenciasradicado.correspondenciasrecibida_id = Correspondenciasrecibida.find_by_nro_radicado_and_anno(params[:correspondenciasradicado][:radicado], params[:correspondenciasradicado][:anno]).id rescue nil
      @correspondenciasradicado.estado = 'CERRADO'
      if @correspondenciasradicado.valid?
        @correspondenciasenviada.correspondenciasradicados << @correspondenciasradicado
        @correspondenciasenviada.save
        @correspondenciasradicado = Correspondenciasradicado.new
        flash[:correspondenciasradicado] = "Creado con exito"
      else
        flash[:correspondenciasradicado] = "Se produjo un error al guardar el registro"
      end
    else
      flash[:correspondenciasradicado] = "El Nro del Radicado que indica no es valido. Verifique!!"
    end
    respond_to do |format|
      format.js { render :action => "correspondenciasradicados" }
    end
  end

  def update
    @correspondenciasradicado   = Correspondenciasradicado.new
    correspondenciasradicado    = Correspondenciasradicado.find(params[:id])
    @correspondenciasenviada        = correspondenciasradicado.correspondenciasenviada
    ok = correspondenciasradicado.update_attributes(params[:correspondenciasradicado])
    flash[:correspondenciasradicado] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "correspondenciasradicados" }
    end
  end

  def destroy
    correspondenciasradicado   = Correspondenciasradicado.find(params[:id])
    @correspondenciasenviada  = correspondenciasradicado.correspondenciasenviada
    @correspondenciasradicado  = Correspondenciasradicado.new
    correspondenciasradicado.destroy
    flash[:correspondenciasradicado] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "correspondenciasradicados" }
    end
  end

  private
  def determine_layout
    if ['create'].include?(action_name)
      "application"
#    else
#      "basico"
    end
  end
end

#  # GET /correspondenciasradicados
#  # GET /correspondenciasradicados.xml
#  def index
#    @correspondenciasradicados = Correspondenciasradicado.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @correspondenciasradicados }
#    end
#  end
#
#  # GET /correspondenciasradicados/1
#  # GET /correspondenciasradicados/1.xml
#  def show
#    @correspondenciasradicado = Correspondenciasradicado.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @correspondenciasradicado }
#    end
#  end
#
#  # GET /correspondenciasradicados/new
#  # GET /correspondenciasradicados/new.xml
#  def new
#    @correspondenciasradicado = Correspondenciasradicado.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @correspondenciasradicado }
#    end
#  end
#
#  # GET /correspondenciasradicados/1/edit
#  def edit
#    @correspondenciasradicado = Correspondenciasradicado.find(params[:id])
#  end
#
#  # POST /correspondenciasradicados
#  # POST /correspondenciasradicados.xml
#  def create
#    @correspondenciasradicado = Correspondenciasradicado.new(params[:correspondenciasradicado])
#
#    respond_to do |format|
#      if @correspondenciasradicado.save
#        flash[:notice] = 'Correspondenciasradicado was successfully created.'
#        format.html { redirect_to(@correspondenciasradicado) }
#        format.xml  { render :xml => @correspondenciasradicado, :status => :created, :location => @correspondenciasradicado }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @correspondenciasradicado.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /correspondenciasradicados/1
#  # PUT /correspondenciasradicados/1.xml
#  def update
#    @correspondenciasradicado = Correspondenciasradicado.find(params[:id])
#
#    respond_to do |format|
#      if @correspondenciasradicado.update_attributes(params[:correspondenciasradicado])
#        flash[:notice] = 'Correspondenciasradicado was successfully updated.'
#        format.html { redirect_to(@correspondenciasradicado) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @correspondenciasradicado.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /correspondenciasradicados/1
#  # DELETE /correspondenciasradicados/1.xml
#  def destroy
#    @correspondenciasradicado = Correspondenciasradicado.find(params[:id])
#    @correspondenciasradicado.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(correspondenciasradicados_url) }
#      format.xml  { head :ok }
#    end
#  end
