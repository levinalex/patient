##
# TODO
#
# i18n this document

##
# Corporate colors
# Should this be CMYK instead????

colors = {:black => "000000", :grey => "e5e5e5", :pink => "f096b8", :white => "ffffff"}

##
# Writeable max width: 540
# Writeable max height: 750????
#pdf.stroke_color colors[:grey]
#pdf.stroke_line [pdf.bounds.left,pdf.bounds.bottom], [pdf.bounds.right,pdf.bounds.top]
#pdf.stroke_color colors[:black]

##
# Header with logo and information

require "open-uri"
logoimage = "http://localhost:3000/images/logo.png" 
pdf.image open(logoimage), :at => [0,745], :scale => 0.5

pdf.bounding_box([125,730], :width => 350, :height => 50) do
  pdf.text "MasterLab - Laboratorio Clínico Especializado", :size => 12, :style => :bold, :kerning => true
  pdf.text "Villa Lucre, Cosultorios San Judas Tadeo, Local 107", :size => 10, :kerning => true
  pdf.text "Tel: 222-9200 ext. 1107 / Telefax: 277-7832", :size => 10, :kerning => true
  pdf.text "Director: Lcdo. Erick Chu, TM, MSc - Email: masterlab@labtecsa.com", :size => 10, :kerning => true
end

##
# Report

pdf.line_width = 1
pdf.move_down(25)
pdf.stroke_horizontal_line(0,540)
pdf.line_width = 0.75

##
# Patient demographics

pdf.bounding_box([5,650], :width => 45, :height => 50) do
  pdf.text "Nombre:", :size => 8, :style => :bold
  pdf.text "Cédula:", :size => 8
  pdf.text "Doctor:", :size => 8
end
pdf.bounding_box([45,650], :width => 150, :height => 50) do
  pdf.text "#{@accession.patient.full_name}", :size => 8, :style => :bold
  pdf.text "#{@accession.patient.identifier}", :size => 8
  pdf.text "—", :size => 8
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

##
# Report values

##
# - Change the range value for independent range_min & range_max to align them
# - Try adding the NOTES: with column_box check out example in github
##

pdf.fill_color colors[:pink]
pdf.fill_and_stroke do
  pdf.rectangle [0, 620], 540, 15
end
pdf.fill_color colors[:black]

pdf.text "Prueba", :size => 8, :style => :bold, :at => [10,610]
pdf.text "Resultado", :size => 8, :style => :bold, :at => [150,610]
pdf.text "Undades", :size => 8, :style => :bold, :at => [210,610]
pdf.text "Flag", :size => 8, :style => :bold, :at => [330,610]
pdf.text "Rango de Referencia", :size => 8, :style => :bold, :at => [430,610]

@results.each do |department, results|
  results_table = results.map do |result|
    units = result.lab_test.lab_test_unit.name if result.lab_test.lab_test_unit
    flag = result.flag unless result.flag == "normal_value"
    [
      Prawn::Table::Cell.new( :text => result.lab_test.name, :borders => [:bottom] ),
      Prawn::Table::Cell.new( :text => result.formatted_value, :borders => [:bottom] ),
      Prawn::Table::Cell.new( :text => units, :borders => [:bottom] ),
      Prawn::Table::Cell.new( :text => flag, :borders => [:bottom] ),
      Prawn::Table::Cell.new( :text => result.range, :borders => [:bottom] )
    ]
  end
  
  pdf.text department, :size => 8, :style => :bold, :align => :left
  pdf.table results_table,
    :font_size => 8,
    :vertical_padding => 2,
    :border_color => colors[:grey],
    :border_width => 0.75,
    :border_style => :underline_header,
    :position => :left,
    :align => { 0 => :left, 1 => :right, 2 => :left, 3 => :center, 4 => :center },
    :column_widths => { 0 => 140, 1 => 60, 2 => 88, 3 => 100, 4 => 152 }

  ##
  # Hackish last-child element no-border
  
  #pdf.stroke_color colors[:white]
  #pdf.line_width = 2
  #pdf.stroke_horizontal_line(0,540)
  #pdf.stroke_color colors[:black]
  #pdf.line_width = 0.75

  pdf.move_down(15)
end
  
##
# Signature

pdf.move_down(15)
pdf.text "Firma:", :size => 8, :at => [70,pdf.cursor]
pdf.text "Fecha:", :size => 8, :at => [330,pdf.cursor]
pdf.stroke_line [356,pdf.cursor], [470,pdf.cursor]
pdf.bounding_box([95,pdf.cursor], :width => 190, :height => 15) do
  pdf.stroke_horizontal_rule
  pdf.pad_top(5) do
    pdf.text "Lcdo. Yoshi Temato", :size => 8, :align => :center
  end
end

##
# Footer

num_pag=0 
pdf.footer [0,40] do
  pdf.font "Helvetica" do
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
