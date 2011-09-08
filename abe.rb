require 'sinatra'
require 'erb'
require 'json'

class Abe < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/fact' do
    content_type :json
    {"fact" => "got stuck in a bathtub?", "pres" => "Taft"}.to_json
  end
end
