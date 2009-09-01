##
# Corporate colors

colors = {:black => "000000", :grey => "e5e5e5", :pink => "f096b8", :high_value => "ff0000", :low_value => "0000ff", :abnormal_value => "800080", :white => "ffffff"}

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

pdf.bounding_box([460, 730], :width => 80, :height => 15) do
  pdf.fill_color colors[:high_value]
  pdf.text "#{t('.preliminary') unless @accession.reported_at}", :size => 8, :align => :right
  pdf.fill_color colors[:black]
end

pdf.bounding_box([125,730], :width => 350, :height => 50) do
  pdf.text "MasterLab - Laboratorio Clínico Especializado", :size => 12, :style => :bold
  pdf.text "Villa Lucre, Consultorios San Judas Tadeo, Local 107", :size => 10
  pdf.text "Tel: 222-9200 ext. 1107 / Telefax: 277-7832", :size => 10
  pdf.text "Director: Lcdo. Erick Chu, TM, MSc - Email: masterlab@labtecsa.com", :size => 10
end

pdf.move_down(25)

##
# Report

##
# Patient demographics

pdf.stroke_horizontal_rule

pdf.bounding_box([5,650], :width => 45, :height => 50) do
  pdf.text t('.full_name'), :size => 8, :style => :bold
  pdf.text t('.identifier'), :size => 8
  pdf.text t('.doctor'), :size => 8
end
pdf.bounding_box([45,650], :width => 150, :height => 50) do
  pdf.text @accession.patient.full_name, :size => 8, :style => :bold
  pdf.text @accession.patient.identifier, :size => 8
  pdf.text "—", :size => 8
end

pdf.bounding_box([200,641], :width => 30, :height => 50) do
  pdf.text t('.age'), :size => 8
  pdf.text t('.gender'), :size => 8
end
pdf.bounding_box([230,641], :width => 40, :height => 50) do
  pdf.text "#{@accession.patient_age} #{t('.years')}", :size => 8
  pdf.text @accession.patient.gender_name, :size => 8
end

pdf.bounding_box([310,650], :width => 80, :height => 50) do
  pdf.text t('.accession'), :size => 8, :style => :bold
  pdf.text t('.drawn_at'), :size => 8
  pdf.text t('.received_at'), :size => 8
end
pdf.bounding_box([390,650], :width => 150, :height => 50) do
  pdf.text @accession.id, :size => 8, :style => :bold
  pdf.text @accession.drawn_at.strftime('%d/%m/%Y %I:%M %p'), :size => 8
  pdf.text "#{@accession.received_at.strftime('%d/%m/%Y %I:%M %p') if @accession.received_at}", :size => 8
end

##
# Report values

##
# - Change the range value for independent range_min & range_max to align them
# - Try adding the NOTES: with column_box check out example in github
##

pdf.header pdf.margin_box.top_left do
  pdf.fill_color colors[:pink]
  pdf.fill_and_stroke do
    pdf.rectangle [0, 620], 540, 15
  end
  pdf.fill_color colors[:black]
  
  pdf.bounding_box([5,620], :width => 140, :height => 15) do
    pdf.pad(5) do
      pdf.text t('.lab_test'), :size => 8, :style => :bold, :align => :left
    end
  end
  pdf.bounding_box([140,620], :width => 60, :height => 15) do
    pdf.pad(5) do
      pdf.text t('.result'), :size => 8, :style => :bold, :align => :center
    end
  end
  pdf.bounding_box([200,620], :width => 88, :height => 15) do
    pdf.pad(5) do
      pdf.text t('.units'), :size => 8, :style => :bold, :align => :left
    end
  end
  pdf.bounding_box([288,620], :width => 100, :height => 15) do
    pdf.pad(5) do
      pdf.text t('.flag'), :size => 8, :style => :bold, :align => :center
    end
  end
  pdf.bounding_box([388,620], :width => 152, :height => 15) do
    pdf.pad(5) do
      pdf.text t('.range'), :size => 8, :style => :bold, :align => :center
    end
  end
end

##
# Try a bounding box here accession 17
##

@results.each do |department, results|
  table_headers = [Prawn::Table::Cell.new( :text => department, :font_style => :bold, :borders => [:none], :padding => 5 )]
  results_table = results.map do |result|
    units = result.lab_test.lab_test_unit.name if result.lab_test.lab_test_unit
    [
      Prawn::Table::Cell.new( :text => result.lab_test.name, :borders => [:bottom], :horizontal_padding => 15 ),
      Prawn::Table::Cell.new( :text => result.formatted_value, :borders => [:bottom] ),
      Prawn::Table::Cell.new( :text => units, :borders => [:bottom] ),
      Prawn::Table::Cell.new( :text => result.flag, :borders => [:bottom], :font_style => :bold, :text_color => colors[:"#{result.flag_color}"] ),
      Prawn::Table::Cell.new( :text => result.range_min, :borders => [:bottom] ),
      Prawn::Table::Cell.new( :text => result.range_interval_symbol, :borders => [:bottom] ),
      Prawn::Table::Cell.new( :text => result.range_max, :borders => [:bottom] )
    ]
  end
  
  pdf.text department, :size => 8, :style => :bold, :at => [0,pdf.cursor-5]
  pdf.text "#{[t('.run_by'), User.find(@accession.reported_by).initials, t('.on_date'), @accession.reported_at.strftime('%d/%m/%Y %I:%M %p')].join(' ') if @accession.reported_at}", :size => 7.5, :style => :italic, :align => :right
  pdf.text "#{' ' unless @accession.reported_at}", :size => 7.5
  pdf.table results_table,
#    :headers => table_headers,
    :font_size => 8,
    :vertical_padding => 2,
#    :horizontal_padding => 0,
    :border_color => colors[:grey],
    :border_width => 0.75,
    :position => :left,
    :align => { 0 => :left, 1 => :right, 2 => :left, 3 => :center, 4 => :right, 5 => :center, 6 => :left },
    :column_widths => { 0 => 140, 1 => 60, 2 => 88, 3 => 100, 4 => 65, 5 => 22, 6 => 65 }

  pdf.move_down(10)
end
  
##
# Signature

pdf.move_down(15)
pdf.text t('.reviewed_by'), :size => 8, :at => [70,pdf.cursor]
pdf.text t('.date'), :size => 8, :at => [330,pdf.cursor]
pdf.stroke_line [356,pdf.cursor], [470,pdf.cursor]
pdf.bounding_box([121,pdf.cursor], :width => 164, :height => 15) do
  pdf.stroke_horizontal_rule
  pdf.pad_top(5) do
    pdf.text "#{User.find(current_user).name_to_display}", :size => 8, :align => :center
  end
end

##
# Footer

num_pag=0 
pdf.footer [0,40] do
  pdf.font "Helvetica" do
    pdf.move_down 15
    pdf.line_width = 1
    pdf.stroke_horizontal_rule
    pdf.move_down 5
    pdf.text "#{t('.originally_printed_at')} #{@accession.reported_at.strftime('%d/%m/%Y %I:%M %p') if @accession.reported_at}#{t('.preliminary') unless @accession.reported_at}", :size => 8
    pdf.text "#{t('.printed_at')} #{Time.now.strftime('%d/%m/%Y %I:%M %p')}", :size => 8
    num_pag += 1
    ##
    # Should be inside a lazy_bounding_box
    # #{pdf.page_count}
    ##
    pdf.text t('.page')+num_pag.to_s+" #{t('.of')} "+pdf.page_count.to_s, :size => 8, :align => :left
    pdf.move_up 27
    pdf.text "#{t('.accession')} #{@accession.id}", :size => 8, :align => :right
    pdf.text "#{t('.results_of')} #{@accession.patient.full_name}", :size => 8, :align => :right
    pdf.fill_color colors[:high_value]
    pdf.text "#{t('.preliminary') unless @accession.reported_at}", :size => 8, :align => :right
    pdf.fill_color colors[:black]
  end
end
