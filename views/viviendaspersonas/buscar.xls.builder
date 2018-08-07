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
  xml.Worksheet 'ss:Name' => 'Informacion Proyecto' do
    xml.Table do
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Información Vivienda', 'ss:Type' => 'String' }
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
          xml.Cell { xml.Data 'Información Beneficiario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Informacion Etapa', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Proyecto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Direccion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Bloque', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Piso', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Apto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Vivienda', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Ahorro Programado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Ahorro Trasladado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Credito', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Donacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Pago Escrituras', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'CIERRE TOTAL', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Identificacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nombre', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Registro', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Usuario Registro', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Etapa', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Actividad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Inicio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Fin', 'ss:Type' => 'String' }
      end
      for vivienda in @viviendas
        valorcredito  = Vivienda.valorcredito(vivienda.id)
        valorsubsidio = Vivienda.valorsubsidio(vivienda.id, vivienda.consig_escrituras.to_i)
        saldo         = valorcredito.to_i + valorsubsidio.to_i + vivienda.valor_donacion.to_i + vivienda.valor_ahorro_tras.to_i + vivienda.otros_aportes.to_i
        cierretotal   = vivienda.valor_vivienda.to_i - saldo.to_i
        @viviendaspersonas = Viviendaspersona.find_all_by_vivienda_id(vivienda.id);
        for viviendaspersona in @viviendaspersonas
           persona  = Persona.find(viviendaspersona.persona_id);
           identifi = persona.identificacion
           nombre = persona.nombres
        end
        @viviendastramites = Viviendastramite.find_all_by_vivienda_id(vivienda.id)
        etapa = ""
        user1 = ""
        tramite = ""
        for viviendastramite in @viviendastramites
          etapa   = viviendastramite.viviendastipostramite.etapa rescue nil
          tramite = viviendastramite.viviendastipostramite.descripcion rescue nil
          user1 = User.find(viviendastramite.user_id).nombre rescue nil
          xml.Row do
              xml.Cell { xml.Data vivienda.proyecto.descripcion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data vivienda.bloque.direccion.to_s, 'ss:Type' => 'String' }
              xml.Cell { xml.Data vivienda.bloque.descripcion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data vivienda.piso.descripcion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data vivienda.apto.descripcion.to_s, 'ss:Type' => 'String' }
              xml.Cell { xml.Data vivienda.valor_vivienda, 'ss:Type' => 'Number' }
              xml.Cell { xml.Data vivienda.valor_ahorro_prog, 'ss:Type' => 'Number' }
              xml.Cell { xml.Data vivienda.valor_ahorro_tras, 'ss:Type' => 'Number' }
              xml.Cell { xml.Data valorcredito, 'ss:Type' => 'Number' }
              xml.Cell { xml.Data vivienda.valor_donacion, 'ss:Type' => 'Number' }
              xml.Cell { xml.Data vivienda.consig_escrituras, 'ss:Type' => 'Number' }
              xml.Cell { xml.Data cierretotal, 'ss:Type' => 'Number' }
              xml.Cell { xml.Data identifi, 'ss:Type' => 'String' }
              xml.Cell { xml.Data nombre, 'ss:Type' => 'String' }
              xml.Cell { xml.Data viviendastramite.created_at.strftime("%Y-%m-%d %X"), 'ss:Type' => 'String' }
              xml.Cell { xml.Data user1, 'ss:Type' => 'String' }
              xml.Cell { xml.Data etapa, 'ss:Type' => 'String' }
              xml.Cell { xml.Data tramite, 'ss:Type' => 'String' }
              xml.Cell { xml.Data viviendastramite.fecha_inicio, 'ss:Type' => 'String' }
              xml.Cell { xml.Data viviendastramite.fecha_esperada, 'ss:Type' => 'String' }
          end
        end
      end
    end
  end
end
