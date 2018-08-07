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

#
#   INFORMACION DEL PROYECTO
#
  xml.Worksheet 'ss:Name' => 'Informacion Inventario' do
    xml.Table do
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Codigo', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Elemento', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cantidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Dependencia', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Usuario USO', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Serial', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Estado', 'ss:Type' => 'String' }
      end
      @usersinventarios = Usersinventario.all
      for usersinventario in @usersinventarios
        inventario = ""
        usuario = ""
        dependencia = ""
        if usersinventario.inventarioselemento_id.to_s != ""
          inventario = usersinventario.inventarioselemento.descripcion
        end
        if usersinventario.user_id.to_s != ""
          usuario = usersinventario.user.nombre rescue nil
        end
        if usersinventario.dependencia_id.to_s != ""
          dependencia = usersinventario.dependencia.descripcion
        end
        xml.Row do
            xml.Cell { xml.Data usersinventario.codigo, 'ss:Type' => 'String' }
            xml.Cell { xml.Data inventario, 'ss:Type' => 'String' }
            xml.Cell { xml.Data usersinventario.cantidad, 'ss:Type' => 'String' }
            xml.Cell { xml.Data dependencia, 'ss:Type' => 'String' }
            xml.Cell { xml.Data usuario, 'ss:Type' => 'String' }
            xml.Cell { xml.Data usersinventario.serial, 'ss:Type' => 'String' }
            xml.Cell { xml.Data usersinventario.estado, 'ss:Type' => 'String' }
        end
      end
    end
  end
end
