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
#   Inicio Pestaña 1 - Tipo de Proceso
#   ***************************************************************

  xml.Worksheet 'ss:Name' => 'Tipo Proceso - Estado' do
    xml.Table do

      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Reporte por Tipo de Proceso', 'ss:Type' => 'String' }
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
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fallo Primera Instancia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'En Segunda Instancia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fallo Primera Instancia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'En Segunda Instancia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fallo Primera Instancia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'En Segunda Instancia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end
     xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Tipo Proceso', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cantidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Absuelve', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2 - Absuelve', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2 - Condena Total', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2 - Condena Parcial', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Condena Total', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2 - Absuelve', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2 - Condena Total', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2 - Condena Parcial', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Condena Parcial', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2 - Absuelve', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2 - Condena Total', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '2 - Condena Parcial', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'PENDIENTES', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Año', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Poblacion', 'ss:Type' => 'String' }
      end
      procesosjuridico = Procesosjuridico.find(:all,
                                           :select => 'tiposproceso_id, count(*) count',
                                           :group => 'tiposproceso_id',
                                           :order => 'tiposproceso_id')
      procesosjuridico.each do |data|
        cant1absuelve = Procesosetapa.count(:conditions => [' procesosjuridico_id in (select id from procesosjuridicos where tiposproceso_id = ?) and etapasproceso_id = 10012 and estado = ? and firmeza_fallo != ?' , "#{data.tiposproceso_id}", "1", "1"])
        cant1absuelvecant2absuelve = Procesosetapa.count(:conditions => [' procesosjuridico_id in (select procesosjuridico_id
                                                                                  from   procesosetapas
                                                                                  where  procesosjuridico_id in (select id
                                                                                                                 from   procesosjuridicos
                                                                                                                 where  tiposproceso_id = ?)
                                                                                  and etapasproceso_id = 10012
                                                                                  and estado = ?
                                                                                  and firmeza_fallo != ?)
                                                                           and procesosjuridico_id in (select id from procesosjuridicos where tiposproceso_id = ?) and etapasproceso_id = 10013 and estado = ?  and firmeza_fallo != ? ' , "#{data.tiposproceso_id}", "1", "1","#{data.tiposproceso_id}", "1", "1"])
        cant1absuelvecant2condenatotal = Procesosetapa.count(:conditions => [' procesosjuridico_id in (select procesosjuridico_id
                                                                                  from   procesosetapas
                                                                                  where  procesosjuridico_id in (select id
                                                                                                                 from   procesosjuridicos
                                                                                                                 where  tiposproceso_id = ?)
                                                                                  and etapasproceso_id = 10012
                                                                                  and estado = ?
                                                                                  and firmeza_fallo != ?)
                                                                           and procesosjuridico_id in (select id from procesosjuridicos where tiposproceso_id = ?) and etapasproceso_id = 10013 and estado = ?  and firmeza_fallo != ? ' , "#{data.tiposproceso_id}", "1", "1","#{data.tiposproceso_id}", "2", "1"])
        cant1absuelvecant2condenaparcial = Procesosetapa.count(:conditions => [' procesosjuridico_id in (select procesosjuridico_id
                                                                                  from   procesosetapas
                                                                                  where  procesosjuridico_id in (select id
                                                                                                                 from   procesosjuridicos
                                                                                                                 where  tiposproceso_id = ?)
                                                                                  and etapasproceso_id = 10012
                                                                                  and estado = ?
                                                                                  and firmeza_fallo != ?)
                                                                           and procesosjuridico_id in (select id from procesosjuridicos where tiposproceso_id = ?) and etapasproceso_id = 10013 and estado = ?  and firmeza_fallo != ? ' , "#{data.tiposproceso_id}", "1", "1","#{data.tiposproceso_id}", "3", "1"])
        cant1condenatotal = Procesosetapa.count(:conditions => [' procesosjuridico_id in (select id from procesosjuridicos where tiposproceso_id = ?) and etapasproceso_id = 10012 and estado = ?  and firmeza_fallo != ?' , "#{data.tiposproceso_id}", "2", "1"])
        cant1condenatotalcant2absuelve = Procesosetapa.count(:conditions => [' procesosjuridico_id in (select procesosjuridico_id
                                                                                  from   procesosetapas
                                                                                  where  procesosjuridico_id in (select id
                                                                                                                 from   procesosjuridicos
                                                                                                                 where  tiposproceso_id = ?)
                                                                                  and etapasproceso_id = 10012
                                                                                  and estado = ?
                                                                                  and firmeza_fallo != ?)
                                                                           and procesosjuridico_id in (select id from procesosjuridicos where tiposproceso_id = ?) and etapasproceso_id = 10013 and estado = ?  and firmeza_fallo != ? ' , "#{data.tiposproceso_id}", "2", "1","#{data.tiposproceso_id}", "1", "1"])
        cant1condenatotalcant2condenatotal = Procesosetapa.count(:conditions => [' procesosjuridico_id in (select procesosjuridico_id
                                                                                  from   procesosetapas
                                                                                  where  procesosjuridico_id in (select id
                                                                                                                 from   procesosjuridicos
                                                                                                                 where  tiposproceso_id = ?)
                                                                                  and etapasproceso_id = 10012
                                                                                  and estado = ?
                                                                                  and firmeza_fallo != ?)
                                                                           and procesosjuridico_id in (select id from procesosjuridicos where tiposproceso_id = ?) and etapasproceso_id = 10013 and estado = ?  and firmeza_fallo != ? ' , "#{data.tiposproceso_id}", "2", "1","#{data.tiposproceso_id}", "2", "1"])
        cant1condenatotalcant2condenaparcial = Procesosetapa.count(:conditions => [' procesosjuridico_id in (select procesosjuridico_id
                                                                                  from   procesosetapas
                                                                                  where  procesosjuridico_id in (select id
                                                                                                                 from   procesosjuridicos
                                                                                                                 where  tiposproceso_id = ?)
                                                                                  and etapasproceso_id = 10012
                                                                                  and estado = ?
                                                                                  and firmeza_fallo != ?)
                                                                           and procesosjuridico_id in (select id from procesosjuridicos where tiposproceso_id = ?) and etapasproceso_id = 10013 and estado = ?  and firmeza_fallo != ? ' , "#{data.tiposproceso_id}", "2", "1","#{data.tiposproceso_id}", "3", "1"])

        cant1condenaparcial = Procesosetapa.count(:conditions => [' procesosjuridico_id in (select id from procesosjuridicos where tiposproceso_id = ?) and etapasproceso_id = 10012 and estado = ?  and firmeza_fallo != ?' , "#{data.tiposproceso_id}", "3", "1"])
        cant1condenaparcialcant2absuelve = Procesosetapa.count(:conditions => [' procesosjuridico_id in (select procesosjuridico_id
                                                                                  from   procesosetapas
                                                                                  where  procesosjuridico_id in (select id
                                                                                                                 from   procesosjuridicos
                                                                                                                 where  tiposproceso_id = ?)
                                                                                  and etapasproceso_id = 10012
                                                                                  and estado = ?
                                                                                  and firmeza_fallo != ?)
                                                                           and procesosjuridico_id in (select id from procesosjuridicos where tiposproceso_id = ?) and etapasproceso_id = 10013 and estado = ?  and firmeza_fallo != ? ' , "#{data.tiposproceso_id}", "3", "1","#{data.tiposproceso_id}", "1", "1"])
        cant1condenaparcialcant2condenatotal = Procesosetapa.count(:conditions => [' procesosjuridico_id in (select procesosjuridico_id
                                                                                  from   procesosetapas
                                                                                  where  procesosjuridico_id in (select id
                                                                                                                 from   procesosjuridicos
                                                                                                                 where  tiposproceso_id = ?)
                                                                                  and etapasproceso_id = 10012
                                                                                  and estado = ?
                                                                                  and firmeza_fallo != ?)
                                                                           and procesosjuridico_id in (select id from procesosjuridicos where tiposproceso_id = ?) and etapasproceso_id = 10013 and estado = ?  and firmeza_fallo != ? ' , "#{data.tiposproceso_id}", "3", "1","#{data.tiposproceso_id}", "2", "1"])
        cant1condenaparcialcant2condenaparcial = Procesosetapa.count(:conditions => [' procesosjuridico_id in (select procesosjuridico_id
                                                                                  from   procesosetapas
                                                                                  where  procesosjuridico_id in (select id
                                                                                                                 from   procesosjuridicos
                                                                                                                 where  tiposproceso_id = ?)
                                                                                  and etapasproceso_id = 10012
                                                                                  and estado = ?
                                                                                  and firmeza_fallo != ?)
                                                                           and procesosjuridico_id in (select id from procesosjuridicos where tiposproceso_id = ?) and etapasproceso_id = 10013 and estado = ?  and firmeza_fallo != ? ' , "#{data.tiposproceso_id}", "3", "1","#{data.tiposproceso_id}", "3", "1"])

        pendientes = data.count - (cant1absuelve + cant1condenatotal+cant1condenaparcial)
        cadenaanno = ""
        annoradicado = Procesosjuridico.find(:all,
                                           :select => 'anno_radicado, count(*) count',
                                           :group => 'anno_radicado',
                                           :conditions => [' tiposproceso_id = ?', data.tiposproceso_id],
                                           :order => 'anno_radicado')
        annoradicado.each do |data2|
          if data2.anno_radicado.to_s != ""
            annorad = data2.anno_radicado.to_s
          else
            annorad = "SIN AÑO"
          end
          cadenaanno = cadenaanno + annorad + ' : ' + data2.count.to_s + ' - '
        end
        cadenapoblacion = ""
        poblacion = Procesosjuridico.find(:all,
                                          :select => 'poblacionesespecial_id, count(*) count',
                                          :group => 'poblacionesespecial_id',
                                          :conditions => [' tiposproceso_id = ?', data.tiposproceso_id],
                                          :order => 'poblacionesespecial_id')
        poblacion.each do |data3|
          if data3.poblacionesespecial_id.to_s != ""
            poblacionespecial = Poblacionesespecial.find(data3.poblacionesespecial_id).descripcion
          else
            poblacionespecial = "SIN POBLACION ASIGNADA"
          end
          cadenapoblacion = cadenapoblacion + poblacionespecial + ' : ' + data3.count.to_s + ' - '
        end
        xml.Row do
          if data.tiposproceso_id.to_s != ""
            xml.Cell { xml.Data data.tiposproceso.descripcion, 'ss:Type' => 'String' }
          else
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          end
            xml.Cell { xml.Data data.count, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant1absuelve, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant1absuelvecant2absuelve, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant1absuelvecant2condenatotal, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant1absuelvecant2condenaparcial, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant1condenatotal, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant1condenatotalcant2absuelve, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant1condenatotalcant2condenatotal, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant1condenatotalcant2condenaparcial, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant1condenaparcial, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant1condenaparcialcant2absuelve, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant1condenaparcialcant2condenatotal, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant1condenaparcialcant2condenaparcial, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data pendientes, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cadenaanno, 'ss:Type' => 'String' }
            xml.Cell { xml.Data cadenapoblacion, 'ss:Type' => 'String' }
        end
      end
    end
  end

#   ***************************************************************
#   Inicio Pestaña 2 - Informacion Total
#   ***************************************************************

  xml.Worksheet 'ss:Name' => 'Informacion Procesos' do
    xml.Table do

      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Informacion Completa Procesos', 'ss:Type' => 'String' }
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
          xml.Cell { xml.Data 'Etapa Proceso', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end                      

      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'ID', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tipo Proceso', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nro Radicado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Año Radicado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Juzgado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Demandante', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Demandado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tema', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'SubTema', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Poblacion Especial', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Observaciones Proceso', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Pretension', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cuantia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Etapa del Proceso', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Actuacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Observacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Resultado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cumplimiento Fallo', 'ss:Type' => 'String' }
      end
      procesosjuridico = Procesosjuridico.find(:all)
      procesosjuridico.each do |data|
        xml.Row do
          xml.Cell { xml.Data data.id, 'ss:Type' => 'String' }
          if data.tiposproceso_id.to_s != ""
            xml.Cell { xml.Data data.tiposproceso.descripcion, 'ss:Type' => 'String' }
          else
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          end
            xml.Cell { xml.Data data.nro_radicado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data data.anno_radicado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data data.juzgado, 'ss:Type' => 'String' }
            if data.demandante
              xml.Cell { xml.Data data.demandante, 'ss:Type' => 'String' }
            else
              datosdemandante = ""
              procesospersonas = Procesospersona.find_all_by_procesosjuridico_id(data.id)
              procesospersonas.each do |procesospersona|
                @persona = Persona.find(procesospersona.persona_id)
                if datosdemandante.to_s == ""
                  datosdemandante = @persona.autobuscar.to_s
                else
                  datosdemandante = datosdemandante + " - " + @persona.autobuscar.to_s
                end
              end
              xml.Cell { xml.Data datosdemandante, 'ss:Type' => 'String' }
            end
            xml.Cell { xml.Data data.demandado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data data.etapa, 'ss:Type' => 'String' }
            xml.Cell { xml.Data data.subetapa, 'ss:Type' => 'String' }
          if data.poblacionesespecial_id.to_s != ""
            xml.Cell { xml.Data data.poblacionesespecial.descripcion, 'ss:Type' => 'String' }
          else
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          end
            xml.Cell { xml.Data data.observacion_proceso, 'ss:Type' => 'String' }
            xml.Cell { xml.Data data.pretension, 'ss:Type' => 'String' }
            xml.Cell { xml.Data data.cuantia, 'ss:Type' => 'String' }
            xml.Cell { xml.Data data.estado, 'ss:Type' => 'String' }
            procesosetapa = Procesosetapa.find(:all, :conditions=>[ 'procesosjuridico_id = ?  and fecha_actuacion = (select max(fecha_actuacion) from procesosetapas where procesosjuridico_id = ?)',data.id,data.id])
            procesosetapa.each do |data1|
              if data1.etapasproceso_id.to_s != ""
                xml.Cell { xml.Data data1.etapasproceso.descripcion, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data1.fecha_actuacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.observaciones, 'ss:Type' => 'String' }
              if data1.estado.to_s != ""
                xml.Cell { xml.Data data1.destado, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              end
              if data1.firmeza_fallo.to_s != ""
                xml.Cell { xml.Data data1.dfirmeza, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data1.cumplimiento_fallo, 'ss:Type' => 'String' }
            end
        end
      end
    end
  end

#   ***************************************************************
#   Inicio Pestaña 3 - Informacion Primera y Segunda Instancia
#   ***************************************************************

  xml.Worksheet 'ss:Name' => 'Primera y Segunda Inst.' do
    xml.Table do

      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Informacion Completa Procesos', 'ss:Type' => 'String' }
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
          xml.Cell { xml.Data 'Informacion Primera Instancia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Informacion Segunda Instancia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end

      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'ID', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tipo Proceso', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nro Radicado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Año Radicado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Juzgado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Demandante', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Demandado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tema', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'SubTema', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Poblacion Especial', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Observaciones Proceso', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Pretension', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cuantia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Etapa del Proceso', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Actuacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Observacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Resultado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estado Fallo', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cumplimiento Fallo', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Etapa del Proceso', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Actuacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Observacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Resultado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estado Fallo', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cumplimiento Fallo', 'ss:Type' => 'String' }
      end
      procesosjuridico = Procesosjuridico.find(:all)
      procesosjuridico.each do |data|
        xml.Row do
          xml.Cell { xml.Data data.id, 'ss:Type' => 'String' }
          if data.tiposproceso_id.to_s != ""
            xml.Cell { xml.Data data.tiposproceso.descripcion, 'ss:Type' => 'String' }
          else
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          end
          xml.Cell { xml.Data data.nro_radicado, 'ss:Type' => 'String' }
          xml.Cell { xml.Data data.anno_radicado, 'ss:Type' => 'String' }
          xml.Cell { xml.Data data.juzgado, 'ss:Type' => 'String' }
          if data.demandante
              xml.Cell { xml.Data data.demandante, 'ss:Type' => 'String' }
          else
            datosdemandante = ""
            procesospersonas = Procesospersona.find_all_by_procesosjuridico_id(data.id)
            procesospersonas.each do |procesospersona|
              @persona = Persona.find(procesospersona.persona_id)
              if datosdemandante.to_s == ""
                datosdemandante = @persona.autobuscar.to_s
              else
                datosdemandante = datosdemandante + " - " + @persona.autobuscar.to_s
              end
            end
            xml.Cell { xml.Data datosdemandante, 'ss:Type' => 'String' }
          end
          xml.Cell { xml.Data data.demandado, 'ss:Type' => 'String' }
          xml.Cell { xml.Data data.etapa, 'ss:Type' => 'String' }
          xml.Cell { xml.Data data.subetapa, 'ss:Type' => 'String' }
          if data.poblacionesespecial_id.to_s != ""
            xml.Cell { xml.Data data.poblacionesespecial.descripcion, 'ss:Type' => 'String' }
          else
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          end
          xml.Cell { xml.Data data.observacion_proceso, 'ss:Type' => 'String' }
          xml.Cell { xml.Data data.pretension, 'ss:Type' => 'String' }
          xml.Cell { xml.Data data.cuantia, 'ss:Type' => 'String' }
          xml.Cell { xml.Data data.estado, 'ss:Type' => 'String' }
          ingreso = ""
          procesosetapa = Procesosetapa.find(:all, :conditions=>[ 'procesosjuridico_id = ?  and etapasproceso_id = 10012 and firmeza_fallo != ?',data.id,"1"])
          procesosetapa.each do |data1|
            ingreso = "S"
            if data1.etapasproceso_id.to_s != ""
              xml.Cell { xml.Data data1.etapasproceso.descripcion, 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            end
            xml.Cell { xml.Data data1.fecha_actuacion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data data1.observaciones, 'ss:Type' => 'String' }
            if data1.estado.to_s != ""
              xml.Cell { xml.Data data1.destado, 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            end
            if data1.firmeza_fallo.to_s != ""
              xml.Cell { xml.Data data1.dfirmeza, 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            end
            xml.Cell { xml.Data data1.cumplimiento_fallo, 'ss:Type' => 'String' }
          end
          if ingreso == ""
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          end
          procesosetapa = Procesosetapa.find(:all, :conditions=>[ 'procesosjuridico_id = ?  and etapasproceso_id = 10013 and firmeza_fallo != ?',data.id,"1"])
          procesosetapa.each do |data1|
            if data1.etapasproceso_id.to_s != ""
              xml.Cell { xml.Data data1.etapasproceso.descripcion, 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            end
            xml.Cell { xml.Data data1.fecha_actuacion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data data1.observaciones, 'ss:Type' => 'String' }
            if data1.estado.to_s != ""
              xml.Cell { xml.Data data1.destado, 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            end
            if data1.firmeza_fallo.to_s != ""
              xml.Cell { xml.Data data1.dfirmeza, 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            end
            xml.Cell { xml.Data data1.cumplimiento_fallo, 'ss:Type' => 'String' }
          end
        end
      end
    end
  end

end