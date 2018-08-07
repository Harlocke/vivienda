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

  xml.Worksheet 'ss:Name' => 'Informacion Almacen' do
    xml.Table do
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Enero', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Febrero', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Marzo', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Abril', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Mayo', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Junio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Julio', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Agosto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Septiembre', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Octubre', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Noviembre', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Diciembre', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
          xml.Cell { xml.Data '', 'ss:Type' => 'String' }
      end
      xml.Row 'ss:StyleID' => 'header' do
          xml.Cell { xml.Data 'Producto', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cantidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Suma Vlr. Unitario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cantidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Suma Vlr. Unitario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cantidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Suma Vlr. Unitario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cantidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Suma Vlr. Unitario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cantidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Suma Vlr. Unitario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cantidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Suma Vlr. Unitario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cantidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Suma Vlr. Unitario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cantidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Suma Vlr. Unitario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cantidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Suma Vlr. Unitario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cantidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Suma Vlr. Unitario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cantidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Suma Vlr. Unitario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Cantidad', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Suma Vlr. Unitario', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Promedio Cant', 'ss:Type' => 'String' }
          xml.Cell { xml.Data 'Promedio Valor', 'ss:Type' => 'String' }
      end
      acumcant01 = 0
      acumcant02 = 0
      acumcant03 = 0
      acumcant04 = 0
      acumcant05 = 0
      acumcant06 = 0
      acumcant07 = 0
      acumcant08 = 0
      acumcant09 = 0
      acumcant10 = 0
      acumcant11 = 0
      acumcant12 = 0
      acumsum01 = 0
      acumsum02 = 0
      acumsum03 = 0
      acumsum04 = 0
      acumsum05 = 0
      acumsum06 = 0
      acumsum07 = 0
      acumsum08 = 0
      acumsum09 = 0
      acumsum10 = 0
      acumsum11 = 0
      acumsum12 = 0
      @productos = Producto.all
      for producto in @productos
        cant01 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(1,'+"#{producto.id}"+','+"#{'01'+@anno}"+') valor from dual')
        cant02 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(1,'+"#{producto.id}"+','+"#{'02'+@anno}"+') valor from dual')
        cant03 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(1,'+"#{producto.id}"+','+"#{'03'+@anno}"+') valor from dual')
        cant04 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(1,'+"#{producto.id}"+','+"#{'04'+@anno}"+') valor from dual')
        cant05 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(1,'+"#{producto.id}"+','+"#{'05'+@anno}"+') valor from dual')
        cant06 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(1,'+"#{producto.id}"+','+"#{'06'+@anno}"+') valor from dual')
        cant07 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(1,'+"#{producto.id}"+','+"#{'07'+@anno}"+') valor from dual')
        cant08 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(1,'+"#{producto.id}"+','+"#{'08'+@anno}"+') valor from dual')
        cant09 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(1,'+"#{producto.id}"+','+"#{'09'+@anno}"+') valor from dual')
        cant10 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(1,'+"#{producto.id}"+','+"#{'10'+@anno}"+') valor from dual')
        cant11 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(1,'+"#{producto.id}"+','+"#{'11'+@anno}"+') valor from dual')
        cant12 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(1,'+"#{producto.id}"+','+"#{'12'+@anno}"+') valor from dual')
        promedio = ((cant01.first['valor'] +
                   cant02.first['valor'] +
                   cant03.first['valor'] +
                   cant04.first['valor'] +
                   cant05.first['valor'] +
                   cant06.first['valor'] +
                   cant07.first['valor'] +
                   cant08.first['valor'] +
                   cant09.first['valor'] +
                   cant10.first['valor'] +
                   cant11.first['valor'] +
                   cant12.first['valor'])/12)
        acumcant01 = acumcant01 + cant01.first['valor']
        acumcant02 = acumcant02 + cant02.first['valor']
        acumcant03 = acumcant03 + cant03.first['valor']
        acumcant04 = acumcant04 + cant04.first['valor']
        acumcant05 = acumcant05 + cant05.first['valor']
        acumcant06 = acumcant06 + cant06.first['valor']
        acumcant07 = acumcant07 + cant07.first['valor']
        acumcant08 = acumcant08 + cant08.first['valor']
        acumcant09 = acumcant09 + cant09.first['valor']
        acumcant10 = acumcant10 + cant10.first['valor']
        acumcant11 = acumcant11 + cant11.first['valor']
        acumcant12 = acumcant12 + cant12.first['valor']
        sum01 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(2,'+"#{producto.id}"+','+"#{'01'+@anno}"+') valor from dual')
        sum02 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(2,'+"#{producto.id}"+','+"#{'02'+@anno}"+') valor from dual')
        sum03 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(2,'+"#{producto.id}"+','+"#{'03'+@anno}"+') valor from dual')
        sum04 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(2,'+"#{producto.id}"+','+"#{'04'+@anno}"+') valor from dual')
        sum05 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(2,'+"#{producto.id}"+','+"#{'05'+@anno}"+') valor from dual')
        sum06 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(2,'+"#{producto.id}"+','+"#{'06'+@anno}"+') valor from dual')
        sum07 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(2,'+"#{producto.id}"+','+"#{'07'+@anno}"+') valor from dual')
        sum08 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(2,'+"#{producto.id}"+','+"#{'08'+@anno}"+') valor from dual')
        sum09 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(2,'+"#{producto.id}"+','+"#{'09'+@anno}"+') valor from dual')
        sum10 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(2,'+"#{producto.id}"+','+"#{'10'+@anno}"+') valor from dual')
        sum11 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(2,'+"#{producto.id}"+','+"#{'11'+@anno}"+') valor from dual')
        sum12 = ActiveRecord::Base.connection.select_all('select fnc_sifi_entradas(2,'+"#{producto.id}"+','+"#{'12'+@anno}"+') valor from dual')
        promedio2 = ((sum01.first['valor'] +
                   sum02.first['valor'] +
                   sum03.first['valor'] +
                   sum04.first['valor'] +
                   sum05.first['valor'] +
                   sum06.first['valor'] +
                   sum07.first['valor'] +
                   sum08.first['valor'] +
                   sum09.first['valor'] +
                   sum10.first['valor'] +
                   sum11.first['valor'] +
                   sum12.first['valor'])/12)
        acumsum01 = acumsum01 + sum01.first['valor']
        acumsum02 = acumsum02 + sum02.first['valor']
        acumsum03 = acumsum03 + sum03.first['valor']
        acumsum04 = acumsum04 + sum04.first['valor']
        acumsum05 = acumsum05 + sum05.first['valor']
        acumsum06 = acumsum06 + sum06.first['valor']
        acumsum07 = acumsum07 + sum07.first['valor']
        acumsum08 = acumsum08 + sum08.first['valor']
        acumsum09 = acumsum09 + sum09.first['valor']
        acumsum10 = acumsum10 + sum10.first['valor']
        acumsum11 = acumsum11 + sum11.first['valor']
        acumsum12 = acumsum12 + sum12.first['valor']

        xml.Row do
            xml.Cell { xml.Data producto.descripcion, 'ss:Type' => 'String' }
            xml.Cell { xml.Data cant01.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sum01.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant02.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sum02.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant03.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sum03.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant04.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sum04.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant05.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sum05.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant06.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sum06.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant07.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sum07.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant08.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sum08.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant09.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sum09.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant10.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sum10.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant11.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sum11.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data cant12.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data sum12.first['valor'], 'ss:Type' => 'Number' }
            xml.Cell { xml.Data promedio, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data promedio2, 'ss:Type' => 'Number' }
        end
      end
        xml.Row 'ss:StyleID' => 'header' do
            xml.Cell { xml.Data 'Sumatorias', 'ss:Type' => 'String' }
            xml.Cell { xml.Data acumcant01, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumsum01, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumcant02, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumsum02, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumcant03, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumsum03, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumcant04, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumsum04, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumcant05, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumsum05, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumcant06, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumsum06, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumcant07, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumsum07, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumcant08, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumsum08, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumcant09, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumsum09, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumcant10, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumsum10, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumcant11, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumsum11, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumcant12, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data acumsum12, 'ss:Type' => 'Number' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
            xml.Cell { xml.Data '', 'ss:Type' => 'String' }
        end
    end
  end
end
