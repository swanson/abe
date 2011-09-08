require 'sinatra'
require 'erb'
require 'json'
require 'mongo'

class Abe < Sinatra::Base

  configure do
    uri_string = uri_string = ENV['MONGOHQ_URL'] || ENV['MONGOHQ_ABE']
    uri = URI.parse(uri_string)
    conn = Mongo::Connection.from_uri(uri_string)
    db = conn.db(uri.path.gsub(/^\//, ''))
    $coll = db.collection('facts')
  end

  get '/' do
    r = rand(42)
    fact = $coll.find_one({'random' => r})
    @pres = fact['pres']
    @fact = fact['fact']
    erb :index
  end

  get '/fact' do
    content_type :json
    r = rand(42)
    fact = $coll.find_one({'random' => r})
    fact.to_json
  end
end
