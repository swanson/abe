require 'rubygems'
require 'mongo'
require 'uri'
require 'json'

uri_string = ENV['MONGOHQ_URL'] || ENV['MONGOHQ_ABE']
uri = URI.parse(uri_string)
conn = Mongo::Connection.from_uri(uri_string)
db = conn.db(uri.path.gsub(/^\//, ''))
facts = db.collection("facts")
facts.remove

file = File::open('president_list.txt', 'r')

i = 0
file.each do |line|
 cols = line.split('|')
 doc = {
    "pres" => cols[0],
    "fact" => cols[1].strip,
    "random" => i
 }
 i+=1
 facts.insert(doc)
end
