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


  xml.Worksheet 'ss:Name' => 'Plan de Pago' do
    xml.Table do
      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'No.', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Saldo Inicial', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cuota Plan Amort.', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Amortización', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Intereses', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Saldo Final', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Seguro', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cuota + Seg.', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha', 'ss:Type' => 'String' }
      end
      # Rows
      for planpago in @planpagos
        xml.Row do
            xml.Cell { xml.Data planpago.nro_cuota, 'ss:Type' => 'String' }
            xml.Cell { xml.Data planpago.saldo_inicial, 'ss:Type' => 'String' }
            xml.Cell { xml.Data planpago.cuota_plan_amort, 'ss:Type' => 'String' }
            xml.Cell { xml.Data planpago.amortizacion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data planpago.intereses, 'ss:Type' => 'String' }
            xml.Cell { xml.Data planpago.saldo_final, 'ss:Type' => 'String' }
            xml.Cell { xml.Data planpago.valor_seguro, 'ss:Type' => 'String' }
            xml.Cell { xml.Data planpago.cuota_seg, 'ss:Type' => 'String' }
            xml.Cell { xml.Data planpago.fecha, 'ss:Type' => 'String' }
        end
      end
    end
  end 
end
