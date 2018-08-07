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

  xml.Worksheet 'ss:Name' => 'Info. Detalle' do
    xml.Table do

      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Datos Basicos', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Contratos', 'ss:Type' => 'String' }
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
          xml.Cell { xml.Data 'Modificaciones', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Rubros', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Ejecuciones', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Documento', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Identificacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Digito', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nombre', 'ss:Type' => 'String' }
          #Contratos
          xml.Cell { xml.Data 'Nro Contrato', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha firma', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Objeto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Contrato', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Plazo Mes', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Plazo Dias', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Inicio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Final', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Final + Modificaciones', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Contrato + Modificaciones', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Interventor', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Subdireccion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Publicacion Gaceta', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Publicacion Secop', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Publicacion C. Comercio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Modalidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Poliza', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Garantia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Aprobacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Abogado Asignado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Liquidacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Anticipo', 'ss:Type' => 'String' }
          #fin contratos
          #inicio modificaciones
          xml.Cell { xml.Data 'Tipo Modificacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Plazo Mes', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Plazo Dias', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Observaciones', 'ss:Type' => 'String' }
          #fin modificaciones
          #inicio Rubros
          xml.Cell { xml.Data 'Rubro', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Posicion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tipo', 'ss:Type' => 'String' }
          #fin Rubros
          #inicio Ejecuciones
          xml.Cell { xml.Data 'Nro Cuenta', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Cuenta Cobro', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Aprobacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Rubro', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Orden', 'ss:Type' => 'String' }
          #fin Ejecuciones
      end
      @empleados.each do |data|
        ingreso1 = ""
        #contrato = Contrato.find_all_by_empleado_id(data.id)
        contrato = Contrato.find(:all, :conditions => ["empleado_id = #{data.id} and fecha_firma between ? and ? ", @fchinicial, @fchfinal])
        contrato.each do |data1|
          ingreso1 = ""
          contratosmodificacion  = Contratosmodificacion.find_all_by_contrato_id(data1.id)
          contratosmodificacion.each do |data2|
            ingreso1 = "S"
            xml.Row do
              if data.documento.to_s != ""
                xml.Cell { xml.Data data.documento.descripcion, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data.identificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data.verificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data.nombres, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.nro_contrato, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_firma, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.objeto, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.valor_contrato, 'ss:Type' => 'Number' }
              xml.Cell { xml.Data data1.plazo_mes, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.plazo_dias, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_inicio, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_final, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_masmodi, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.valor_masmodi, 'ss:Type' => 'String' }
              if data1.interventorempleado_id.to_s != ""
                nombreinterventor = Empleado.find(data1.interventorempleado_id)
                dato = ""
                if nombreinterventor.dependencia_id.to_i > 0
                  dato = nombreinterventor.dependencia.descripcion rescue nil
                else
                  dato = "SIN INFO"
                end
                xml.Cell { xml.Data nombreinterventor.nombres, 'ss:Type' => 'String' }
                xml.Cell { xml.Data dato, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data1.dpublicaciongazeta, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.dpublicacionsecop, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.dpublicacioncc, 'ss:Type' => 'String' }
              if data1.modalidad_id.to_s != ""
                xml.Cell { xml.Data data1.modalidad.descripcion, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data1.dpoliza, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.descgarantia, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_garantia, 'ss:Type' => 'String' }
              if data1.abogadoempleado_id.to_s != ""
                nombreabogado = Empleado.find(data1.abogadoempleado_id)
                xml.Cell { xml.Data nombreabogado.nombre, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data1.fecha_liquidacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.destado, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.anticipo, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data2.dtipomodificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data2.fecha, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data2.valor, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data2.plazo_mes, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data2.plazo_dias, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data2.observaciones, 'ss:Type' => 'String' }
            end
          end
          contratosrubro  = Contratosrubro.find_all_by_contrato_id(data1.id)
          contratosrubro.each do |data3|
            ingreso1 = "S"
            xml.Row do
              if data.documento.to_s != ""
                xml.Cell { xml.Data data.documento.descripcion, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data.identificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data.verificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data.nombres, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.nro_contrato, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_firma, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.objeto, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.valor_contrato, 'ss:Type' => 'Number' }
              xml.Cell { xml.Data data1.plazo_mes, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.plazo_dias, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_inicio, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_final, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_masmodi, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.valor_masmodi, 'ss:Type' => 'String' }
              if data1.interventorempleado_id.to_s != ""
                nombreinterventor = Empleado.find(data1.interventorempleado_id)
                dato = ""
                if nombreinterventor.dependencia_id.to_i > 0
                  dato = nombreinterventor.dependencia.descripcion rescue nil
                else
                  dato = "SIN INFO"
                end
                xml.Cell { xml.Data nombreinterventor.nombres, 'ss:Type' => 'String' }
                xml.Cell { xml.Data dato, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data1.dpublicaciongazeta, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.dpublicacionsecop, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.dpublicacioncc, 'ss:Type' => 'String' }
              if data1.modalidad_id.to_s != ""
                xml.Cell { xml.Data data1.modalidad.descripcion, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data1.dpoliza, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.descgarantia, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_garantia, 'ss:Type' => 'String' }
              if data1.abogadoempleado_id.to_s != ""
                nombreabogado = Empleado.find(data1.abogadoempleado_id)
                xml.Cell { xml.Data nombreabogado.nombre, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data1.fecha_liquidacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.destado, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.anticipo, 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              if data3.rubro_id.to_s != ""
                nombrerubro = Rubro.find(data3.rubro_id)
                xml.Cell { xml.Data nombrerubro.descripcion, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data3.posicion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data3.valor, 'ss:Type' => 'String' }
              if data3.rubro_id.to_s != ""
                nombrerubro = Rubro.find(data3.rubro_id)
                xml.Cell { xml.Data nombrerubro.dtipo, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
              end
            end
          end
          contratospago  = Contratospago.find_all_by_contrato_id(data1.id)
          contratospago.each do |data4|
            ingreso1 = "S"
            xml.Row do
              if data.documento.to_s != ""
                xml.Cell { xml.Data data.documento.descripcion, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data.identificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data.verificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data.nombres, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.nro_contrato, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_firma, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.objeto, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.valor_contrato, 'ss:Type' => 'Number' }
              xml.Cell { xml.Data data1.plazo_mes, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.plazo_dias, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_inicio, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_final, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_masmodi, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.valor_masmodi, 'ss:Type' => 'String' }
              if data1.interventorempleado_id.to_s != ""
                nombreinterventor = Empleado.find(data1.interventorempleado_id)
                dato = ""
                if nombreinterventor.dependencia_id.to_i > 0
                  dato = nombreinterventor.dependencia.descripcion rescue nil
                else
                  dato = "SIN INFO"
                end
                xml.Cell { xml.Data nombreinterventor.nombres, 'ss:Type' => 'String' }
                xml.Cell { xml.Data dato, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data1.dpublicaciongazeta, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.dpublicacionsecop, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.dpublicacioncc, 'ss:Type' => 'String' }
              if data1.modalidad_id.to_s != ""
                xml.Cell { xml.Data data1.modalidad.descripcion, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data1.dpoliza, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.descgarantia, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_garantia, 'ss:Type' => 'String' }
              if data1.abogadoempleado_id.to_s != ""
                nombreabogado = Empleado.find(data1.abogadoempleado_id)
                xml.Cell { xml.Data nombreabogado.nombre, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data1.fecha_liquidacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.destado, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.anticipo, 'ss:Type' => 'String' }
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
              xml.Cell { xml.Data data4.nro_cuenta, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data4.fecha_cuenta, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data4.fecha_aprobacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data4.valor, 'ss:Type' => 'Number' }
              if data4.rubro_id.to_s != ""
                nombrerubro = Rubro.find(data4.rubro_id)
                xml.Cell { xml.Data nombrerubro.descripcion, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data4.fecha_orden, 'ss:Type' => 'String' }
            end
          end
          if ingreso1 != "S"
            xml.Row do
              if data.documento.to_s != ""
                xml.Cell { xml.Data data.documento.descripcion, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data.identificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data.verificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data.nombres, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.nro_contrato, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_firma, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.objeto, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.valor_contrato, 'ss:Type' => 'Number' }
              xml.Cell { xml.Data data1.plazo_mes, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.plazo_dias, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_inicio, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_final, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_masmodi, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.valor_masmodi, 'ss:Type' => 'String' }
              if data1.interventorempleado_id.to_s != ""
                nombreinterventor = Empleado.find(data1.interventorempleado_id)
                dato = ""
                if nombreinterventor.dependencia_id.to_i > 0
                  dato = nombreinterventor.dependencia.descripcion rescue nil
                else
                  dato = "SIN INFO"
                end
                xml.Cell { xml.Data nombreinterventor.nombres, 'ss:Type' => 'String' }
                xml.Cell { xml.Data dato, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data1.dpublicaciongazeta, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.dpublicacionsecop, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.dpublicacioncc, 'ss:Type' => 'String' }
              if data1.modalidad_id.to_s != ""
                xml.Cell { xml.Data data1.modalidad.descripcion, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data1.dpoliza, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.descgarantia, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_garantia, 'ss:Type' => 'String' }
              if data1.abogadoempleado_id.to_s != ""
                nombreabogado = Empleado.find(data1.abogadoempleado_id)
                xml.Cell { xml.Data nombreabogado.nombre, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data1.fecha_liquidacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.destado, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.anticipo, 'ss:Type' => 'String' }
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
  end

#Informe 2
xml.Worksheet 'ss:Name' => 'Consolidado Contratos' do
    xml.Table do

      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Datos Basicos', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Contratos', 'ss:Type' => 'String' }
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
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Documento', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Identificacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Digito', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nombre', 'ss:Type' => 'String' }
          #Contratos
          xml.Cell { xml.Data 'Nro Contrato', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha firma', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Objeto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Contrato', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Plazo Mes', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Plazo Dias', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Inicio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Final', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Final + Modificaciones', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor Contrato + Modificaciones', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Interventor', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Subdireccion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Publicacion Gaceta', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Publicacion Secop', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Publicacion C. Comercio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Modalidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Poliza', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Garantia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Aprobacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Abogado Asignado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Liquidacion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Anticipo', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tipo de Contrato', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tiene Modificaciones', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tiene Rubros', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Tiene Ejecuciones', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nro Compromiso', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Compromiso', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nro Disponibilidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha Disponibilidad', 'ss:Type' => 'String' }
      end
      @empleados.each do |data|
        contrato = Contrato.find(:all, :conditions => ["empleado_id = #{data.id} and fecha_firma between ? and ? ", @fchinicial, @fchfinal])
        contrato.each do |data1|
            xml.Row do
              if data.documento.to_s != ""
                xml.Cell { xml.Data data.documento.descripcion, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data.identificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data.verificacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data.nombres, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.nro_contrato, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_firma, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.objeto, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.valor_contrato, 'ss:Type' => 'Number' }
              xml.Cell { xml.Data data1.plazo_mes, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.plazo_dias, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_inicio, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_final, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_masmodi, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.valor_masmodi, 'ss:Type' => 'String' }
              if data1.interventorempleado_id.to_s != ""
                nombreinterventor = Empleado.find(data1.interventorempleado_id)
                dato = ""
                if nombreinterventor.dependencia_id.to_i > 0
                  dato = nombreinterventor.dependencia.descripcion rescue nil
                else
                  dato = "SIN INFO"
                end
                xml.Cell { xml.Data nombreinterventor.nombres, 'ss:Type' => 'String' }
                xml.Cell { xml.Data dato, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data1.dpublicaciongazeta, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.dpublicacionsecop, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.dpublicacioncc, 'ss:Type' => 'String' }
              if data1.modalidad_id.to_s != ""
                xml.Cell { xml.Data data1.modalidad.descripcion, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data1.dpoliza, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.descgarantia, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_garantia, 'ss:Type' => 'String' }
              if data1.abogadoempleado_id.to_s != ""
                nombreabogado = Empleado.find(data1.abogadoempleado_id)
                xml.Cell { xml.Data nombreabogado.nombre, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data1.fecha_liquidacion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.destado, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.anticipo, 'ss:Type' => 'String' }
              if data1.tiposcontrato_id.to_s != ""
                tiposcon = Tiposcontrato.find(data1.tiposcontrato_id)
                xml.Cell { xml.Data tiposcon.descripcion, 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data '---', 'ss:Type' => 'String' }
              end
              if Contratosmodificacion.exists?(["contrato_id = ?", data1.id])
                xml.Cell { xml.Data 'SI', 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data 'NO', 'ss:Type' => 'String' }
              end
              if Contratosrubro.exists?(["contrato_id = ?", data1.id])
                xml.Cell { xml.Data 'SI', 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data 'NO', 'ss:Type' => 'String' }
              end
              if Contratospago.exists?(["contrato_id = ?", data1.id])
                xml.Cell { xml.Data 'SI', 'ss:Type' => 'String' }
              else
                xml.Cell { xml.Data 'NO', 'ss:Type' => 'String' }
              end
              xml.Cell { xml.Data data1.nro_compromiso, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_compromiso, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.nro_disponibilidad, 'ss:Type' => 'String' }
              xml.Cell { xml.Data data1.fecha_disponibilidad, 'ss:Type' => 'String' }
            end
          end
      end
    end
  end
end