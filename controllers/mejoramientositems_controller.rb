class MejoramientositemsController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @mejoramientositems = Mejoramientositem.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mejoramientositems }
    end
  end

  def informe
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_MejoramientosElementos_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @mejoramientositems = Mejoramientositem.find(:all, :order=>"descripcion")
    respond_to do |format|
       format.xls
    end
  end

  def new
    @mejoramientositem = Mejoramientositem.new
    render :action => "mejoramientositem_form"
  end

  def create
     @mejoramientositem = Mejoramientositem.new(params[:mejoramientositem])
     #@mejoramientositem.user_id = is_admin
     if @mejoramientositem.save
       is_trigger_mej(0,is_admin,'mejoramientositems','I')
       flash[:notice] = "mejoramientositem Creado con Exito."
       redirect_to edit_mejoramientositem_path(@mejoramientositem)
     else
       flash[:warning] = "Problemas con la creacion del registro."
       render :action => "mejoramientositem_form"
      end
  end

 def show
   @mejoramientositem = Mejoramientositem.find(params[:id])
   respond_to do |format|
     format.html # show.html.erb
     format.xml  { render :xml => @mejoramientositem }
   end
 end

 def edit
   @mejoramientositem = Mejoramientositem.find(params[:id])
   respond_to do |format|
     format.html { render :action => "mejoramientositem_form" }
   end
 end

 def update
   @mejoramientositem = Mejoramientositem.find(params[:id])
   if @mejoramientositem.update_attributes(params[:mejoramientositem])
     is_trigger_mej(0,is_admin,'mejoramientositems','A')
     flash[:notice] = "Mejoramientositem actualizado correctamente."
     redirect_to edit_mejoramientositem_path(@mejoramientositem)
   else
     render :action => "mejoramientositem_form"
   end
   rescue
   redirect_to edit_mejoramientositem_path(@mejoramientositem)
 end

 def destroy
   @mejoramientositem = Mejoramientositem.find(params[:id])
   @mejoramientositem.destroy
   respond_to do |format|
     format.html { redirect_to mejoramientositems_path }
     format.xml  { head :ok }
   end
 end

  private
  def determine_layout
    if ['informe','actacambioobra','actaterminaobra','actareciboobra','actaaprobacionobra'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
