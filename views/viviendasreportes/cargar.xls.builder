xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.Workbook({
  'xmlns'      => "urn:schemas-microsoft-com:office:spreadsheet",
  'xmlns:o'    => "urn:schemas-microsoft-com:office:office",
  'xmlns:x'    => "urn:schemas-microsoft-com:office:excel",
  'xmlns:html' => "http://www.w3.org/TR/REC-html40",
  'xmlns:ss'   => "urn:schemas-microsoft-com:office:spreadsheet"
  }) do

  xml.Styles do
   xml.Style 'ss:ID' => 'Default', 'ss:Name' => 'Normal' do
     xml.Alignment 'ss:Vertical' => 'Bottom'
     xml.Borders
     xml.Font 'ss:FontName' => 'Verdana'
     xml.Interior
     xml.NumberFormat
     xml.Protection
   end
   xml.Style 'ss:ID' => 'header' do
        xml.Alignment 'ss:Vertical' => 'Bottom',
        'ss:Horizontal' => 'Center'
        xml.Font 'ss:FontName' => 'Arial','ss:Bold'=>'1'
        xml.Interior 'ss:Color'=>'#99CCFF', 'ss:Pattern'=>'Solid'
   end
   xml.Style 'ss:ID' => 's22' do
     xml.NumberFormat 'ss:Format' => 'General Date'
   end
  end

  xml.Worksheet 'ss:Name' => 'Informe ETAPAS' do
      xml.Table do
        xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Proyecto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Direccion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Bloque', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Piso', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Apto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Entregado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Usuario Identificacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Usuario Nombre', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Etapa', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Inicio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Observaciones', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Usuario Registro', 'ss:Type' => 'String' }
        end
        for viviendasreporte in @viviendasreportes
          @viviendastramites = Viviendastramite.find(:all, :conditions=>['vivienda_id = ? and fecha_esperada is null', viviendasreporte.vivienda_id])
          for viviendastramite in @viviendastramites
            usuario = User.find(viviendastramite.user_id).username rescue nil
            cadena = ""
            xml.Row do
              vivienda = Vivienda.find(viviendastramite.vivienda_id)
              xml.Cell { xml.Data vivienda.proyecto.descripcion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data vivienda.bloque.descripcion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data vivienda.piso.descripcion, 'ss:Type' => 'String' }
              if vivienda.apto_id.nil? == false
                xml.Cell { xml.Data vivienda.apto.descripcion, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data vivienda.descentregado, 'ss:Type' => 'String' }
              contador = 0
              cadenaidentificacion = ""
              @viviendaspersonas = Viviendaspersona.find_all_by_vivienda_id(viviendastramite.vivienda.id);
              for viviendaspersona in @viviendaspersonas
                persona  = Persona.find(viviendaspersona.persona_id);
                if contador == 0
                  cadenaidentificacion = persona.identificacion
                  contador = contador  + 1
                end
                cadena = cadena + persona.autobuscar + ' - '
              end
              xml.Cell { xml.Data cadenaidentificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data cadena, 'ss:Type' => 'String' }
              xml.Cell { xml.Data viviendastramite.viviendastipostramite.descripcion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data viviendastramite.fecha_inicio, 'ss:Type' => 'String' }
              xml.Cell { xml.Data viviendastramite.observaciones, 'ss:Type' => 'String' }
              xml.Cell { xml.Data usuario, 'ss:Type' => 'String' }
            end
          end
        end
        @viviendas = Vivienda.find(:all, :conditions=>['id in (select vivienda_id from viviendasreportes) and id not in (select vivienda_id from viviendastramites)'])
        for vivienda in @viviendas
            cadena = ""
            xml.Row do
              xml.Cell { xml.Data vivienda.proyecto.descripcion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data vivienda.bloque.descripcion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data vivienda.piso.descripcion, 'ss:Type' => 'String' }
              if vivienda.apto_id.nil? == false
                xml.Cell { xml.Data vivienda.apto.descripcion, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data vivienda.descentregado, 'ss:Type' => 'String' }
              contador = 0
              cadenaidentificacion = ""
              @viviendaspersonas = Viviendaspersona.find_all_by_vivienda_id(vivienda.id);
              for viviendaspersona in @viviendaspersonas
                persona  = Persona.find(viviendaspersona.persona_id);
                if contador == 0
                  cadenaidentificacion = persona.identificacion
                  contador = contador  + 1
                end
                cadena = cadena + persona.autobuscar + ' - '
              end
              xml.Cell { xml.Data cadenaidentificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data cadena, 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            end
        end
#SIn VIvienda asociada
        @viviendasreportes = Viviendasreporte.find(:all, :conditions=>['user_id is null and vivienda_id is null and persona_id is not null'])
        for viviendasreporte in @viviendasreportes
            xml.Row do
              persona  = Persona.find(viviendasreporte.persona_id);
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data persona.identificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data persona.autobuscar, 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data 'NO TIENE VIVIENDA ASIGNADA', 'ss:Type' => 'String' }
            end
        end
    end
  end

#
#   RESUMEN INCONSISTENCIAS
#
   existeinconsistencia = ""
   existeinconsistencia = Viviendasreporte.exists?(['user_id is null and persona_id is null'])
   if existeinconsistencia
     xml.Worksheet 'ss:Name' => 'INCONSISTENCIAS' do
        xml.Table do
          xml.Row 'ss:StyleID' => 'header' do
              xml.Cell { xml.Data 'Cedula', 'ss:Type' => 'String' }
          end
          @viviendasreportes = Viviendasreporte.find(:all, :conditions=>['user_id is null and persona_id is null'])
          for viviendasreporte in @viviendasreportes
            xml.Row do
              xml.Cell { xml.Data viviendasreporte.identificacion, 'ss:Type' => 'String' }
            end
          end
        end
     end
   end     
#
#   RESUMEN POR ETAPAS
#
   xml.Worksheet 'ss:Name' => 'Resumen Etapas' do
      xml.Table do
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            proyecto = Proyecto.find(:all, :order =>'descripcion')
            proyecto.each do |data|
              xml.Cell { xml.Data data.descripcion, 'ss:Type' => 'String' }
            end
            xml.Cell { xml.Data 'TOTAL', 'ss:Type' => 'String' }
        end
      #
      # Cuando las fases son Recoleccion de documentos SIN CIERRE FINANCIERO
      #
          sumetapa = 0
          existetramite = ""
          xml.Row do
            xml.Cell { xml.Data 'ETAPA I CONSOLIDACION DE CIERRE FINANCIERO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data 'RECOLECCION DE DOCUMENTOS SIN CIERRE FINANCIERO', 'ss:Type' => 'String' }
            proyecto = Proyecto.find(:all, :order =>'descripcion')
            proyecto.each do |data|
              cantidadfase = 0
              existetramite = Viviendastramite.exists?(['vivienda_id in (select id from viviendas where proyecto_id = ?) and viviendastipostramite_id = 10080 and fecha_esperada is null and vivienda_id in (select vivienda_id from viviendasreportes where vivienda_id is not null)and vivienda_id in (select vivienda_id from viviendastramites where viviendastipostramite_id = 10051 and fecha_esperada is null)' , "#{data.id}"])
              if existetramite
                cantidadfase = Viviendastramite.count(:conditions => [' vivienda_id in (select id from viviendas where proyecto_id = ?) and viviendastipostramite_id = 10080 and fecha_esperada is null and vivienda_id in (select vivienda_id from viviendasreportes where vivienda_id is not null)and vivienda_id in (select vivienda_id from viviendastramites where viviendastipostramite_id = 10051 and fecha_esperada is null)' , "#{data.id}"])
              end
              xml.Cell { xml.Data cantidadfase.to_i, 'ss:Type' => 'Number' }
              sumetapa = sumetapa + cantidadfase.to_i
            end
            xml.Cell { xml.Data sumetapa.to_i, 'ss:Type' => 'Number' }
          end
      #
      # Cuando las fases son Recoleccion de documentos CON CIERRE FINANCIERO
      #
          sumetapa = 0
          existetramite = ""
          xml.Row do
            xml.Cell { xml.Data 'ETAPA I CONSOLIDACION DE CIERRE FINANCIERO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data 'RECOLECCION DE DOCUMENTOS CON CIERRE FINANCIERO', 'ss:Type' => 'String' }
            proyecto = Proyecto.find(:all, :order =>'descripcion')
            proyecto.each do |data|
              cantidadfase = 0
              existetramite = Viviendastramite.exists?([' vivienda_id in (select id from viviendas where proyecto_id = ?) and viviendastipostramite_id = 10080 and fecha_esperada is null and vivienda_id in (select vivienda_id from viviendasreportes where vivienda_id is not null)and vivienda_id in (select vivienda_id from viviendastramites where viviendastipostramite_id = 10051 and fecha_esperada is not null)' , "#{data.id}"])
              if existetramite
                cantidadfase = Viviendastramite.count(:conditions => [' vivienda_id in (select id from viviendas where proyecto_id = ?) and viviendastipostramite_id = 10080 and fecha_esperada is null and vivienda_id in (select vivienda_id from viviendasreportes where vivienda_id is not null)and vivienda_id in (select vivienda_id from viviendastramites where viviendastipostramite_id = 10051 and fecha_esperada is not null)' , "#{data.id}"])
              end
              xml.Cell { xml.Data cantidadfase.to_i, 'ss:Type' => 'Number' }
              sumetapa = sumetapa + cantidadfase.to_i
            end
            xml.Cell { xml.Data sumetapa.to_i, 'ss:Type' => 'Number' }
          end
      #
      # Cuando las fases son DIFERENTES a Recoleccion de documentos y Cierre Financiero
      #
        viviendastipostramite = Viviendastipostramite.find(:all, :conditions=>['id not in (10080,10051)'], :order =>['ordenetapa'])
        viviendastipostramite.each do |data1|
          sumetapa = 0
          xml.Row do
            xml.Cell { xml.Data data1.etapa, 'ss:Type' => 'String' }
            xml.Cell { xml.Data data1.descripcion, 'ss:Type' => 'String' }
            proyecto = Proyecto.find(:all, :order =>'descripcion')
            proyecto.each do |data|
              cantidadfase = Viviendastramite.count(:conditions => [' vivienda_id in (select id from viviendas where proyecto_id = ?) and viviendastipostramite_id =? and fecha_esperada is null and vivienda_id in (select vivienda_id from viviendasreportes where vivienda_id is not null)' , "#{data.id}", "#{data1.id}"])
              sumetapa = sumetapa + cantidadfase.to_i
              xml.Cell { xml.Data cantidadfase.to_i, 'ss:Type' => 'Number' }
            end
            xml.Cell { xml.Data sumetapa.to_i, 'ss:Type' => 'Number' }
          end
        end
      end
   end
end
