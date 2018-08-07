class UsersproyectosController < ApplicationController
before_filter :require_user

  def index
    user   = User.find(params[:user_id])
    @usersproyectos = user.usersproyectos.all
  end

  def edit
    @usersproyecto  = Usersproyecto.find(params[:id], :include => "user")
    @user  = @usersproyecto.user
    respond_to do |format|
      format.js { render :action => "edit_usersproyecto" }
    end
  end

  def create
    @user  = User.find(params[:user_id])
    @usersproyecto = Usersproyecto.new(params[:usersproyecto])
    if @usersproyecto.valid?
      @user.usersproyectos << @usersproyecto
      @user.save
      @usersproyecto = Usersproyecto.new
    else
      flash[:warning] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "usersproyectos" }
    end
  end

  def update
    @usersproyecto        = Usersproyecto.new
    usersproyecto         = Usersproyecto.find(params[:id])
    @user        = usersproyecto.user
    ok = usersproyecto.update_attributes(params[:usersproyecto])
    flash[:notice] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "usersproyectos" }
    end
  end

  def destroy
    usersproyecto   = Usersproyecto.find(params[:id])
    @user  = usersproyecto.user
    @usersproyecto  = Usersproyecto.new
    usersproyecto.destroy
    respond_to do |format|
      format.js { render :action => "usersproyectos" }
    end
  end
end