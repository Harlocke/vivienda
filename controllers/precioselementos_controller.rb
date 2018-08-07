class PrecioselementosController < ApplicationController
  before_filter :require_user
#  layout :determine_layout

  def index
    @precioselementos = Precioselemento.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @precioselementos }
    end
  end

  def show
    @precioselemento = Precioselemento.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @precioselemento }
    end
  end

  def listar
      @precioselementos = Precioselemento.find(:all, :conditions => [" autobuscar LIKE upper('%%#{params[:search]}%%')"], :limit=>10)
  end

  def new
    @precioselemento = Precioselemento.new
    render :action => "precioselemento_form"
  end

  def edit
    @precioselemento = Precioselemento.find(params[:id])
    @precioselementoshijo = Precioselementoshijo.new
    respond_to do |format|
      format.html { render :action => "precioselemento_form" }
    end
  end

  def create
    @precioselemento = Precioselemento.new(params[:precioselemento])
#    if @precioselemento.clasificacion.to_s == 'EQUIPO'
#      if @precioselemento.volumen.to_f > 0.0
#        @precioselemento.rendimiento = (@precioselemento.valor.to_f / @precioselemento.volumen.to_f) rescue 0
#      else
#        @precioselemento.rendimiento = 0
#      end
#    end
    @precioselemento.user_id = is_admin
    if @precioselemento.save
      flash[:notice] = "Registro Creado con Exito."
      redirect_to edit_precioselemento_path(@precioselemento)
    else
      @precioselementoshijo = Precioselementoshijo.new
      render :action => "precioselemento_form"
    end
  end

  def update
    @precioselemento = Precioselemento.find(params[:id])
    params[:precioselemento][:user_actualiza] = is_admin
#    if params[:precioselemento][:clasificacion].to_s == 'EQUIPO'
#      if params[:precioselemento][:volumen].to_f > 0.0
#        params[:precioselemento][:rendimiento] = (params[:precioselemento][:valor].to_f / params[:precioselemento][:volumen].to_f) rescue 0
#      else
#        params[:precioselemento][:rendimiento] = 0
#      end
#    end
    if @precioselemento.update_attributes(params[:precioselemento])
      flash[:notice] = "Registro Actualizado con Exito."
##      ActiveRecord::Base.connection.execute("update analisisprecioselementos set valorunitario = #{@precioselemento.valor}, valortotal = #{@precioselemento.valor} * cantidad, updated_at = CURRENT_TIMESTAMP()
#                                             where  elemento_id = #{@precioselemento.id}#")

      #@precioselemento.actualizavaloresitems
      redirect_to edit_precioselemento_path(@precioselemento)
    else
      @precioselementoshijo = Precioselementoshijo.new
      render :action => "precioselemento_form"
    end
  end

  def destroy
    @precioselemento = Precioselemento.find(params[:id])
    @precioselemento.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro ha sido eliminado con Exito."
        redirect_to busqueda_precioselementos_path
      }
      format.xml  { head :ok }
    end
  end
end
