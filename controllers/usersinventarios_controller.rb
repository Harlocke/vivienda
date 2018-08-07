class UsersinventariosController < ApplicationController

  before_filter :require_user

  def index
    @usersinventarios = Usersinventario.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @usersinventarios }
    end
  end

  def buscar
    @usersinventarios = Usersinventario.search(
                             params[:ubicacion][:inventarioselemento_id],
                             params[:ubicacion][:usuario],
                             params[:codigo],
                             params[:serial],
                             params[:ubicacion][:dependencia]
                             )
    if @usersinventarios.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_usersinventarios_path
    elsif @usersinventarios.count == 1 and params[:format] != 'xls'
      redirect_to edit_usersinventario_path(@usersinventarios)
    else
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end

  def new
    @usersinventario = Usersinventario.new
    render :action => "usersinventario_form"
  end

  def edit
    @usersinventario = Usersinventario.find(params[:id])
    respond_to do |format|
      format.html { render :action => "usersinventario_form" }
    end
  end

  def create
    @usersinventario = Usersinventario.new(params[:usersinventario])
    if @usersinventario.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_usersinventario_path(@usersinventario)
    else
      render :action => "usersinventario_form"
    end
  end

  def update
    @usersinventario = Usersinventario.find(params[:id])
    if @usersinventario.update_attributes(params[:usersinventario])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_usersinventario_path(@usersinventario)
    else
      render :action => "usersinventario_form"
    end
    rescue
      redirect_to edit_usersinventario_path(@usersinventario)
  end

  def destroy
    @usersinventario = Usersinventario.find(params[:id])
    @usersinventario.destroy
    respond_to do |format|
      format.html { redirect_to(usersinventarios_url) }
      format.xml  { head :ok }
    end
  end
end
