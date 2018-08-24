require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "https://stackoverflow.com/questions/5046153/rails-and-openuri"
doc = Nokogiri::HTML(open(url))
puts doc.at_css("title").text
