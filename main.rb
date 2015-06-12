require 'rubygems'
require 'sinatra'
require 'json'

get '/' do
    erb :form
end

post '/p' do
    @params = params[:message]
    # erb :displaypost

end
