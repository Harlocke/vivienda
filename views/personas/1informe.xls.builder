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

  xml.Worksheet 'ss:Name' => 'Atencion - Personas' do
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
      for personasobservacion in @personasobservaciones
        #Atencion al predio con identificacion de plano <> cuyo propietario(s) es(son) <> . <atencion>
        cadena = "ATENCIÓN AL USUARIO : "
        persona  = Persona.find(personasobservacion.persona_id);
        cadena = cadena + persona.autobuscar
        cadena = cadena + ". INFORMACIÓN ATENCIÓN: "
        cadena = cadena + personasobservacion.observacion
        nombreuser = ""
        xml.Row do
            xml.Cell { xml.Data personasobservacion.created_at, 'ss:Type' => 'String' }
            xml.Cell { xml.Data personasobservacion.dtipoatencion, 'ss:Type' => 'String' }
            if (personasobservacion.user_id.to_s != "")
              nombreuser = personasobservacion.user.nombre rescue nil
              xml.Cell { xml.Data nombreuser, 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            end
            xml.Cell { xml.Data cadena, 'ss:Type' => 'String' }
        end
      end
    end
  end
end
