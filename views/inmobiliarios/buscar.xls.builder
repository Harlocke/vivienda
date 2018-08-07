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

  xml.Worksheet 'ss:Name' => 'Informacion Inmobiliario' do
    xml.Table do

      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Información BANCO INMOBILIARIO', 'ss:Type' => 'String' }
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
          xml.Cell { xml.Data 'Sector', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Direccion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nivel', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Piso', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Alcoba', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cocina', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Baño', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Sala', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Comedor', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Patio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Balcon', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Otros', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estrato', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Precio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estado Juridico', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Disponible', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Disponible', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Concepto Riesgos', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Resultado Concepto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Documentacion Completa', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estudio de Titulos', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Resultado Estudio Titulos', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Registro', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Identificacion Vendedor', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nombre Vendedor', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Telefonos Vendedor', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Usuario Registro', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Observaciones', 'ss:Type' => 'String' }
      end

      # Rows
      for inmobiliario in @inmobiliarios
        xml.Row do
            xml.Cell { xml.Data inmobiliario.comuna.descripcion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data inmobiliario.direccion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data inmobiliario.nivel, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data inmobiliario.piso, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data inmobiliario.alcoba, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data inmobiliario.cocina, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data inmobiliario.bano, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data inmobiliario.sala, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data inmobiliario.comedor, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data inmobiliario.patio, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data inmobiliario.balcon, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data inmobiliario.otros, 'ss:Type' => 'String' }
            xml.Cell { xml.Data inmobiliario.estrato, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data inmobiliario.precio, 'ss:Type' => 'Number' }
            if inmobiliario.info_juridica == "S"
              xml.Cell { xml.Data 'VERIFICADA', 'ss:Type' => 'String' }
            elsif inmobiliario.info_juridica == "N"
              xml.Cell { xml.Data 'NO VERIFICADA', 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            end
            if inmobiliario.disponible == "S"
              xml.Cell { xml.Data 'SI', 'ss:Type' => 'String' }
            elsif inmobiliario.disponible == "N"
              xml.Cell { xml.Data 'NO', 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            end
            xml.Cell { xml.Data inmobiliario.fecha_disponible, 'ss:Type' => 'String' }
            if inmobiliario.concepto_riesgo == "S"
              xml.Cell { xml.Data 'SI', 'ss:Type' => 'String' }
            elsif inmobiliario.disponible == "N"
              xml.Cell { xml.Data 'NO', 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            end
            xml.Cell { xml.Data inmobiliario.resultado_concepto, 'ss:Type' => 'String' }
            xml.Cell { xml.Data inmobiliario.documentacion_completa, 'ss:Type' => 'String' }
            xml.Cell { xml.Data inmobiliario.titulos, 'ss:Type' => 'String' }
            xml.Cell { xml.Data inmobiliario.titulos_resultado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data inmobiliario.created_at, 'ss:Type' => 'String' }
            xml.Cell { xml.Data inmobiliario.identificacion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data inmobiliario.nombre, 'ss:Type' => 'String' }
            xml.Cell { xml.Data inmobiliario.telefonos, 'ss:Type' => 'String' }
            xml.Cell { xml.Data inmobiliario.user.nombre, 'ss:Type' => 'String' }
            xml.Cell { xml.Data inmobiliario.observaciones, 'ss:Type' => 'String' }
        end
      end

    end
  end
  xml.Worksheet 'ss:Name' => 'Consolidado' do
    xml.Table do

      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Consolidado Disponibles por Sector', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Sector', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cantidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end
      
      inmobiliario = Inmobiliario.find(:all,
                                       :select => 'sector, count(*) count',
                                       :conditions => ['disponible = ? ', 'S'],
                                       :group => 'sector',
                                       :order => 'sector')
      inmobiliario.each do |data|      
        xml.Row do
            xml.Cell { xml.Data data.sector, 'ss:Type' => 'String' }
            xml.Cell { xml.Data data.count, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
      end
      totaldisp = Inmobiliario.count(:conditions => ['disponible = ? ', 'S'])
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Cantidad Total', 'ss:Type' => 'String' }
          xml.Cell { xml.Data totaldisp, 'ss:Type' => 'Number' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end

    end
 end


end
