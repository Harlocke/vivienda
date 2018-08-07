pdf = Prawn::Document.new
    pdf.repeat :all do
        # header
        pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], :width  => pdf.bounds.width do
            logo2 = "#{RAILS_ROOT}/public/images/logoisv.jpg"
            two_dimensional_array3 = [[pdf.make_cell(:content => "CÓDIGO: ", :font_style => :bold, :size => 8, :align => :left),pdf.make_cell(:content => "F-GC-03", :size => 8, :align => :left)],
                                      [pdf.make_cell(:content => "VERSIÓN: ", :font_style => :bold, :size => 8, :align => :left),pdf.make_cell(:content => "02", :size => 8, :align => :left)],
                                      [pdf.make_cell(:content => "FECHA: ", :font_style => :bold, :size => 8, :align => :left),pdf.make_cell(:content => "24/02/2016", :size => 8, :align => :left)],
                                      [pdf.make_cell(:content => "PÁGINA: ", :font_style => :bold, :size => 8, :align => :left),pdf.make_cell(:content => "", :size => 8, :align => :left)]]
            data22222 =  [[{:image => logo2, :scale => 0.13, :position => :center},
                           pdf.make_cell(:content => "
                              MEMORANDO ", :size => 14, :font_style => :bold, :align => :center),
                           two_dimensional_array3]]
            pdf.table data22222, :position => :center, :width => 550
            #pdf.move_down(8)
            #pdf.stroke_horizontal_rule
        end
        # footer
        pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 60], :width  => pdf.bounds.width do
            logo2 = "#{RAILS_ROOT}/public/images/piepagina.jpg"
            data3 =  [[{:image => logo2, :scale => 0.7, :position => :center, :border_colors =>"white"}]]
            pdf.table data3, :position => :center, :width => 540, :cell_style=> {:border_color => "FFFFFF"}
            pdf.move_down(5)
        end

    end
    pdf.bounding_box([pdf.bounds.left, pdf.bounds.top - 95], :width  => pdf.bounds.width - 20, :height => pdf.bounds.height - 180) do
        pdf.text "<b></b>

               ", :size =>10, :align => :justify, :inline_format => true
        pdf.text "<b>Medellín,</b> #{@correspondenciasinterna.fecha_documento.strftime("%Y-%m-%d") rescue nil}

               ", :size =>10, :align => :justify, :inline_format => true

       pdf.text "<b>PARA:</b>

               ", :size =>10, :align => :justify, :inline_format => true

        pdf.text "<b>DE:</b> #{User.find(@correspondenciasinterna.user_envia).nombre}
                             #{User.find(@correspondenciasinterna.user_envia).cargo}

               ", :size =>10, :align => :justify, :inline_format => true
 
        pdf.text "<b>ASUNTO:</b> #{@correspondenciasinterna.asunto rescue nil}

               ", :size =>10, :align => :justify, :inline_format => true
        pdf.text "Cordial saludo:

               ", :size =>10, :align => :justify, :inline_format => true
        pdf.text "#{@correspondenciasinterna.desarrollo rescue nil}

               ", :size =>10, :align => :justify, :inline_format => true
        pdf.text "Documentos cargados:", :size =>10, :align => :justify, :inline_format => true
        @correspondenciasinterna.corresinternasimagenes.each do |corresinternasimagen|
          pdf.text "#{corresinternasimagen.corresinterna_file_name rescue nil}
                    ", :size =>10, :align => :justify, :inline_format => true

        end
        pdf.move_down(15)
        pdf.text "Gracias por su atención,

               ", :size =>10, :align => :justify, :inline_format => true


        pdf.move_down(10)
        pdf.font_size 10

        pdf.text "<b>#{User.find(@correspondenciasinterna.user_envia).nombre}</b>
                             #{User.find(@correspondenciasinterna.user_envia).cargo}
               ", :size =>10, :align => :justify, :inline_format => true

        datoinforme = [[pdf.make_cell(:content => "Elaboró", :font_style => :bold, :size => 6, :align => :left, :width =>50),
                        pdf.make_cell(:content => "#{User.find(@correspondenciasinterna.user_elabora).nombre}", :size => 6, :align => :left),
                        pdf.make_cell(:content => "", :font_style => :bold, :size => 6, :align => :left, :width =>10),
                        pdf.make_cell(:content => "Aprobó", :font_style => :bold, :size => 6, :align => :left, :width =>40),
                        pdf.make_cell(:content => "#{User.find(@correspondenciasinterna.user_aprueba).nombre}", :size => 6, :align => :left),],

                        [pdf.make_cell(:content => "Elaboró", :font_style => :bold, :size => 6, :align => :left, :width =>30),
                        pdf.make_cell(:content => "#{User.find(@correspondenciasinterna.user_elabora).cargo}", :size => 6, :align => :left),
                        pdf.make_cell(:content => "", :font_style => :bold, :size => 6, :align => :left, :width =>10),
                        pdf.make_cell(:content => "Aprobó", :font_style => :bold, :size => 6, :align => :left, :width =>40),
                        pdf.make_cell(:content => "#{User.find(@correspondenciasinterna.user_aprueba).cargo}", :size => 6, :align => :left),]]
        pdf.table datoinforme, :position => :center, :width => pdf.bounds.width, :cell_style=> {:border_color => "999999"}

        pdf.page_count.times do |i|
            pdf.font_size 8
            pdf.go_to_page(i+1)
            pdf.draw_text "#{(i+1)} de #{pdf.page_count}", :at => [500,634]
        end
        pdf.move_down(4)
end
