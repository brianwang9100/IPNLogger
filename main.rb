require 'rubygems'
require 'sinatra'
require 'json'
require_relative 'IPNLogger.rb'
require 'rest-client'

get '/' do
    erb :form
end

post '/receive' do
    @params = request.body.read
    IPNLogger.write_to_file(@params)
    erb :displaypost
end

get '/send' do
    json_data = File.read('j.json')
    # response = RestClient.post 'http://localhost:4567/', json_data, :content_type => :json

    req = Net::HTTP::Post.new("/receive", initheader = {'Content-Type' =>'application/json'})
    req.body = json_data
    response = Net::HTTP.new("localhost", 4567).start {|http| http.request(req) }
    return JSON.parse(json_data)
end
