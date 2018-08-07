pdf = Prawn::Document.new
    pdf.repeat :all do
            pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], :width  => pdf.bounds.width do
                logo2 = "#{RAILS_ROOT}/public/images/logoisv.jpg"
                data22222 =  [[{:image => logo2, :scale => 0.35, :position => :center},
                               pdf.make_cell(:content => "
                                  ACTA DE ATENCION", :size => 14, :font_style => :bold, :align => :center, :width =>450)]]
                pdf.table data22222, :position => :center, :width => 550
                pdf.move_down(8)
            end
            pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 60], :width  => pdf.bounds.width do
            logo2 = "#{RAILS_ROOT}/public/images/piepagina.jpg"
            data3 =  [[{:image => logo2, :scale => 0.7, :position => :center, :border_colors =>"white"}]]
            pdf.table data3, :position => :center, :width => 540, :cell_style=> {:border_color => "FFFFFF"}
            pdf.move_down(5)
      end
    end
pdf.bounding_box([pdf.bounds.left + 20, pdf.bounds.top - 95], :width  => pdf.bounds.width - 50, :height => pdf.bounds.height - 50) do
        datoinforme = [[pdf.make_cell(:content => "Usuario", :font_style => :bold, :size => 9, :align => :left, :width =>120),
                        pdf.make_cell(:content => "Fecha y Hora de Atención", :font_style => :bold,  :size => 9, :align => :left),
                        pdf.make_cell(:content => "Profesional", :font_style => :bold, :size => 9, :align => :left)
                        ],
                       [pdf.make_cell(:content => "#{@personasobservaciones.persona.autobuscar rescue nil}", :size => 9, :align => :left),
                        pdf.make_cell(:content => "#{@personasobservaciones.created_at.strftime("%Y-%m-%d %X") rescue nil}", :size => 9, :align => :left),
                        pdf.make_cell(:content => "#{@personasobservaciones.user.nombre rescue nil}", :size => 9, :align => :left)
                        ]]
        pdf.table datoinforme, :position => :center, :width => pdf.bounds.width, :cell_style=> {:border_color => "FFFFFF"}
        pdf.move_down(15)

        pdf.table([[pdf.make_cell(:content => "Desarrolló de la atención", :size => 10,:font_style => :bold, :align => :left,:background_color => "CCCCCC",:border_color => "999999", :width  => pdf.bounds.width)]])
        pdf.move_down(10)
        
        pdf.font_size 12
        pdf.table([[pdf.make_cell(:content => "#{@personasobservaciones.observacion rescue nil} ", :size => 10, :align => :justify,:background_color => "FFFFFF",:border_color => "FFFFFF", :width  => pdf.bounds.width)]])
        pdf.move_down(80)

        datoin= [[pdf.make_cell(:content => "________________________________________", :font_style => :bold, :size => 9, :align => :left, :width =>280),
                  pdf.make_cell(:content => "________________________________________", :font_style => :bold,  :size => 9, :align => :left)
                        ],
                 [pdf.make_cell(:content => "#{@personasobservaciones.persona.nombres rescue nil}", :font_style => :bold,:size => 10, :align => :left),
                  pdf.make_cell(:content => "#{@personasobservaciones.user.nombre rescue nil rescue nil}", :font_style => :bold, :size => 10, :align => :left)
                        ],
                 [pdf.make_cell(:content => "Usuario", :size => 9, :align => :left),
                  pdf.make_cell(:content => "Profesional Atención", :size => 9, :align => :left)
                        ]]
        pdf.table datoin, :position => :center, :width => pdf.bounds.width, :cell_style=> {:border_color => "FFFFFF"}
        pdf.move_down(20)

        pdf.text "<b>S I F I - Sistema de Informacion ISVIMED - #{Time.now().strftime("%Y-%m-%d %H:%M:%S")} </b>", :size =>10, :align => :justify, :inline_format => true

end