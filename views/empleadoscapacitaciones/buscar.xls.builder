xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.Workbook({
  'xmlns'      => "urn:schemas-microsoft-com:office:spreadsheet",
  'xmlns:o'    => "urn:schemas-microsoft-com:office:office",
  'xmlns:x'    => "urn:schemas-microsoft-com:office:excel",
  'xmlns:html' => "http://www.w3.org/TR/REC-html40",
  'xmlns:ss'   => "urn:schemas-microsoft-com:office:spreadsheet"
  }) do

#   ***************************************************************
#   Inicio Pestaña 1 - Tipo de Poblacion
#   ***************************************************************

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


  xml.Worksheet 'ss:Name' => 'Informe Capacitacion' do
    xml.Table do
      # Header
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
          xml.Cell { xml.Data 'Funcionario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cargo', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fuente DNC', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Priorización Institucional', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Necesidad Institucional', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Dependencia, áreas de trabajo u oficina', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Conocimiento (SABER)', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Habilidades (HACER)', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Actitudes, Motivacion (SER)', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Población objetivo por nivel jerárquico', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Presupuesto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Se dictó', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Evento de capacitación aprobado', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Nombre capacitación', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Valor pagado rubro capacitación', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Métodos o estrategias', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Recursos', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Objetivo de la capacitación', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Contenido (temas)', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Metodología', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Institución evaluada', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Duración', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha de inicio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Fecha de finalización', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Calificación proveedor', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Evaluación del aprendizaje, eficaz?', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end
      empleadoscapacitacion = Empleadoscapacitacion.find(:all)
      empleadoscapacitacion.each do |data|
      xml.Row do
        xml.Cell { xml.Data Empleado.find(data.empleado_id).nombre, 'ss:Type' => 'String' }
        xml.Cell { xml.Data 'CARGO', 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.fuente_dnc, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.dpriorizacion, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.necesidad, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.dependencia_id, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.aspecto_conocimiento, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.aspecto_habilidades, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.aspecto_actitudes, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.dpoblacionobjeto, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.presupuesto, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.dsedicto, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.evento_aprobado, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.nombre_capacitacion, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.valor_pagado, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.dmetodos, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.drecursos, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.objetivo, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.contenido, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.metodologia, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.institucion_evaluada, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.duracion, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.fecha_inicio, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.fecha_finalizacion, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.calificacion_proveedor, 'ss:Type' => 'String' }
        xml.Cell { xml.Data data.devaluacioneficacia, 'ss:Type' => 'String' }
      end
    end

    end
  end

end