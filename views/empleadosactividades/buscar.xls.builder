xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.Workbook({
  'xmlns'      => "urn:schemas-microsoft-com:office:spreadsheet",
  'xmlns:o'    => "urn:schemas-microsoft-com:office:office",
  'xmlns:x'    => "urn:schemas-microsoft-com:office:excel",
  'xmlns:html' => "http://www.w3.org/TR/REC-html40",
  'xmlns:ss'   => "urn:schemas-microsoft-com:office:spreadsheet"
  }) do

#   ***************************************************************
#   Inicio Pestaña 1 - Tipo de Poblacion
#   ***************************************************************

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


  xml.Worksheet 'ss:Name' => 'Informe Actividades' do
    xml.Table do
      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Funcionario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tipo Actividad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Observaciones', 'ss:Type' => 'String' }
      end
      empleadosactividad = Empleadosactividad.find(:all)
      empleadosactividad.each do |data|
      xml.Row do
        xml.Cell { xml.Data Empleado.find(data.empleado_id).nombre, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.tipo_actividad, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.fecha, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.valor, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.observaciones, 'ss:Type' => 'String' }
      end
    end

    end
  end

end