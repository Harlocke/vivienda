pdf = Prawn::Document.new
    pdf.repeat :all do
        # header
        pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], :width  => pdf.bounds.width do
            logo2 = "#{RAILS_ROOT}/public/images/logoisv.jpg"
            two_dimensional_array3 = [[pdf.make_cell(:content => "CÓDIGO: ", :font_style => :bold, :size => 8, :align => :left),pdf.make_cell(:content => "F-GJ-33", :size => 8, :align => :left)],
                                      [pdf.make_cell(:content => "VERSIÓN: ", :font_style => :bold, :size => 8, :align => :left),pdf.make_cell(:content => "07", :size => 8, :align => :left)],
                                      [pdf.make_cell(:content => "FECHA: ", :font_style => :bold, :size => 8, :align => :left),pdf.make_cell(:content => "09/09/2015", :size => 8, :align => :left)],
                                      [pdf.make_cell(:content => "PÁGINA: ", :font_style => :bold, :size => 8, :align => :left),pdf.make_cell(:content => "", :size => 8, :align => :left)]]
            data22222 =  [[{:image => logo2, :scale => 0.35, :position => :center},
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

        pdf.table([[pdf.make_cell(:content => "DATOS DEL INFORME FINAL", :size => 8,:font_style => :bold, :align => :center,:background_color => "CCCCCC",:border_color => "999999", :width  => pdf.bounds.width)]])
        pdf.move_down(5)
        datoinforme = [[pdf.make_cell(:content => "Fecha informe", :font_style => :bold, :size => 8, :align => :left, :width =>100),
                        pdf.make_cell(:content => "#{@interventoria.contrato.fechafinalreal.strftime("%Y-%m-%d") rescue nil}", :size => 8, :align => :left)
                        ],
                       [pdf.make_cell(:content => "Supervisor", :font_style => :bold, :size => 8, :align => :left),
                        pdf.make_cell(:content => "#{@interventoria.contrato.nombreinterventor rescue nil}", :size => 8, :align => :left)
                        ]]
        pdf.table datoinforme, :position => :center, :width => pdf.bounds.width, :cell_style=> {:border_color => "999999"}
        pdf.move_down(5)
        pdf.table([[pdf.make_cell(:content => "INFORMACIÓN GENERAL CONTRATO / CONVENIO", :size => 8,:font_style => :bold, :align => :center,:background_color => "CCCCCC",:border_color => "999999", :width  => pdf.bounds.width)]])
        pdf.move_down(5)
        datogeneral = [[pdf.make_cell(:content => "Contratista: ", :font_style => :bold, :size => 8, :align => :left, :width =>100),
                        pdf.make_cell(:content => "#{@interventoria.contrato.empleado.autobuscar rescue nil}", :size => 8, :align => :left)
                        ],
                       [pdf.make_cell(:content => "Número de contrato: ", :font_style => :bold, :size => 8, :align => :left),
                        pdf.make_cell(:content => "#{@interventoria.contrato.nro_contrato rescue nil}", :size => 8, :align => :left)
                        ],
                       [pdf.make_cell(:content => "Objeto: ", :font_style => :bold, :size => 8, :align => :left),
                        pdf.make_cell(:content => "#{@interventoria.contrato.objeto rescue nil}", :size => 8, :align => :justify)
                        ]]
        pdf.table datogeneral, :position => :center, :width => pdf.bounds.width,  :cell_style=> {:border_color => "999999"}
        pdf.move_down(5)
        pdf.table([[pdf.make_cell(:content => "VERIFICACIONES DE LA SUPERVISIÓN", :size => 8,:font_style => :bold, :align => :center,:background_color => "CCCCCC",:border_color => "999999", :width  => pdf.bounds.width)]])
        pdf.move_down(10)
        pdf.text "<b>1. Modificaciones Realizadas al Contrato/Convenio– Balance final</b>

                    Durante el contrato (no) se realizaron  prorrogas y  adiciones, por lo que el plazo y valor del contrato final es el siguiente:", :size =>10, :align => :justify, :inline_format => true
        moddata  = [[pdf.make_cell(:content => "CONCEPTO", :size => 8, :align => :center,:height=>19,:background_color => "CCCCCC",:border_color => "999999", :width =>100),
                      pdf.make_cell(:content => "VALOR", :size => 8, :align => :center,:height=>19,:background_color => "CCCCCC",:border_color => "999999", :width =>100)]]
        moddata += [[pdf.make_cell(:content => "Valor Inicial", :size => 8,:height=>19, :align => :left,:border_color => "999999"),
                      pdf.make_cell(:content => "#{camponumerico(@interventoria.contrato.valor_contrato) rescue 0}",:height=>19, :size => 8, :align => :right,:border_color => "999999")]]
        moddata += [[pdf.make_cell(:content => "Valor Adiciones", :height=>19,:size => 8, :align => :left,:border_color => "999999"),
                      pdf.make_cell(:content => "#{camponumerico(@interventoria.contrato.adiciones) rescue 0}", :height=>19,:size => 8, :align => :right,:border_color => "999999")]]
        moddata += [[pdf.make_cell(:content => "Valor Final",:height=>19, :size => 8, :align => :left,:border_color => "999999"),
                      pdf.make_cell(:content => "#{camponumerico(@interventoria.contrato.valorreal) rescue 0}", :height=>19,:size => 8, :align => :right,:border_color => "999999")]]

        moddata1  = [[pdf.make_cell(:content => "CONCEPTO",:height=>19, :size => 8, :align => :center,:background_color => "CCCCCC",:border_color => "999999",:width =>100),
                      pdf.make_cell(:content => "TERMINO",:height=>19, :size => 8, :align => :center,:background_color => "CCCCCC",:border_color => "999999",:width =>100)]]
        moddata1 += [[pdf.make_cell(:content => "Plazo Inicial",:height=>19, :size => 8, :align => :left,:border_color => "999999"),
                      pdf.make_cell(:content => "#{@interventoria.contrato.fecha_inicio rescue nil}",:height=>19, :size => 8, :align => :center,:border_color => "999999")]]
        moddata1 += [[pdf.make_cell(:content => "Prórrogas",:height=>19,:size => 8, :align => :left,:border_color => "999999"),
                      pdf.make_cell(:content => "#{}",:height=>19, :size => 8, :align => :center,:border_color => "999999")]]
        moddata1 += [[pdf.make_cell(:content => "Plazo Final",:height=>19, :size => 8, :align => :left,:border_color => "999999"),
                      pdf.make_cell(:content => "#{@interventoria.contrato.fechafinalreal rescue nil}", :height=>19,:size => 8, :align => :center,:border_color => "999999")]]

        moddata0 = [[pdf.make_cell(:content => "  ", :size => 8, :align => :left, :width =>30,:border_color => "999999")]]

        moddata2 =  [[moddata,moddata0,moddata1]]
        pdf.move_down(5)
        pdf.table moddata2, :position => :center, :width => 430, :cell_style=> {:border_color => "999999"}

        pdf.text "
                <b>2. Ejecución y Balance financiero</b>", :size =>10, :align => :justify, :inline_format => true
        data = [[pdf.make_cell(:content => "#",:height=>19, :size => 8, :align => :center,:background_color => "CCCCCC",:border_color => "999999"),
                pdf.make_cell(:content => "CONCEPTO",:height=>19, :size => 8, :align => :center,:background_color => "CCCCCC",:border_color => "999999"),
                pdf.make_cell(:content => "FECHA",:height=>19, :size => 8, :align => :center,:background_color => "CCCCCC",:border_color => "999999"),
                pdf.make_cell(:content => "VALOR",:height=>19, :size => 8, :align => :center,:background_color => "CCCCCC",:border_color => "999999")]]
        conse = 0
        @inter = Interventoria.find(:all, :conditions=>["contrato_id = #{@interventoria.contrato_id}"], :order=>"mes,anno")
        @inter.each do |inter|
           conse = conse + 1
            data += [[pdf.make_cell(:content => "#{conse}", :size => 7, :align => :left, :height=>19,:border_color => "999999"),
                      pdf.make_cell(:content => "Cuenta de cobro #{inter.anno rescue nil}-#{descmesmin(inter.mes) rescue nil} ", :size => 7, :align => :left, :height=>19,:border_color => "999999"),
                      pdf.make_cell(:content => "#{inter.anno rescue nil}-#{descmesmin(inter.mes) rescue nil}", :size => 7, :align => :left, :height=>19,:border_color => "999999"),
                      pdf.make_cell(:content => "#{camponumerico(inter.valor_mes) rescue 0}", :size => 7, :align => :left, :height=>19,:border_color => "999999")]]
        end
        data1= [[pdf.make_cell(:content => "CONCEPTO",:height=>19, :size => 8, :align => :center,:background_color => "CCCCCC",:border_color => "999999"),
                 pdf.make_cell(:content => "VALOR",:height=>19, :size => 8, :align => :center,:background_color => "CCCCCC",:border_color => "999999")]]
        data1 += [[pdf.make_cell(:content => "Valor Total del Contrato", :size => 8, :align => :left, :height=>19,:border_color => "999999"),
                   pdf.make_cell(:content => "#{camponumerico(@interventoria.contrato.valorreal) rescue 0}", :size => 8, :align => :left, :height=>19,:border_color => "999999")]]
        data1 += [[pdf.make_cell(:content => "Valor Total pagado", :size => 8, :align => :left, :height=>19,:border_color => "999999"),
                   pdf.make_cell(:content => "#{camponumerico(@interventoria.contrato.valor_pagadointer) rescue 0}", :size => 8, :align => :left, :height=>19,:border_color => "999999")]]
        data1 += [[pdf.make_cell(:content => "", :size => 8, :align => :left, :height=>19,:border_color => "999999",:background_color => "CCCCCC"),
                   pdf.make_cell(:content => "", :size => 8, :align => :left, :height=>19,:border_color => "999999",:background_color => "CCCCCC")]]
        data1 += [[pdf.make_cell(:content => "Saldo no ejecutado", :size => 8, :align => :left, :height=>19,:border_color => "999999"),
                   pdf.make_cell(:content => "#{camponumerico(@interventoria.contrato.valor_saldo) rescue 0}", :size => 8, :align => :left, :height=>19,:border_color => "999999")]]
        data1 += [[pdf.make_cell(:content => "", :size => 8, :align => :left, :height=>19,:border_color => "999999",:background_color => "CCCCCC"),
                   pdf.make_cell(:content => "", :size => 8, :align => :left, :height=>19,:border_color => "999999",:background_color => "CCCCCC")]]
        data1 += [[pdf.make_cell(:content => "Valor pendiente por pagar", :size => 8, :align => :left, :height=>19,:border_color => "999999"),
                   pdf.make_cell(:content => "0", :size => 8, :align => :left, :height=>19,:border_color => "999999")]]

        data0 = [[pdf.make_cell(:content => "  ", :size => 8, :align => :left, :width =>30, :border_color => "999999")]]

        data2 =  [[data,data0,data1]]
        pdf.move_down(5)
        pdf.table data2, :position => :center, :cell_style=> {:border_color => "999999"}
        pdf.move_down(10)
        pdf.text "De acuerdo con lo anterior se observa que se la ejecución financiera corresponde al #{@interventoria.contrato.porcentaje_eje rescue 0}% del contrato, por lo que los recursos del contrato son suficientes para culminar su ejecución y por tanto no es necesario efectuar adición de recursos.", :size =>10, :align => :justify, :inline_format => true
        pdf.move_down(15)
        pdf.text "<b>3. Ejecución de las Obligaciones", :size =>10, :align => :justify, :inline_format => true
        @estudiosactividades.each do |estudiosactividad|
          pdf.move_down(15)
          pdf.text "<b> ACTIVIDAD: #{is_capitalize(estudiosactividad.observaciones) rescue nil}</b>", :size =>10, :align => :justify, :inline_format => true
          interactividades = Interactividad.all(:include => :interventoria, :conditions => { :interactividades => {:estudiosactividad_id => estudiosactividad.id}}, :order=>"interventorias.mes, interventorias.anno")
          interactividades.each do |interactividad|
            pdf.text "<b><u>#{interactividad.interventoria.anno rescue nil}-#{descmesmin(interactividad.interventoria.mes).upcase rescue nil}</u></b> :", :size => 8, :align => :justify, :inline_format => true
            pdf.text "#{is_capitalize(interactividad.desarrollo) rescue nil}", :size => 8, :align => :justify, :inline_format => true
            if interactividad.interactimagenes.exists?
              interactividad.interactimagenes.each do |interactimagen|
                pdf.text "******** <u>Soporte digital: </u>#{interactimagen.descripcion rescue nil rescue nil} (#{interactimagen.interactividad_file_name rescue nil})", :size => 8, :align => :justify, :inline_format => true
              end
            end
            pdf.move_down(8)
          end
        end
        pdf.move_down(15)
        pdf.text "<b>4. Estado de las garantías, multas y sanciones", :size =>10, :align => :justify, :inline_format => true
        pdf.move_down(10)
        pdf.text "Durante el plazo del contrato no se impusieron multas o sanciones", :size =>10, :align => :justify, :inline_format => true
        pdf.move_down(10)
        pdf.text "Durante el plazo del contrato las garantías no han sido afectadas.", :size =>10, :align => :justify, :inline_format => true

        pdf.move_down(15)
        pdf.text "<b>5. Forma de terminación del contrato ", :size =>10, :align => :justify, :inline_format => true
        pdf.move_down(10)
        pdf.text "El contrato se terminó normal por cumplimiento del plazo pactado", :size =>10, :align => :justify, :inline_format => true


        pdf.move_down(10)
        pdf.table([[pdf.make_cell(:content => "CONCLUSIONES", :size => 8,:font_style => :bold, :align => :center,:background_color => "CCCCCC",:border_color => "999999", :width  => pdf.bounds.width)]])
        pdf.move_down(10)
        pdf.text "El contratista ha cumplido a entera satisfacción con las obligaciones del Contrato <b>#{@interventoria.contrato.nro_contrato rescue nil}</b> de <b>#{@interventoria.contrato.fecha_firma rescue nil}</b> cuyo objeto es '<b>#{@interventoria.contrato.objeto rescue nil}</b>', desde la firma del acta de inicio, hasta el momento de la terminación. A partir de esta fecha cesan las obligaciones contraídas por el contratista el cual se encuentra a paz y salvo por todo concepto, especialmente en lo que a las obligaciones de seguridad social y parafiscales se refiere, cesando para el ISVIMED y el contratista las prestaciones económicas establecidas en dicho contrato a partir de su terminación.

                  De conformidad con el artículo 217 del Decreto Ley 019 de 2012 'Por el cual se dictan normas para suprimir o reformar regulaciones, procedimientos y trámites innecesarios existentes en la Administración Pública', la liquidación a que se refiere el referido artículo no será obligatoria en los contratos de prestación de servicios profesionales y de apoyo a la gestión.
                 ", :size => 9, :align => :justify, :inline_format => true
        pdf.move_down(40)
        pdf.font_size 10
        pdf.text "______________________________________________
          <b>#{@interventoria.contrato.nombreinterventor rescue nil}</b>
          <b>SUPERVISOR</b>", :align => :justify, :inline_format => true
        pdf.move_down(40)
        pdf.text "______________________________________________
          <b>#{@interventoria.contrato.empleado.autobuscar rescue nil}</b>
          <b>CONTRATISTA</b>
         ", :align => :justify, :inline_format => true
        pdf.page_count.times do |i|
            pdf.font_size 8
            pdf.go_to_page(i+1)
            pdf.draw_text "#{(i+1)} de #{pdf.page_count}", :at => [500,634]
        end
        pdf.move_down(4)
        #pdf.start_new_page
end