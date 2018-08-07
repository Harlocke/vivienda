class CrucesimagenesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def new
    @crucesimagen = Crucesimagen.new
    render :action => "crucesimagen_form"
  end

  def create
    @crucesimagen = Crucesimagen.new(params[:crucesimagen])
    @crucesimagen.user_id = is_admin
    if @crucesimagen.save
      flash[:notice] = "Creado con Exito."
      redirect_to new_crucesimagen_path
    else
      render :action => "crucesimagen_form"
     end
  end

  def destroy
    @crucesimagen = Crucesimagen.find(params[:id])
    @crucesimagen.destroy
    respond_to do |format|
      format.html { redirect_to(crucesimagenes_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['visualizar','ver'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end