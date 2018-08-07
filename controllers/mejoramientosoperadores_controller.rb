class MejoramientosoperadoresController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
     @mejoramientosoperadores = Mejoramientosoperador.all
     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @mejoramientosoperadores }
     end
  end

  def new
    @mejoramientosoperador = Mejoramientosoperador.new
    render :action => "mejoramientosoperador_form"
  end

  def create
     @mejoramientosoperador = Mejoramientosoperador.new(params[:mejoramientosoperador])
     @mejoramientosoperador.user_id = is_admin
     if @mejoramientosoperador.save
       flash[:notice] = "mejoramientosoperador Creado con Exito."
       redirect_to edit_mejoramientosoperador_path(@mejoramientosoperador)
     else
       flash[:warning] = "Problemas con la creacion del registro."
       render :action => "mejoramientosoperador_form"
      end
  end

 def show
   @mejoramientosoperador = Mejoramientosoperador.find(params[:id])
   respond_to do |format|
     format.html # show.html.erb
     format.xml  { render :xml => @mejoramientosoperador }
   end
 end

 def edit
   @mejoramientosoperador = Mejoramientosoperador.find(params[:id])
   respond_to do |format|
     format.html { render :action => "mejoramientosoperador_form" }
   end
 end

 def update
   @mejoramientosoperador = Mejoramientosoperador.find(params[:id])
   if @mejoramientosoperador.update_attributes(params[:mejoramientosoperador])
     flash[:notice] = "Mejoramientosoperador actualizado correctamente."
     redirect_to edit_mejoramientosoperador_path(@mejoramientosoperador)
   else
     render :action => "mejoramientosoperador_form"
   end
   rescue
   redirect_to edit_mejoramientosoperador_path(@mejoramientosoperador)
 end

 def destroy
   @mejoramientosoperador = Mejoramientosoperador.find(params[:id])
   @mejoramientosoperador.destroy
   respond_to do |format|
     format.html { redirect_to mejoramientosoperadores_path }
     format.xml  { head :ok }
   end
 end

  private
  def determine_layout
    if [''].include?(action_name)
      "new2"
    else
      "new2"
    end
  end
end
