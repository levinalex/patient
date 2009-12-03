##
# Corporate colors

colors = {:black => "000000", :grey => "dcdcdc", :light_grey => "e4e4e4", :pink => "f096b8", :high_value => "ff0000", :low_value => "0000ff", :abnormal_value => "513059", :white => "ffffff"}

##
# Document defaults

pdf.font "Helvetica" 
pdf.font_size = 8

##
# Header

pdf.header pdf.margin_box.top_left do
  ##
  # Header with logo and information

  require "open-uri"
  logoimage = "http://localhost:3000/images/logo.png" 
  pdf.image open(logoimage), :at => [pdf.bounds.left, pdf.bounds.top + 110], :scale => 0.5

  pdf.bounding_box([pdf.bounds.right - 80, pdf.bounds.top + 110], :width => 80, :height => 15) do
    pdf.fill_color colors[:high_value]
    pdf.text "#{t('.preliminary') unless @accession.reported_at}", :align => :right
    pdf.fill_color colors[:black]
  end

  ##
  # TODO: Replace 125 to use the width of the logo image and 135 to center in its height also

  pdf.bounding_box([pdf.bounds.left + 125, pdf.bounds.top + 110], :width => 350, :height => 50) do
    pdf.text "MasterLab - Laboratorio Clínico Especializado", :size => 12, :style => :bold
    pdf.text "Villa Lucre, Consultorios San Judas Tadeo, Local 107", :size => 10
    pdf.text "Tel: 222-9200 ext. 1107 / Telefax: 277-7832", :size => 10
    pdf.text "Director: Lcdo. Erick Chu, TM, MSc - Email: masterlab@labtecsa.com", :size => 10
  end

  pdf.fill_color colors[:grey]
  pdf.fill_and_stroke do
    pdf.rectangle [0, 620], 540, 15
  end
  pdf.fill_color colors[:black]
  
  pdf.bounding_box([5,620], :width => 140, :height => 15) do
    pdf.pad(5) do
      pdf.text t('.lab_test'), :style => :bold, :align => :left
    end
  end
  pdf.bounding_box([140,620], :width => 60, :height => 15) do
    pdf.pad(5) do
      pdf.text t('.result'), :style => :bold, :align => :center
    end
  end
  pdf.bounding_box([200,620], :width => 88, :height => 15) do
    pdf.span(88, :position => 205) do
      pdf.pad(5) do
        pdf.text t('.units'), :style => :bold, :align => :left
      end
    end
  end
  pdf.bounding_box([288,620], :width => 100, :height => 15) do
    pdf.pad(5) do
      pdf.text t('.flag'), :style => :bold, :align => :center
    end
  end
  pdf.bounding_box([388,620], :width => 152, :height => 15) do
    pdf.pad(5) do
      pdf.fill_color colors[:abnormal_value]
      pdf.text t('.range'), :style => :bold, :align => :center
      pdf.fill_color colors[:black]
    end
  end
end

##
# Footer

num_pag=0 
pdf.footer [pdf.bounds.left, pdf.bounds.bottom + 20] do
  pdf.font "Helvetica" do
    pdf.move_down 15
    pdf.line_width = 1
    pdf.stroke_horizontal_rule
    pdf.move_down 5
    pdf.text "#{t('.originally_printed_at')} #{@accession.reported_at.strftime('%e/%m/%Y %l:%m%p') if @accession.reported_at}#{t('.preliminary') unless @accession.reported_at}"
    pdf.text "#{t('.printed_at')} #{Time.now.strftime('%e/%m/%Y %l:%m%p')}"
    num_pag += 1
    ##
    # Should be inside a lazy_bounding_box
    # #{pdf.page_count}
    ##
    pdf.text "#{t('.page')} " + num_pag.to_s + " #{t('.of')} " + pdf.page_count.to_s, :align => :left
    pdf.move_up 27
    pdf.text "#{t('.accession')} #{@accession.id}", :align => :right
    pdf.text "#{t('.results_of')} #{@accession.patient.full_name}", :align => :right
    pdf.fill_color colors[:high_value]
    pdf.text "#{t('.preliminary') unless @accession.reported_at}", :align => :right
    pdf.fill_color colors[:black]
  end
end

##
# Report

##
# Patient demographics

pdf.stroke_line [pdf.bounds.left,655], [pdf.bounds.right,655]


########################

pdf.bounding_box([5,650], :width => 40, :height => 10) do
  pdf.text t('.full_name'), :style => :bold
end
pdf.bounding_box([5,640], :width => 40, :height => 10) do
  pdf.text t('.identifier')
end
pdf.bounding_box([5,630], :width => 40, :height => 10) do
  pdf.text t('.doctor')
end
pdf.bounding_box([45,650], :width => 265, :height => 10) do
  pdf.text @accession.patient.full_name, :style => :bold
end
pdf.bounding_box([45,640], :width => 155, :height => 10) do
  pdf.text @accession.patient.identifier
end
pdf.bounding_box([45,630], :width => 155, :height => 10) do
  pdf.text @accession.doctor_name
end

########################

pdf.bounding_box([200,640], :width => 30, :height => 10) do
  pdf.text t('.age')
end
pdf.bounding_box([200,630], :width => 30, :height => 10) do
  pdf.text t('.gender')
end
pdf.bounding_box([230,640], :width => 80, :height => 10) do
  pdf.text "#{@accession.patient_age} #{t('.years')}"
end
pdf.bounding_box([230,630], :width => 80, :height => 10) do
  pdf.text @accession.patient.gender_name
end

########################

pdf.bounding_box([310,650], :width => 80, :height => 10) do
  pdf.text t('.accession'), :style => :bold
end
pdf.bounding_box([310,640], :width => 80, :height => 10) do
  pdf.text t('.drawn_at')
end
pdf.bounding_box([310,630], :width => 80, :height => 10) do
  pdf.text t('.received_at')
end
pdf.bounding_box([390,650], :width => 150, :height => 10) do
  pdf.text @accession.id, :style => :bold
end
pdf.bounding_box([390,640], :width => 150, :height => 10) do
  pdf.text @accession.drawn_at.strftime('%e/%m/%Y %l:%m%p')
end
pdf.bounding_box([390,630], :width => 150, :height => 10) do
  pdf.text "#{@accession.received_at.strftime('%e/%m/%Y %l:%m%p') if @accession.received_at}"
end

pdf.move_down(25)

##
# Report values

##
# TODO:
# - Try adding the NOTES: with column_box check out example in github
##

@results.each do |department, results|
  table_headers = [Prawn::Table::Cell.new( :text => department, :font_style => :bold, :borders => [:none], :vertical_padding => 5 )]
  results_table = results.map do |result|
    if result.flag
    [
      Prawn::Table::Cell.new( :text => result.lab_test.name, :borders => [:bottom], :horizontal_padding => 5, :background_color => colors[:grey] ),
      Prawn::Table::Cell.new( :text => result.formatted_value, :borders => [:bottom], :background_color => colors[:grey] ),
      Prawn::Table::Cell.new( :text => result.units, :borders => [:bottom], :horizontal_padding => 5 ),
      Prawn::Table::Cell.new( :text => result.flag, :borders => [:bottom], :font_style => :bold, :text_color => colors[:"#{result.flag_color}"] ),
      Prawn::Table::Cell.new( :text => result.range_min, :borders => [:bottom] ),
      Prawn::Table::Cell.new( :text => result.range_interval_symbol, :borders => [:bottom] ),
      Prawn::Table::Cell.new( :text => result.range_max, :borders => [:bottom] )
    ]
    else
      [
        Prawn::Table::Cell.new( :text => result.lab_test.name, :borders => [:bottom], :horizontal_padding => 5 ),
        Prawn::Table::Cell.new( :text => result.formatted_value, :borders => [:bottom] ),
        Prawn::Table::Cell.new( :text => result.units, :borders => [:bottom], :horizontal_padding => 5 ),
        Prawn::Table::Cell.new( :text => result.flag, :borders => [:bottom], :font_style => :bold, :text_color => colors[:"#{result.flag_color}"] ),
        Prawn::Table::Cell.new( :text => result.range_min, :borders => [:bottom] ),
        Prawn::Table::Cell.new( :text => result.range_interval_symbol, :borders => [:bottom] ),
        Prawn::Table::Cell.new( :text => result.range_max, :borders => [:bottom] )
      ]
    end
  end
  
  pdf.text department, :style => :bold, :at => [0,pdf.cursor-5]
  pdf.text "#{[t('.run_by'), User.find(@accession.reported_by).initials, t('.on_date'), @accession.reported_at.strftime('%e/%m/%Y %l:%m%p')].join(' ') if @accession.reported_at}", :size => 7.5, :style => :italic, :align => :right
  pdf.text "#{' ' unless @accession.reported_at}", :size => 7.5
  pdf.table results_table,
#    :headers => table_headers,
    :font_size => 8,
    :vertical_padding => 2,
#    :horizontal_padding => 0,
    :border_color => colors[:light_grey],
    :border_width => 0.75,
    :position => :left,
    :align => { 0 => :left, 1 => :right, 2 => :left, 3 => :center, 4 => :right, 5 => :center, 6 => :left },
    :column_widths => { 0 => 140, 1 => 60, 2 => 88, 3 => 100, 4 => 65, 5 => 22, 6 => 65 }
  
  if @accession.department_notes(Department.find_by_name(department).id)
    pdf.move_down(5)
    pdf.indent(45) do
      pdf.fill_color colors[:abnormal_value]
      pdf.text "#{t('.notes')} #{@accession.department_notes(Department.find_by_name(department).id).content}", :style => :bold_italic
    end
    pdf.fill_color colors[:black]
  end

  pdf.move_down(10)

end

##
# End of report

pdf.move_up(10)
pdf.horizontal_rule
pdf.move_down(10)
  
##
# Signature

pdf.move_down(25)
pdf.text t('.reviewed_by'), :at => [70,pdf.cursor]
pdf.text t('.date'), :at => [330,pdf.cursor]
pdf.stroke_line [356,pdf.cursor], [470,pdf.cursor]
pdf.bounding_box([121,pdf.cursor], :width => 164, :height => 15) do
  pdf.stroke_horizontal_rule
  pdf.pad_top(5) do
    pdf.text "#{User.find(current_user).name_to_display}", :align => :center
  end
end
