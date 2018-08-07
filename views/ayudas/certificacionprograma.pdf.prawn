pdf = Prawn::Document.new
    pdf.repeat :all do

        pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 60], :width  => pdf.bounds.width do
            logo2 = "#{RAILS_ROOT}/public/images/piedepagina.jpg"
            data3 =  [[{:image => logo2, :scale => 0.7, :position => :center, :border_colors =>"white"}]]
            pdf.table data3, :position => :center, :width => 540, :cell_style=> {:border_color => "FFFFFF"}
            pdf.move_down(10)
        end
    end

pdf.bounding_box([pdf.bounds.left + 20, pdf.bounds.top - 30], :width  => pdf.bounds.width - 50, :height => pdf.bounds.height - 50) do

        pdf.text "<b>CERTIFICACIÓN AL PROGRAMA</b>", :size =>12, :align => :center, :inline_format => true
        pdf.move_down(20)
        
        pdf.text "Medelín, #{Time.now().strftime("%d")} de #{Time.now().strftime("%m")} de #{Time.now().strftime("%Y")}", :size =>11, :align => :left, :inline_format => true
        pdf.move_down(25)
        pdf.text "<b>EL PROGRAMA DE ARRENDAMIENTO
                     TEMPORAL

                    CERTIFICA:</b>", :size =>12, :align => :center, :inline_format => true
        pdf.move_down(15)
        pdf.text "Que el (la) señor(a) #{@ayuda.persona.nombres} con cédula de ciudadania número #{@ayuda.persona.identificacion} está siendo atendido(a) por el PROGRAMA DE ARRENDAMIENTO TEMPORAL desde ------ hasta la fecha.

        Fue remitido(a) con la ficha número ----------, recibe un subsidio de arrendamiento de ---------- pesos mensuales ($ ----------- )." , :size =>10, :align => :justify, :inline_format => true
        pdf.move_down(15)
        pdf.text "La vivienda de donde fue evacuado(a) se encuentra ubicada en la dirección ----- del barrio  ---- de la ciudad de -------- .", :size =>10, :align => :justify, :inline_format => true
        pdf.move_down(20)
        pdf.text "<b>OBSERVACIÓN</b> (Motivo de la evacuación) 


        Esta certificación se expide por solicitud directa  del interesado(a).", :size =>10, :align => :justify, :inline_format => true
        pdf.move_down(20)
        logo2 = "#{RAILS_ROOT}/public/images/logoisv.jpg"
            data22222 =  [[pdf.make_cell(:content => "_______________________________
                            Área Juridica
                            Programa Arrendamiento Temporal
                            Tel: 4480255 ext 150 - 161", :size => 9, :align => :left, :width => 300),
                            {:image => logo2, :scale => 0.35, :position => :center, :width => 200}
                           ]]
            pdf.table data22222, :position => :center, :width => 500
            pdf.move_down(8)

        pdf.text "<b>S I F I - Sistema de Informacion ISVIMED - #{Time.now().strftime("%Y-%m-%d %H:%M:%S")} </b>", :size =>10, :align => :justify, :inline_format => true

end