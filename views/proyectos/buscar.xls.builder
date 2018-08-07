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

  xml.Worksheet 'ss:Name' => 'Informacion Proyecto' do
    xml.Table do

      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Proyectos', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Proyecto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor total estimado del proyecto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Numero de viviendas', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Numero de locales comerciales', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Instrumento de gestión del suelo', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Comuna/barrio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Vigencia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Terminación estudios y diseños', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha inicio de obra', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha de terminacion obra', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha de entrega a las familias', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha de inauguracion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Porcentaje de avance programado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Porcentaje de avance ejecutado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Constructor', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Gerente', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Interventor', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Empleos calificados generados', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Empleos no calificados generados', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Porcentaje de empleos generados en la zona', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Numero de predios a adquirir para la ejecucion del proyecto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Numero de predios con dificultades de adquisicion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Numero de viviendas escrituradas', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha de terminación de compra de predios', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha de inicio de licitación o celebración de contrato de fiducia mercantil', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha de adjudicación', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Observaciones', 'ss:Type' => 'String' }
      end
      # Rows
      for proyectosficha in @proyectosfichas
        xml.Row do
          xml.Cell { xml.Data proyectosficha.proyecto.descripcion, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.valor_proyecto, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.nro_viviendas, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.nro_locales, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.instrumentogestion, 'ss:Type' => 'String' }
          if proyectosficha.comuna_id.to_s != ""
            xml.Cell { xml.Data proyectosficha.comuna.descripcion, 'ss:Type' => 'String' }
          else
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          end
          xml.Cell { xml.Data proyectosficha.vigencia, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.fecha_fin_estudios, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.fecha_inicio_obra, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.fecha_fin_obra, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.fecha_entrega, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.fecha_inauguracion, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.por_avance_pro, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.por_avance_eje, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.constructor, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.gerente, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.interventor, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.empleos_calificados, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.empleos_nocalificados, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.porcentaje_empleos, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.nro_predios_adquirir, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.nro_predios_dificiles, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.nro_viviendas_esc, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.fecha_fin_predio, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.fecha_inicio_licitacion, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.fecha_adjudicacion, 'ss:Type' => 'String' }
          xml.Cell { xml.Data proyectosficha.observaciones, 'ss:Type' => 'String' }
        end
      end

    end
  end

end
