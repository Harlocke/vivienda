class EstudiosactividadesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    estudiosprevio   = Estudiosprevio.find(params[:estudiosprevio_id])
    @estudiosactividades = estudiosprevio.estudiosactividades.all
  end

 def edit
    @estudiosactividad  = Estudiosactividad.find(params[:id], :include => "estudiosprevio")
    @estudiosprevio  = @estudiosactividad.estudiosprevio
    respond_to do |format|
      format.js { render :action => "edit_estudiosactividad" }
    end
  end

  def create
    vlrexiste = ""
    @estudiosprevio  = Estudiosprevio.find(params[:estudiosprevio_id])
    @estudiosactividad = Estudiosactividad.new(params[:estudiosactividad])
    if @estudiosactividad.observaciones.include? "*."
      valor = @estudiosactividad.observaciones.split('*.')
      vlrexiste = "S"
    else
      vlrexiste = "N"
    end
    if vlrexiste.to_s == 'S'
      i = 1
      while i < valor.size
        #logger.error(" valor...."+valor[i].to_s)
        @estudiosprevio  = Estudiosprevio.find(params[:estudiosprevio_id])
        @estudiosactividad.observaciones = valor[i].to_s
        @estudiosactividad.user_id = is_admin
        @estudiosprevio.estudiosactividades << @estudiosactividad
        @estudiosprevio.save
        @estudiosactividad = Estudiosactividad.new
        i = i + 1
      end
    else
      if @estudiosactividad.valid?
        @estudiosprevio.estudiosactividades << @estudiosactividad
        @estudiosprevio.save
        @estudiosactividad = Estudiosactividad.new
        flash[:estudiosactividad] = "Creado con exito"
      else
        flash[:estudiosactividad] = "Se produjo un error al guardar el registro"
      end
    end
    respond_to do |format|
      format.js { render :action => "estudiosactividades" }
    end
  end

  def update
    @estudiosactividad        = Estudiosactividad.new
    estudiosactividad         = Estudiosactividad.find(params[:id])
    #estudiosactividad.user_id = is_admin
    @estudiosprevio        = estudiosactividad.estudiosprevio
    ok = estudiosactividad.update_attributes(params[:estudiosactividad])
    flash[:estudiosactividad] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "estudiosactividades" }
    end
  end

  def destroy
    estudiosactividad   = Estudiosactividad.find(params[:id])
    @estudiosprevio  = estudiosactividad.estudiosprevio
    @estudiosactividad  = Estudiosactividad.new
    estudiosactividad.destroy
    flash[:estudiosactividad] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "estudiosactividades" }
    end
  end
end
