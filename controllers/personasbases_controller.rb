class PersonasbasesController < ApplicationController
  before_filter :require_user
  require 'ruby_plsql'
  layout :determine_layout

  def show
    persona   = Persona.find(params[:persona_id])
    @personasbases = persona.personasbases.all
  end

  def imagen
    @ruta = RAILS_ROOT+"/public/images/censoudea/"+params[:id].to_s
    @imagen = params[:id].to_s
  end

  private
  def determine_layout
    if ['imagen'].include?(action_name)
      "excel"
    else
      "application"
    end
  end

#  def index
#    @personasbases = Personasbase.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @personasbases }
#    end
#  end
#
#  # GET /personasbases/1
#  # GET /personasbases/1.xml
#  def show
#    @personasbase = Personasbase.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @personasbase }
#    end
#  end
#
#  # GET /personasbases/new
#  # GET /personasbases/new.xml
#  def new
#    @personasbase = Personasbase.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @personasbase }
#    end
#  end
#
#  # GET /personasbases/1/edit
#  def edit
#    @personasbase = Personasbase.find(params[:id])
#  end
#
#  # POST /personasbases
#  # POST /personasbases.xml
#  def create
#    @personasbase = Personasbase.new(params[:personasbase])
#
#    respond_to do |format|
#      if @personasbase.save
#        format.html { redirect_to(@personasbase, :notice => 'Personasbase was successfully created.') }
#        format.xml  { render :xml => @personasbase, :status => :created, :location => @personasbase }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @personasbase.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /personasbases/1
#  # PUT /personasbases/1.xml
#  def update
#    @personasbase = Personasbase.find(params[:id])
#
#    respond_to do |format|
#      if @personasbase.update_attributes(params[:personasbase])
#        format.html { redirect_to(@personasbase, :notice => 'Personasbase was successfully updated.') }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @personasbase.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /personasbases/1
#  # DELETE /personasbases/1.xml
#  def destroy
#    @personasbase = Personasbase.find(params[:id])
#    @personasbase.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(personasbases_url) }
#      format.xml  { head :ok }
#    end
#  end
end
