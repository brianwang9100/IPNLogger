require 'rubygems'
require 'minitest/autorun'
require 'bitpay_sdk'
require_relative 'IPNLogger.rb'
require 'Time'

class LogTests < MiniTest::Unit::TestCase

    # #also another really shitty test because i'm too lazy to write asserts
    # def test_json_to_log_string
    #     file = File.read('j.json')
    #     log_string = IPNLogger.parse_to_log_string(file, Time.now)
    #     assert_match(/id:\s[a-zA-Z0-9]*/, log_string)
    #     assert_match(/status:\s((paid)|(confirmed)|(completed))/, log_string)
    #     assert_match(/btcPrice:\s(\d+(\.\d+)?)/, log_string)
    #     assert_match(/url:\s.*/, log_string)
    #     assert_match(/    posData:\s\d+/, log_string)
    #     assert_match(/    price:\s(\d+(\.\d+)?)/, log_string)
    #     assert_match(/    currency:\s.*/, log_string)
    #     assert_match(/    invoiceTime:\s\d+/, log_string)
    #     assert_match(/    expirationTime:\s\d+/, log_string)
    #     assert_match(/    currentTime:\s\d+/, log_string)
    #     assert_match(/    btcPaid:\s(\d+(\.\d+)?)/, log_string)
    #     assert_match(/    rate:\s(\d+(\.\d+)?)/, log_string)
    #     assert_match(/    exceptionStatus:\s((false)|(true))/, log_string)
    #     assert_match(/    buyerFields:\s.*/, log_string)
    # end
    # #reallyshittytests because i'm too lazy
    # def test_json_to_file
    #     for i in 0...10
    #         file = File.read('j.json')
    #         IPNLogger.write_to_file(file, 'id')
    #         ipn = JSON.parse(file)
    #         returnFile = File.read("./logs/" + ipn['id'])
    #         assert_match(/id:\s[a-zA-Z0-9]*/, returnFile)
    #         assert_match(/status:\s((paid)|(confirmed)|(completed))/, returnFile)
    #         assert_match(/btcPrice:\s(\d+(\.\d+)?)/, returnFile)
    #         assert_match(/url:\s.*/, returnFile)
    #         assert_match(/    posData:\s\d+/, returnFile)
    #         assert_match(/    price:\s(\d+(\.\d+)?)/, returnFile)
    #         assert_match(/    currency:\s.*/, returnFile)
    #         assert_match(/    invoiceTime:\s\d+/, returnFile)
    #         assert_match(/    expirationTime:\s\d+/, returnFile)
    #         assert_match(/    currentTime:\s\d+/, returnFile)
    #         assert_match(/    btcPaid:\s(\d+(\.\d+)?)/, returnFile)
    #         assert_match(/    rate:\s(\d+(\.\d+)?)/, returnFile)
    #         assert_match(/    exceptionStatus:\s((false)|(true))/, returnFile)
    #         assert_match(/    buyerFields:\s.*/, returnFile)
    #     end
    # end

    def test_with_bitpay_client
        pem = File.read('bitpaykey.pem')
        client = BitPay::SDK::Client.new(api_uri: 'https://brianw.bp:8088', pem: pem, insecure: true)
        invoice = client.create_invoice(price: 0.000114, currency: 'BTC', params: {notificationURL: 'http://brianw.bp:4567/receive', fullNotifications: true})
        puts invoice
    end

end
