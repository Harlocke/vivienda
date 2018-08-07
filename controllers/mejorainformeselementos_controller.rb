class MejorainformeselementosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
     @mejorainformeselementos = Mejorainformeselemento.all
     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @mejorainformeselementos }
     end
  end

  def new
    @mejorainformeselemento = Mejorainformeselemento.new
    @mejorainformescriterio = Mejorainformescriterio.new
    @mejorainformesimagen = Mejorainformesimagen.new
    render :action => "mejorainformeselemento_form"
  end

  def create
     @mejorainformeselemento = Mejorainformeselemento.new(params[:mejorainformeselemento])
     @mejorainformeselemento.user_id = is_admin
     if @mejorainformeselemento.save
       flash[:notice] = "mejorainformeselemento Creado con Exito."
       redirect_to edit_mejorainformeselemento_path(@mejorainformeselemento)
     else
       @mejorainformescriterio = Mejorainformescriterio.new
       @mejorainformesimagen = Mejorainformesimagen.new
       flash[:warning] = "Problemas con la creacion del registro."
       render :action => "mejorainformeselemento_form"
      end
  end

 def show
   @mejorainformeselemento = Mejorainformeselemento.find(params[:id])
   respond_to do |format|
     format.html # show.html.erb
     format.xml  { render :xml => @mejorainformeselemento }
   end
 end

 def edit
   @mejorainformeselemento = Mejorainformeselemento.find(params[:id])
   @mejorainformescriterio = Mejorainformescriterio.new
   @mejorainformesimagen = Mejorainformesimagen.new
   respond_to do |format|
     format.html { render :action => "mejorainformeselemento_form" }
   end
 end

 def update
   @mejorainformeselemento = Mejorainformeselemento.find(params[:id])
   @mejoele = Mejoramientoselemento.find(@mejorainformeselemento.mejoramientoselemento_id)
   #logger.error("Graboooo1 ... #{params[:mejorainformeselemento][:cantidad].to_f}" )
   var1 = 0.0
   var = 0.0
   var = params[:mejorainformeselemento][:cantidad].to_f
   var1 = @mejoele.valor_unitario.to_f * var.to_f
   params[:mejorainformeselemento][:valor_total] = var1.to_s
   #logger.error("Graboooo2 ... #{params[:mejorainformeselemento][:valor_total].to_s}" )
   if @mejorainformeselemento.update_attributes(params[:mejorainformeselemento])
     is_trigger_mej(@mejorainformeselemento.mejoramientosinforme.mejoramiento_id,is_admin,'mejorainformeselementos','A')
     flash[:notice] = "Item registrado con exito"
     redirect_to :controller=>"mejoramientosinformes", :action=>"edit", :id=>@mejorainformeselemento.mejoramientosinforme.mejoramientosinterventoria_id
     #redirect_to edit_mejorainformeselemento_path(@mejorainformeselemento)
   else
     @mejorainformescriterio = Mejorainformescriterio.new
     @mejorainformesimagen = Mejorainformesimagen.new
     flash[:warning] = "Problemas con la creacion del registro"
     render :action => "mejorainformeselemento_form"
   end
   #rescue
    # flash[:warning] = "Problemas con la creacion del registro2"
     #redirect_to edit_mejorainformeselemento_path(@mejorainformeselemento)
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
