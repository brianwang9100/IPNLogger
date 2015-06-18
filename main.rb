require 'rubygems'
require 'sinatra'
require 'json'
require 'net/http'
require_relative 'IPNLogger.rb'

get '/' do
    erb :form
end

post '/receive' do
    puts 'RECEIVED'
    binding.pry
    @params = request.body.read
    IPNLogger.write_to_file(@params)
    erb :displaypost
end

get '/send' do
    json_data = File.read('j.json')

    req = Net::HTTP::Post.new("/receive", initheader = {'Content-Type' =>'application/json'})
    req.body = json_data
    response = Net::HTTP.new("localhost", 4567).start {|http| http.request(req) }
    return JSON.parse(json_data)
end
