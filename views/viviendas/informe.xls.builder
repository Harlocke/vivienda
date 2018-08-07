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

  xml.Worksheet 'ss:Name' => 'Atencion - ViviendaNueva' do
    xml.Table do
      # Header
      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Fecha', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tipo de Atencion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Funcionario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Descripcion de la Atencion', 'ss:Type' => 'String' }
      end
      # Rows
      cadena = ""
      for observavivienda in @observaviviendas
        #Atencion al predio con identificacion de plano <> cuyo propietario(s) es(son) <> . <atencion>
        cadena = "ATENCIÓN AL PROYECTO " + observavivienda.vivienda.proyecto.descripcion
        cadena = cadena + ", CUYO PROPIETARIO ES: "
        @viviendaspersonas = Viviendaspersona.find_all_by_vivienda_id(observavivienda.vivienda_id)
        for viviendaspersona in @viviendaspersonas
          persona  = Persona.find(viviendaspersona.persona_id);
          cadena = cadena + ' - ' + persona.autobuscar
        end
        cadena = cadena + ". INFORMACIÓN ATENCIÓN: "
        cadena = cadena + observavivienda.observacion
        
        xml.Row do
            xml.Cell { xml.Data observavivienda.created_at, 'ss:Type' => 'String' }
            xml.Cell { xml.Data observavivienda.dtipoatencion, 'ss:Type' => 'String' }
            if (observavivienda.user_id.to_s != "")
              xml.Cell { xml.Data observavivienda.user.nombre, 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            end
            xml.Cell { xml.Data cadena, 'ss:Type' => 'String' }
        end
      end
    end
  end
end
