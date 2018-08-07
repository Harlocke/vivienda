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
      for valorizacion in @valorizaciones
        socialasignado = ""
        juridicoasignado = ""
        estadogeneral = ""
        updatedat = ""
        usercrea = ""
        updatedat = valorizacion.updated_at.strftime("%Y-%m-%d %X") rescue nil
        usercrea = User.find(valorizacion.useract_id).username rescue nil
        if valorizacion.social_asignado
          socialasignado = User.find(valorizacion.social_asignado).nombre rescue nil
        end
        if valorizacion.juridico_asignado
          juridicoasignado = User.find(valorizacion.juridico_asignado).nombre rescue nil
        end
        if valorizacion.valorizacionesestado_id
          estadogeneral = Valorizacionesestado.find(valorizacion.valorizacionesestado_id).descripcion rescue nil
        end
        xml.Row do
            xml.Cell { xml.Data valorizacion.id, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.proyecto, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.nro_registro, 'ss:Type' => 'String' }
            xml.Cell { xml.Data socialasignado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data juridicoasignado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.sector, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.encuesta, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.cobama, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.matricula, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.comuna, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.barrio, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.manzana, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.lote, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.interior, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.disponibilidad, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.direccion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.valor_compensacion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.valor_traslado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.valor_tramites, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.valor_avaluo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.valor_arrendatario, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_sol_avaluo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_limite, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.entidad_avaluadora, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_avaluo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.resolucion_ofercompra, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.acepta_oferta_compra, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.resolucion_notificada, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_notificacion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.resolucion_aceptada, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.solicitud_revision_avaluo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_sol_rev_avaluo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.resultado_revision, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.compraventa_firma, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.nro_resol_compra, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_resol_compra, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.nro_resol_modif, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_resol_modif, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.escritura, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.nro_escritura, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_escritura, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.notaria, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.expropiacion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.opcion_vivienda, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.estado_vivienda, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.cruzado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_cruzado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.reasentado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_reasentamiento, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_inicio_arre, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_fin_arre, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_sol_riesgo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_rec_riesgo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_solre_avaluo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_rec_avaluo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_rem_banco, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_dev_banco, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_rem_subsidio, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_dev_subsidio, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_rem_financiera, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_rem_juridica, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_estimada, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.tratamiento, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.deshabilitado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.demolido, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_entrega, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.solicitud_desccatastro, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_radicadocatastro, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.radicado_nro, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_epm, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.epm_radicado_nro, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.fecha_eevv, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.predio_lote, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.paga_catastro, 'ss:Type' => 'String' }
            xml.Cell { xml.Data updatedat, 'ss:Type' => 'String' }
            xml.Cell { xml.Data usercrea, 'ss:Type' => 'String' }
            xml.Cell { xml.Data estadogeneral, 'ss:Type' => 'String' }
            cadena = ""
            @valorizacionespersonas = Valorizacionespersona.find_all_by_valorizacion_id(valorizacion.id);
            for valorizacionespersona in @valorizacionespersonas
              persona  = Persona.find(valorizacionespersona.persona_id);
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
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') and valorizacionesestado_id in (7,8)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') and valorizacionesestado_id in (7,8)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id in (7,8)"]), 'ss:Type' => 'Number' }
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
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') and valorizacionesestado_id in (2,3,6,13,14,19,20,21,22,23,24)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') and valorizacionesestado_id in (2,3,6,13,14,19,20,21,22,23,24)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id in (2,3,6,13,14,19,20,21,22,23,24)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Ofertas Compra', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') and valorizacionesestado_id in (4,16,18)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') and valorizacionesestado_id in (4,16,18)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id in (4,16,18)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Notificaciones', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') and valorizacionesestado_id in (11,12)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') and valorizacionesestado_id in (11,12)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id in (11,12)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Enajenación Voluntaria', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') and valorizacionesestado_id in (1)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') and valorizacionesestado_id in (1)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id in (1)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Procesos Expropiación', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') and valorizacionesestado_id in (5,10,9,15,17)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') and valorizacionesestado_id in (5,10,9,15,17)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id in (5,10,9,15,17)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data 'TOTALES', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') and valorizacionesestado_id not in (7,8)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') and valorizacionesestado_id not in (7,8)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id not in (7,8)"]), 'ss:Type' => 'Number' }
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
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 7"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 7"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 7"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 8
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 8)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'LIBERADO EXPROPIADO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 8"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 8"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 8"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 8
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 8)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
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
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 20"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 20"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 20"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 20
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 20)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SOLICITUD CARGUE CATASTRO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 22"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 22"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 22"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id =22
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id =22)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SOLICITUD FICHA PREDIAL', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 24"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 24"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 24"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 24
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 24)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'FICHA PREDIAL EN CORRECCIONES', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 6"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 6"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 6"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 6
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 6)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SIN AVALUO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 19"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 19"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 19"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 19
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 19)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'ACTUALIZACION AVALUO CATASTRO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 2"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 2"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 2"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 2
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 2)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SOLICITUD AVALUO IGAC', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 21"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 21"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 21"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 21
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 21)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'CORRECCION AVALUO IGAC', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 3"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 3"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 3"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 3
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 3)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SOLICITUD CERTIFICADO DE AREAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 23"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 23"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 23"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 23
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 23)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RECONOCIMIENTO DE MEJORAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 14"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 14"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 14"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 14
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 14)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'PENDIENTE PUNTEOS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 13"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 13"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 13"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id =13
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 13)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
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
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 4"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 4"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 4"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 4
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id =4)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RESOLUCION EN FIRMAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 16"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 16"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 16"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 16
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 16)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RESOLUCION POR NOTIFICAR', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 18"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 18"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 18"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 18
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 18)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
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
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 11"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 11"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 11"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 11
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 11)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'NOTIFICADO POR EDICTO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 12"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 12"]), 'ss:Type' => 'Number' }  
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 12"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 12
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 12)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
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
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 9"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 9"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id =9"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 9
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 9)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'NOTIFICADA RESOLUCION EXPROPIACION POR EDICTO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 10"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 10"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 10"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 10
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 10)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'ELABORACION RESOLUCION EXPROPIACION', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 5"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 5"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 5"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 5
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 5)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RESOLUCION DE EXPROPIACION POR NOTIFICAR', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 15"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 15"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 15"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 15
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 15)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RESOLUCION EXPROPIACION EN FIRMAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 17"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 17"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 17"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 17
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 17)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
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
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 1
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 1)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
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
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'SOLICITUD AVALUO' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'SOLICITUD AVALUO' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'SOLICITUD AVALUO' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'ASIGNACION DE SUBSIDIO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'ASIGNACION DE SUBSIDIO' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'ASIGNACION DE SUBSIDIO' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'ASIGNACION DE SUBSIDIO' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'ESCRITURACION', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'ESCRITURACION' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'ESCRITURACION' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'ESCRITURACION' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'PAGOS', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'PAGOS' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'PAGOS' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'PAGOS' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'SOLICITUD CERTIFICADO DE RIESGO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'SOLICITUD CERTIFICADO DE RIESGO' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'SOLICITUD CERTIFICADO DE RIESGO' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'SOLICITUD CERTIFICADO DE RIESGO' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'REMISION BANCO INMOBILIARIO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'REMISION BANCO INMOBILIARIO' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'REMISION BANCO INMOBILIARIO' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'REMISION BANCO INMOBILIARIO' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'SIN DEFINIR OPCION', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda ='VIVIENDA USADA' AND estado_vivienda = 'SIN DEFINIR OPCION' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda ='VIVIENDA USADA' AND estado_vivienda = 'SIN DEFINIR OPCION' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda ='VIVIENDA USADA' AND estado_vivienda = 'SIN DEFINIR OPCION' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
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
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'ASIGNACION DE SUBSIDIO' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'ASIGNACION DE SUBSIDIO' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'ASIGNACION DE SUBSIDIO' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'CIERRE FINANCIERO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'CIERRE FINANCIERO' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'CIERRE FINANCIERO' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'CIERRE FINANCIERO' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'ESCRITURACION', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'ESCRITURACION' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'ESCRITURACION' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'ESCRITURACION' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'POSTULACION', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'POSTULACION' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'POSTULACION' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'POSTULACION' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'SIN DEFINIR OPCION', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'SIN DEFINIR OPCION' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'SIN DEFINIR OPCION' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'SIN DEFINIR OPCION' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
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
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda ='NEGOCIACION DIRECTA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda ='NEGOCIACION DIRECTA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND opcion_vivienda ='NEGOCIACION DIRECTA' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
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
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 25"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 25"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 25"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 25
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 25)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'REASENTAMIENTO INTERNO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL JARDIN','ISLA DE LA FANTASIA') AND valorizacionesestado_id = 26"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND sector in ('EL PORVENIR Y VALLEJUELOS','OLAYA1 Y OLAYA2','MASAVIELLE','LA PLAYITA Y CHORROS') AND valorizacionesestado_id = 26"]), 'ss:Type' => 'Number' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='IGUANA' AND valorizacionesestado_id = 26"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'IGUANA'
                                                                 AND    valorizacionesestado_id = 26
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 26)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
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
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id in (7,8)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Avalúo', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id in (2,3,6,13,14,19,20,21,22,23,24)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Ofertas Compra', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id in (4,16,18)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Notificaciones', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id in (11,12)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Enajenación Voluntaria', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id in (1)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row  do
            xml.Cell { xml.Data 'Procesos Expropiación', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id in (5,10,9,15,17)"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data 'TOTALES', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id not in (7,8)"]), 'ss:Type' => 'Number' }
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
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 7"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 8
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 8)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'LIBERADO EXPROPIADO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 8"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 8
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 8)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
          xml.Cell { xml.Data 'SIN REGISTRO TOPOGRAFICO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 20"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 20
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 20)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SOLICITUD CARGUE CATASTRO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 22"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id =22
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id =22)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SOLICITUD FICHA PREDIAL', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 24"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 24
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 24)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'FICHA PREDIAL EN CORRECCIONES', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 6"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 6
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 6)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SIN AVALUO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 19"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 19
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 19)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'ACTUALIZACION AVALUO CATASTRO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 2"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 2
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 2)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SOLICITUD AVALUO IGAC', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 21"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 21
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 21)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'CORRECCION AVALUO IGAC', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 3"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 3
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 3)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'SOLICITUD CERTIFICADO DE AREAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 23"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 23
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 23)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RECONOCIMIENTO DE MEJORAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 14"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 14
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 14)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'PENDIENTE PUNTEOS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 13"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id =13
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 13)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
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
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 4"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 4
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id =4)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RESOLUCION EN FIRMAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 16"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 16
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 16)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RESOLUCION POR NOTIFICAR', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 18"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 18
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 18)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
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
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 11"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 11
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 11)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'NOTIFICADO POR EDICTO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 12"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 12
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 12)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
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
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id =9"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 9
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 9)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'NOTIFICADA RESOLUCION EXPROPIACION POR EDICTO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 10"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 10
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 10)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'ELABORACION RESOLUCION EXPROPIACION', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 5"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 5
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 5)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RESOLUCION DE EXPROPIACION POR NOTIFICAR', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 15"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 15
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 15)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'RESOLUCION EXPROPIACION EN FIRMAS', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 17"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 17
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 17)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
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
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 1
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 1)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
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
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'SOLICITUD AVALUO' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'ASIGNACION DE SUBSIDIO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'ASIGNACION DE SUBSIDIO' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
        end
        xml.Row do
            xml.Cell { xml.Data 'ESCRITURACION', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'ESCRITURACION' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'PAGOS', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'PAGOS' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'SOLICITUD CERTIFICADO DE RIESGO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'SOLICITUD CERTIFICADO DE RIESGO' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'REMISION BANCO INMOBILIARIO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda  ='VIVIENDA USADA' AND estado_vivienda = 'REMISION BANCO INMOBILIARIO' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'SIN DEFINIR OPCION', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda ='VIVIENDA USADA' AND estado_vivienda = 'SIN DEFINIR OPCION' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
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
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'SOLICITUD AVALUO' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'ASIGNACION DE SUBSIDIO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'ASIGNACION DE SUBSIDIO' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'ESCRITURACION', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'ESCRITURACION' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'PAGOS', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'PAGOS' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'SOLICITUD CERTIFICADO DE RIESGO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'SOLICITUD CERTIFICADO DE RIESGO' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'REMISION BANCO INMOBILIARIO', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'REMISION BANCO INMOBILIARIO' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'SIN DEFINIR OPCION', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda IN ('CANTARES','AURORA','CHAGUALON','HUERTA','MONTANA','NAZARET','TIROL','CASCADA','ALAMOS I','ALAMOS II','HERRADURA III','HUERTA III') AND estado_vivienda = 'SIN DEFINIR OPCION' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
            xml.Cell { xml.Data 'PAGO DE MEJORAS', 'ss:Type' => 'String' }
            xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND opcion_vivienda ='NEGOCIACION DIRECTA' AND valorizacionesestado_id = 1"]), 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
        xml.Row do
          xml.Cell { xml.Data 'OCUPACION IRREGULAR', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 25"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 25
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 25)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
        xml.Row do
          xml.Cell { xml.Data 'REASENTAMIENTO INTERNO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data Valorizacion.count(:conditions => [" proyecto='MORAVIA' AND valorizacionesestado_id = 26"]), 'ss:Type' => 'Number' }
          @valorizacionesestadosnotas = Valorizacionesestadosnota.find_by_sql("select observaciones
                                                                 from   valorizacionesestadosnotas
                                                                 where  proyecto = 'MORAVIA'
                                                                 AND    valorizacionesestado_id = 26
                                                                 and    created_at = (select max(created_at)
                                                                                      from valorizacionesestadosnotas
                                                                                      where valorizacionesestado_id = 26)")
          @valorizacionesestadosnotas.each do |valorizacionesestadosnota|
            xml.Cell { xml.Data valorizacionesestadosnota.observaciones, 'ss:Type' => 'String' }
          end
        end
      end
  end
end
