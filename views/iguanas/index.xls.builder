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
          xml.Cell { xml.Data 'Información Vivienda', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'ID', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Proyecto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Identificacion Plano', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Social Asignado ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Juridico Asignado ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Sector', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Encuesta', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cobama', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Matricula', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Comuna', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Barrio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Manzana', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Lote', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Interior', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Disponibilidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Direccion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Compensacion Economica', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Compensacion Traslado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Compensacion Tramites Legales', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor AVALUO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Compensacion Arrendatario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Solicitud Avaluo ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha LIMITE ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Entidad Avaluadora ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Avaluo ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Resolucion Oferta de Compra', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Acepta Oferta Compra', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Resolucion Notificada ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Resolucion Fecha Notificacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Resolucion Fecha Aceptacion ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Solicitud Revision Avaluo ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Solicitud', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Solicitud Resultado ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Compraventa Firmada ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nro Resolucion Oferta de Compra ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Resolucion de Compra ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nro Resolucion Modificatorias', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Resolucion Modificatoria ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Escritura', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nro Escritura ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Escritura', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Notaria', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Expropiacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Opcion de Vivienda ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estado Vivienda', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cruce con Ministerio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Cruce', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Reasentado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Reasentado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Inicio Arrendamiento', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Finalizacion Arrendamiento', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'VU - Fecha Solicitud Certificado Riesgo ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'VU - Fecha Recibido Certificado Riesgo ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'VU - Fecha Solicitud Avaluo ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'VU - Fecha Recibido Avaluo', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'VU - Fecha Remision Banco Inmobiliario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'VU - Fecha Devolucion  Banco Inmobiliario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'VU - Fecha Remision Asignacion Subsidio ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'VU - Fecha Devolucion Asignacion Subsidio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'VN - Fecha Remision Financiera', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'VN - Fecha Remision Juridica', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Estimada Liberacion ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tratamiento', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Deshabilitado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Demolido', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Acta Entrega', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Descargue Catastro', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Radicado Catastro', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Descargue Catastro - Nro Radicado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Descargue EPM', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Descargue EPM - Nro Radicado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Descargue EEVV', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Predio Lote?', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Paga Catastro?', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estado General', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Ult. Actualizacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Usuario Ult. Actualizacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Personas', 'ss:Type' => 'String' }
      end
      # Rows
      for iguana in @iguanas
        socialasignado = ""
        juridicoasignado = ""
        estadogeneral = ""
        updatedat = ""
        usercrea = ""
        updatedat = iguana.updated_at.strftime("%Y-%m-%d %X") rescue nil
        usercrea = User.find(iguana.useract_id).username rescue nil
        if iguana.social_asignado
          socialasignado = User.find(iguana.social_asignado).nombre rescue nil
        end
        if iguana.juridico_asignado
          juridicoasignado = User.find(iguana.juridico_asignado).nombre rescue nil
        end
        if iguana.iguanasestado_id
          estadogeneral = Iguanasestado.find(iguana.iguanasestado_id).descripcion rescue nil
        end
        xml.Row do
            xml.Cell { xml.Data iguana.id, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.proyecto, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.nro_registro, 'ss:Type' => 'String' }
            xml.Cell { xml.Data socialasignado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data juridicoasignado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.sector, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.encuesta, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.cobama, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.matricula, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.comuna, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.barrio, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.manzana, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.lote, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.interior, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.disponibilidad, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.direccion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.valor_compensacion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.valor_traslado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.valor_tramites, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.valor_avaluo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.valor_arrendatario, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_sol_avaluo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_limite, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.entidad_avaluadora, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_avaluo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.resolucion_ofercompra, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.acepta_oferta_compra, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.resolucion_notificada, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_notificacion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.resolucion_aceptada, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.solicitud_revision_avaluo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_sol_rev_avaluo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.resultado_revision, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.compraventa_firma, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.nro_resol_compra, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_resol_compra, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.nro_resol_modif, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_resol_modif, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.escritura, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.nro_escritura, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_escritura, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.notaria, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.expropiacion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.opcion_vivienda, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.estado_vivienda, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.cruzado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_cruzado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.reasentado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_reasentamiento, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_inicio_arre, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_fin_arre, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_sol_riesgo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_rec_riesgo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_solre_avaluo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_rec_avaluo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_rem_banco, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_dev_banco, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_rem_subsidio, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_dev_subsidio, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_rem_financiera, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_rem_juridica, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_estimada, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.tratamiento, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.deshabilitado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.demolido, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_entrega, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.solicitud_desccatastro, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_radicadocatastro, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.radicado_nro, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_epm, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.epm_radicado_nro, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.fecha_eevv, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.predio_lote, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.paga_catastro, 'ss:Type' => 'String' }
            xml.Cell { xml.Data updatedat, 'ss:Type' => 'String' }
            xml.Cell { xml.Data usercrea, 'ss:Type' => 'String' }
            xml.Cell { xml.Data estadogeneral, 'ss:Type' => 'String' }
            cadena = ""
            @iguanaspersonas = Iguanaspersona.find_all_by_iguana_id(iguana.id);
            for iguanaspersona in @iguanaspersonas
              persona  = Persona.find(iguanaspersona.persona_id);
              if cadena != ""
                cadena = cadena + ' - ' + persona.autobuscar
              else
                cadena = persona.autobuscar
              end
            end
            xml.Cell { xml.Data cadena, 'ss:Type' => 'String' }
        end
      end

    end
  end
  
# Pestaña Informe Nuevo Antonio Toro
  xml.Worksheet 'ss:Name' => 'Consolidado IGUANA' do
      xml.Table do
        # Header
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data 'Informe Consolidado', 'ss:Type' => 'String' }
            xml.Cell { xml.Data 'Fase 1', 'ss:Type' => 'String' }
            xml.Cell { xml.Data 'Fase 2', 'ss:Type' => 'String' }
            xml.Cell { xml.Data 'Total', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Liberados', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') and iguanasestado_id in (7,8)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') and iguanasestado_id in (7,8)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id in (7,8)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Avalúo', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') and iguanasestado_id in (2,3,6,13,14,19,20,21,22,23,24)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') and iguanasestado_id in (2,3,6,13,14,19,20,21,22,23,24)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id in (2,3,6,13,14,19,20,21,22,23,24)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Ofertas Compra', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') and iguanasestado_id in (4,16,18)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') and iguanasestado_id in (4,16,18)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id in (4,16,18)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Notificaciones', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') and iguanasestado_id in (11,12)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') and iguanasestado_id in (11,12)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id in (11,12)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Enajenación Voluntaria', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') and iguanasestado_id in (1)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') and iguanasestado_id in (1)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id in (1)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Procesos Expropiación', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') and iguanasestado_id in (5,10,9,15,17)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') and iguanasestado_id in (5,10,9,15,17)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id in (5,10,9,15,17)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data 'TOTALES', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') and iguanasestado_id not in (7,8)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') and iguanasestado_id not in (7,8)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id not in (7,8)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data 'Estado', 'ss:Type' => 'String' }
            xml.Cell { xml.Data 'Fase 1', 'ss:Type' => 'String' }
            xml.Cell { xml.Data 'Fase 2', 'ss:Type' => 'String' }
            xml.Cell { xml.Data 'Total', 'ss:Type' => 'String' }
            xml.Cell { xml.Data 'Observacion Etapa', 'ss:Type' => 'String' }
        end
        xml.Row do
          xml.Cell { xml.Data 'LIBERADO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 7"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 7"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 7"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 8
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 8)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'LIBERADO EXPROPIADO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 8"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 8"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 8"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 8
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 8)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
          xml.Cell { xml.Data 'SIN REGISTRO TOPOGRAFICO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 20"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 20"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 20"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 20
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 20)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SOLICITUD CARGUE CATASTRO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 22"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 22"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 22"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id =22
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id =22)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SOLICITUD FICHA PREDIAL', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 24"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 24"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 24"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 24
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 24)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'FICHA PREDIAL EN CORRECCIONES', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 6"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 6"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 6"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 6
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 6)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SIN AVALUO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 19"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 19"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 19"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 19
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 19)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'ACTUALIZACION AVALUO CATASTRO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 2"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 2"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 2"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 2
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 2)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SOLICITUD AVALUO IGAC', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 21"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 21"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 21"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 21
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 21)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'CORRECCION AVALUO IGAC', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 3"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 3"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 3"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 3
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 3)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SOLICITUD CERTIFICADO DE AREAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 23"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 23"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 23"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 23
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 23)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RECONOCIMIENTO DE MEJORAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 14"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 14"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 14"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 14
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 14)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'PENDIENTE PUNTEOS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 13"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 13"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 13"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id =13
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 13)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
          xml.Cell { xml.Data 'ELABORACION RESOLUCION', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 4"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 4"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 4"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 4
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id =4)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RESOLUCION EN FIRMAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 16"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 16"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 16"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 16
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 16)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RESOLUCION POR NOTIFICAR', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 18"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 18"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 18"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 18
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 18)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
          xml.Cell { xml.Data 'NOTIFICADO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 11"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 11"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 11"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 11
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 11)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'NOTIFICADO POR EDICTO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 12"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 12"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 12"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 12
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 12)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
          xml.Cell { xml.Data 'NOTIFICADA LA EXPROPIACION', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 9"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 9"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id =9"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 9
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 9)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'NOTIFICADA RESOLUCION EXPROPIACION POR EDICTO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 10"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 10"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 10"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 10
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 10)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'ELABORACION RESOLUCION EXPROPIACION', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 5"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 5"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 5"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 5
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 5)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RESOLUCION DE EXPROPIACION POR NOTIFICAR', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 15"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 15"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 15"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 15
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 15)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RESOLUCION EXPROPIACION EN FIRMAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 17"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 17"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 17"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 17
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 17)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
          xml.Cell { xml.Data 'ACEPTADO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 1
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 1)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data 'OPCION DE VIVIENDA - USADA', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'SOLICITUD AVALUO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'SOLICITUD AVALUO' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'SOLICITUD AVALUO' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'SOLICITUD AVALUO' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'ASIGNACION DE SUBSIDIO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'ASIGNACION DE SUBSIDIO' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'ASIGNACION DE SUBSIDIO' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'ASIGNACION DE SUBSIDIO' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'ESCRITURACION', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'ESCRITURACION' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'ESCRITURACION' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'ESCRITURACION' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'PAGOS', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'PAGOS' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'PAGOS' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'PAGOS' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'SOLICITUD CERTIFICADO DE RIESGO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'SOLICITUD CERTIFICADO DE RIESGO' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'SOLICITUD CERTIFICADO DE RIESGO' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'SOLICITUD CERTIFICADO DE RIESGO' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'REMISION BANCO INMOBILIARIO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'REMISION BANCO INMOBILIARIO' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'REMISION BANCO INMOBILIARIO' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'REMISION BANCO INMOBILIARIO' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'SIN DEFINIR OPCION', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda ='VIVIENDA USADA' AND estado_vivienda = 'SIN DEFINIR OPCION' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda ='VIVIENDA USADA' AND estado_vivienda = 'SIN DEFINIR OPCION' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda ='VIVIENDA USADA' AND estado_vivienda = 'SIN DEFINIR OPCION' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
          xml.Row 'ss:StyleID' => 'header' do
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data 'OPCION DE VIVIENDA - NUEVA', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'ASIGNACION DE SUBSIDIO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'ASIGNACION DE SUBSIDIO' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'ASIGNACION DE SUBSIDIO' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'ASIGNACION DE SUBSIDIO' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'CIERRE FINANCIERO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'CIERRE FINANCIERO' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'CIERRE FINANCIERO' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'CIERRE FINANCIERO' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'ESCRITURACION', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'ESCRITURACION' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'ESCRITURACION' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'ESCRITURACION' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'POSTULACION', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'POSTULACION' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'POSTULACION' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'POSTULACION' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'SIN DEFINIR OPCION', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'SIN DEFINIR OPCION' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'SIN DEFINIR OPCION' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'SIN DEFINIR OPCION' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'PAGO DE MEJORAS', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda ='NEGOCIACION DIRECTA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda ='NEGOCIACION DIRECTA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda ='NEGOCIACION DIRECTA' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
          xml.Cell { xml.Data 'OCUPACION IRREGULAR', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 25"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 25"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 25"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 25
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 25)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'REASENTAMIENTO INTERNO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND iguanasestado_id = 26"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND iguanasestado_id = 26"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='IGUANA' AND iguanasestado_id = 26"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    iguanasestado_id = 26
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 26)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end

      end
  end

# Pestaña Informe Nuevo Antonio Toro
  xml.Worksheet 'ss:Name' => 'Consolidado MORAVIA' do
      xml.Table do
        # Header
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data 'Informe Consolidado', 'ss:Type' => 'String' }
            xml.Cell { xml.Data 'Total', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Liberados', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id in (7,8)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Avalúo', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id in (2,3,6,13,14,19,20,21,22,23,24)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Ofertas Compra', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id in (4,16,18)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Notificaciones', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id in (11,12)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Enajenación Voluntaria', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id in (1)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Procesos Expropiación', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id in (5,10,9,15,17)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data 'TOTALES', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id not in (7,8)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data 'Estado', 'ss:Type' => 'String' }
            xml.Cell { xml.Data 'Total', 'ss:Type' => 'String' }
            xml.Cell { xml.Data 'Observacion Etapa', 'ss:Type' => 'String' }
        end
        xml.Row do
          xml.Cell { xml.Data 'LIBERADO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 7"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 8
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 8)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'LIBERADO EXPROPIADO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 8"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 8
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 8)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
          xml.Cell { xml.Data 'SIN REGISTRO TOPOGRAFICO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 20"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 20
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 20)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SOLICITUD CARGUE CATASTRO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 22"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id =22
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id =22)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SOLICITUD FICHA PREDIAL', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 24"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 24
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 24)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'FICHA PREDIAL EN CORRECCIONES', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 6"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 6
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 6)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SIN AVALUO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 19"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 19
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 19)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'ACTUALIZACION AVALUO CATASTRO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 2"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 2
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 2)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SOLICITUD AVALUO IGAC', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 21"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 21
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 21)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'CORRECCION AVALUO IGAC', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 3"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 3
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 3)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SOLICITUD CERTIFICADO DE AREAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 23"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 23
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 23)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RECONOCIMIENTO DE MEJORAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 14"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 14
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 14)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'PENDIENTE PUNTEOS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 13"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id =13
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 13)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
          xml.Cell { xml.Data 'ELABORACION RESOLUCION', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 4"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 4
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id =4)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RESOLUCION EN FIRMAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 16"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 16
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 16)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RESOLUCION POR NOTIFICAR', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 18"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 18
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 18)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
          xml.Cell { xml.Data 'NOTIFICADO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 11"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 11
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 11)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'NOTIFICADO POR EDICTO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 12"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 12
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 12)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
          xml.Cell { xml.Data 'NOTIFICADA LA EXPROPIACION', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id =9"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 9
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 9)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'NOTIFICADA RESOLUCION EXPROPIACION POR EDICTO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 10"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 10
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 10)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'ELABORACION RESOLUCION EXPROPIACION', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 5"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 5
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 5)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RESOLUCION DE EXPROPIACION POR NOTIFICAR', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 15"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 15
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 15)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RESOLUCION EXPROPIACION EN FIRMAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 17"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 17
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 17)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
          xml.Cell { xml.Data 'ACEPTADO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 1
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 1)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end

        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data 'OPCION DE VIVIENDA - USADA', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'SOLICITUD AVALUO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'SOLICITUD AVALUO' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'ASIGNACION DE SUBSIDIO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'ASIGNACION DE SUBSIDIO' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
        end
        xml.Row do
            xml.Cell { xml.Data 'ESCRITURACION', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'ESCRITURACION' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'PAGOS', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'PAGOS' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'SOLICITUD CERTIFICADO DE RIESGO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'SOLICITUD CERTIFICADO DE RIESGO' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'REMISION BANCO INMOBILIARIO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'REMISION BANCO INMOBILIARIO' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'SIN DEFINIR OPCION', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda ='VIVIENDA USADA' AND estado_vivienda = 'SIN DEFINIR OPCION' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
          xml.Row 'ss:StyleID' => 'header' do
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data 'OPCION DE VIVIENDA - NUEVA', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'SOLICITUD AVALUO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'SOLICITUD AVALUO' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'ASIGNACION DE SUBSIDIO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'ASIGNACION DE SUBSIDIO' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'ESCRITURACION', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'ESCRITURACION' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'PAGOS', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'PAGOS' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'SOLICITUD CERTIFICADO DE RIESGO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'SOLICITUD CERTIFICADO DE RIESGO' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'REMISION BANCO INMOBILIARIO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'REMISION BANCO INMOBILIARIO' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'SIN DEFINIR OPCION', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'SIN DEFINIR OPCION' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'PAGO DE MEJORAS', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda ='NEGOCIACION DIRECTA' AND iguanasestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
          xml.Cell { xml.Data 'OCUPACION IRREGULAR', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 25"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 25
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 25)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'REASENTAMIENTO INTERNO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Iguana.count(:conditions => [" proyecto='MORAVIA' AND iguanasestado_id = 26"]), 'ss:Type' => 'Number' }
          @iguanasestadosnotas = Iguanasestadosnota.find_by_sql("select observaciones
                                                                 from   iguanasestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    iguanasestado_id = 26
                                                                 and    created_at = (select max(created_at)
                                                                                      from iguanasestadosnotas
                                                                                      where iguanasestado_id = 26)")
          @iguanasestadosnotas.each do |iguanasestadosnota|
            xml.Cell { xml.Data iguanasestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
      end
  end
end
