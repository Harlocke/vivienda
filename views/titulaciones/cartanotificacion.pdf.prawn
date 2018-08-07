pdf = Prawn::Document.new
@titulaciones.each do |titulacion|
  if titulacion.titulacionespersonas.exists? 
    titulacion.titulacionespersonas.each do |titulacionespersona|
    pdf.repeat :all do
        # header
        pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], :width  => pdf.bounds.width do
            logo = "#{RAILS_ROOT}/public/images/logoisvimed_midle.png"
            data22222 =  [[{:image => logo, :scale => 0.7, :position => :center}]]
            pdf.table data22222, :position => :center, :width => 540, :cell_style=> {:border_color => "FFFFFF"}
        end

        # footer
        pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 60], :width  => pdf.bounds.width do
            logo2 = "#{RAILS_ROOT}/public/images/piedepagina.jpg"
            data3 =  [[{:image => logo2, :scale => 0.7, :position => :center, :border_colors =>"white"}]]
            pdf.table data3, :position => :center, :width => 540, :cell_style=> {:border_color => "FFFFFF"}
            pdf.move_down(10)
        end
    end
    pdf.bounding_box([pdf.bounds.left + 40, pdf.bounds.top - 105], :width  => pdf.bounds.width - 60, :height => pdf.bounds.height - 170) do
        #Contenido que quiera
        pdf.font_size 12
        pdf.text "
          Medellín,



          Señor(a)
          <b>#{titulacionespersona.persona.nombres rescue nil}
          C.C. #{titulacionespersona.persona.identificacion rescue nil}
          #{titulacion.direccion rescue nil}</b>
          Corregimiento Santa Elena


          <b>Asunto:</b> Resultado y estado del proceso de Legalización y Titulación del predio identificado con CBML <b>#{titulacion.cobama rescue nil}</b>


          En cumplimiento de la priorización de recursos realizada por la Comunidad del Corregimiento de Santa Elena, el Alcalde y su Equipo de Gobierno en las Jornadas de Vida y Equidad celebradas el 31 de agosto de 2013, el INSTITUTO SOCIAL DE VIVIENDA Y HÁBITAT DE MEDELLÍN –ISVIMED- desarrolló el programa de Titulación y Legalización de predios en dicho territorio, asesorando y llevando a cabo trámites judiciales y notariales de Pertenencia, Sucesión, Divisorio, Reglamento de Propiedad Horizontal, Conformación de Comunidad y Reconocimiento de Edificaciones.

          Dichos procesos pudieron llevarse a cabo sólo en los predios que: 1) cumplieron con la reglamentación establecida en el Plan de Ordenamiento Territorial –POT- del municipio de Medellín, contenida en el Acuerdo 048 de 2014; 2) el grupo beneficiario expresó la voluntad de hacer parte del programa y no existía conflicto al interior del mismo; y 3) existía la posibilidad jurídica de ejecutar el trámite respectivo.

          Conforme lo anterior, una vez analizada la situación jurídica y técnica de su predio, aunado a las visitas de campo realizadas al mismo, se pudo diagnosticar lo siguiente:", :align => :justify, :inline_format => true
          if  titulacion.final_diagnostico
            pdf.text "

                        <b>#{titulacion.final_diagnostico rescue nil}</b>

                    ", :align => :justify, :inline_format => true
          else
            pdf.text "

                        <b>ESTE CBML NO TIENE DIAGNOSTICO FINAL POR FAVOR COMPLEMENTAR</b>

                    ", :align => :justify, :inline_format => true
          end
          pdf.text "Cualquier inquietud con gusto será atendida en la Oficina de Atención al Usuario del ISVIMED, ubicada en la Calle 47D No. 75 – 240, en la ciudad de Medellín, en los horarios de atención de Lunes a Jueves de 07:30 a.m. a 05:00 p.m. y Viernes 07:30 a.m. a 04:00 p.m. Favor presentarse con esta carta.


          Cordialmente,


          _________________________________
          <b>#{Sifi.find(30).valor rescue nil}</b>
          <b>#{Sifi.find(31).valor rescue nil}</b>
          <b>ISVIMED</b>
         ", :align => :justify, :inline_format => true
        pdf.move_down(4)
        two_dimensional_array  = [ [pdf.make_cell(:content => "Jhonatan Granda", :size => 8, :align => :left)], [pdf.make_cell(:content => "Abogado", :size => 8, :align => :left)]]
        two_dimensional_array2 = [ [pdf.make_cell(:content => "Beatriz Helena Sánchez", :size => 8, :align => :left)], [pdf.make_cell(:content => "Profesional Especializada", :size => 8, :align => :left)]]
        pdf.table([[pdf.make_cell(:content => "Elaboró", :size => 8, :align => :left),
                    two_dimensional_array,
                    pdf.make_cell(:content => "Revisó y Aprobó", :size => 8, :align => :left),
                    two_dimensional_array2]])
        pdf.start_new_page
    end
  end
end

end