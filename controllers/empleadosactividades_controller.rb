class EmpleadosactividadesController < ApplicationController
before_filter :require_user
  def index
    empleado   = Empleado.find(params[:empleado_id])
    @empleadosactividades = empleado.empleadosactividades.all
  end

  def edit
    @empleadosactividad  = Empleadosactividad.find(params[:id], :include => "empleado")
    @empleado  = @empleadosactividad.empleado
    respond_to do |format|
      format.js { render :action => "edit_empleadosactividad" }
    end
  end

  def buscar
        respond_to do |format|
           format.html
           format.xls if params[:format] == 'xls'
        end
  end

  def create
    @empleado  = Empleado.find(params[:empleado_id])
    @empleadosactividad = Empleadosactividad.new(params[:empleadosactividad])
    if @empleadosactividad.valid?
      @empleado.empleadosactividades << @empleadosactividad
      @empleado.save
      @empleadosactividad = Empleadosactividad.new
      flash[:empleadosactividad] = "Registro almacenado con Exito"
    else
      flash[:empleadosactividad] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "empleadosactividades" }
    end
  end

  def update
    @empleadosactividad        = Empleadosactividad.new
    empleadosactividad         = Empleadosactividad.find(params[:id])
    @empleado        = empleadosactividad.empleado
    ok = empleadosactividad.update_attributes(params[:empleadosactividad])
    flash[:empleadosactividad] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "empleadosactividades" }
    end
  end

  def destroy
    empleadosactividad   = Empleadosactividad.find(params[:id])
    @empleado  = empleadosactividad.empleado
    @empleadosactividad  = Empleadosactividad.new
    empleadosactividad.destroy
    respond_to do |format|
      format.js { render :action => "empleadosactividades" }
    end
  end
end

#  # GET /empleadosactividades
#  # GET /empleadosactividades.xml
#  def index
#    @empleadosactividades = Empleadosactividad.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @empleadosactividades }
#    end
#  end
#
#  # GET /empleadosactividades/1
#  # GET /empleadosactividades/1.xml
#  def show
#    @empleadosactividad = Empleadosactividad.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @empleadosactividad }
#    end
#  end
#
#  # GET /empleadosactividades/new
#  # GET /empleadosactividades/new.xml
#  def new
#    @empleadosactividad = Empleadosactividad.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @empleadosactividad }
#    end
#  end
#
#  # GET /empleadosactividades/1/edit
#  def edit
#    @empleadosactividad = Empleadosactividad.find(params[:id])
#  end
#
#  # POST /empleadosactividades
#  # POST /empleadosactividades.xml
#  def create
#    @empleadosactividad = Empleadosactividad.new(params[:empleadosactividad])
#
#    respond_to do |format|
#      if @empleadosactividad.save
#        flash[:notice] = 'Empleadosactividad was successfully created.'
#        format.html { redirect_to(@empleadosactividad) }
#        format.xml  { render :xml => @empleadosactividad, :status => :created, :location => @empleadosactividad }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @empleadosactividad.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /empleadosactividades/1
#  # PUT /empleadosactividades/1.xml
#  def update
#    @empleadosactividad = Empleadosactividad.find(params[:id])
#
#    respond_to do |format|
#      if @empleadosactividad.update_attributes(params[:empleadosactividad])
#        flash[:notice] = 'Empleadosactividad was successfully updated.'
#        format.html { redirect_to(@empleadosactividad) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @empleadosactividad.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /empleadosactividades/1
#  # DELETE /empleadosactividades/1.xml
#  def destroy
#    @empleadosactividad = Empleadosactividad.find(params[:id])
#    @empleadosactividad.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(empleadosactividades_url) }
#      format.xml  { head :ok }
#    end
#  end
#end
