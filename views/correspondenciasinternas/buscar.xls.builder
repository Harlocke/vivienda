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

#
#   RADICACION
#
  xml.Worksheet 'ss:Name' => 'Correspondencia Interna' do
    xml.Table do
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Consecutivo', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Anno', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Dependencia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tipo', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Asunto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Documento', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Usuario Proyecta', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Usuario Registra', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Usuario Radica', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Radicacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Dirigido a', 'ss:Type' => 'String' }
      end
      for correspondenciasinterna in @correspondenciasinternas
        cadena0 = ""
        user1 = ""
        user2 = ""
        user3 = ""
        if correspondenciasinterna.dependencia_id
          cadena0 = Dependencia.find(correspondenciasinterna.dependencia_id).descripcion
        end
        if correspondenciasinterna.user_proyecta
          user1 = User.find(correspondenciasinterna.user_proyecta).nombre
        end
        if correspondenciasinterna.user_id
          user2 = User.find(correspondenciasinterna.user_id).nombre
        end
        if correspondenciasinterna.user_radicado
          user3 = User.find(correspondenciasinterna.user_radicado).nombre
        end
        xml.Row do
            xml.Cell { xml.Data correspondenciasinterna.consecutivo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data correspondenciasinterna.anno, 'ss:Type' => 'String' }
            xml.Cell { xml.Data cadena0, 'ss:Type' => 'String' }
            xml.Cell { xml.Data correspondenciasinterna.tipo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data correspondenciasinterna.asunto, 'ss:Type' => 'String' }
            xml.Cell { xml.Data correspondenciasinterna.fecha_documento, 'ss:Type' => 'String' }
            xml.Cell { xml.Data user1, 'ss:Type' => 'String' }
            xml.Cell { xml.Data user2, 'ss:Type' => 'String' }
            xml.Cell { xml.Data user3, 'ss:Type' => 'String' }
            xml.Cell { xml.Data correspondenciasinterna.fecha_radicado, 'ss:Type' => 'String' }
            cadena = ""
            @corresinternasdirigidos = Corresinternasdirigido.find_all_by_correspondenciasinterna_id(correspondenciasinterna.id)
            @corresinternasdirigidos.each do |corresinternasdirigido|
              if corresinternasdirigido.dependencia_id
                cadena = cadena + " Dirigido a : " + corresinternasdirigido.dependencia.descripcion rescue nil
                if corresinternasdirigido.user_id
                  cadena = cadena + " (" + corresinternasdirigido.user.nombre rescue nil
                  cadena = cadena + ")"
                end
              else
                cadena = cadena + " Dirigido a : " + corresinternasdirigido.user.nombre rescue nil
              end
              cadena = cadena + "."
            end
            xml.Cell { xml.Data cadena, 'ss:Type' => 'String' }
        end
      end
    end
  end


end
