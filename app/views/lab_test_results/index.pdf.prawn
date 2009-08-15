colors = {:black => "000000", :grey => "8d8d8d", :pink => "f096b8", :magenta => "eb4f95"} 

logoimage = "http://localhost:3000/images/MasterLab.png" 
pdf.image open(logoimage), :at => [0,745], :scale => 0.5

pdf.bounding_box([125,730], :width => 350, :height => 50) do
  pdf.text "MasterLab - Laboratorio Clínico Especializado", :size => 12, :style => :bold
  pdf.text "Villa Lucre, Cosultorios San Judas Tadeo, Local 107", :size => 10
  pdf.text "Tel: 222-9200 ext. 1107 / Telefax: 277-7832", :size => 10
  pdf.text "Director: Lcdo. Erick Chu, TM, MSc - email: masterlab@labtecsa.com", :size => 10
end

pdf.line_width = 1
pdf.move_down(25)
pdf.stroke_horizontal_line(0,540)
pdf.line_width = 0.75

pdf.bounding_box([5,650], :width => 45, :height => 50) do
  pdf.text "Nombre:", :size => 8, :style => :bold
  pdf.text "Cédula:", :size => 8
  pdf.text "Doctor:", :size => 8
end
pdf.bounding_box([45,650], :width => 150, :height => 50) do
  pdf.text "#{@accession.patient.full_name}", :size => 8, :style => :bold
  pdf.text "#{@accession.patient.identifier}", :size => 8
  pdf.text "", :size => 8
end

pdf.bounding_box([200,641], :width => 30, :height => 50) do
  pdf.text "Edad:", :size => 8
  pdf.text "Sexo:", :size => 8
end
pdf.bounding_box([230,641], :width => 30, :height => 50) do
  pdf.text "#{@accession.patient.age} años", :size => 8
  pdf.text "#{@accession.patient.gender}", :size => 8
end

pdf.bounding_box([310,650], :width => 80, :height => 50) do
  pdf.text "Accesión:", :size => 8, :style => :bold
  pdf.text "Fecha de extracción:", :size => 8
  pdf.text "Fecha de recepción:", :size => 8
end
pdf.bounding_box([390,650], :width => 150, :height => 50) do
  pdf.text "#{@accession.id}", :size => 8, :style => :bold
  pdf.text "#{@accession.drawn_at.strftime('%d/%m/%Y %I:%M %p')}", :size => 8
  pdf.text "#{@accession.received_at.strftime('%d/%m/%Y %I:%M %p') if @accession.received_at}", :size => 8
end

pdf.fill_color colors[:pink]
pdf.fill_and_stroke do
  pdf.rectangle [0, 620], 540, 15
end
pdf.fill_color colors[:black]

pdf.text "Test Name", :size => 8, :style => :bold, :at => [10,610]
pdf.text "Result", :size => 8, :style => :bold, :at => [150,610]
pdf.text "Units", :size => 8, :style => :bold, :at => [210,610]
pdf.text "Flag", :size => 8, :style => :bold, :at => [330,610]
pdf.text "Reference Range", :size => 8, :style => :bold, :at => [430,610]

@results.each do |department, results|
  results_table = results.map do |result|
    units = result.lab_test.lab_test_unit.name if result.lab_test.lab_test_unit
    [
      result.lab_test.name,
      result.formatted_value,
      units,
      result.range
    ]
  end
  
  pdf.text department, :size => 8, :style => :bold, :align => :left
  pdf.table results_table,
    :font_size => 8,
    :vertical_padding => 2,
    :border_color => colors[:grey],
    :border_width => 0.75,
    :border_style => :header_bottom,
    :position => :left,
    :align => { 0 => :left, 1 => :right, 2 => :left, 3 => :center }
  pdf.move_down(15)
end

pdf.text "Improve with Prawn::Format", :size => 6

num_pag=0 
pdf.footer [pdf.margin_box.left, pdf.margin_box.bottom + 25] do
  pdf.font "Helvetica" do
pdf.text "Firma:", :size => 8, :at => [70,pdf.margin_box.bottom + 40]
pdf.text "Fecha:", :size => 8, :at => [330,pdf.margin_box.bottom + 40]
pdf.text "Lcdo. Yoshi Temato", :size => 8, :at => [150,pdf.margin_box.bottom + 30]
pdf.stroke_horizontal_line(95,280)
pdf.stroke_horizontal_line(355,450)
pdf.move_down(25)
    pdf.line_width = 1
    pdf.stroke_horizontal_rule
    pdf.move_down 5
    pdf.text "Fecha de reporte: #{@accession.reported_at.strftime('%d/%m/%Y %I:%M %p')}", :size => 8
    num_pag += 1
    pdf.text "Página "+num_pag.to_s+" de "+pdf.page_count.to_s,
      :align => :center, :size => 8, :align => :left
    pdf.move_up 18
    pdf.text "Accesión: #{@accession.id}", :size => 8, :align => :right
    pdf.text "Resultados de: #{@accession.patient.full_name}", :size => 8, :align => :right
  end
end
