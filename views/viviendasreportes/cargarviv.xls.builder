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
          xml.Cell { xml.Data 'Usuario Nombres', 'ss:Type' => 'String' }
        end
        for viviendasreporte in @viviendasreportes
          if viviendasreporte.vivienda_id.to_s != ""
            vivienda = Vivienda.find(viviendasreporte.vivienda_id)
            direccion = vivienda.bloque.direccion rescue nil
            cadena = ""
            xml.Row do
              xml.Cell { xml.Data vivienda.proyecto.descripcion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data direccion, 'ss:Type' => 'String' }
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
            end
          end
        end
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
        @viviendasreportes = Viviendasreporte.find(:all, :conditions=>['user_id is null and persona_id is null'])
        for viviendasreporte in @viviendasreportes
            xml.Row do
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data viviendasreporte.identificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data 'NO EXISTE EN EL SIFI', 'ss:Type' => 'String' }
            end
        end
     end
   end
end
