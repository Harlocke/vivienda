class MejoramientosinformesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
     @mejoramientosinformes = Mejoramientosinforme.all
     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @mejoramientosinformes }
     end
  end

  def new
    @mejoramientosinforme = Mejoramientosinforme.new
    @mejorainformeselemento = Mejorainformeselemento.new
    render :action => "mejoramientosinforme_form"
  end

  def create
     @mejoramientosinforme = Mejoramientosinforme.new(params[:mejoramientosinforme])
     @mejoramientosinforme.user_id = is_admin
     if @mejoramientosinforme.save
       is_trigger_mej(@mejoramientosinforme.mejoramiento_id,is_admin,'mejoramientosinformes','I')
       flash[:notice] = "mejoramientosinforme Creado con Exito."
       redirect_to edit_mejoramientosinforme_path(@mejoramientosinforme)
     else
       @mejorainformeselemento = Mejorainformeselemento.new
       flash[:warning] = "Problemas con la creacion del registro."
       render :action => "mejoramientosinforme_form"
      end
  end

 def show
   @mejoramientosinforme = Mejoramientosinforme.find(params[:id])
   respond_to do |format|
     format.html # show.html.erb
     format.xml  { render :xml => @mejoramientosinforme }
   end
 end

 def edit
   @mejoramientosinforme = Mejoramientosinforme.find(:first, :conditions=>["mejoramientosinterventoria_id = #{params[:id]}"])
   @mejorainformeselemento = Mejorainformeselemento.new
   respond_to do |format|
     format.html { render :action => "mejoramientosinforme_form" }
   end
 end

 def informe
   @mejoramientosinforme = Mejoramientosinforme.find(:first, :conditions=>["mejoramientosinterventoria_id = #{params[:id]}"])
 end

 def update
   @mejoramientosinforme = Mejoramientosinforme.find(params[:id])
   if @mejoramientosinforme.update_attributes(params[:mejoramientosinforme])
     is_trigger_mej(@mejoramientosinforme.mejoramiento_id,is_admin,'mejoramientosinformes','A')
     flash[:notice] = "Mejoramientosinforme actualizado correctamente."
     redirect_to edit_mejoramientosinforme_path(@mejoramientosinforme)
   else
     @mejorainformeselemento = Mejorainformeselemento.new
     render :action => "mejoramientosinforme_form"
   end
   rescue
   redirect_to edit_mejoramientosinforme_path(@mejoramientosinforme)
 end

 private
  def determine_layout
    if ['informe'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
