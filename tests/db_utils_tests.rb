require 'rubygems'
require 'bitpay_sdk'
require 'minitest/autorun'
require 'Time'
require 'json'
require_relative '../config/constants.rb'
require_relative '../lib/logger_utils'
require_relative '../lib/db_utils'
require_relative '../lib/server_utils'

TEST_LOG_PATH = '../logs/test_log.txt'
TEST_LAST_LOG_PATH = '../logs/test_last_log.json'

module BitPay
    class DataBaseTests < MiniTest::Unit::TestCase
        include BitPay::IPNLoggerUtils
        include BitPay::IPNDataBaseUtils
        def test_to_clear_logs
            clear_logs(TEST_LOG_PATH, TEST_LAST_LOG_PATH)
            refute(File.exist?(TEST_LAST_LOG_PATH))
            refute(File.exist?(TEST_LOG_PATH))

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
                    "buyerEmail":"brianw@bitpay.com",
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
            write_to_files(file, TEST_LAST_LOG_PATH, TEST_LOG_PATH)

            assert_equal(json_data, JSON.parse(File.read(TEST_LOG_PATH)))
            assert_equal(json_data, JSON.parse(File.read(TEST_LAST_LOG_PATH)))

            clear_logs(TEST_LOG_PATH, TEST_LAST_LOG_PATH)
            refute(File.exist?(TEST_LAST_LOG_PATH))
            refute(File.exist?(TEST_LOG_PATH))
        end

        def test_to_get_logs
            clear_logs(TEST_LOG_PATH, TEST_LAST_LOG_PATH)
            refute(File.exist?(TEST_LAST_LOG_PATH))
            refute(File.exist?(TEST_LOG_PATH))

            json1 = JSON.parse '{"id":"ATkW9jqs32ZZNUTeqEP3cm","url":"https://brianw.bp:8088/invoice?id=ATkW9jqs32ZZNUTeqEP3cm","status":"paid","btcPrice":"0.000462","price":0.000462,"currency":"BTC","invoiceTime":1437499716705,"expirationTime":1437500616705,"currentTime":1437499733288,"btcPaid":"0.000462","btcDue":"0.000000","rate":1,"exceptionStatus":false,"buyerFields":{},"time":"2015-07-21 13:54:58 -0400"}'
            json2 = JSON.parse '{"id":"9Y2bHXkoPjuc2CLWyi8iYM","url":"https://brianw.bp:8088/invoice?id=9Y2bHXkoPjuc2CLWyi8iYM","status":"paid","btcPrice":"0.000558","price":0.000558,"currency":"BTC","invoiceTime":1437509040931,"expirationTime":1437509940931,"currentTime":1437509066529,"btcPaid":"0.000558","btcDue":"0.000000","rate":1,"exceptionStatus":false,"buyerFields":{},"time":"2015-07-21 16:04:26 -0400"}'
            json3 = JSON.parse '{"id":"TPsdPt3hhYBNoaTHzCjtnD","url":"https://brianw.bp:8088/invoice?id=TPsdPt3hhYBNoaTHzCjtnD","status":"paid","btcPrice":"0.000038","price":3.8e-05,"currency":"BTC","invoiceTime":1437509148855,"expirationTime":1437510048855,"currentTime":1437509161242,"btcPaid":"0.000038","btcDue":"0.000000","rate":1,"exceptionStatus":false,"buyerFields":{},"time":"2015-07-21 16:06:01 -0400"}'

            json_array1 = [json1, json2, json3]
            json_array2 = [json2, json3, json1]
            json_array3 = [json3, json1, json2]

            json_array1.each do |data|
                write_to_files(data.to_json, TEST_LOG_PATH, TEST_LAST_LOG_PATH)
                data["time"] = Time.now.inspect
                assert_equal(data, JSON.parse(File.read(TEST_LAST_LOG_PATH)))
            end
            assert_equal(json3, JSON.parse(File.read(TEST_LAST_LOG_PATH)))
            expected_string = json1.to_json + "\n" + json2.to_json + "\n" + json3.to_json + "\n"
            result_string = ""
            File.readlines(TEST_LOG_PATH).each {|line| result_string = result_string + line}
            assert_equal(expected_string, result_string)
            
            clear_logs(TEST_LOG_PATH, TEST_LAST_LOG_PATH)
            refute(File.exist?(TEST_LAST_LOG_PATH))
            refute(File.exist?(TEST_LOG_PATH))

            json_array2.each do |data|
                write_to_files(data.to_json, TEST_LOG_PATH, TEST_LAST_LOG_PATH)
                data["time"] = Time.now.inspect
                assert_equal(data, JSON.parse(File.read(TEST_LAST_LOG_PATH)))
            end
            assert_equal(json1, JSON.parse(File.read(TEST_LAST_LOG_PATH)))
            expected_string = json2.to_json + "\n" + json3.to_json + "\n" + json1.to_json + "\n"
            result_string = ""
            File.readlines(TEST_LOG_PATH).each {|line| result_string = result_string + line}
            assert_equal(expected_string, result_string)

            clear_logs(TEST_LOG_PATH, TEST_LAST_LOG_PATH)
            refute(File.exist?(TEST_LAST_LOG_PATH))
            refute(File.exist?(TEST_LOG_PATH))

            json_array3.each do |data|
                write_to_files(data.to_json, TEST_LOG_PATH, TEST_LAST_LOG_PATH)
                data["time"] = Time.now.inspect
                assert_equal(data, JSON.parse(File.read(TEST_LAST_LOG_PATH)))
            end
            assert_equal(json2, JSON.parse(File.read(TEST_LAST_LOG_PATH)))
            expected_string = json3.to_json + "\n" + json1.to_json + "\n" + json2.to_json + "\n"
            result_string = ""
            File.readlines(TEST_LOG_PATH).each {|line| result_string = result_string + line}
            assert_equal(expected_string, result_string)

            clear_logs(TEST_LOG_PATH, TEST_LAST_LOG_PATH)
            refute(File.exist?(TEST_LAST_LOG_PATH))
            refute(File.exist?(TEST_LOG_PATH))



        end


    end
end
