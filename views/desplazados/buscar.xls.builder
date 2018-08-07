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


  xml.Worksheet 'ss:Name' => 'Desplazados' do
    xml.Table do
      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Datos Basicos', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cruces Especiales', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Hogares en Medellin Solidaria', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Gerencia Desplazamiento Forzado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Revision Documentacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Resultado Convocatoria', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Calificacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Identificacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nombre', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Catastro Medellin', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Lista espera', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Auto 092', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Municipio desplazamiento', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Municipio aspiracion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cogestor', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Comuna', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Gerencia desplazados', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Presento reajuste', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Carta medellin', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Colilla banco', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Hora', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Como se Entero', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Variable 1', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Variable 2', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Variable 3', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Variable 4', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Variable 5', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Variable 6', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Variable 7', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Puntaje Total', 'ss:Type' => 'String' }
      end
      total = 0
      desplazado = Desplazado.find(:all)
      desplazado.each do |data|
        total = data.variable1.to_i +
          data.variable2.to_i +
          data.variable3.to_i +
          data.variable4.to_i +
          data.variable5.to_i +
          data.variable6.to_i +
          data.variable7.to_i
      xml.Row do
        xml.Cell { xml.Data data.persona.identificacion, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.persona.nombres, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.catastro_medellin, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.lista_espera, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.auto_092, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.municipio_desplazamiento, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.municipio_aspiracion, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.cogestor, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.comuna, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.gerencia_desplazados, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.presento_reajuste, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.carta_medellin, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.colilla_banco, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.fecha, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.hora, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.entero, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.variable1, 'ss:Type' => 'Number' }
        xml.Cell { xml.Data data.variable2, 'ss:Type' => 'Number' }
        xml.Cell { xml.Data data.variable3, 'ss:Type' => 'Number' }
        xml.Cell { xml.Data data.variable4, 'ss:Type' => 'Number' }
        xml.Cell { xml.Data data.variable5, 'ss:Type' => 'Number' }
        xml.Cell { xml.Data data.variable6, 'ss:Type' => 'Number' }
        xml.Cell { xml.Data data.variable7, 'ss:Type' => 'Number' }
        xml.Cell { xml.Data total, 'ss:Type' => 'Number' }
      end
    end

    end
  end

end