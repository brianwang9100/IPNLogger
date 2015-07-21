require 'rubygems'
require 'bitpay_sdk'
require 'json'
require 'Time'
require 'net/http'
require_relative '../config/constants.rb'


module BitPay
    module IPNServerUtils
        def post_for_resend_notification(invoice_id)
            uri = API_URI
            pem = File.read(PEM_PATH)
            urlpath = "invoices/#{invoice_id}/notifications"
            client = BitPay::SDK::Client.new(api_uri: uri, pem: pem, insecure: true)
            client_token = retrieve_client_token(client)
            invoice_token = retrieve_invoice_token(client, invoice_id, client_token)
            return client.post(path: urlpath, token: invoice_token, params: {})
        end

        def retrieve_client_token(client)
            tokens = client.get(path: "tokens")
            return tokens["data"][0]["merchant"]
        end

        def retrieve_invoice_token(client, invoice_id, token)
            invoice = client.get(path: "invoices/#{invoice_id}", token: token)
            return invoice["data"]["token"]
        end

        def get_invoice(client = nil, invoice_id)
            uri = API_URI
            pem = File.read(PEM_PATH)
            if client.nil?
                client = BitPay::SDK::Client.new(api_uri: uri, pem: pem, insecure: true)
            end

            client_token = retrieve_client_token(client)
            return client.get(path: "invoices/#{invoice_id}", token: client_token)
        end
    end
end
