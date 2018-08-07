class MejoramientostiposController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
     @mejoramientostipos = Mejoramientostipo.all
     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @mejoramientostipos }
     end
  end

  def new
    @mejoramientostipo = Mejoramientostipo.new
    render :action => "mejoramientostipo_form"
  end

  def create
     @mejoramientostipo = Mejoramientostipo.new(params[:mejoramientostipo])
     @mejoramientostipo.user_id = is_admin
     if @mejoramientostipo.save
       flash[:notice] = "mejoramientostipo Creado con Exito."
       redirect_to edit_mejoramientostipo_path(@mejoramientostipo)
     else
       flash[:warning] = "Problemas con la creacion del registro."
       render :action => "mejoramientostipo_form"
      end
  end

 def show
   @mejoramientostipo = Mejoramientostipo.find(params[:id])
   respond_to do |format|
     format.html # show.html.erb
     format.xml  { render :xml => @mejoramientostipo }
   end
 end

 def edit
   @mejoramientostipo = Mejoramientostipo.find(params[:id])
   respond_to do |format|
     format.html { render :action => "mejoramientostipo_form" }
   end
 end

 def update
   @mejoramientostipo = Mejoramientostipo.find(params[:id])
   if @mejoramientostipo.update_attributes(params[:mejoramientostipo])
     flash[:notice] = "Mejoramientostipo actualizado correctamente."
     redirect_to edit_mejoramientostipo_path(@mejoramientostipo)
   else
     render :action => "mejoramientostipo_form"
   end
   rescue
   redirect_to edit_mejoramientostipo_path(@mejoramientostipo)
 end

 def destroy
   @mejoramientostipo = Mejoramientostipo.find(params[:id])
   @mejoramientostipo.destroy
   respond_to do |format|
     format.html { redirect_to mejoramientostipos_path }
     format.xml  { head :ok }
   end
 end

  private
  def determine_layout
    if [''].include?(action_name)
      "new2"
    else
      "application"
    end
  end
end
