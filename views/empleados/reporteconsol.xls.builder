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

  xml.Worksheet 'ss:Name' => 'Resumen Informacion' do
    xml.Table do

      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Resumen Contratos', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Modalidad Contractual', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cantidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Contratos por Año', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Perfeccionado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'En Ejecución', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'En Liquidación', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Liquidados', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Contratos Con Anticipo', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Terminado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Anulados', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '------', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2012 Cantidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2012 Perfeccionado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2012 En Ejecución', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2012 En Liquidación', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2012 Liquidados', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2012 Terminado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2012 Anulados', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '------', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2013 Cantidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2013 Perfeccionado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2013 En Ejecución', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2013 En Liquidación', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2013 Liquidados', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2013 Terminado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2013 Anulados', 'ss:Type' => 'String' }
      end
      valor = "'"
      modalidades = Modalidad.find(:all)
      modalidades.each do |datamodalidad|
        cantmodal = Contrato.count(:conditions => [' modalidad_id = ?' , "#{datamodalidad.id}"])
        cadenaanno = ""
        annoradicado = Contrato.find(:all,
                                     :select => 'to_char(fecha_inicio,'+"#{valor}"+'YYYY'+"#{valor}"+') fch, count(*) count',
                                     :group => 'to_char(fecha_inicio,'+"#{valor}"+'YYYY'+"#{valor}"+')',
                                     :conditions => [' modalidad_id = ?' , "#{datamodalidad.id}"],
                                     :order => 'to_char(fecha_inicio,'+"#{valor}"+'YYYY'+"#{valor}"+')')
        annoradicado.each do |data2|
          if data2.fch.to_s != ""
            annorad = data2.fch.to_s
          else
            annorad = "SIN AÑO"
          end
          cadenaanno = cadenaanno + annorad + ' : ' + data2.count.to_s + ' - '
        end
        cantperfeccionado = Contrato.count(:conditions => [" modalidad_id = ? and estado = ? " , "#{datamodalidad.id}","P"])
        cantenejecucion = Contrato.count(:conditions => [" modalidad_id = ? and estado = ? " , "#{datamodalidad.id}","E"])
        cantenliquidacion = Contrato.count(:conditions => [" modalidad_id = ? and estado = ? " , "#{datamodalidad.id}","L"])
        cantliquidado = Contrato.count(:conditions => [" modalidad_id = ? and estado = ? " , "#{datamodalidad.id}","I"])
        cantanticipo = Contrato.count(:conditions => [" modalidad_id = ? and id in (select contrato_id from contratospagos where tipo_pago = ?) " , "#{datamodalidad.id}","A"])
        cantterminado = Contrato.count(:conditions => [" modalidad_id = ? and estado = ? " , "#{datamodalidad.id}","T"])
        cantanulado = Contrato.count(:conditions => [" modalidad_id = ? and estado = ? " , "#{datamodalidad.id}","C"])
        cantanno2012 = Contrato.count(:conditions => [" modalidad_id = #{datamodalidad.id} and to_char(fecha_inicio,'YYYY') = '2012'"])
        cantperfeccionado2012 = Contrato.count(:conditions => [" modalidad_id = ? and estado = ? and to_char(fecha_inicio,'YYYY') = '2012'" , "#{datamodalidad.id}","P"])
        cantenejecucion2012 = Contrato.count(:conditions => [" modalidad_id = ? and estado = ? and to_char(fecha_inicio,'YYYY') = '2012'" , "#{datamodalidad.id}","E"])
        cantenliquidacion2012 = Contrato.count(:conditions => [" modalidad_id = ? and estado = ? and to_char(fecha_inicio,'YYYY') = '2012'" , "#{datamodalidad.id}","L"])
        cantliquidado2012 = Contrato.count(:conditions => [" modalidad_id = ? and estado = ? and to_char(fecha_inicio,'YYYY') = '2012'" , "#{datamodalidad.id}","I"])
        cantterminado2012 = Contrato.count(:conditions => [" modalidad_id = ? and estado = ?  and to_char(fecha_inicio,'YYYY') = '2012'" , "#{datamodalidad.id}","T"])
        cantanulado2012 = Contrato.count(:conditions => [" modalidad_id = ? and estado = ?  and to_char(fecha_inicio,'YYYY') = '2012'" , "#{datamodalidad.id}","C"])
        cantanno2013  = Contrato.count(:conditions => [" modalidad_id = ? and to_char(fecha_inicio,'YYYY') = '2013'" , "#{datamodalidad.id}"])
        cantperfeccionado2013 = Contrato.count(:conditions => [" modalidad_id = ? and estado = ? and to_char(fecha_inicio,'YYYY') = '2013'" , "#{datamodalidad.id}","P"])
        cantenejecucion2013 = Contrato.count(:conditions => [" modalidad_id = ? and estado = ? and to_char(fecha_inicio,'YYYY') = '2013'" , "#{datamodalidad.id}","E"])
        cantenliquidacion2013 = Contrato.count(:conditions => [" modalidad_id = ? and estado = ? and to_char(fecha_inicio,'YYYY') = '2013'" , "#{datamodalidad.id}","L"])
        cantliquidado2013 = Contrato.count(:conditions => [" modalidad_id = ? and estado = ? and to_char(fecha_inicio,'YYYY') = '2013'" , "#{datamodalidad.id}","I"])
        cantterminado2013 = Contrato.count(:conditions => [" modalidad_id = ? and estado = ?  and to_char(fecha_inicio,'YYYY') = '2013'" , "#{datamodalidad.id}","T"])
        cantanulado2013 = Contrato.count(:conditions => [" modalidad_id = ? and estado = ?  and to_char(fecha_inicio,'YYYY') = '2013'" , "#{datamodalidad.id}","C"])
        xml.Row do
          xml.Cell { xml.Data datamodalidad.descripcion, 'ss:Type' => 'String' }
          xml.Cell { xml.Data cantmodal, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data cadenaanno, 'ss:Type' => 'String' }
          xml.Cell { xml.Data cantperfeccionado, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data cantenejecucion, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data cantenliquidacion, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data cantliquidado, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data cantanticipo, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data cantterminado, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data cantanulado, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data '------', 'ss:Type' => 'String' }
          xml.Cell { xml.Data cantanno2012, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data cantperfeccionado2012, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data cantenejecucion2012, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data cantenliquidacion2012, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data cantliquidado2012, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data cantterminado2012, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data cantanulado2012, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data '------', 'ss:Type' => 'String' }
          xml.Cell { xml.Data cantanno2013, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data cantperfeccionado2013, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data cantenejecucion2013, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data cantenliquidacion2013, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data cantliquidado2013, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data cantterminado2013, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data cantanulado2013, 'ss:Type' => 'Number' }
        end
      end  #datamodalidad
    end
  end
end