class UsersdatosController < ApplicationController
  before_filter :require_user

#  def buscar
#    @usersdatos      = Usersdato.buscar(params[:buscarnombre])
#    if @usersdatos.count == 0
#      flash[:notice] = "No hay informacion de la busqueda"
#      redirect_to busqueda_usersdatos_path
#    end
#    @buscarnombre  = params[:buscarnombre]
#  rescue
#    flash[:notice] = "Debe digitar datos para la consulta"
#    redirect_to busqueda_usersdatos_path
#  end

  def index
    @usersdatos = Usersdato.search(params[:search], params[:page])
    if @usersdatos.count == 0
      #flash[:notice] = "No hay resultados de la consulta "+params[:search].to_s
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @usersdatos }
      end
    else
      #flash[:notice] = "Se encontraron varios resultados"
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @usersdatos }
      end
    end
    rescue
      flash[:notice] = "No hay resultados de la consulta "
      redirect_to usersdatos_path
  end

  def show
    @usersdato = Usersdato.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @usersdato }
    end
  end

  def new
    @usersdato = Usersdato.new
    render :action => "usersdato_form"
  end

  def edit
    @usersdato = Usersdato.find(params[:id])
    respond_to do |format|
      format.html { render :action => "usersdato_form" }
    end
  end

  def create
    @usersdato = Usersdato.new(params[:usersdato])
    if @usersdato.save
      flash[:notice] = "Usuario Creado con Exito."
      redirect_to edit_usersdato_path(@usersdato)
    else
      render :action => "usersdato_form"
     end
  end

  def update
    @usersdato = Usersdato.find(params[:id])
    if @usersdato.update_attributes(params[:usersdato])
     flash[:notice] = "Usuario Actualizado con Exito."
      redirect_to edit_usersdato_path(@usersdato)
    else
      render :action => "usersdato_form"
    end
#    rescue
#      redirect_to edit_usersdato_path(@usersdato)
  end

  def destroy
    @usersdato = Usersdato.find(params[:id])
    @usersdato.destroy
    respond_to do |format|
      format.html { redirect_to(usersdatos_url) }
      format.xml  { head :ok }
    end
  end

end
