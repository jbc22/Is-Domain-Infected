require 'rubygems'
require 'gscraper'

searchterm = "http://exero.eu/catalog/jquery.js"
results = ""

begin 
   file = File.open("domains.txt", "r")
rescue => err
   puts "Excetion opening file: #{err}"
   err
end

file.each_line { |domain|
   begin
      results = GScraper::Search.query(:query => "#{searchterm}")
      results.site = "#{domain}"
   rescue => Net::HTTPServiceUnavailable 
      puts "Cannot connect to google.com, HTTP STATUS CODE 503"
   end      

   results.page(1).map do |pages|
      puts pages.url
   end
}
