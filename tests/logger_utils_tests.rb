require 'rubygems'
require 'bitpay_sdk'
require 'minitest/autorun'
require 'Time'
require_relative '../config/constants.rb'
require_relative '../lib/logger_utils'
require_relative '../lib/db_utils'
require_relative '../lib/server_utils'

module BitPay
    class LogTests < Minitest::Test
        include BitPay::IPNLoggerUtils
        def test_write_to_file
            file = File.read('test.json')
            json_data = JSON.parse('{
                "id":"QXVd4WRtsPbax9jLe7uHBh",
                "url":"https://test.bitpay.com/invoice?id=QXVd4WRtsPbax9jLe7uHBh",
                "posData":"8261418159074",
                "status":"paid",
                "btcPrice":"0.0014",
                "price":0.5,
                "currency":"USD",
                "invoiceTime":1418158912927,
                "expirationTime":1418159812927,
                "currentTime":1418158957984,
                "btcPaid":"0.0014","rate":353.29,
                "exceptionStatus":false,
                "buyerFields":{
                    "buyerCity":"Bob Dole",
                    "buyerEmail":"alex@bitpay.com",
                    "buyerPhone":null,
                    "buyerAddress2":"",
                    "buyerZip":"41015",
                    "buyerState":"KS",
                    "buyerCountry":"US",
                    "buyerName":"Bobert Dole",
                    "buyerAddress1":"123 Bob Dole Way"
                }
            }')
            json_data["time"] = Time.now.inspect
            assert_equal(json_data, write_to_files(file, '../logs/test_last_log.json', '../logs/test_logs.txt')
        end
    end
end
