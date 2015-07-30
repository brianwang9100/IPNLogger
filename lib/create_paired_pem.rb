require 'rubygems'
require 'bitpay_sdk'
require_relative '../config/constants.rb'
uri = API_URI
client = BitPay::SDK::Client.new(api_uri: uri, insecure: true)

# prompt
puts "\n"
puts "Please enter the name of the pem you'd like to use (ex: pem.pem)"
file_name = gets.chomp
puts "\n"
# pairing
paired_client = client.pair_client
pairing_code = paired_client[0]['pairingCode']
puts "Please pair the pem with the pairing code: #{pairing_code} on #{uri}"
# writing
pem = client.instance_variable_get '@pem'
File.open("../pem/#{file_name}", 'w') {|file| file.write(pem)}
# config check
puts "Please check that the PEM_FILE_NAME in /config/constants.rb is properly set to '#{file_name}'"
puts "\n"
