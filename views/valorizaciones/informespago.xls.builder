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


  xml.Worksheet 'ss:Name' => 'Informacion Pagos Valorizacion' do
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
      for valorizacion in @valorizaciones
        sumsaldoeconomica = Valorizacionespago.sum('valor', :conditions => ["valorizacion_id = ? and tipo = ? and estado = 'PAGADO'", valorizacion.id, 'E'])
        sumsaldotraslado = Valorizacionespago.sum('valor', :conditions => ["valorizacion_id = ? and tipo = ? and estado = 'PAGADO'", valorizacion.id, 'T'])
        sumsaldotramites = Valorizacionespago.sum('valor', :conditions => ["valorizacion_id = ? and tipo = ? and estado = 'PAGADO'", valorizacion.id, 'L'])
        sumsaldoavaluo = Valorizacionespago.sum('valor', :conditions => ["valorizacion_id = ? and tipo = ? and estado = 'PAGADO'", valorizacion.id, 'A'])
        sumsaldoarrendatario = Valorizacionespago.sum('valor', :conditions => ["valorizacion_id = ? and tipo = ? and estado = 'PAGADO'", valorizacion.id, 'R'])
        valortotal = valorizacion.valor_compensacion.to_i + valorizacion.valor_traslado.to_i + valorizacion.valor_tramites.to_i + valorizacion.valor_avaluo.to_i + valorizacion.valor_arrendatario.to_i
        saldoeconomica = valorizacion.valor_compensacion.to_i - sumsaldoeconomica.to_i
        saldotraslado = valorizacion.valor_traslado.to_i - sumsaldotraslado.to_i
        saldotramites = valorizacion.valor_tramites.to_i - sumsaldotramites.to_i
        saldoavaluo = valorizacion.valor_avaluo.to_i - sumsaldoavaluo.to_i
        saldoarrendatario = valorizacion.valor_arrendatario.to_i - sumsaldoarrendatario.to_i
        saldototal = saldoeconomica + saldotraslado + saldotramites + saldoavaluo + saldoarrendatario
        xml.Row do
            xml.Cell { xml.Data valorizacion.nro_registro, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.sector, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.encuesta, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.comuna, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.barrio, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.manzana, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.lote, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.interior, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.disponibilidad, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.matricula, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.direccion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.demolido, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.aplica_subsidio, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.reasentado, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacion.opcion_vivienda, 'ss:Type' => 'String' }
            cadena = ""
            contador = 0
            cadenaidentificacion = ""
            @valorizacionespersonas = Valorizacionespersona.find_all_by_valorizacion_id(valorizacion.id);
            for valorizacionespersona in @valorizacionespersonas
              persona  = Persona.find(valorizacionespersona.persona_id);
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
            xml.Cell { xml.Data valorizacion.valor_compensacion.to_i, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sumsaldoeconomica, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data saldoeconomica, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data valorizacion.valor_traslado.to_i, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sumsaldotraslado, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data saldotraslado, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data valorizacion.valor_tramites.to_i, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sumsaldotramites, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data saldotramites, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data valorizacion.valor_avaluo.to_i, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sumsaldoavaluo, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data saldoavaluo, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data valorizacion.valor_arrendatario.to_i, 'ss:Type' => 'Number' }
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
      @valorizacionespagos = Valorizacionespago.find(:all, :conditions =>["estado = 'PAGADO' and valorizacion_id in (select id from valorizaciones where proyecto='IGUANA')"])
      for valorizacionespago in @valorizacionespagos
        cadena = ""
        contador = 0
        cadenaidentificacion = ""
        @valorizacionespersonas = Valorizacionespersona.find_all_by_valorizacion_id(valorizacionespago.valorizacion_id);
        for valorizacionespersona in @valorizacionespersonas
          persona  = Persona.find(valorizacionespersona.persona_id);
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
            xml.Cell { xml.Data valorizacionespago.valorizacion.nro_registro, 'ss:Type' => 'String' }
            xml.Cell { xml.Data cadenaidentificacion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data cadena, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacionespago.tipopago, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacionespago.valor, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacionespago.fecha_solicitud, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacionespago.fecha_desembolso, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacionespago.convenio, 'ss:Type' => 'String' }
            xml.Cell { xml.Data valorizacionespago.rubro, 'ss:Type' => 'String' }
        end
      end
    end
  end
end
