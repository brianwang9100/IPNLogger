require 'rubygems'
require 'bitpay_sdk'
require 'minitest/autorun'
require 'Time'
require_relative 'logger_utils'
require_relative 'db_utils'

module BitPay
    class LogTests < Minitest::Test
        include BitPay::IPNLoggerUtils
        def test_write_to_file
            file = File.read('j.json')
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
            assert_equal(json_data, write_to_files(file))
        end
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
        # def test_with_bitpay_client_create_invoice
        #     pem = File.read('bitpaykey.pem')
        #     client = BitPay::SDK::Client.new(api_uri: 'https://brianw.bp:8088', pem: pem, insecure: true)
        #     randomNumber = rand * (0.000999-0.00001) + 0.00001
        #     puts randomNumber.round(6)
        #     invoice = client.create_invoice(price: randomNumber.round(6), currency: 'BTC', params: {notificationURL: 'http://brianw.bp:4567/receive', fullNotifications: true})
        #     puts invoice
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
        # end

        # def test_with_bitpay_client_get_invoice
        #     invoice_id = "CZzugj2ZLue4BC3mZuu3Q"
        #     uri = 'http://brianw.bp:8088'
        #     urlpath = "#{uri}/invoices/#{invoice_id}/notifications"
        #     pem = File.read('bitpaykey.pem')
        #     client = BitPay::SDK::Client.new(api_uri: uri, pem: pem, insecure: true)
        #     # client.send_request('POST', '/invoices/CZzugj2ZLue4BC3mZuu3Q/notifications', facade: 'pos' )
        #
        #     inst_var = client.instance_variables
        #     params = {token: inst_var["@tokens"]["pos"], guid: SecureRandom.uuid, id: isnt_var["@client_id"]}
        #     req = Net::HTTP::Post.new(urlpath)
        #     req.body = params.to_json
        #     req['X-Signature'] = KeyUtils.sign(uri, pem).to_s + urlpath + req.body, client.instance_variable_get("@priv_key"))
        #     req['X-Identity'] = client.instance_variable_get("@pub_key")
        #     req['User-Agent'] = client.instance_variable_get("@user_agent")
        #     req['Content-Type'] = 'application/json'
        #     req['X-BitPay-Plugin-Info'] = 'Rubylib' + VERSION
        #     @https = Net::HTTP.new("localhost", 8088)
        #     @https.use_ssl = true
        #     @https.ca_file = CA_FILE
        #     response = @https.request(req)
        #     # getInvoice = client.send_request( 'GET', '/invoices/CZzugj2ZLue4BC3mZuu3Q', facade: 'pos')
        #     # put response
        # end
        #
        # def retrieve_token
        #     client = BitPay::SDK::Client.new(api_uri: uri, pem: pem, insecure: true)
        #
        #     token
        #
        #
        #
        #
        # end
    end
end
