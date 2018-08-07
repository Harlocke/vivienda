class CorrespondenciasController < ApplicationController

  before_filter :require_user
  
  def index
    @correspondenciasremitentes = Correspondenciasremitente.find(:all)
    #@productos = Producto.find(:all)
  end

end
