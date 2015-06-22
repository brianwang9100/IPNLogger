require 'rubygems'
require 'bitpay_sdk'
require 'minitest/autorun'
require 'Time'
require_relative 'logger_utils'
require_relative 'db_utils'

module BitPay

    class LogTests < MiniTest::Unit::TestCase
        include BitPay::IPNLoggerUtils
        # #also another really shitty test because i'm too lazy to write asserts
        # def test_json_to_log_string
        #     file = File.read('j.json')
        #     log_string = parse_to_log_string(file, Time.now)
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
        #         write_to_files(file)
        #         ipn = JSON.parse(file)
        #         returnFile = File.read("./logs/log.txt")
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
        #
        def test_with_bitpay_client
            pem = File.read('bitpaykey.pem')
            client = BitPay::SDK::Client.new(api_uri: 'https://brianw.bp:8088', pem: pem, insecure: true)
            randomNumber = rand * (0.000999-0.00001) + 0.00001
            puts randomNumber.round(6)
            invoice = client.create_invoice(price: randomNumber.round(6), currency: 'BTC', params: {notificationURL: 'http://brianw.bp:4567/receive', fullNotifications: true})
            puts invoice
        #     returnFile = File.read('./logs/log.txt')
        #
        #     assert_match(/id:\s[a-zA-Z0-9]*/, returnFile)
        #     assert_match(/status:\s((paid)|(confirmed)|(completed))/, returnFile)
        #     assert_match(/btcPrice:\s(\d+(\.\d+)?)/, returnFile)
        #     assert_match(/url:\s.*/, returnFile)
        #     assert_match(/    posData:\s\d+/, returnFile)
        #     assert_match(/    price:\s(\d+(\.\d+)?)/, returnFile)
        #     assert_match(/    currency:\s.*/, returnFile)
        #     assert_match(/    invoiceTime:\s\d+/, returnFile)
        #     assert_match(/    expirationTime:\s\d+/, returnFile)
        #     assert_match(/    currentTime:\s\d+/, returnFile)
        #     assert_match(/    btcPaid:\s(\d+(\.\d+)?)/, returnFile)
        #     assert_match(/    rate:\s(\d+(\.\d+)?)/, returnFile)
        #     assert_match(/    exceptionStatus:\s((false)|(true))/, returnFile)
        #     assert_match(/    buyerFields:\s.*/, returnFile)
        end
    end
end
