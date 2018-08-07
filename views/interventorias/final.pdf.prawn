pdf = Prawn::Document.new
    pdf.repeat :all do
        # header
        pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], :width  => pdf.bounds.width do
            logo2 = "#{RAILS_ROOT}/public/images/logoisv.jpg"
            two_dimensional_array3 = [[pdf.make_cell(:content => "CÓDIGO: ", :font_style => :bold, :size => 8, :align => :left),pdf.make_cell(:content => "F-GJ-33", :size => 8, :align => :left)],
                                      [pdf.make_cell(:content => "VERSIÓN: ", :font_style => :bold, :size => 8, :align => :left),pdf.make_cell(:content => "07", :size => 8, :align => :left)],
                                      [pdf.make_cell(:content => "FECHA: ", :font_style => :bold, :size => 8, :align => :left),pdf.make_cell(:content => "09/09/2015", :size => 8, :align => :left)],
                                      [pdf.make_cell(:content => "PÁGINA: ", :font_style => :bold, :size => 8, :align => :left),pdf.make_cell(:content => "", :size => 8, :align => :left)]]
            data22222 =  [[{:image => logo2, :scale => 0.13, :position => :center},
                           pdf.make_cell(:content => "
                              INFORME FINAL DE SUPERVISIÓN", :size => 14, :font_style => :bold, :align => :center),
                           two_dimensional_array3]]
            pdf.table data22222, :position => :center, :width => 550
            pdf.move_down(8)
            #pdf.stroke_horizontal_rule
        end
        # footer
#        pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 60], :width  => pdf.bounds.width do
#            logo2 = "#{RAILS_ROOT}/public/images/piedepagina.jpg"
#            data3 =  [[{:image => logo2, :scale => 0.7, :position => :center, :border_colors =>"white"}]]
#            pdf.table data3, :position => :center, :width => 540, :cell_style=> {:border_color => "FFFFFF"}
#            pdf.move_down(10)
#        end
    end
    pdf.bounding_box([pdf.bounds.left, pdf.bounds.top - 95], :width  => pdf.bounds.width, :height => pdf.bounds.height - 110) do
        #Contenido que quiera

        pdf.table([[pdf.make_cell(:content => "DATOS DEL INFORME FINAL", :size => 11,:font_style => :bold, :align => :center, :width  => pdf.bounds.width)]])
        pdf.move_down(5)
        datoinforme = [[pdf.make_cell(:content => "Fecha informe", :font_style => :bold, :size => 9, :align => :left, :width =>100),
                        pdf.make_cell(:content => "#{@interventoria.contrato.fecha_inicio.strftime("%Y-%m-%d") rescue nil}", :size => 9, :align => :left)
                        ],
                       [pdf.make_cell(:content => "Supervisor", :font_style => :bold, :size => 9, :align => :left),
                        pdf.make_cell(:content => "#{@interventoria.contrato.nombreinterventor rescue nil}", :size => 9, :align => :left)
                        ]]
        pdf.table datoinforme, :position => :center, :width => pdf.bounds.width, :cell_style=> {:border_color => "999999"}
        pdf.move_down(5)
        pdf.table([[pdf.make_cell(:content => "INFORMACIÓN GENERAL CONTRATO / CONVENIO", :size => 11,:font_style => :bold, :align => :center, :width  => pdf.bounds.width)]])
        pdf.move_down(5)
        datogeneral = [[pdf.make_cell(:content => "Contratista: ", :font_style => :bold, :size => 9, :align => :left, :width =>100),
                        pdf.make_cell(:content => "#{@interventoria.contrato.empleado.autobuscar rescue nil}", :size => 9, :align => :left)
                        ],
                       [pdf.make_cell(:content => "Número de contrato: ", :font_style => :bold, :size => 9, :align => :left),
                        pdf.make_cell(:content => "#{@interventoria.contrato.nro_contrato rescue nil}", :size => 9, :align => :left)
                        ],
                       [pdf.make_cell(:content => "Objeto: ", :font_style => :bold, :size => 9, :align => :left),
                        pdf.make_cell(:content => "#{@interventoria.contrato.objeto rescue nil}", :size => 9, :align => :justify)
                        ]]
        pdf.table datogeneral, :position => :center, :width => pdf.bounds.width,  :cell_style=> {:border_color => "999999"}
        pdf.move_down(5)
        pdf.table([[pdf.make_cell(:content => "VERIFICACIONES DE LA SUPERVISIÓN", :size => 11,:font_style => :bold, :align => :center, :width  => pdf.bounds.width)]])
        pdf.move_down(5)
        pdf.text "<b>1. Modificaciones Realizadas al Contrato/Convenio– Balance final</b>

               ", :size =>10, :align => :justify, :inline_format => true
        pdf.text "<b>2. Ejecución y Balance financiero</b>

               ", :size =>10, :align => :justify, :inline_format => true
        pdf.text "<b>3. Ejecución de las Obligaciones", :size =>10, :align => :justify, :inline_format => true
        @estudiosactividades.each do |estudiosactividad|
          pdf.text "
                    <b> ACTIVIDAD: #{is_capitalize(estudiosactividad.observaciones) rescue nil}</b>", :size =>10, :align => :justify, :inline_format => true
          interactividades = Interactividad.all(:include => :interventoria, :conditions => { :interactividades => {:estudiosactividad_id => estudiosactividad.id}}, :order=>"interventorias.mes, interventorias.anno")
          interactividades.each do |interactividad|

                pdf.text "<b><u>#{interactividad.interventoria.anno rescue nil}-#{descmesmin(interactividad.interventoria.mes).upcase rescue nil}</u></b> : #{is_capitalize(interactividad.desarrollo) rescue nil}", :size => 8, :align => :justify, :inline_format => true
          end
        end
        pdf.move_down(10)
        pdf.table([[pdf.make_cell(:content => "CONCLUSIONES", :size => 11,:font_style => :bold, :align => :center, :width  => pdf.bounds.width)]])
        pdf.move_down(5)
        pdf.text "El contratista ha cumplido a entera satisfacción con las obligaciones del Contrato <b>#{@interventoria.contrato.nro_contrato rescue nil}</b> de <b>#{@interventoria.contrato.fecha_firma rescue nil}</b> cuyo objeto es '<b>#{@interventoria.contrato.objeto rescue nil}</b>', desde la firma del acta de inicio, hasta el momento de la terminación. A partir de esta fecha cesan las obligaciones contraídas por el contratista el cual se encuentra a paz y salvo por todo concepto, especialmente en lo que a las obligaciones de seguridad social y parafiscales se refiere, cesando para el ISVIMED y el contratista las prestaciones económicas establecidas en dicho contrato a partir de su terminación.

                  De conformidad con el artículo 217 del Decreto Ley 019 de 2012 'Por el cual se dictan normas para suprimir o reformar regulaciones, procedimientos y trámites innecesarios existentes en la Administración Pública', la liquidación a que se refiere el referido artículo no será obligatoria en los contratos de prestación de servicios profesionales y de apoyo a la gestión.
                 ", :size => 8, :align => :justify, :inline_format => true
        pdf.move_down(40)
        pdf.font_size 10
        pdf.text "___________________________________________________________________
          <b>#{@interventoria.contrato.nombreinterventor rescue nil}</b>
          <b>SUPERVISOR</b>", :align => :justify, :inline_format => true
        pdf.move_down(40)
        pdf.text "___________________________________________________________________
          <b>#{@interventoria.contrato.empleado.autobuscar rescue nil}</b>
          <b>CONTRATISTA</b>
         ", :align => :justify, :inline_format => true
        10.times do
            pdf.start_new_page
        end
        pdf.page_count.times do |i|
            pdf.font_size 8
            pdf.go_to_page(i+1)
            pdf.draw_text "#{(i+1)} de #{pdf.page_count}", :at => [500,634]
        end
        pdf.move_down(4)
        #pdf.start_new_page
end