require 'rubygems'
require 'sinatra'
require 'json'
require 'net/http'
require_relative './lib/logger_utils.rb'
require_relative './lib/db_utils.rb'
require_relative './lib/server_utils.rb'

Tilt.register Tilt::ERBTemplate, 'html.erb'
include BitPay::IPNLoggerUtils
include BitPay::IPNDataBaseUtils
include BitPay::IPNServerUtils

def herb(template, options={}, locals={})
  render "html.erb", template, options, locals
end

get '/' do
    #json
    @last_table = get_last_ipn

    #file
    @list_table = get_list_ipn
    herb :home
end

post '/receive' do
    @params = request.body.read
    write_to_files(@params)
end

# get '/send' do
#     json_data = File.read('tests/test.json')
#
#     req = Net::HTTP::Post.new("/receive", initheader = {'Content-Type' =>'application/json'})
#     req.body = json_data
#     response = Net::HTTP.new("localhost", 4567).start {|http| http.request(req) }
#     # return JSON.parse(json_data)
# end

post '/clear' do
    clear_logs
    puts 'logs have been cleared'
    erb :clear
end

post '/resend' do
    @invoice_id = params[:invoice_id]
    if (!@invoice_id.nil? && !@invoice_id.empty?)
        post_for_resend_notification(invoice_id: @invoice_id)
    end
    erb :resend
end
