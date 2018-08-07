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
#   Inicio Pestaña 1 - Consolidado
#   ***************************************************************

  xml.Worksheet 'ss:Name' => 'Tipo Resolucion' do
    xml.Table do

      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Reporte por Tipo de Resolucion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Tipo de Resolucion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Año', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nro Total de Resoluciones', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Total Subsidio Municipal en Dinero', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Total Subsidio Municipal en Especie', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Total Subsidio Mejoras', 'ss:Type' => 'String' }
      end
      resoluciones = Resolucion.find_by_sql("select distinct anno from resoluciones order by anno")
      resoluciones.each do |dataanno|
        resolucionesclases = Resolucionesclase.find(:all)
        resolucionesclases.each do |dataclases|
          cantresoluciones = Resolucion.count(:conditions => [' resolucionesclase_id = ? and anno = ?' , "#{dataclases.id}", "#{dataanno.anno}"])
          sumespecie = Resolucionespersona.sum('subsidio_especie', :conditions => [' resolucion_id in (select id from resoluciones where resolucionesclase_id = ? and anno = ?)' , "#{dataclases.id}", "#{dataanno.anno}"])
          sumdinero = Resolucionespersona.sum('subsidio_dinero', :conditions => [' resolucion_id in (select id from resoluciones where resolucionesclase_id = ? and anno = ?)' , "#{dataclases.id}", "#{dataanno.anno}"])
          summejoras = Resolucionespersona.sum('subsidio_mejoras', :conditions => [' resolucion_id in (select id from resoluciones where resolucionesclase_id = ? and anno = ?)' , "#{dataclases.id}", "#{dataanno.anno}"])
          xml.Row do
              xml.Cell { xml.Data dataclases.descripcion, 'ss:Type' => 'String' }
              xml.Cell { xml.Data dataanno.anno, 'ss:Type' => 'String' }
              xml.Cell { xml.Data cantresoluciones, 'ss:Type' => 'Number' }
              xml.Cell { xml.Data sumespecie, 'ss:Type' => 'Number' }
              xml.Cell { xml.Data sumdinero, 'ss:Type' => 'Number' }
              xml.Cell { xml.Data summejoras, 'ss:Type' => 'Number' }
          end
        end
      end
    end
  end

  xml.Worksheet 'ss:Name' => 'Informacion Completa' do
    xml.Table do

      # Header
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Informacion Completa', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Tipo de Resolucion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Año', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nro Resolucion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Total Subsidio Municipal en Dinero', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Total Subsidio Municipal en Especie', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Total Subsidio Mejoras', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Beneficiario(s)', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Empleado - Contratista', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Proyectos', 'ss:Type' => 'String' }
      end
      resoluciones = Resolucion.find(:all, :order => 'anno')
      resoluciones.each do |dataresolucion|
          cadena = ""
          cadena1 = ""
          sumespecie = Resolucionespersona.sum('subsidio_especie', :conditions => [' resolucion_id = ?' , "#{dataresolucion.id}"])
          sumdinero = Resolucionespersona.sum('subsidio_dinero', :conditions => [' resolucion_id = ?' , "#{dataresolucion.id}"])
          summejoras = Resolucionespersona.sum('subsidio_mejoras', :conditions => [' resolucion_id = ?' , "#{dataresolucion.id}"])
          @resolucionespersonas = Resolucionespersona.find_all_by_resolucion_id(dataresolucion.id);
          for resolucionespersona in @resolucionespersonas
            persona  = Persona.find(resolucionespersona.persona_id);
            if cadena != ""
              cadena = cadena + ' - ' + persona.autobuscar.to_s
            else
              cadena = persona.autobuscar.to_s
            end
          end
          @resolucionescontratistas = Resolucionescontratista.find_all_by_resolucion_id(dataresolucion.id);
          for resolucionescontratista in @resolucionescontratistas
            empleado  = Empleado.find(resolucionescontratista.empleado_id);
            if cadena1 != ""
              cadena1 = cadena1 + ' - ' + empleado.identificacion.to_s + ' - '+ empleado.nombre.to_s
            else
              cadena = empleado.identificacion.to_s + ' - '+ empleado.nombre.to_s
            end
          end
          descproyectos = ""
          @proyectos = Proyecto.find(:all, :conditions=>["id in (select distinct proyecto_id
                                                                 from  viviendas where id in (select vivienda_id
                                                                                              from   viviendaspersonas where persona_id in (select persona_id from resolucionespersonas where resolucion_id = ?)))", dataresolucion.id])
          @proyectos.each do |proyecto|
            descproyectos = descproyectos + proyecto.descripcion + " - "
          end
          xml.Row do
            if dataresolucion.resolucionesclase_id.to_s != ""
              xml.Cell { xml.Data dataresolucion.resolucionesclase.descripcion, 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data 'SIN ASIGNACION', 'ss:Type' => 'String' }
            end
            xml.Cell { xml.Data dataresolucion.anno, 'ss:Type' => 'String' }
            xml.Cell { xml.Data dataresolucion.nro_resolucion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data sumespecie, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sumdinero, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data summejoras, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cadena, 'ss:Type' => 'String' }
            xml.Cell { xml.Data cadena1, 'ss:Type' => 'String' }
            xml.Cell { xml.Data descproyectos, 'ss:Type' => 'String' }
          end
        end
      end
    end
end
