class AlmacenesController < ApplicationController

  before_filter :require_user
  
  def index
    @productos = Producto.find(:all)
  end

  def reporte
    
  end
end
