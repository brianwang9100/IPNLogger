require 'rubygems'
require 'sinatra'
require 'json'

get '/' do
    erb :form
end

post '/p' do
    @params = params[:message]
    @invoice = JSON.parse(@params)
    # erb :displaypost

end
