class TitulacionescarguesController < ApplicationController
  layout :determine_layout
  before_filter :require_user

  def index
  end

  def new
    @titulacionescargue = Titulacionescargue.new
	  @catastrosdato = Catastrosdato.find(params[:id])
    if Persona.exists?(["ltrim(rtrim(identificacion)) = '#{@catastrosdato.documento}'"]) == true
      flash[:notice] = "Ya existe el registro"
      #Se verifica si la persona esta asociada al cobama
      ActiveRecord::Base.connection.execute("begin prc_titulacionescargueotro(#{@catastrosdato.id},#{params[:titulacion_id].to_i},#{is_admin}); end;")
      redirect_to edit_titulacion_path(params[:titulacion_id].to_i)
      #personexiste
    else
      @titulacionescargue.titulacion_id = params[:titulacion_id].to_i
      @titulacionescargue.identificacion = @catastrosdato.documento
      @titulacionescargue.primer_nombre = @catastrosdato.dato3
      @titulacionescargue.segundo_nombre = @catastrosdato.dato4
      @titulacionescargue.primer_apellido = @catastrosdato.dato1
      @titulacionescargue.segundo_apellido = @catastrosdato.dato2
      @titulacionescargue.direccion = @catastrosdato.direccion
      @titulacionescargue.matricula = @catastrosdato.matricula
      @titulacionescargue.catastrosdato_id = @catastrosdato.id
      render :action => "titulacionescargue_form"
    end    
  end

  def edit
    @titulacionescargue = Titulacionescargue.find(params[:id])
    respond_to do |format|
      format.html { render :action => "titulacionescargue_form" }
    end
  end

  def create
    @titulacionescargue = Titulacionescargue.new(params[:titulacionescargue])
    @titulacionescargue.user_id = is_admin
    if @titulacionescargue.save
      if Benevivienda.exists?(["identificacion = '#{@titulacionescargue.identificacion.to_s}'"]) 
         flash[:warning] = "La identificación ya esta creada como beneficiario."
      else
        flash[:notice] = "El registro ha sido registrado con Exito."
      end
      #Inicia proceso de Asociacion
      ActiveRecord::Base.connection.execute("begin prc_titulacionescargue(#{@titulacionescargue.id}); end;")
      redirect_to edit_titulacion_path(@titulacionescargue.titulacion_id)
    else
      render :action => "titulacionescargue_form"
    end
  end

  private
  def determine_layout
    if ['cierre'].include?(action_name)
      "atencion"
    elsif ['consolidado'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end

#  # GET /titulacionescargues
#  # GET /titulacionescargues.xml
#  def index
#    @titulacionescargues = Titulacionescargue.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @titulacionescargues }
#    end
#  end
#
#  # GET /titulacionescargues/1
#  # GET /titulacionescargues/1.xml
#  def show
#    @titulacionescargue = Titulacionescargue.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @titulacionescargue }
#    end
#  end
#
#  # GET /titulacionescargues/new
#  # GET /titulacionescargues/new.xml
#  def new
#    @titulacionescargue = Titulacionescargue.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @titulacionescargue }
#    end
#  end
#
#  # GET /titulacionescargues/1/edit
#  def edit
#    @titulacionescargue = Titulacionescargue.find(params[:id])
#  end
#
#  # POST /titulacionescargues
#  # POST /titulacionescargues.xml
#  def create
#    @titulacionescargue = Titulacionescargue.new(params[:titulacionescargue])
#
#    respond_to do |format|
#      if @titulacionescargue.save
#        format.html { redirect_to(@titulacionescargue, :notice => 'Titulacionescargue was successfully created.') }
#        format.xml  { render :xml => @titulacionescargue, :status => :created, :location => @titulacionescargue }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @titulacionescargue.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /titulacionescargues/1
#  # PUT /titulacionescargues/1.xml
#  def update
#    @titulacionescargue = Titulacionescargue.find(params[:id])
#
#    respond_to do |format|
#      if @titulacionescargue.update_attributes(params[:titulacionescargue])
#        format.html { redirect_to(@titulacionescargue, :notice => 'Titulacionescargue was successfully updated.') }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @titulacionescargue.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /titulacionescargues/1
#  # DELETE /titulacionescargues/1.xml
#  def destroy
#    @titulacionescargue = Titulacionescargue.find(params[:id])
#    @titulacionescargue.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(titulacionescargues_url) }
#      format.xml  { head :ok }
#    end
#  end
#end
