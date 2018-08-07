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
#   OBRA PUBLICA
#
  xml.Worksheet 'ss:Name' => 'Informacion Obra Publica' do
    xml.Table do
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Identificacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nombre', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Proyecto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Direccion Vivienda Adquirir', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Ejecutor', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cuenta Ahorro Programado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'PUI Comuna XIII', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'PUI Centro Oriental', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Unipersonal', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Caso Especial ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Opcion de Vivienda ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Direccion Vivienda de Reposicion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Barrio de la Vivienda', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Avaluo', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Vivienda Reposicion ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Donacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estado General ', 'ss:Type' => 'String' }
      end
      for obraspublica in @obraspublicas
        personasidentificacion = ""
        personasnombre = ""
        proyectodescripcion = ""
        if obraspublica.persona_id
          personasidentificacion = obraspublica.persona.identificacion rescue nil
          personasnombre = obraspublica.persona.nombres rescue nil
        end
        if obraspublica.obrasproyecto_id
          proyectodescripcion = obraspublica.obrasproyecto.descripcion rescue nil
        end
        xml.Row do
            xml.Cell { xml.Data personasidentificacion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data personasnombre, 'ss:Type' => 'String' }
            xml.Cell { xml.Data proyectodescripcion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data obraspublica.dirvivienda_adquirir, 'ss:Type' => 'String' }
            xml.Cell { xml.Data obraspublica.ejecutor, 'ss:Type' => 'String' }
            xml.Cell { xml.Data obraspublica.cap, 'ss:Type' => 'String' }
            xml.Cell { xml.Data obraspublica.pui_comuna, 'ss:Type' => 'String' }
            xml.Cell { xml.Data obraspublica.pui_oriental, 'ss:Type' => 'String' }
            xml.Cell { xml.Data obraspublica.unipersonal, 'ss:Type' => 'String' }
            xml.Cell { xml.Data obraspublica.caso_especial, 'ss:Type' => 'String' }
            xml.Cell { xml.Data obraspublica.opcion_vivienda, 'ss:Type' => 'String' }
            xml.Cell { xml.Data obraspublica.dirvivienda_reposicion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data obraspublica.barrio_reposicion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data obraspublica.avaluo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data obraspublica.valor_reposicion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data obraspublica.donacion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data obraspublica.estado, 'ss:Type' => 'String' }
        end
      end
    end
  end

#
#   OBRA PUBLICA - DISPONIBILIDADES
#
  xml.Worksheet 'ss:Name' => 'Disponibilidades' do
    xml.Table do
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Identificacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nombre', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Proyecto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nro Resolucion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Resolucion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nro Disponibilidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Disponibilidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nro Compromiso', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Compromiso', 'ss:Type' => 'String' }
      end
      for obraspublica in @obraspublicas
        personasidentificacion = ""
        personasnombre = ""
        proyectodescripcion = ""
        if obraspublica.persona_id
          personasidentificacion = obraspublica.persona.identificacion rescue nil
          personasnombre = obraspublica.persona.nombres rescue nil
        end
        if obraspublica.obrasproyecto_id
          proyectodescripcion = obraspublica.obrasproyecto.descripcion rescue nil
        end
        @obrasdisponibilidades = Obrasdisponibilidad.find(:all, :conditions => ["obraspublica_id = ?",obraspublica.id])
        for obrasdisponibilidad in @obrasdisponibilidades
          xml.Row do
              xml.Cell { xml.Data personasidentificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data personasnombre, 'ss:Type' => 'String' }
              xml.Cell { xml.Data proyectodescripcion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data obrasdisponibilidad.nro_resolucion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data obrasdisponibilidad.fecha_resolucion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data obrasdisponibilidad.nro_disponibilidad, 'ss:Type' => 'String' }
              xml.Cell { xml.Data obrasdisponibilidad.fecha_disponibilidad, 'ss:Type' => 'String' }
              xml.Cell { xml.Data obrasdisponibilidad.nro_compromiso, 'ss:Type' => 'String' }
              xml.Cell { xml.Data obrasdisponibilidad.fecha_compromiso, 'ss:Type' => 'String' }
          end
        end
      end
    end
  end

#
#   OBRA PUBLICA - RADICADOS
#
  xml.Worksheet 'ss:Name' => 'Radicados' do
    xml.Table do
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Identificacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nombre', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Proyecto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nro Radicado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Radicado', 'ss:Type' => 'String' }
      end
      for obraspublica in @obraspublicas
        personasidentificacion = ""
        personasnombre = ""
        proyectodescripcion = ""
        if obraspublica.persona_id
          personasidentificacion = obraspublica.persona.identificacion rescue nil
          personasnombre = obraspublica.persona.nombres rescue nil
        end
        if obraspublica.obrasproyecto_id
          proyectodescripcion = obraspublica.obrasproyecto.descripcion rescue nil
        end
        @obrasradicados = Obrasradicado.find(:all, :conditions => ["obraspublica_id = ?",obraspublica.id])
        for obrasradicado in @obrasradicados
          xml.Row do
              xml.Cell { xml.Data personasidentificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data personasnombre, 'ss:Type' => 'String' }
              xml.Cell { xml.Data proyectodescripcion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data obrasradicado.nro_radicado, 'ss:Type' => 'String' }
              xml.Cell { xml.Data obrasradicado.fecha, 'ss:Type' => 'String' }
          end
        end
      end
    end
  end

#
#   OBRA PUBLICA - VENDEDORES
#
  xml.Worksheet 'ss:Name' => 'Vendedores' do
    xml.Table do
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Identificacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nombre', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Proyecto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Identificacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nombre', 'ss:Type' => 'String' }
      end
      for obraspublica in @obraspublicas
        personasidentificacion = ""
        personasnombre = ""
        proyectodescripcion = ""
        if obraspublica.persona_id
          personasidentificacion = obraspublica.persona.identificacion rescue nil
          personasnombre = obraspublica.persona.nombres rescue nil
        end
        if obraspublica.obrasproyecto_id
          proyectodescripcion = obraspublica.obrasproyecto.descripcion rescue nil
        end
        @obrasvendedores = Obrasvendedor.find(:all, :conditions => ["obraspublica_id = ?",obraspublica.id])
        for obrasvendedor in @obrasvendedores
          xml.Row do
              xml.Cell { xml.Data personasidentificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data personasnombre, 'ss:Type' => 'String' }
              xml.Cell { xml.Data proyectodescripcion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data obrasvendedor.identificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data obrasvendedor.nombre, 'ss:Type' => 'String' }
          end
        end
      end
    end
  end
end


