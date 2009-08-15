############
#
# Lovelight
# PDF Template for Sales Report
# Sorry, its not real data. The company is real though.
#
###
#
# Created : 17 Jan 09 
# Craig Forster (CF) / craig@lovelight.co.nz
#
###
#
# Last Modified 
# CF - 17 Jan 09 - Stuffed around with my charts a bit more
#
############

# Global Variable and Style Definitions

#pdf.page_size = "A4" # I've hard-wired this in vendor/plugins/prawnto/lib/prawnto/template_handler/base.rb
#pdf.font "Helvetica" 
#pdf.font.size = 9

colors = {:black => "000000", :grey => "8d8d8d", :pink => "f096b8", :magenta => "eb4f95"} 

pdf.line_width = 0.75
pdf.stroke_color colors[:pink]


######
# Logo and Title
######

require "open-uri"

logoimage = "http://www.lovelight.co.nz/images/logo/logo-medium2.png" 
pdf.image open(logoimage), :at => [22,750], :scale => 0.25     

pdf.fill_color colors[:magenta]
pdf.text "Important Financial Report", :size => 24, :align => :center, :spacing => -4 , :at => [27, 650]
pdf.fill_color colors[:black]






######
# Date, Right Column
######

# Aligned to the right of our rightmost column, top-aligned to name
pdf.bounding_box([196,615], :width => 180, :height => 150) do
	pdf.fill_color colors[:grey]
	pdf.text "Date :", :align => :right
	pdf.move_down(5)
	pdf.text "Validity / Accuracy :",  :align => :right
	pdf.move_down(5)

end

pdf.fill_color colors[:black]

# Text fields are aligned left, on the right columnw
pdf.bounding_box([388,615], :width => 120, :height => 150) do

	pdf.text "17 Jan 2009"
	pdf.move_down(5)
	pdf.text "Less than 10%" 
	pdf.move_down(5)


end


######
# Name and Address
######

# in essence, this bounding box just gives us a rather nice left margin
pdf.bounding_box([27,615], :width => 200, :height => 600) do

 
	pdf.fill_color colors[:grey]
	pdf.text "For the attention of", :size => 8
	pdf.fill_color colors[:black]

  
	pdf.text "Mr Craig Forster", :size => 10
	pdf.text "CEO", :style => :bold, :size => 10
	pdf.text "PO Box 4482,\nChristchurch 8142,\nNew Zealand", :size => 10



	######
	# Income
	######

	pdf.move_down(33)

	
	pdf.text "Sales to budget - 2008",  :size => 9, :style => :bold, :spacing => 4
	pdf.stroke_horizontal_line(-5,485)
	pdf.move_down(5)

	pdf.text "We just made it!"
	
	
	###
	# 
	# Google Chart API
	#
	###
	#
	# API Documentation : http://code.google.com/apis/chart/
	# 
	### 1 - Sales
	# 3 Lines, Self Assessment, Target, Annual Assessments
	#
	# Size & Style
	# cht=lc							  : Style = Line
	# chs=300x150						  : Size = 300 x 150
	# chco=CA3A3A,eb4f95		 		  : Line colours (red dashed, magneta )
	# chls=1,4,1|2		 				  : Line weights = 1pt dashed, 2 point
	#
	# Axis
	# chxt=x,y							  : we want an axis on left and bottom
	# chxl=0:Jan%7CDec...  				  : x axis labels (%7C = | )
	# chxr=1,0,5000					 	  : y-Axis, Min (0), Max (5000). Should co-incide with chds (below)
	#
	# Title & Legend
	# chtt=Sales			 			  : Title (Specify a space with a plus sign (+),Use a pipe character (|) to force a line break)
	# chts=000000,12					  : Title Colour & font-size
	# chdl=Budget|Actual				  : Legend
	# chdlp=b					 		  : places the legend at the bottom
	#
	# Data
	# chd=t:40,40|15,54...				  : Data Sets... in this order : Budget, Actual
	# chds=0,60				  		      : Data Scaling. As each line chart with the API is 0-100, we scale it back with 0 and our max. This should co-incide with our y-AXIS


	saleschart = "http://chart.apis.google.com/chart?cht=lc&chs=300x150&chco=CA3A3A,eb4f95&chls=1,4,1%7C2&chxt=x,y&chxl=0:%7CJan%7C%7CDec&chxr=1,0,5000&chtt=Sales&chts=000000,12&chdl=Budget%7CActual&chdlp=b&chd=t:40,40%7C15,54,55,8,41,60,44,38,68&chds=0,70"
	pdf.image open(saleschart), :at => [0, 430], :scale => 0.5
	
	
	######
	# Profit by Sector
	######

	pdf.pad_top(178) do
		pdf.text "Profit by Sector", :size => 9, :style => :bold, :spacing => 4
	end
	
	pdf.stroke_horizontal_line(-5,485)
	pdf.move_down(5)


	pdf.text "We made more from weddings than we did from software development... just! "

	sectorchart = "http://chart.apis.google.com/chart?chs=300x150&chco=eb4f95&chd=t:20,6,34,40&cht=p&chl=Web+Design%7CConsulting%7CSoftware%7CWeddings&chtt=Profit+by+sector"
	pdf.image open(sectorchart), :at => [0, 230], :scale => 0.5


	#ends the bounding box that gives us a left margin
end 


######
# Footer
######

 pdf.fill_color colors[:magenta]
 pdf.text "Looking to have your New Zealand wedding filmed? www.lovelight.co.nz", :at => [27,-11], :align => :left, :size => 9
 pdf.fill_color colors[:grey]

 pdf.text "PDF developed by craig@lovelight.co.nz, using the Google charts API, Prawn and prawnto via rails on a Mac", :at =>[27,-22], :align => :left, :size => 5