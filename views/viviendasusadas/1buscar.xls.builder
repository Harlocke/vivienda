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

#   ***************************************************************
#   Inicio Pestaña 1 - Tipo de Poblacion
#   ***************************************************************

  xml.Worksheet 'ss:Name' => 'Tipo Poblacion - Estado' do
    xml.Table do

      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Reporte por Tipo de Poblacion - Estado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Tipo Poblacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cantidad', 'ss:Type' => 'String' }
      end

      cadena = ""
      if @buscadorpoblacion.to_s != ""
        if cadena != ""
          cadena = cadena + ' and tipospoblacion_id = ' + @buscadorpoblacion.to_s
        else
          cadena = ' tipospoblacion_id = ' + @buscadorpoblacion.to_s
        end
      end
      if @buscadorestado.to_s != ""
        if cadena != ""
          cadena = cadena + ' and viviendasusadasestado_id = ' + @buscadorestado.to_s
        else
          cadena = ' viviendasusadasestado_id = ' + @buscadorestado.to_s
        end
      end
      viviendasusada = Viviendasusada.find(:all,
                                           :select => 'tipospoblacion_id, viviendasusadasestado_id, count(*) count',
                                           :group => 'tipospoblacion_id, viviendasusadasestado_id',
                                           :conditions => [cadena],
                                           :order => 'tipospoblacion_id, viviendasusadasestado_id')
      viviendasusada.each do |data|
        xml.Row do
            if data.tipospoblacion_id.nil? == false
              xml.Cell { xml.Data data.tipospoblacion.descripcion, 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data '*** SIN POBLACION', 'ss:Type' => 'String' }
            end
            if data.viviendasusadasestado_id.nil? == false
              xml.Cell { xml.Data data.viviendasusadasestado.descripcion, 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data '*** SIN ESTADO', 'ss:Type' => 'String' }
            end
            xml.Cell { xml.Data data.count, 'ss:Type' => 'Number' }
        end
      end
    end
  end

#   ***************************************************************
#   FIN Pestaña 1 - Tipo de Poblacion
#   ***************************************************************

#   ***************************************************************
#   INICIO Pestaña 2 - Pagos
#   ***************************************************************

xml.Worksheet 'ss:Name' => 'Pagos' do
    xml.Table do

      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Reporte por Tipo de Poblacion - Pago', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Tipo Poblacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tipo de pago', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cantidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Total Pagado', 'ss:Type' => 'String' }
      end
      cadena = ""
      if @buscadorpoblacion.to_s != ""
        if cadena != ""
          cadena = cadena + ' and tipospoblacion_id = ' + @buscadorpoblacion.to_s
        else
          cadena = ' tipospoblacion_id = ' + @buscadorpoblacion.to_s
        end
      end
      viviendasusada = Viviendasusada.find(:all,
                                           :select => 'tipospoblacion_id ',
                                           :group => 'tipospoblacion_id',
                                           :conditions => [cadena],
                                           :order => 'tipospoblacion_id')
      viviendasusada.each do |data|
        cant1 = Viviendasusadaspago.count(:conditions => [' tipo_pago = ? and viviendasusada_id in (select id from viviendasusadas where tipospoblacion_id = ?) ', 'PAGO ISVIMED', "#{data.tipospoblacion_id}"])
        cantValor1 = Viviendasusadaspago.sum('valor', :conditions => [' tipo_pago = ? and viviendasusada_id in (select id from viviendasusadas where tipospoblacion_id = ?) ', 'PAGO ISVIMED', "#{data.tipospoblacion_id}"])
        xml.Row do
           if data.tipospoblacion_id.nil? == false
              xml.Cell { xml.Data data.tipospoblacion.descripcion, 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data '*** SIN POBLACION', 'ss:Type' => 'String' }
            end
            xml.Cell { xml.Data 'PAGO ISVIMED', 'ss:Type' => 'String' }
            xml.Cell { xml.Data cant1, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cantValor1, 'ss:Type' => 'Number' }
        end
        cant2 = Viviendasusadaspago.count(:conditions => [' tipo_pago = ? and viviendasusada_id in (select id from viviendasusadas where tipospoblacion_id = ?) ', 'PAGO IDEA', "#{data.tipospoblacion_id}"])
        cantValor2 = Viviendasusadaspago.sum('valor', :conditions => [' tipo_pago = ? and viviendasusada_id in (select id from viviendasusadas where tipospoblacion_id = ?) ', 'PAGO IDEA', "#{data.tipospoblacion_id}"])
        xml.Row do
            if data.tipospoblacion_id.nil? == false
              xml.Cell { xml.Data data.tipospoblacion.descripcion, 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data '*** SIN POBLACION', 'ss:Type' => 'String' }
            end
            xml.Cell { xml.Data 'PAGO IDEA', 'ss:Type' => 'String' }
            xml.Cell { xml.Data cant2, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cantValor2, 'ss:Type' => 'Number' }
        end
      end
      
    end
end

#   ***************************************************************
#   FIN Pestaña 2 - Pagos
#   ***************************************************************

#   ***************************************************************
#   INICIO Pestaña 3 - Tramites
#   ***************************************************************

#xml.Worksheet 'ss:Name' => 'Tramites' do
#    xml.Table do
#      # Header
#      xml.Row 'ss:StyleID' => 'header' do
#          xml.Cell { xml.Data 'Reporte por Tramites', 'ss:Type' => 'String' }
#          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
#          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
#          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
#          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
#          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
#          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
#          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
#      end
#      xml.Row 'ss:StyleID' => 'header' do
#          xml.Cell { xml.Data 'Id Predio', 'ss:Type' => 'String' }
#          xml.Cell { xml.Data 'Tipo Poblacion', 'ss:Type' => 'String' }
#          xml.Cell { xml.Data 'Beneficiario', 'ss:Type' => 'String' }
#          xml.Cell { xml.Data 'Tramite', 'ss:Type' => 'String' }
#          xml.Cell { xml.Data 'Fecha Tramite', 'ss:Type' => 'String' }
#          xml.Cell { xml.Data 'Rojo', 'ss:Type' => 'String' }
#          xml.Cell { xml.Data 'Verde', 'ss:Type' => 'String' }
#          xml.Cell { xml.Data 'Amarillo', 'ss:Type' => 'String' }
#      end
#      for viviendasusada in @viviendasusadas
#        viviendasusadastramite = Viviendasusadastramite.find_all_by_viviendasusada_id(viviendasusada.id)
#        viviendasusadastramite.each do |data|
#          if (data.fecha_recibido.to_s == "")
#            if (data.fecha_solicitud.to_s != "")
#              segundos = (Time.now - data.fecha_solicitud).to_i
#              minutos  = (segundos/60).to_i #es el nÃºmero total de minutos
#              horas    = (minutos/60).to_i #nÃºmero total de horas
#              dias     = (horas/24).to_i # nÃºmero total de dÃ­as
#              if (dias <= data.tipostramite.tiempo )
#                bandverde = "X"
#              elsif (dias > data.tipostramite.tiempo and dias <= (data.tipostramite.tiempo+2) )
#                bandamarillo = "X"
#              else
#                bandrojo = "X"
#              end
#            end
#            nombrepersona = ""
#            viviendasusadaspersona = Viviendasusadaspersona.find_all_by_viviendasusada_id(viviendasusada.id)
#            viviendasusadaspersona.each do |data2|
#              nombrepersona = data2.persona.autobuscar
#            end
#            xml.Row do
#                xml.Cell { xml.Data viviendasusada.id, 'ss:Type' => 'String' }
#                if viviendasusada.tipospoblacion_id.nil? == false
#                  xml.Cell { xml.Data viviendasusada.tipospoblacion.descripcion, 'ss:Type' => 'String' }
#                else
#                  xml.Cell { xml.Data '*** SIN POBLACION', 'ss:Type' => 'String' }
#                end
#                xml.Cell { xml.Data nombrepersona, 'ss:Type' => 'String' }
#                xml.Cell { xml.Data data.tipostramite.descripcion, 'ss:Type' => 'String' }
#                xml.Cell { xml.Data data.fecha_solicitud, 'ss:Type' => 'String' }
#                xml.Cell { xml.Data bandrojo, 'ss:Type' => 'String' }
#                xml.Cell { xml.Data bandverde, 'ss:Type' => 'String' }
#                xml.Cell { xml.Data bandamarillo, 'ss:Type' => 'String' }
#            end
#          end
#        end
#      end
#    end
#  end

#   ***************************************************************
#   FIN Pestaña 3 - Tramites
#   ***************************************************************

#   ***************************************************************
#   Inicio Pestaña 4 - Totalidad
#   ***************************************************************

  xml.Worksheet 'ss:Name' => 'Inf. Completo' do
    xml.Table do

      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Reporte por Poblacion', 'ss:Type' => 'String' }
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
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Id', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tipo Poblacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Proyecto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Sector', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Recepcion Documentos', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Direccion EEPP', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Direccion Catastro', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Beneficiario(s)', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Telefono(s)', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Direccion Vivienda Reposicion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Matricula Vivienda Reposicion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Resultado Concepto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Visita Tecnica', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nro Compromiso', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nro Resolucion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nro Escritura', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Elaboracion Escritura', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Recibido Escritura', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Registrada Escritura', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Resultado Estudio de Titulos', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Inicio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Final', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tiempo Empleado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Demora', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Vendedor', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Modo Adquisicion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Vivienda', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Vivienda Entregada?', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Desiste por?', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tramite', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Tramite', 'ss:Type' => 'String' }
      end

      for viviendasusada in @viviendasusadas
        nombrepersona = ""
        telefonosper = ""
        viviendasusadaspersona = Viviendasusadaspersona.find_all_by_viviendasusada_id(viviendasusada.id)
        viviendasusadaspersona.each do |data2|
          nombrepersona = nombrepersona + data2.persona.autobuscar.to_s
          telefonosper = telefonosper + data2.persona.telefonos.to_s
        end
        xml.Row do
            xml.Cell { xml.Data viviendasusada.id, 'ss:Type' => 'String' }
            if viviendasusada.tipospoblacion_id.to_s != ""
              xml.Cell { xml.Data viviendasusada.tipospoblacion.descripcion, 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            end
            xml.Cell { xml.Data viviendasusada.proyecto, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.sector, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.fecha_recibido_doc, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.direccion_eepp, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.direccion_catastro, 'ss:Type' => 'String' }
            xml.Cell { xml.Data nombrepersona, 'ss:Type' => 'String' }
            xml.Cell { xml.Data telefonosper, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.direccion_vivreposicion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.matricula_vivreposicion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.resultado_concepto, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.fecha_visita_tecnica, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.nro_compromiso, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.nro_resolucion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.escritura_nro, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.escritura_elaboracion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.escritura_recibido, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.escritura_registrada, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.resultado_estudio, 'ss:Type' => 'String' }
            if viviendasusada.viviendasusadasestado_id.to_s != ""
              xml.Cell { xml.Data viviendasusada.viviendasusadasestado.descripcion, 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            end
            xml.Cell { xml.Data viviendasusada.created_at, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.fecha_final, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.tiempo_empleado, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data viviendasusada.demora, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data viviendasusada.nombre_vendedor, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.modo_adquisicion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.valor_vivienda, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data viviendasusada.entregada, 'ss:Type' => 'String' }
            xml.Cell { xml.Data viviendasusada.desiste, 'ss:Type' => 'String' }
#            viviendasusadastramite = Viviendasusadastramite.find_all_by_viviendasusada_id(viviendasusada.id)
#            viviendasusadastramite.each do |data|
#          if (data.fecha_recibido.to_s == "")
#            if (data.fecha_solicitud.to_s != "")
#              segundos = (Time.now - data.fecha_solicitud).to_i
#              minutos  = (segundos/60).to_i #es el nÃºmero total de minutos
#              horas    = (minutos/60).to_i #nÃºmero total de horas
#              dias     = (horas/24).to_i # nÃºmero total de dÃ­as
#              if (dias <= data.tipostramite.tiempo )
#                bandverde = "X"
#              elsif (dias > data.tipostramite.tiempo and dias <= (data.tipostramite.tiempo+2) )
#                bandamarillo = "X"
#              else
#                bandrojo = "X"
#              end
#            end
#            nombrepersona = ""
#            viviendasusadaspersona = Viviendasusadaspersona.find_all_by_viviendasusada_id(viviendasusada.id)
#            viviendasusadaspersona.each do |data2|
#              nombrepersona = data2.persona.autobuscar
#            end
#            xml.Row do
#                xml.Cell { xml.Data viviendasusada.id, 'ss:Type' => 'String' }
#                if viviendasusada.tipospoblacion_id.nil? == false
#                  xml.Cell { xml.Data viviendasusada.tipospoblacion.descripcion, 'ss:Type' => 'String' }
#                else
#                  xml.Cell { xml.Data '*** SIN POBLACION', 'ss:Type' => 'String' }
#                end
#                xml.Cell { xml.Data nombrepersona, 'ss:Type' => 'String' }
#                xml.Cell { xml.Data data.tipostramite.descripcion, 'ss:Type' => 'String' }
#                xml.Cell { xml.Data data.fecha_solicitud, 'ss:Type' => 'String' }
#                xml.Cell { xml.Data bandrojo, 'ss:Type' => 'String' }
#                xml.Cell { xml.Data bandverde, 'ss:Type' => 'String' }
#                xml.Cell { xml.Data bandamarillo, 'ss:Type' => 'String' }
#            end
#          end
#        end
#      end





        end
      end
    end
  end

#   ***************************************************************
#   FIN Pestaña 4 - Informacion Completa
#   ***************************************************************

end