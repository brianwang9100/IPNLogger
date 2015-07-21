require 'rubygems'
require 'bitpay_sdk'
require_relative '../config/constants.rb'
uri = API_URI
puts "Posting invoice creation to #{uri}"
pem = File.read(PEM_PATH)
client = BitPay::SDK::Client.new(api_uri: uri, pem: pem, insecure: true)
randomNumber = rand * (0.00099900-0.00001000) + 0.00001000
randomNumber.round(8)
invoice = client.create_invoice(price: randomNumber.round(8), currency: 'BTC', facade: 'merchant', params: {notificationURL: ROOT_URL + '/receive', fullNotifications: true})
puts "Please pay for the invoice: btcPrice = " + invoice['btcPrice'] + " Address = " + invoice['paymentUrls']['BIP21'][8...42]
