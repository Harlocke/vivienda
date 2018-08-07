class DesplazadosController < ApplicationController

  before_filter :require_user

  def index
    persona   = Persona.find(params[:persona_id])
    @desplazados = persona.desplazados.all
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @desplazados = persona.desplazados.all
  end

  def edit
    @desplazado  = Desplazado.find(params[:id])
    @persona     = Persona.find(@desplazado.persona_id)
  end

  def buscar
    respond_to do |format|
       format.html
       format.xls if params[:format] == 'xls'
    end
  end

#
# def edit
#    @desplazado  = Desplazado.find(params[:id], :include => "persona")
#    @persona  = @desplazado.persona
#    respond_to do |format|
#      format.js { render :action => "edit_desplazado" }
#    end
#  end
  
  def visualizar
    @desplazado  = Desplazado.find(params[:id])
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @desplazado = Desplazado.new(params[:desplazado])
    if @desplazado.valid?
      @persona.desplazados << @desplazado
      @persona.save
      @desplazado = Desplazado.new
      flash[:desplazado] = "Creado con exito"
    else
      flash[:desplazado] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "desplazados" }
    end
  end

#  def update
#    @desplazado   = Desplazado.new
#    desplazado    = Desplazado.find(params[:id])
#    @persona        = desplazado.persona
#    ok = desplazado.update_attributes(params[:desplazado])
#    flash[:desplazado] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
#    respond_to do |format|
#      format.js { render :action => "desplazados" }
#    end
#  end

  def update
    @desplazado = Desplazado.find(params[:id])
    respond_to do |format|
      if @desplazado.update_attributes(params[:desplazado])
        format.html {
          redirect_to edit_desplazado_path(@desplazado) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @desplazado.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    desplazado   = Desplazado.find(params[:id])
    @persona  = desplazado.persona
    @desplazado  = Desplazado.new
    desplazado.respaldo(is_admin)
    desplazado.destroy
    flash[:desplazado] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "desplazados" }
    end
  end

end


#  # GET /desplazados
#  # GET /desplazados.xml
#  def index
#    @desplazados = Desplazado.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @desplazados }
#    end
#  end
#
#  # GET /desplazados/1
#  # GET /desplazados/1.xml
#  def show
#    @desplazado = Desplazado.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @desplazado }
#    end
#  end
#
#  # GET /desplazados/new
#  # GET /desplazados/new.xml
#  def new
#    @desplazado = Desplazado.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @desplazado }
#    end
#  end
#
#  # GET /desplazados/1/edit
#  def edit
#    @desplazado = Desplazado.find(params[:id])
#  end
#
#  # POST /desplazados
#  # POST /desplazados.xml
#  def create
#    @desplazado = Desplazado.new(params[:desplazado])
#
#    respond_to do |format|
#      if @desplazado.save
#        flash[:notice] = 'Desplazado was successfully created.'
#        format.html { redirect_to(@desplazado) }
#        format.xml  { render :xml => @desplazado, :status => :created, :location => @desplazado }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @desplazado.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /desplazados/1
#  # PUT /desplazados/1.xml
#  def update
#    @desplazado = Desplazado.find(params[:id])
#
#    respond_to do |format|
#      if @desplazado.update_attributes(params[:desplazado])
#        flash[:notice] = 'Desplazado was successfully updated.'
#        format.html { redirect_to(@desplazado) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @desplazado.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /desplazados/1
#  # DELETE /desplazados/1.xml
#  def destroy
#    @desplazado = Desplazado.find(params[:id])
#    @desplazado.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(desplazados_url) }
#      format.xml  { head :ok }
#    end
#  end
#end
