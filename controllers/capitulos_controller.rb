class CapitulosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
     @capitulos = Capitulo.all
     respond_to do |format|
       format.html # index.html.erb
       format.xml  { render :xml => @capitulos }
     end
  end

  def informe
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_CapitulosActividades_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @capitulos = Capitulo.find(:all, :order=>"desccapitulo")
    respond_to do |format|
       format.xls
    end
  end

  def new
    @capitulo = Capitulo.new
    @capituloscriterio = Capituloscriterio.new
    render :action => "capitulo_form"
  end

  def create
     @capitulo = Capitulo.new(params[:capitulo])
     @capitulo.user_id = is_admin
     if @capitulo.save
       flash[:notice] = "capitulo Creado con Exito."
       redirect_to edit_capitulo_path(@capitulo)
     else
       @capituloscriterio = Capituloscriterio.new
       flash[:warning] = "Problemas con la creacion del registro."
       render :action => "capitulo_form"
      end
  end

 def show
   @capitulo = Capitulo.find(params[:id])
   respond_to do |format|
     format.html # show.html.erb
     format.xml  { render :xml => @capitulo }
   end
 end

 def edit
   @capitulo = Capitulo.find(params[:id])
   @capituloscriterio = Capituloscriterio.new
   respond_to do |format|
     format.html { render :action => "capitulo_form" }
   end
 end

 def update
   @capitulo = Capitulo.find(params[:id])
   if @capitulo.update_attributes(params[:capitulo])
     flash[:notice] = "Capitulo actualizado correctamente."
     redirect_to edit_capitulo_path(@capitulo)
   else
     @capituloscriterio = Capituloscriterio.new
     render :action => "capitulo_form"
   end
   rescue
   redirect_to edit_capitulo_path(@capitulo)
 end

 def destroy
   @capitulo = Capitulo.find(params[:id])
   @capitulo.destroy
   respond_to do |format|
     format.html { redirect_to capitulos_path }
     format.xml  { head :ok }
   end
 end

  private
  def determine_layout
    if [''].include?(action_name)
      "new2"
    elsif ['informe'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
