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


  xml.Worksheet 'ss:Name' => 'Informacion Pagos Iguana' do
    xml.Table do

      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Información Vivienda', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Nro Predio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Sector', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Encuesta', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Comuna', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Barrio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Manzana', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Lote', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Interior', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Disponibilidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Matricula', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Direccion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Demolido', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Aplica Subsidio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Reasentado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Opcion Vivienda', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Personas Identificacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Personas Nombres', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Total Pagos', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Saldo Pagos', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Compensacion Economica', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Pagado Compensacion Economica', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Saldo Compensacion Economica', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Compensacion Traslado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Pagado Compensacion Traslado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Saldo Compensacion Traslado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Compensacion Tramites Legales', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Pagado Compensacion Tramites Legales', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Saldo Compensacion Tramites Legales', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Avaluo', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Pagado Avaluo', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Saldo Avaluo', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Compensacion Arrendatario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Pagado Compensacion Arrendatario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Saldo Compensacion Arrendatario', 'ss:Type' => 'String' }
      end
      # Rows
      valortotal = 0
      saldoeconomica = 0
      saldotraslado = 0
      saldotramites = 0
      saldoavaluo = 0
      saldoarrendatario = 0
      sumsaldoeconomica = 0
      sumsaldotraslado = 0
      sumsaldotramites = 0
      sumsaldoavaluo = 0
      sumsaldoarrendatario = 0
      saldototal = 0
      for iguana in @iguanas
        sumsaldoeconomica = Iguanaspago.sum('valor', :conditions => ["iguana_id = ? and tipo = ? and estado = 'PAGADO'", iguana.id, 'E'])
        sumsaldotraslado = Iguanaspago.sum('valor', :conditions => ["iguana_id = ? and tipo = ? and estado = 'PAGADO'", iguana.id, 'T'])
        sumsaldotramites = Iguanaspago.sum('valor', :conditions => ["iguana_id = ? and tipo = ? and estado = 'PAGADO'", iguana.id, 'L'])
        sumsaldoavaluo = Iguanaspago.sum('valor', :conditions => ["iguana_id = ? and tipo = ? and estado = 'PAGADO'", iguana.id, 'A'])
        sumsaldoarrendatario = Iguanaspago.sum('valor', :conditions => ["iguana_id = ? and tipo = ? and estado = 'PAGADO'", iguana.id, 'R'])
        valortotal = iguana.valor_compensacion.to_i + iguana.valor_traslado.to_i + iguana.valor_tramites.to_i + iguana.valor_avaluo.to_i + iguana.valor_arrendatario.to_i
        saldoeconomica = iguana.valor_compensacion.to_i - sumsaldoeconomica.to_i
        saldotraslado = iguana.valor_traslado.to_i - sumsaldotraslado.to_i
        saldotramites = iguana.valor_tramites.to_i - sumsaldotramites.to_i
        saldoavaluo = iguana.valor_avaluo.to_i - sumsaldoavaluo.to_i
        saldoarrendatario = iguana.valor_arrendatario.to_i - sumsaldoarrendatario.to_i
        saldototal = saldoeconomica + saldotraslado + saldotramites + saldoavaluo + saldoarrendatario
        xml.Row do
            xml.Cell { xml.Data iguana.nro_registro, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.sector, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.encuesta, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.comuna, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.barrio, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.manzana, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.lote, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.interior, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.disponibilidad, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.matricula, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.direccion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.demolido, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.aplica_subsidio, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.reasentado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguana.opcion_vivienda, 'ss:Type' => 'String' }
            cadena = ""
            contador = 0
            cadenaidentificacion = ""
            @iguanaspersonas = Iguanaspersona.find_all_by_iguana_id(iguana.id);
            for iguanaspersona in @iguanaspersonas
              persona  = Persona.find(iguanaspersona.persona_id);
              if contador == 0
                  cadenaidentificacion = persona.identificacion
                  contador = contador  +  1
              end
              if cadena != ""
                cadena = cadena + ' - ' + persona.autobuscar
              else
                cadena = persona.autobuscar
              end
            end
            xml.Cell { xml.Data cadenaidentificacion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data cadena, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valortotal, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data saldototal, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data iguana.valor_compensacion.to_i, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sumsaldoeconomica, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data saldoeconomica, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data iguana.valor_traslado.to_i, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sumsaldotraslado, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data saldotraslado, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data iguana.valor_tramites.to_i, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sumsaldotramites, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data saldotramites, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data iguana.valor_avaluo.to_i, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sumsaldoavaluo, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data saldoavaluo, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data iguana.valor_arrendatario.to_i, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sumsaldoarrendatario, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data saldoarrendatario, 'ss:Type' => 'Number' }
        end
      end
    end
  end

# Informe de pagos Exclusivamente
xml.Worksheet 'ss:Name' => 'Pagos IGUANA' do
    xml.Table do

      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Información Vivienda', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Nro Predio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Personas Identificacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Personas Nombres', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tipo de Pago', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor ', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Solicitud', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Desembolso', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Convenio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Rubro', 'ss:Type' => 'String' }
      end
      # Rows
      @iguanaspagos = Iguanaspago.find(:all, :conditions =>["estado = 'PAGADO' and iguana_id in (select id from iguanas where proyecto='IGUANA')"])
      for iguanaspago in @iguanaspagos
        cadena = ""
        contador = 0
        cadenaidentificacion = ""
        @iguanaspersonas = Iguanaspersona.find_all_by_iguana_id(iguanaspago.iguana_id);
        for iguanaspersona in @iguanaspersonas
          persona  = Persona.find(iguanaspersona.persona_id);
          if contador == 0
              cadenaidentificacion = persona.identificacion
              contador = contador  +  1
          end
          if cadena != ""
            cadena = cadena + ' - ' + persona.autobuscar
          else
            cadena = persona.autobuscar
          end
        end
        xml.Row do
            xml.Cell { xml.Data iguanaspago.iguana.nro_registro, 'ss:Type' => 'String' }
            xml.Cell { xml.Data cadenaidentificacion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data cadena, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguanaspago.tipopago, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguanaspago.valor, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguanaspago.fecha_solicitud, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguanaspago.fecha_desembolso, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguanaspago.convenio, 'ss:Type' => 'String' }
            xml.Cell { xml.Data iguanaspago.rubro, 'ss:Type' => 'String' }
        end
      end
    end
  end
end
