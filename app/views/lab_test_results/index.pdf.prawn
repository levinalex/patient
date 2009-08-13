pdf.text "Nombre: #{@accession.patient.full_name}", :size => 10, :style => :bold
pdf.text "Edad: #{@accession.patient.age}", :size => 10, :style => :bold
pdf.move_up(12)
pdf.text "Fecha: #{@accession.reported_at}", :size => 10, :align => :right

pdf.move_down(20)

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
  
  pdf.text department, :size => 10, :style => :bold, :align => :center
  pdf.move_down(1)
  pdf.table results_table, :border_style => :grid,
    :font_size => 9,
    :position => :center,
    :align => { 0 => :left, 1 => :center, 2 => :center, 3 => :center }
  pdf.move_down(15)
end

pdf.text "Improve with Prawn::Format", :size => 6
