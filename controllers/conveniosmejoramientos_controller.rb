class ConveniosmejoramientosController < ApplicationController
  before_filter :require_user
  require 'ruby_plsql'

  def index
    convenio   = Convenio.find(params[:convenio_id])
    @conveniosmejoramientos = convenio.conveniosmejoramientos.all
  end

  def edit
    @conveniosmejoramiento  = Conveniosmejoramiento.find(params[:id], :include => "convenio")
    @convenio  = @conveniosmejoramiento.convenio
    respond_to do |format|
      format.js { render :action => "edit_conveniosmejoramiento" }
    end
  end

  def actualizamejora
    ActiveRecord::Base.connection.execute("begin prc_mejoramiento; end;")
    flash[:notice] = "Proceso de actualización de Obra Extra finalizado con Exito"
    redirect_to edit_convenio_path(params[:convenio_id])
  end

  def buscar
    respond_to do |format|
       format.html
       format.xls if params[:format] == 'xls'
    end
  end

  def create
    @convenio  = Convenio.find(params[:convenio_id])
    @conveniosmejoramiento = Conveniosmejoramiento.new(params[:conveniosmejoramiento])
    @conveniosmejoramiento.user_id = is_admin
    if @conveniosmejoramiento.valid?
      @convenio.conveniosmejoramientos << @conveniosmejoramiento
      @convenio.save
      @conveniosmejoramiento = Conveniosmejoramiento.new
      flash[:conveniosmejoramiento] = "Registro almacenado con Exito"
    else
      flash[:conveniosmejoramiento] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "conveniosmejoramientos" }
    end
  end

  def update
    @conveniosmejoramiento        = Conveniosmejoramiento.new
    conveniosmejoramiento         = Conveniosmejoramiento.find(params[:id])
    params[:conveniosmejoramiento][:user_actualiza] = is_admin
    @convenio        = conveniosmejoramiento.convenio
    ok = conveniosmejoramiento.update_attributes(params[:conveniosmejoramiento])
    flash[:conveniosmejoramiento] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "conveniosmejoramientos" }
    end
  end

  def nuevo1
    @conveniosmejoramiento        = Conveniosmejoramiento.new
    conveniosmejoramiento         = Conveniosmejoramiento.find(params[:id])
    @convenio        = conveniosmejoramiento.convenio
    ActiveRecord::Base.connection.execute(
      "insert into conveniosmejoramientos
       select conveniosmejoramientos_seq.nextval,#{@convenio.id},id,0,sysdate,sysdate,#{is_admin},null,null
       from   mejoramientositems
       where  id not in (select mejoramientositem_id from conveniosmejoramientos where convenio_id = #{@convenio.id})")
    flash[:conveniosmejoramiento] = "Actividades Adicionados con exito"
    respond_to do |format|
      format.js { render :action => "conveniosmejoramientos" }
    end
  end

  def nuevo2
    @conveniosmejoramiento        = Conveniosmejoramiento.new
    conveniosmejoramiento         = Conveniosmejoramiento.find(params[:id])
    @convenio        = conveniosmejoramiento.convenio
    ActiveRecord::Base.connection.execute(
      "insert into conveniosmejoramientos
       select conveniosmejoramientos_seq.nextval,#{@convenio.id},id,valor,sysdate,sysdate,#{is_admin},null,null
       from   mejoramientositems
       where  valor > 0
       and    id not in (select mejoramientositem_id
                         from conveniosmejoramientos
                         where convenio_id = #{@convenio.id})")
    flash[:conveniosmejoramiento] = "Actividades Adicionados con exito"
    respond_to do |format|
      format.js { render :action => "conveniosmejoramientos" }
    end
  end

  def nuevo3
    @conveniosmejoramiento        = Conveniosmejoramiento.new
    conveniosmejoramiento         = Conveniosmejoramiento.find(params[:id])
    @convenio        = conveniosmejoramiento.convenio
    ActiveRecord::Base.connection.execute(
      "insert into conveniosmejoramientos
       select conveniosmejoramientos_seq.nextval,#{@convenio.id},id,valor,sysdate,sysdate,#{is_admin},null,null
       from   mejoramientositems
       where  descripcion like '2015-%'
       and    valor > 0
       and    id not in (select mejoramientositem_id
                         from conveniosmejoramientos
                         where convenio_id = #{@convenio.id})")
    flash[:conveniosmejoramiento] = "Actividades Adicionados con exito"
    respond_to do |format|
      format.js { render :action => "conveniosmejoramientos" }
    end
  end

  def nuevo4
    @conveniosmejoramiento        = Conveniosmejoramiento.new
    conveniosmejoramiento         = Conveniosmejoramiento.find(params[:id])
    @convenio        = conveniosmejoramiento.convenio
    ActiveRecord::Base.connection.execute(
      "insert into conveniosmejoramientos
       select conveniosmejoramientos_seq.nextval,#{@convenio.id},id,valor,sysdate,sysdate,#{is_admin},null,null
       from   mejoramientositems
       where  descripcion like '2016-%'
       and    valor > 0
       and    id not in (select mejoramientositem_id
                         from conveniosmejoramientos
                         where convenio_id = #{@convenio.id})")
    flash[:conveniosmejoramiento] = "Actividades Adicionados con exito"
    respond_to do |format|
      format.js { render :action => "conveniosmejoramientos" }
    end
  end

  def nuevo5
    @conveniosmejoramiento        = Conveniosmejoramiento.new
    conveniosmejoramiento         = Conveniosmejoramiento.find(params[:id])
    @convenio        = conveniosmejoramiento.convenio
    ActiveRecord::Base.connection.execute(
      "insert into conveniosmejoramientos
       select conveniosmejoramientos_seq.nextval,#{@convenio.id},id,valor,sysdate,sysdate,#{is_admin},null,null
       from   mejoramientositems
       where  descripcion like '2017-%'
       and    valor > 0
       and    id not in (select mejoramientositem_id
                         from conveniosmejoramientos
                         where convenio_id = #{@convenio.id})")
    flash[:conveniosmejoramiento] = "Actividades Adicionados con exito"
    respond_to do |format|
      format.js { render :action => "conveniosmejoramientos" }
    end
    def nuevo6
    @conveniosmejoramiento        = Conveniosmejoramiento.new
    conveniosmejoramiento         = Conveniosmejoramiento.find(params[:id])
    @convenio        = conveniosmejoramiento.convenio
    ActiveRecord::Base.connection.execute(
      "insert into conveniosmejoramientos
       select conveniosmejoramientos_seq.nextval,#{@convenio.id},id,valor,sysdate,sysdate,#{is_admin},null,null
       from   mejoramientositems
       where  descripcion like '2018-%'
       and    valor > 0
       and    id not in (select mejoramientositem_id
                         from conveniosmejoramientos
                         where convenio_id = #{@convenio.id})")
    flash[:conveniosmejoramiento] = "Actividades Adicionados con exito"
    respond_to do |format|
      format.js { render :action => "conveniosmejoramientos" }
    end
  end  
  def borrar1
    @conveniosmejoramiento        = Conveniosmejoramiento.new
    conveniosmejoramiento         = Conveniosmejoramiento.find(params[:id])
    @convenio        = conveniosmejoramiento.convenio
    ActiveRecord::Base.connection.execute(
      "delete from conveniosmejoramientos where convenio_id = #{@convenio.id}")
    flash[:conveniosmejoramiento] = "Actividades Eliminados con exito"
    respond_to do |format|
      format.js { render :action => "conveniosmejoramientos" }
    end
  end

  def destroy
    conveniosmejoramiento   = Conveniosmejoramiento.find(params[:id])
    @convenio  = conveniosmejoramiento.convenio
    @conveniosmejoramiento  = Conveniosmejoramiento.new
    conveniosmejoramiento.destroy
    respond_to do |format|
      format.js { render :action => "conveniosmejoramientos" }
    end
  end
end
