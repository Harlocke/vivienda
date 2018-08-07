class Fase2censosController < ApplicationController
  require 'geokit'

  include GeoKit::Geocoders

  before_filter :require_user
  layout :determine_layout

  rescue_from ActionView::MissingTemplate do |exception|
    nil
    # use exception.path to extract the path information
    # This does not work for partials
  end

  def retrieve
    f1 = params[:id].gsub("img","")
    f2 = f1.split("P")
    #valor = "d:/#{f2[0].to_s}/min_#{params[:id].to_s}.jpg"
    valor = "#{Sifi.find(34).valor.to_s}/#{f2[0].to_s}/min_#{params[:id].to_s}.jpg"
    if File.exist?(valor) == true
      File.open(valor, 'rb') do |f|
        send_data f.read, :type => "image/jpeg", :disposition => "inline"
      end
    end
  end

  def dowloadmed
    f1 = params[:id].gsub("img","")
    f2 = f1.split("P")
    valor = "#{Sifi.find(34).valor.to_s}/#{f2[0].to_s}/med_#{params[:id].to_s}.jpg"
    send_file valor, :type => 'image/jpeg', :disposition => 'inline'
  end

  def dowloadfull
    f1 = params[:id].gsub("img","")
    f2 = f1.split("P")
    valor = "#{Sifi.find(34).valor.to_s}/#{f2[0].to_s}/#{params[:id].to_s}.jpg"
    send_file valor, :type => 'image/jpeg', :disposition => 'inline'
  end

  def buscar
    @fase2censo  = Fase2censo.new
    @nameinforme = "VIVIENDAS CON UNIDADES ECONÓMICAS E INQUILINATOS"
    @fase2censo.noform =  params[:noform]
    @fase2censo.p4 =  params[:ubicacion][:p4]
    @fase2censo.p5 =  params[:ubicacion][:p5]
    @fase2censo.p11 =  params[:ubicacion][:p11]
    @fase2censo.p11_1 =  params[:p11_1]
    @fase2censo.p12 =  params[:ubicacion][:p12]
    @fase2censo.p12_1 =  params[:p12_1]
    @fase2censo.p13 =  params[:ubicacion][:p13]
    @fase2censo.p50 =  params[:ubicacion][:p50]
    @fase2censo.p52 =  params[:ubicacion][:p52]
    @fase2censo.p53 =  params[:ubicacion][:p53]
    @fase2censo.p54 =  params[:ubicacion][:p54]
    @fase2censo.p55 =  params[:ubicacion][:p55]
    @fase2censo.p56 =  params[:ubicacion][:p56]
    @fase2censo.p57 =  params[:ubicacion][:p57]
    @fase2censo.p58 =  params[:ubicacion][:p58]
    @fase2censo.p59 =  params[:ubicacion][:p59]
    @fase2censo.p60 =  params[:ubicacion][:p60]
    @fase2censo.p61 =  params[:ubicacion][:p61]
    @fase2censo.p63 =  params[:ubicacion][:p63]
    if params[:format].to_s == 'xls'
      @pagina = 'NO'
    else
      @pagina = 'SI'
    end
    @fase2censos = Fase2censo.search(@fase2censo,params[:ubicacion][:fchinicial], params[:ubicacion][:fchfinal], params[:areatotal1], params[:areatotal2], params[:areaconst1], params[:areaconst2], params[:areaocupa1], params[:areaocupa2],@pagina,params[:page])
    if @fase2censos.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to unidades_fase2censos_path
    elsif params[:format] != 'xls'
        respond_to do |format|
          format.html
        end
    else
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Unidades_econimicas_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
    end
  end

def buscar2
    @fase2censo  = Fase2censo.new
    @nameinforme = "INTERIOR DE LA VIVIENDA"
    @fase2censo.noform =  params[:noform]
    @fase2censo.p4 =  params[:ubicacion][:p4]
    @fase2censo.p5 =  params[:ubicacion][:p5]
    @fase2censo.p11 =  params[:ubicacion][:p11]
    @fase2censo.p11_1 =  params[:p11_1]
    @fase2censo.p12 =  params[:ubicacion][:p12]
    @fase2censo.p12_1 =  params[:p12_1]
    @fase2censo.p13 =  params[:ubicacion][:p13]
    @fase2censo.p14 =  params[:ubicacion][:p14]
    @fase2censo.p16 =  params[:ubicacion][:p16]
    @fase2censo.p22 =  params[:ubicacion][:p22]
    @fase2censo.p23 =  params[:ubicacion][:p23]
    @fase2censo.p24 =  params[:ubicacion][:p24]
    @fase2censo.p25 =  params[:ubicacion][:p25]
    @fase2censo.p26 =  params[:ubicacion][:p26]
    @fase2censo.p27 =  params[:ubicacion][:p27]
    @fase2censo.p28 =  params[:ubicacion][:p28]
    @fase2censo.p29 =  params[:ubicacion][:p29]
    @fase2censo.p30 =  params[:ubicacion][:p30]
    @fase2censo.p31 =  params[:ubicacion][:p31]
    @fase2censo.p32 =  params[:ubicacion][:p32]
    @fase2censo.p33 =  params[:ubicacion][:p33]
    @fase2censo.p34 =  params[:ubicacion][:p34]
    @fase2censo.p35 =  params[:ubicacion][:p35]
    @fase2censo.p36 =  params[:ubicacion][:p36]
    @fase2censo.p37 =  params[:ubicacion][:p37]
    @fase2censo.p38 =  params[:ubicacion][:p38]
    @fase2censo.p39 =  params[:ubicacion][:p39]
    @fase2censo.p40 =  params[:ubicacion][:p40]
    @fase2censo.p40_1 =  params[:ubicacion][:p40_1]
    @fase2censo.p41 =  params[:ubicacion][:p41]
    @fase2censo.p41_1 =  params[:ubicacion][:p41_1]
    @fase2censo.p42 =  params[:ubicacion][:p42]
    @fase2censo.p42_1 =  params[:ubicacion][:p42_1]
    @fase2censo.p102 =  params[:ubicacion][:p102]
    @fase2censo.p103 =  params[:ubicacion][:p103]
    @fase2censo.p104 =  params[:ubicacion][:p104]
    @fase2censo.p105 =  params[:ubicacion][:p105]
    @fase2censo.p106 =  params[:ubicacion][:p106]
    @fase2censo.p107 =  params[:ubicacion][:p107]
    @fase2censo.p109 =  params[:ubicacion][:p109]
    @fase2censo.p110 =  params[:ubicacion][:p110]
    @fase2censo.p115 =  params[:ubicacion][:p115]
    @fase2censo.p169 =  params[:ubicacion][:p169]
    @fase2censo.p170 =  params[:ubicacion][:p170]
    @fase2censo.p171 =  params[:ubicacion][:p171]
    @fase2censo.p174 =  params[:ubicacion][:p174]
    @fase2censo.p175 =  params[:ubicacion][:p175]
    @fase2censo.p176 =  params[:ubicacion][:p176]
    @fase2censo.p177 =  params[:ubicacion][:p177]
    @fase2censo.p178 =  params[:ubicacion][:p178]
    @fase2censo.p179 =  params[:ubicacion][:p179]
    @fase2censo.p180 =  params[:ubicacion][:p180]
    @fase2censo.p181 =  params[:ubicacion][:p181]
    @fase2censo.p182 =  params[:ubicacion][:p182]
    if params[:format].to_s == 'xls'
      @pagina = 'NO'
    else
      @pagina = 'SI'
    end
    @fase2censos = Fase2censo.search2(@fase2censo,params[:ubicacion][:fchinicial], params[:ubicacion][:fchfinal], params[:areatotal1], params[:areatotal2], params[:areaconst1], params[:areaconst2],@pagina,params[:page])
    if @fase2censos.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to interiores_fase2censos_path
    elsif params[:format] != 'xls'
        respond_to do |format|
          format.html
        end
    else
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Interior_vivienda_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
    end
  end

def buscar3
    @fase2censo  = Fase2censo.new
    @nameinforme = "ESTRUCTURA DE LA VIVIENDA"
    @fase2censo.noform =  params[:noform]
    @fase2censo.p4 =  params[:ubicacion][:p4]
    @fase2censo.p5 =  params[:ubicacion][:p5]
    @fase2censo.p11 =  params[:ubicacion][:p11]
    @fase2censo.p11_1 =  params[:p11_1]
    @fase2censo.p12 =  params[:ubicacion][:p12]
    @fase2censo.p12_1 =  params[:p12_1]
    @fase2censo.p13 =  params[:ubicacion][:p13]
    @fase2censo.p78 =  params[:ubicacion][:p78]
    @fase2censo.p79 =  params[:ubicacion][:p79]
    @fase2censo.p80 =  params[:ubicacion][:p80]
    @fase2censo.p81 =  params[:ubicacion][:p81]
    @fase2censo.p82 =  params[:ubicacion][:p82]
    @fase2censo.p83 =  params[:ubicacion][:p83]
    @fase2censo.p108 =  params[:ubicacion][:p108]
    if params[:format].to_s == 'xls'
      @pagina = 'NO'
    else
      @pagina = 'SI'
    end
    @fase2censos = Fase2censo.search6(@fase2censo,params[:ubicacion][:fchinicial], params[:ubicacion][:fchfinal], params[:areatotal1], params[:areatotal2], params[:areaconst1], params[:areaconst2],@pagina,params[:page])
    if @fase2censos.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to estructuras_fase2censos_path
    elsif params[:format] != 'xls'
        respond_to do |format|
          format.html
        end
    else
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Estructura_vivienda_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
    end
  end

def buscar4
    @fase2censo  = Fase2censo.new
    @nameinforme = "MATERIALES DE CERRAMIENTO"
    @fase2censo.noform =  params[:noform]
    @fase2censo.p4 =  params[:ubicacion][:p4]
    @fase2censo.p5 =  params[:ubicacion][:p5]
    @fase2censo.p11 =  params[:ubicacion][:p11]
    @fase2censo.p11_1 =  params[:p11_1]
    @fase2censo.p12 =  params[:ubicacion][:p12]
    @fase2censo.p12_1 =  params[:p12_1]
    @fase2censo.p13 =  params[:ubicacion][:p13]
    @fase2censo.p87 =  params[:ubicacion][:p87]
    @fase2censo.p88 =  params[:ubicacion][:p88]
    @fase2censo.p89 =  params[:ubicacion][:p89]
    @fase2censo.p91 =  params[:ubicacion][:p91]
    @fase2censo.p92 =  params[:ubicacion][:p92]
    @fase2censo.p92_2 =  params[:ubicacion][:p92_2]
    @fase2censo.p93 =  params[:ubicacion][:p93]
    @fase2censo.p94 =  params[:ubicacion][:p94]
    @fase2censo.p97 =  params[:ubicacion][:p97]
    @fase2censo.p98 =  params[:ubicacion][:p98]
    @fase2censo.p99 =  params[:ubicacion][:p99]
    @fase2censo.p116 =  params[:ubicacion][:p116]
    @fase2censo.p117 =  params[:ubicacion][:p117]
    @fase2censo.p118 =  params[:ubicacion][:p118]
    @fase2censo.p119 =  params[:ubicacion][:p119]
    @fase2censo.p120 =  params[:ubicacion][:p120]
    @fase2censo.p121 =  params[:ubicacion][:p121]
    @fase2censo.p122 =  params[:ubicacion][:p122]
    @fase2censo.p123 =  params[:ubicacion][:p123]
    @fase2censo.p124 =  params[:ubicacion][:p124]
    @fase2censo.p161 =  params[:ubicacion][:p161]
    @fase2censo.p162 =  params[:ubicacion][:p162]
    @fase2censo.p163 =  params[:ubicacion][:p163]
    @fase2censo.p164 =  params[:ubicacion][:p164]
    @fase2censo.p165 =  params[:ubicacion][:p165]
    @fase2censo.p166 =  params[:ubicacion][:p166]
    if params[:format].to_s == 'xls'
      @pagina = 'NO'
    else
      @pagina = 'SI'
    end
    @fase2censos = Fase2censo.search3(@fase2censo,params[:ubicacion][:fchinicial], params[:ubicacion][:fchfinal], params[:areatotal1], params[:areatotal2], params[:areaconst1], params[:areaconst2],@pagina,params[:page])
    if @fase2censos.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to materiales_fase2censos_path
    elsif params[:format] != 'xls'
        respond_to do |format|
          format.html
        end
    else
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Materiales_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
    end
  end

def buscar5
    @fase2censo  = Fase2censo.new
    @nameinforme = "SERVICIOS PÚBLICOS"
    @fase2censo.noform =  params[:noform]
    @fase2censo.p4 =  params[:ubicacion][:p4]
    @fase2censo.p5 =  params[:ubicacion][:p5]
    @fase2censo.p11 =  params[:ubicacion][:p11]
    @fase2censo.p11_1 =  params[:p11_1]
    @fase2censo.p12 =  params[:ubicacion][:p12]
    @fase2censo.p12_1 =  params[:p12_1]
    @fase2censo.p13 =  params[:ubicacion][:p13]
    @fase2censo.p130 =  params[:ubicacion][:p130]
    @fase2censo.p131 =  params[:ubicacion][:p131]
    @fase2censo.p134 =  params[:ubicacion][:p134]
    @fase2censo.p135 =  params[:ubicacion][:p135]
    @fase2censo.p136 =  params[:ubicacion][:p136]
    @fase2censo.p137 =  params[:ubicacion][:p137]
    @fase2censo.p138 =  params[:ubicacion][:p138]
    @fase2censo.p139 =  params[:ubicacion][:p139]
    @fase2censo.p140 =  params[:ubicacion][:p140]
    @fase2censo.p141 =  params[:ubicacion][:p141]
    @fase2censo.p142 =  params[:ubicacion][:p142]
    @fase2censo.p143 =  params[:ubicacion][:p143]
    @fase2censo.p144 =  params[:ubicacion][:p144]
    @fase2censo.p145 =  params[:ubicacion][:p145]
    @fase2censo.p146 =  params[:ubicacion][:p146]
    @fase2censo.p147 =  params[:ubicacion][:p147]
    @fase2censo.p148 =  params[:ubicacion][:p148]
    @fase2censo.p149 =  params[:ubicacion][:p149]
    @fase2censo.p150 =  params[:ubicacion][:p150]
    @fase2censo.p151 =  params[:ubicacion][:p151]
    @fase2censo.p152 =  params[:ubicacion][:p152]
    @fase2censo.p153 =  params[:ubicacion][:p153]
    @fase2censo.p154 =  params[:ubicacion][:p154]
    @fase2censo.p155 =  params[:ubicacion][:p155]
    @fase2censo.p156 =  params[:ubicacion][:p156]
    @fase2censo.p157 =  params[:ubicacion][:p157]
    if params[:format].to_s == 'xls'
      @pagina = 'NO'
    else
      @pagina = 'SI'
    end
    @fase2censos = Fase2censo.search4(@fase2censo,params[:ubicacion][:fchinicial], params[:ubicacion][:fchfinal], params[:areatotal1], params[:areatotal2], params[:areaconst1], params[:areaconst2],@pagina,params[:page])
    if @fase2censos.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to servicios_fase2censos_path
    elsif params[:format] != 'xls'
        respond_to do |format|
          format.html
        end
    else
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Servicios_publicos_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
    end
  end

  def buscar6
    @fase2censo  = Fase2censo.new
    @nameinforme = "RIESGO"
    @fase2censo.noform =  params[:noform]
    @fase2censo.p4 =  params[:ubicacion][:p4]
    @fase2censo.p5 =  params[:ubicacion][:p5]
    @fase2censo.p11 =  params[:ubicacion][:p11]
    @fase2censo.p11_1 =  params[:p11_1]
    @fase2censo.p12 =  params[:ubicacion][:p12]
    @fase2censo.p12_1 =  params[:p12_1]
    @fase2censo.p13 =  params[:ubicacion][:p13]
    @fase2censo.p186 =  params[:ubicacion][:p186]
    @fase2censo.p187 =  params[:ubicacion][:p187]
    @fase2censo.p188 =  params[:ubicacion][:p188]
    @fase2censo.p189 =  params[:ubicacion][:p189]
    @fase2censo.p190 =  params[:ubicacion][:p190]
    @fase2censo.p191 =  params[:ubicacion][:p191]
    @fase2censo.p193 =  params[:ubicacion][:p193]
    @fase2censo.p194 =  params[:ubicacion][:p194]
    if params[:format].to_s == 'xls'
      @pagina = 'NO'
    else
      @pagina = 'SI'
    end
    @fase2censos = Fase2censo.search5(@fase2censo,params[:ubicacion][:fchinicial], params[:ubicacion][:fchfinal], params[:areatotal1], params[:areatotal2], params[:areaconst1], params[:areaconst2],@pagina,params[:page])
    if @fase2censos.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to riesgos_fase2censos_path
    elsif params[:format] != 'xls'
        respond_to do |format|
          format.html
        end
    else
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Riesgos_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
    end
  end

  def buscar7
    @fase2censo  = Fase2censo.new
    @nameinforme = "OTROS SERVICIOS DE LA ALCALDÍA"
    @fase2censo.noform =  params[:noform]
    @fase2censo.p4 =  params[:ubicacion][:p4]
    @fase2censo.p5 =  params[:ubicacion][:p5]
    @fase2censo.p11 =  params[:ubicacion][:p11]
    @fase2censo.p11_1 =  params[:p11_1]
    @fase2censo.p12 =  params[:ubicacion][:p12]
    @fase2censo.p12_1 =  params[:p12_1]
    @fase2censo.p13 =  params[:ubicacion][:p13]
    @fase2censo.p192 =  params[:ubicacion][:p192]
    if params[:format].to_s == 'xls'
      @pagina = 'NO'
    else
      @pagina = 'SI'
    end
    @fase2censos = Fase2censo.search7(@fase2censo,params[:ubicacion][:fchinicial], params[:ubicacion][:fchfinal], params[:areatotal1], params[:areatotal2], params[:areaconst1], params[:areaconst2],@pagina,params[:page])
    if @fase2censos.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to otros_fase2censos_path
    elsif params[:format] != 'xls'
        respond_to do |format|
          format.html
        end
    else
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Otros_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
    end
  end

  def ubicacion
    @fase2censo = Fase2censo.find(params[:id])
    #coordinates = [@fase2censo.coordenada_x,@fase2censo.coordenada_y]
    coordinates = ['6.28586916885','-75.57770172980']
    @map = GMap.new("map")
    @map.control_init(:large_map => true, :map_type => true)
    #@map.set_map_type_init(GMapType::G_HYBRID_MAP)
    @map.center_zoom_init(coordinates,16)
    @map.icon_global_init( GIcon.new(:image =>"/images/anthropo.png",
                         :icon_size => GSize.new(32,32),
                         :shadow_size => GSize.new(37,32),
                         :icon_anchor => GPoint.new(9,32),
                         :info_window_anchor => GPoint.new(9,2),
                         :info_shadow_anchor => GPoint.new(18,25)),"icon_source")
    icon_source = Variable.new("icon_source")
    source = GMarker.new(coordinates,:icon => icon_source, :title => @fase2censo.noform, :info_window => "Ubicacion Georeferencial")
    @map.overlay_init(source)
    @informacion = @fase2censo.noform
  end

  def unidades
    @fase2censo = Fase2censo.new
    @nameinforme = "VIVIENDAS CON UNIDADES ECONÓMICAS E INQUILINATOS"
  end

  def interiores
    @fase2censo = Fase2censo.new
    @nameinforme = "INTERIOR DE LA VIVIENDA"
  end

  def estructuras
    @fase2censo = Fase2censo.new
    @nameinforme = "ESTRUCTURA DE LA VIVIENDA"
  end

  def materiales
    @fase2censo = Fase2censo.new
    @nameinforme = "MATERIALES DE CERRAMIENTO"
  end

  def servicios
    @fase2censo = Fase2censo.new
    @nameinforme = "SERVICIOS PÚBLICOS"
  end

  def riesgos
    @fase2censo = Fase2censo.new
    @nameinforme = "RIESGO"
  end

  def otros
    @fase2censo = Fase2censo.new
    @nameinforme = "OTROS SERVICIOS DE LA ALCALDÍA"
  end

  private
  def determine_layout
    if['informecalificacion','informe'].include?(action_name)
      "excel"
    elsif ['ubicacion'].include?(action_name)
      "geo"
    elsif ['buscar','buscar2','buscar3','buscar4','buscar5','buscar6','buscar7'].include?(action_name)
      "excel2"
    else
      "application"
    end
  end

end
