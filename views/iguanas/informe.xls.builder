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

  xml.Worksheet 'ss:Name' => 'Atencion - Iguana' do
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
      for iguanasobservacion in @iguanasobservaciones
        #Atencion al predio con identificacion de plano <> cuyo propietario(s) es(son) <> . <atencion>
        cadena = "ATENCIÓN AL PREDIO CON IDENTIFICACION DE PLANO NRO " + iguanasobservacion.iguana.nro_registro
        cadena = cadena + ", CUYO PROPIETARIO(S) ES(SON): "
        @iguanaspersonas = Iguanaspersona.find_all_by_iguana_id(iguanasobservacion.iguana_id);
        for iguanaspersona in @iguanaspersonas
          persona  = Persona.find(iguanaspersona.persona_id);
          cadena = cadena + ' - ' + persona.autobuscar
        end
        cadena = cadena + ". INFORMACIÓN ATENCIÓN: "
        cadena = cadena + iguanasobservacion.observacion

        xml.Row do
            xml.Cell { xml.Data iguanasobservacion.created_at, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguanasobservacion.dtipoatencion, 'ss:Type' => 'String' }
            if (iguanasobservacion.user_id.to_s != "")
              nombreuser = User.find(iguanasobservacion.user_id)
              xml.Cell { xml.Data nombreuser.nombre, 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            end
            xml.Cell { xml.Data cadena, 'ss:Type' => 'String' }
        end
      end
    end
  end
end
