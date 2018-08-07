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
          xml.Cell { xml.Data 'Fecha Resolucion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Responsable', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Objeto de la Resolucion', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Beneficiario(s)', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Empleado - Contratista', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Telefonos', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Proyectos', 'ss:Type' => 'String' }
      end
      for dataresolucion in @resoluciones
          cadena = ""
          cadena1 = ""
          cadenatelefonos = ""
          @resolucionespersonas = Resolucionespersona.find_all_by_resolucion_id(dataresolucion.id);
          for resolucionespersona in @resolucionespersonas
            persona  = Persona.find(resolucionespersona.persona_id);
            if cadena != ""
              cadena = cadena + ' - ' + persona.autobuscar.to_s
              cadenatelefonos = cadenatelefonos + ' - ' + persona.telefonos.to_s
            else
              cadena = persona.autobuscar.to_s
              cadenatelefonos = persona.telefonos.to_s
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
          if dataresolucion.user_id
            nombreuser = User.find(dataresolucion.user_id).nombre
          end
          descproyectos = ""
##          @proyectos = Proyecto.find(:all, :conditions=>["id in (select distinct proyecto_id
#                                                                 from  viviendas where id in (select vivienda_id
#                                                                                              from   viviendaspersonas where persona_id in (select persona_id from resolucionespersonas where resolucion_id = ?)))#",dataresolucion.id ])
          @proyectos = Proyecto.find_by_sql("select p.descripcion||' + Entregado ('||decode(v.entregado,'S','SI','NO')||')' estado
                                             from   proyectos p, viviendas v, viviendaspersonas vp, resolucionespersonas r
                                             where  r.resolucion_id = #{dataresolucion.id}
                                             and    r.persona_id    = vp.persona_id
                                             and    vp.vivienda_id  = v.id
                                             and    v.proyecto_id   = p.id")
          @proyectos.each do |proyecto|
            descproyectos = descproyectos + proyecto.estado.to_s + " - "
          end
          xml.Row do
            if dataresolucion.resolucionesclase_id.to_s != ""
              xml.Cell { xml.Data dataresolucion.resolucionesclase.descripcion, 'ss:Type' => 'String' }
            else
              xml.Cell { xml.Data 'SIN ASIGNACION', 'ss:Type' => 'String' }
            end
            xml.Cell { xml.Data dataresolucion.anno, 'ss:Type' => 'String' }
            xml.Cell { xml.Data dataresolucion.nro_resolucion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data dataresolucion.fecha, 'ss:Type' => 'String' }
            xml.Cell { xml.Data nombreuser, 'ss:Type' => 'String' }
            xml.Cell { xml.Data dataresolucion.resuelve, 'ss:Type' => 'String' }
            xml.Cell { xml.Data cadena, 'ss:Type' => 'String' }
            xml.Cell { xml.Data cadena1, 'ss:Type' => 'String' }
            xml.Cell { xml.Data cadenatelefonos, 'ss:Type' => 'String' }
            xml.Cell { xml.Data descproyectos, 'ss:Type' => 'String' }
          end
        end
      end
    end
end
