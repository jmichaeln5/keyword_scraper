# require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "https://stackoverflow.com/questions/6632873/how-to-make-html-ignore-code-that-is-part-of-text"

html_doc = Nokogiri::HTML(open(url))

# html_doc = Nokogiri::HTML(open(url)) do |config|
#   config.strict.noblanks
# end

# puts html_doc
# puts html_doc.class
# puts html_doc.at_css('title')
# puts html_doc.class

# puts html_doc.search('a')

i = 1 #Variable for iteration called 'i' which starts at 1

until i > 5 #Until we've gone over 5
	puts i #Output the loop count
	i = i + 1 #Add one to the loop count
end #End the loop


# xml_doc = Nokogiri::XML(open(url))
#
# puts xml_doc
# puts xml_doc.class
