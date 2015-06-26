require 'rubygems'
require 'bitpay_sdk'
require 'minitest/autorun'
require 'Time'
require_relative 'logger_utils'
require_relative 'db_utils'
require_relative 'server_utils'
module BitPay
    class ServerTests < MiniTest::Unit::TestCase
        include BitPay::IPNServerUtils
        # include Minitest::RSpecMocks

        def test_retrieve_client_token
            @bpc = MiniTest::Mock.new
            @bpc.expect :get,
                {"data"=>[{"merchant"=>"DBubnxihDdxbnah6ENsmKCfs7sFiDngpXRBTbDwcCJh"}]},
                [path: "tokens"]
            assert_equal("DBubnxihDdxbnah6ENsmKCfs7sFiDngpXRBTbDwcCJh", retrieve_client_token(@bpc))
            @bpc.verify
        end

        def test_retrieve_invoice_token
            @bpc = MiniTest::Mock.new
            @bpc.expect :get,
                {"data"=>[{"merchant"=>"C96Nr9EsRzK1crgGiVu2nJRXC8qfiWjX2ZvNCV1PcBw9"}]},
                [path: "tokens"]
            @bpc.expect :get,
                JSON.parse('{
                    "facade": "merchant/invoice",
                    "data": {
                        "url": "https://test.bitpay.com/invoice?id=MVKr5FifPs3mzrY4h6NV4h",
                        "status": "complete",
                        "btcPrice": "0.000144",
                        "btcDue": "0.000000",
                        "price": 0.000144,
                        "currency": "BTC",
                        "exRates": {
                          "USD": 241.57
                        },
                        "invoiceTime": 1435246738328,
                        "expirationTime": 1435247638328,
                        "currentTime": 1435255168876,
                        "guid": "5e0cb5a5-2703-413d-b323-d3bab12e562e",
                        "id": "MVKr5FifPs3mzrY4h6NV4h",
                        "btcPaid": "0.000144",
                        "rate": 1,
                        "exceptionStatus": false,
                        "transactions": [
                            {
                                "amount": 14400,
                                "confirmations": 7,
                                "time": "2015-06-25T15:39:45.000Z",
                                "receivedTime": "2015-06-25T15:39:44.706Z"
                            }
                        ],
                        "flags": {
                          "refundable": true
                        },
                        "token": "4ure11x8FvaRaG6BTggZoi5bw2ihzUZbkSqgQZsb3Kqd49BAfJtP4MFSdK7NAKtgJu",
                        "buyer": {}
                    }
                }'),
                [path: "invoices/MVKr5FifPs3mzrY4h6NV4h", token: "C96Nr9EsRzK1crgGiVu2nJRXC8qfiWjX2ZvNCV1PcBw9"]
            assert_equal("4ure11x8FvaRaG6BTggZoi5bw2ihzUZbkSqgQZsb3Kqd49BAfJtP4MFSdK7NAKtgJu", retrieve_invoice_token(@bpc, "MVKr5FifPs3mzrY4h6NV4h", retrieve_client_token(@bpc)))
            @bpc.verify
        end


        def test_post_notification
            @invoice_id = 'CZzugj2ZLue4BC3mZuu3Q'
            response = post_for_resend_notification(invoice_id: @invoice_id)
            assert_equal({"data" => "Success"}, response)
        end

        # def test_get_invoices
        #     @bpc = MiniTest::Mock.new
        #     @bpc.expect :get,
        #         {"data"=>[{"merchant"=>"C96Nr9EsRzK1crgGiVu2nJRXC8qfiWjX2ZvNCV1PcBw9"}]},
        #         [path: "tokens"]
        #     @bpc.expect :get,
        #         {"facade": "something", "data":[]},
        #         [path: "invoices?dateStart=1430000000000", tokens: retrieve_client_token(@bpc)]
        #     assert_equal([], get_invoices(@bpc))
        # end
        #
        # def test_get_invoice
        #     @bpc = MiniTest::Mock.new
        #     @bpc.expect :get,
        #         {"data"=>[{"merchant"=>"C96Nr9EsRzK1crgGiVu2nJRXC8qfiWjX2ZvNCV1PcBw9"}]},
        #         [path: "tokens"]
        #     @bpc.expect :get,
        #         JSON.parse('{"facade": "something", "data":{}'}),
        #         [path: "invoices/MVKr5FifPs3mzrY4h6NV4h", tokens: retrieve_client_token(@bpc)]
        #     assert_equal({}, get_invoice('MVKr5FifPs3mzrY4h6NV4h'))
        # end
    end
end
