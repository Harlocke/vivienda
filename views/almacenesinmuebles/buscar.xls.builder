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
#   INFORMACION DEL PROYECTO
#
  xml.Worksheet 'ss:Name' => 'Inmuebles ISVIMED' do
    xml.Table do
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Matrícula', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Descripción', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Dirección Certificado de Tradicion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Ubicacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Dirección Catastro', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Avaluo', 'ss:Type' => 'String' }
      end
      #@almacenesinmuebles = Almacenesinmueble.all
      for almacenesinmueble in @almacenesinmuebles
        xml.Row do
            xml.Cell { xml.Data almacenesinmueble.matricula , 'ss:Type' => 'String' }
            xml.Cell { xml.Data almacenesinmueble.descripcion , 'ss:Type' => 'String' }
            xml.Cell { xml.Data almacenesinmueble.direccion_certificado , 'ss:Type' => 'String' }
            xml.Cell { xml.Data almacenesinmueble.lugar , 'ss:Type' => 'String' }
            xml.Cell { xml.Data almacenesinmueble.estado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data almacenesinmueble.direccion_catastro , 'ss:Type' => 'String' }
            xml.Cell { xml.Data almacenesinmueble.avaluo, 'ss:Type' => 'String' }
        end
      end
    end
  end
end
