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
  xml.Worksheet 'ss:Name' => 'Informacion Radicados' do
    xml.Table do
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Nro Radicado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Elaboracion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Recibido', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Numero Externo', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Remitente', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Asunto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Dependencia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Traslado 1 Dependencia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Traslado 1 Nro Oficio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Traslado 1 Fecha', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Traslado 2 Dependencia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Traslado 2 Nro Oficio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Traslado 2 Fecha', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Traslado 3 Dependencia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Traslado 3 Nro Oficio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Traslado 3 Fecha', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Anexos', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Clase', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tiempo maximo', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Observaciones', 'ss:Type' => 'String' }
      end
      for correspondenciasrecibida in @correspondenciasenviadas
        if correspondenciasrecibida.persona_id.to_i > 0
          cadena = Persona.find(correspondenciasrecibida.persona_id).autobuscar rescue nil
        elsif correspondenciasrecibida.correspondenciasremitente_id
          correspondenciasremitente = Correspondenciasremitente.find(correspondenciasrecibida.correspondenciasremitente_id)
          cadena = correspondenciasremitente.nombre.to_s
          if correspondenciasremitente.entidad.to_s
            cadena = cadena + " - " + correspondenciasremitente.entidad.to_s
          end
        end
        if correspondenciasrecibida.dependencia_id
          cadena0 = Dependencia.find(correspondenciasrecibida.dependencia_id).descripcion
        end
        if correspondenciasrecibida.dependencia1_id
          cadena1 = Dependencia.find(correspondenciasrecibida.dependencia1_id).descripcion
        end
        if correspondenciasrecibida.dependencia2_id
          cadena2 = Dependencia.find(correspondenciasrecibida.dependencia2_id).descripcion
        end
        if correspondenciasrecibida.dependencia3_id
          cadena3 = Dependencia.find(correspondenciasrecibida.dependencia3_id).descripcion
        end
        xml.Row do
            xml.Cell { xml.Data correspondenciasrecibida.nro_radicado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data correspondenciasrecibida.fecha_elaboracion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data correspondenciasrecibida.numero_externo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data correspondenciasrecibida.fecha_recibido, 'ss:Type' => 'String' }
            xml.Cell { xml.Data cadena, 'ss:Type' => 'String' }
            xml.Cell { xml.Data correspondenciasrecibida.asunto, 'ss:Type' => 'String' }
            xml.Cell { xml.Data cadena0, 'ss:Type' => 'String' }
            xml.Cell { xml.Data cadena1, 'ss:Type' => 'String' }
            xml.Cell { xml.Data correspondenciasrecibida.oficio1, 'ss:Type' => 'String' }
            xml.Cell { xml.Data correspondenciasrecibida.fecha1, 'ss:Type' => 'String' }
            xml.Cell { xml.Data cadena2, 'ss:Type' => 'String' }
            xml.Cell { xml.Data correspondenciasrecibida.oficio2, 'ss:Type' => 'String' }
            xml.Cell { xml.Data correspondenciasrecibida.fecha2, 'ss:Type' => 'String' }
            xml.Cell { xml.Data cadena3, 'ss:Type' => 'String' }
            xml.Cell { xml.Data correspondenciasrecibida.oficio3, 'ss:Type' => 'String' }
            xml.Cell { xml.Data correspondenciasrecibida.fecha3, 'ss:Type' => 'String' }
            xml.Cell { xml.Data correspondenciasrecibida.anexos, 'ss:Type' => 'String' }
            xml.Cell { xml.Data correspondenciasrecibida.dclase, 'ss:Type' => 'String' }
            xml.Cell { xml.Data correspondenciasrecibida.tiempo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data correspondenciasrecibida.observacion, 'ss:Type' => 'String' }
        end
      end
    end
  end


end
