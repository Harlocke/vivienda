  class ConveniosresolmejoramientosController < ApplicationController
  before_filter :require_user

  def index
    conveniosresolintencion   = Conveniosresolintencion.find(params[:conveniosresolintencion_id])
    @conveniosresolmejoramientos = conveniosresolintencion.conveniosresolmejoramientos.all
  end

  def edit
    @conveniosresolmejoramiento  = Conveniosresolmejoramiento.find(params[:id], :include => "conveniosresolintencion")
    ActiveRecord::Base.connection.execute("update conveniosresolmejoramientos set estado = 'NO', valor = 0
                                           where  id = #{@conveniosresolmejoramiento.id}")
    @conveniosresolintencion  = @conveniosresolmejoramiento.conveniosresolintencion
    respond_to do |format|
      format.js { render :action => "edit_conveniosresolmejoramiento" }
    end
  end

  def create
    @conveniosresolintencion  = Conveniosresolintencion.find(params[:conveniosresolintencion_id])
    @conveniosresolmejoramiento = Conveniosresolmejoramiento.new(params[:conveniosresolmejoramiento])
    @valor = params[:conveniosresolmejoramiento][:mejoramiento_id]
    if @valor.to_s != ""
      i = 0
      while i < @valor.size
        #if @conveniosresolintencion.conveniosforma.porcentaje.to_s == '10'
        #  @valorcalculo = Mejoramiento.find(@valor[i]).vlrtotaleje.to_f - Mejoramientospago.sum("valor", :conditions=>["mejoramiento_id = #{@valor[i]}"]).to_f
        #else
        @valorcalculo = Mejoramiento.find(@valor[i]).valor_resolucion.to_f * (@conveniosresolintencion.conveniosforma.porcentaje.to_f / 100.to_f).to_f
        #end
        ActiveRecord::Base.connection.execute("insert into conveniosresolmejoramientos (id,CONVENIOSRESOLINTENCION_ID,mejoramiento_id,valor,user_id,created_at,updated_at,valor_cobrado,estado)
                                               values (conveniosresolmejoramiento_seq.nextval,#{@conveniosresolintencion.id},#{@valor[i]},#{@valorcalculo.to_i},#{is_admin},sysdate,sysdate,#{@valorcalculo.to_i},'SI')")
        i = i + 1
      end
    end
    @conveniosresolmejoramiento = Conveniosresolmejoramiento.new
    respond_to do |format|
      format.js { render :action => "conveniosresolmejoramientos" }
    end
  end

  def si
    @conveniosresolmejoramiento        = Conveniosresolmejoramiento.new
    conveniosresolmejoramiento         = Conveniosresolmejoramiento.find(params[:id])
    conveniosresolmejoramiento.estado ='SI'
    @conveniosresolintencion        = conveniosresolmejoramiento.conveniosresolintencion
    ok = conveniosresolmejoramiento.update_attributes(params[:conveniosresolmejoramiento])
    respond_to do |format|
      format.js { render :action => "conveniosresolmejoramientos" }
    end
  end

  def no
    @conveniosresolmejoramiento        = Conveniosresolmejoramiento.new
    conveniosresolmejoramiento         = Conveniosresolmejoramiento.find(params[:id])
    conveniosresolmejoramiento.estado ='NO'
    conveniosresolmejoramiento.valor = 0
    @conveniosresolintencion        = conveniosresolmejoramiento.conveniosresolintencion
    ok = conveniosresolmejoramiento.update_attributes(params[:conveniosresolmejoramiento])
    respond_to do |format|
      format.js { render :action => "conveniosresolmejoramientos" }
    end
  end

#
#  def create
#    @conveniosresolintencion  = Conveniosresolintencion.find(params[:conveniosresolintencion_id])
#    @conveniosresolmejoramiento = Conveniosresolmejoramiento.new(params[:conveniosresolmejoramiento])
#    @conveniosresolmejoramiento.user_id = is_admin
#    if @conveniosresolmejoramiento.valid?
#      @conveniosresolintencion.conveniosresolmejoramientos << @conveniosresolmejoramiento
#      @conveniosresolintencion.save
#      @conveniosresolmejoramiento = Conveniosresolmejoramiento.new
#      flash[:conveniosresolmejoramiento] = "Registro almacenado con Exito"
#    else
#      flash[:conveniosresolmejoramiento] = "Se produjo un error al guardar el registro"
#    end
#    respond_to do |format|
#      format.js { render :action => "conveniosresolmejoramientos" }
#    end
#  end

  def update
    @conveniosresolmejoramiento        = Conveniosresolmejoramiento.new
    conveniosresolmejoramiento         = Conveniosresolmejoramiento.find(params[:id])
    @estado = conveniosresolmejoramiento.estado.to_s
    @conveniosresolintencion        = conveniosresolmejoramiento.conveniosresolintencion
    ok = conveniosresolmejoramiento.update_attributes(params[:conveniosresolmejoramiento])
    if ok == true
      flash[:conveniosresolmejoramiento] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "conveniosresolmejoramientos" }
      end
    else
      flash[:conveniosresolmejoramiento] = "Se produjo un error al actualizar el registro"
      if @estado.to_s == "NO" and params[:conveniosresolmejoramiento][:observacion].to_s == ""
        @error = "NO OK. Debe registrar la observación"
      end
      render :update do |page|
        page.alert "ATENCIÓN: El Registro presenta inconsistencias y no se permite Actualizar.\n"+@error.to_s
      end
    end
  end

  def destroy
    conveniosresolmejoramiento   = Conveniosresolmejoramiento.find(params[:id])
    @conveniosresolintencion  = conveniosresolmejoramiento.conveniosresolintencion
    @conveniosresolmejoramiento  = Conveniosresolmejoramiento.new
    conveniosresolmejoramiento.destroy
    respond_to do |format|
      format.js { render :action => "conveniosresolmejoramientos" }
    end
  end
end
