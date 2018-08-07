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
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Información Beneficiario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Credito', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Subsidio Nacional', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Aporte Viva', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Municipal en Dinero', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Municipal en Especie', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Reconocimiento Mejoras', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Subsidio Ajustado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Subsidio Caja', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end

      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Proyecto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Direccion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Bloque', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Piso', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Apto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estado Inmueble', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Vivienda', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Ahorro Programado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Ahorro Trasladado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Credito', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Donacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Pago Escrituras', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'CIERRE TOTAL', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Entregado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Entrega', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Identificacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Primer Nombre', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Segundo Nombre', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Primer Apellido', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Segundo Apellido', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tenencia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Procedencia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Telefonos', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Direccion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nombre Entidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Credito', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Vencimiento', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Caja', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Bolsa', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estado SFV', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Resolucion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Vigencia del Subsidio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Viva', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Resolucion Viva', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Mpal Dinero', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Resolucion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Mpal Especie', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Resolucion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Mejoras', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Resolucion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Ajustado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Resolucion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Caja', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Resolucion', 'ss:Type' => 'String' }
      end
      for viviendasreporte in @viviendasreportes
        if viviendasreporte.vivienda_id.to_s != ""
          @viviendas = Vivienda.find(:all, :conditions=>["id = #{viviendasreporte.vivienda_id}"])
          #for vivienda in @viviendas
          @viviendas.each do |vivienda|
            valorcredito  = Vivienda.valorcredito(vivienda.id)
            valorsubsidio = Vivienda.valorsubsidio(vivienda.id, vivienda.consig_escrituras.to_i)
            saldo         = valorcredito.to_i + valorsubsidio.to_i + vivienda.valor_donacion.to_i + vivienda.valor_ahorro_tras.to_i + vivienda.otros_aportes.to_i
            cierretotal   = vivienda.valor_vivienda.to_i - saldo.to_i
            xml.Row do
                xml.Cell { xml.Data vivienda.proyecto.descripcion, 'ss:Type' => 'String' }
                xml.Cell { xml.Data '', 'ss:Type' => 'String' }
                xml.Cell { xml.Data vivienda.bloque.descripcion, 'ss:Type' => 'String' }
                xml.Cell { xml.Data vivienda.piso.descripcion, 'ss:Type' => 'String' }
                if vivienda.apto_id.nil? == false
                  xml.Cell { xml.Data vivienda.apto.descripcion, 'ss:Type' => 'String' }
                else
                  xml.Cell { xml.Data '', 'ss:Type' => 'String' }
                end
                xml.Cell { xml.Data vivienda.estadovivienda, 'ss:Type' => 'String' }
                xml.Cell { xml.Data vivienda.valor_vivienda, 'ss:Type' => 'Number' }
                xml.Cell { xml.Data vivienda.valor_ahorro_prog, 'ss:Type' => 'Number' }
                xml.Cell { xml.Data vivienda.valor_ahorro_tras, 'ss:Type' => 'Number' }
                xml.Cell { xml.Data valorcredito, 'ss:Type' => 'Number' }
                xml.Cell { xml.Data vivienda.valor_donacion, 'ss:Type' => 'Number' }
                xml.Cell { xml.Data vivienda.consig_escrituras, 'ss:Type' => 'Number' }
                xml.Cell { xml.Data cierretotal, 'ss:Type' => 'Number' }
                xml.Cell { xml.Data vivienda.descentregado, 'ss:Type' => 'String' }
                xml.Cell { xml.Data vivienda.fecha_entrega, 'ss:Type' => 'String' }

                @viviendaspersonas = Viviendaspersona.find_all_by_vivienda_id(vivienda.id);
                for viviendaspersona in @viviendaspersonas
                   persona  = Persona.find(viviendaspersona.persona_id);
                   xml.Cell { xml.Data persona.identificacion, 'ss:Type' => 'String' }
                   xml.Cell { xml.Data persona.primer_nombre, 'ss:Type' => 'String' }
                   xml.Cell { xml.Data persona.segundo_nombre, 'ss:Type' => 'String' }
                   xml.Cell { xml.Data persona.primer_apellido, 'ss:Type' => 'String' }
                   xml.Cell { xml.Data persona.segundo_apellido, 'ss:Type' => 'String' }
                   xml.Cell { xml.Data persona.tenencia, 'ss:Type' => 'String' }
                   xml.Cell { xml.Data 'procedencia', 'ss:Type' => 'String' }
                   xml.Cell { xml.Data persona.telefonos, 'ss:Type' => 'String' }
                   xml.Cell { xml.Data persona.direccion, 'ss:Type' => 'String' }
                   @creditos  = Credito.find_all_by_persona_id(viviendaspersona.persona_id);
                   cantcre = 0
                   for credito in @creditos
                     if cantcre == 0
                       cantcre = cantcre + 1
                       if (credito.entidad_id.nil? == false)
                         xml.Cell { xml.Data credito.entidad.descripcion, 'ss:Type' => 'String' }
                       else
                         xml.Cell { xml.Data '', 'ss:Type' => 'String' }
                       end
                       xml.Cell { xml.Data credito.valor, 'ss:Type' => 'Number' }
                       if credito.fecha_vencimiento.to_s != ""
                         if credito.fecha_vencimiento < Time.now
                           xml.Cell { xml.Data 'VENCIDO', 'ss:Type' => 'String' }
                         else
                           xml.Cell { xml.Data 'VIGENTE', 'ss:Type' => 'String' }
                         end
                       else
                         xml.Cell { xml.Data '', 'ss:Type' => 'String' }
                       end
                       xml.Cell { xml.Data credito.fecha_credito, 'ss:Type' => 'String' }
                       xml.Cell { xml.Data credito.fecha_vencimiento, 'ss:Type' => 'String' }
                     else
                       cantcre = cantcre + 1
                     end
                   end
                   if cantcre == 0
                       xml.Cell { xml.Data '', 'ss:Type' => 'String' }
                       xml.Cell { xml.Data '', 'ss:Type' => 'Number' }
                       xml.Cell { xml.Data '', 'ss:Type' => 'String' }
                       xml.Cell { xml.Data '', 'ss:Type' => 'String' }
                       xml.Cell { xml.Data '', 'ss:Type' => 'String' }
                   end
                   #Subsidio Nacional
                   subsidio  = Subsidio.find_all_by_persona_id_and_tipos_subsidio_id(viviendaspersona.persona_id,4);
                   cantsub = 0
                   subsidio.each do |sub|
                     if cantsub == 0
                       cantsub = cantsub + 1
                       xml.Cell { xml.Data sub.entidadadmin, 'ss:Type' => 'String' }
                       xml.Cell { xml.Data sub.bolsa, 'ss:Type' => 'String' }
                       xml.Cell { xml.Data sub.estadosubsidio, 'ss:Type' => 'String' }
                       xml.Cell { xml.Data sub.valor, 'ss:Type' => 'Number' }
                       xml.Cell { xml.Data sub.resolucion, 'ss:Type' => 'String' }
                       xml.Cell { xml.Data sub.fecha_asig, 'ss:Type' => 'String' }
                       xml.Cell { xml.Data sub.fecha_vigencia, 'ss:Type' => 'String' }
                     else
                       cantsub = cantsub + 1
                     end
                   end
                   if (cantsub == 0)
                       xml.Cell { xml.Data '', 'ss:Type' => 'Number' }
                       xml.Cell { xml.Data '', 'ss:Type' => 'String' }
                       xml.Cell { xml.Data '', 'ss:Type' => 'Number' }
                       xml.Cell { xml.Data '', 'ss:Type' => 'String' }
                       xml.Cell { xml.Data '', 'ss:Type' => 'Number' }
                       xml.Cell { xml.Data '', 'ss:Type' => 'String' }
                       xml.Cell { xml.Data '', 'ss:Type' => 'Number' }
                   end
                   #Aporte VIVA
                   subsidio  = Subsidio.find_all_by_persona_id_and_tipos_subsidio_id(viviendaspersona.persona_id,2);
                   cantsub = 0
                   subsidio.each do |sub|
                     if cantsub == 0
                       cantsub = cantsub + 1
                       xml.Cell { xml.Data sub.valor, 'ss:Type' => 'Number' }
                       xml.Cell { xml.Data sub.resolucion, 'ss:Type' => 'String' }
                     else
                       cantsub = cantsub + 1
                     end
                   end
                   if (cantsub == 0)
                       xml.Cell { xml.Data '', 'ss:Type' => 'Number' }
                       xml.Cell { xml.Data '', 'ss:Type' => 'String' }
                   end
                   #Mpal en Dinero
                   subsidio  = Subsidio.find_all_by_persona_id_and_tipos_subsidio_id(viviendaspersona.persona_id,1);
                   cantsub = 0
                   subsidio.each do |sub|
                     if cantsub == 0
                       cantsub = cantsub + 1
                       xml.Cell { xml.Data sub.valor, 'ss:Type' => 'Number' }
                       xml.Cell { xml.Data sub.resolucion, 'ss:Type' => 'String' }
                     else
                       cantsub = cantsub + 1
                     end
                   end
                   if (cantsub == 0)
                       xml.Cell { xml.Data '', 'ss:Type' => 'Number' }
                       xml.Cell { xml.Data '', 'ss:Type' => 'String' }
                   end
                   #Mpal en Especie
                   subsidio  = Subsidio.find_all_by_persona_id_and_tipos_subsidio_id(viviendaspersona.persona_id,6);
                   cantsub = 0
                   subsidio.each do |sub|
                     if cantsub == 0
                       cantsub = cantsub + 1
                       xml.Cell { xml.Data sub.valor, 'ss:Type' => 'Number' }
                       xml.Cell { xml.Data sub.resolucion, 'ss:Type' => 'String' }
                     else
                       cantsub = cantsub + 1
                     end
                   end
                   if (cantsub == 0)
                       xml.Cell { xml.Data '', 'ss:Type' => 'Number' }
                       xml.Cell { xml.Data '', 'ss:Type' => 'String' }
                   end
                   #Mejoras
                   subsidio  = Subsidio.find_all_by_persona_id_and_tipos_subsidio_id(viviendaspersona.persona_id,3);
                   cantsub = 0
                   subsidio.each do |sub|
                     if cantsub == 0
                       cantsub = cantsub + 1
                       xml.Cell { xml.Data sub.valor, 'ss:Type' => 'Number' }
                       xml.Cell { xml.Data sub.resolucion, 'ss:Type' => 'String' }
                     else
                       cantsub = cantsub + 1
                     end
                   end
                   if (cantsub == 0)
                       xml.Cell { xml.Data '', 'ss:Type' => 'Number' }
                       xml.Cell { xml.Data '', 'ss:Type' => 'String' }
                   end
                   #Subsidio Ajustado
                   subsidio  = Subsidio.find_all_by_persona_id_and_tipos_subsidio_id(viviendaspersona.persona_id,5);
                   cantsub = 0
                   subsidio.each do |sub|
                     if cantsub == 0
                       cantsub = cantsub + 1
                       xml.Cell { xml.Data sub.valor, 'ss:Type' => 'Number' }
                       xml.Cell { xml.Data sub.resolucion, 'ss:Type' => 'String' }
                     else
                       cantsub = cantsub + 1
                     end
                   end
                   if (cantsub == 0)
                       xml.Cell { xml.Data '', 'ss:Type' => 'Number' }
                       xml.Cell { xml.Data '', 'ss:Type' => 'String' }
                   end
                   #Subsidio CAJA
                   subsidio  = Subsidio.find_all_by_persona_id_and_tipos_subsidio_id(viviendaspersona.persona_id,7);
                   cantsub = 0
                   subsidio.each do |sub|
                     if cantsub == 0
                       cantsub = cantsub + 1
                       xml.Cell { xml.Data sub.valor, 'ss:Type' => 'Number' }
                       xml.Cell { xml.Data sub.resolucion, 'ss:Type' => 'String' }
                     else
                       cantsub = cantsub + 1
                     end
                   end
                   if (cantsub == 0)
                       xml.Cell { xml.Data '', 'ss:Type' => 'Number' }
                       xml.Cell { xml.Data '', 'ss:Type' => 'String' }
                   end
                end
            end
          end #Viviendas
        end
      end #Viviendasreportes
      @viviendasreportes = Viviendasreporte.find(:all, :conditions=>['user_id is null and vivienda_id is null and persona_id is not null'])
      for viviendasreporte in @viviendasreportes
           xml.Row 'ss:StyleID' => 'header' do
              persona  = Persona.find(viviendasreporte.persona_id);
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
              xml.Cell { xml.Data  persona.identificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data  persona.primer_nombre, 'ss:Type' => 'String' }
              xml.Cell { xml.Data  persona.segundo_nombre, 'ss:Type' => 'String' }
              xml.Cell { xml.Data  persona.primer_apellido, 'ss:Type' => 'String' }
              xml.Cell { xml.Data  persona.segundo_apellido, 'ss:Type' => 'String' }
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
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          end
      end
      @viviendasreportes = Viviendasreporte.find(:all, :conditions=>['user_id is null and persona_id is null'])
      for viviendasreporte in @viviendasreportes
           xml.Row 'ss:StyleID' => 'header' do
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
              xml.Cell { xml.Data viviendasreporte.identificacion, 'ss:Type' => 'String' }
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
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          end
      end
    end
  end
end
