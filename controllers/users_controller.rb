class UsersController < ApplicationController
  before_filter :require_user, :checkaccess

  def checkaccess
    if is_permit('users') == false
      flash[:warning] = "Usted no tiene acceso a este modulo"
      redirect_to menus_path
    elsif is_activo == false
      current_user_session.destroy
      redirect_to new_user_session_url
      return false
    end
  end

  def index
    @users = User.search(params[:search], params[:page])

=begin
u = User.new
u.username = 'winter.idarraga'
u.email = 'winter.idarraga@isvimed.gov.co'
u.password = 'win717777'
u.password_confirmation = 'win717777'
u.dependencia_id = '10005'
u.nombre = 'WINTER ALONSO IDARRAGA MONTOYA'
u.activo = 'S'
u.directivo = 'N'
u.acceso_remoto = 'N'
u.observaciones = '71777790 - COLEGIO MAYOR - PROYECTO SAN LUIS'
u.save
=end


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end


  end
  
  def new
    @user = User.new
    @dependencias = Dependencia.all
  end

  def listar
    @users = User.find(:all, :conditions => [" activo = 'S' and nombre like '%%#{is_replacespace(params[:search].upcase.to_s)}%%'"], :order=>"nombre")
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      lastid = User.maximum('id')
      usersdato = Usersdato.new
      usersdato.user_id=lastid
      usersdato.save
      @depedencias = Dependencia.all
      redirect_to edit_user_path(lastid)
    else
      render :action => :new
    end
  end

  def show
    @user = User.find(params[:id])
    @usersmodulos = Usersmodulos.find_by_user_id(@user.id)
    @userspermisos = Userspermisos.find_by_user_id(@user.id)
    @usersproyectos = Usersproyectos.find_by_user_id(@user.id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def edit
    @user = User.find(params[:id])
    @usersmodulo = Usersmodulo.new
    @userspermiso = Userspermiso.new
    @usersproyecto = Usersproyecto.new
    respond_to do |format|
      format.html { render :action => "user_form" }
    end
  end
  
  def editpass
    @user = User.find(params[:id])
    respond_to do |format|
      format.html { render :action => "editpass" }
    end
  end

  def updatepass
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Contraseña Actualizada Correctamente."
      redirect_to menus_path
    else
      render :action => "editpass"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Perfil actualizado correctamente."
      @depedencias = Dependencia.all
      redirect_to edit_user_path(@user)
#      if (is_admin == 10002)
#        redirect_to edit_user_path(@user)
#      else
#        redirect_to menus_path
#      end
    else
      @usersmodulo = Usersmodulo.new
      @userspermiso = Userspermiso.new
      @usersproyecto = Usersproyecto.new
      @depedencias = Dependencia.all
      render :action => "user_form"
    end
    rescue
    redirect_to edit_user_path(@user)
  end

  def act
    @user = User.find(params[:id])
    @user.activo = 'S'
    @user.save
    flash[:notice] = "Actualizado"
    redirect_to users_path
  end

  def bact
    @user = User.find(params[:id])
    @user.activo = 'N'
    @user.save
    flash[:notice] = "Actualizado"
    redirect_to users_path
  end    

end
