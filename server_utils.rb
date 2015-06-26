require 'rubygems'
require 'logger'
require 'json'
require 'Time'
require 'bitpay_sdk'
require 'bitpay_key_utils'
require 'net/http'


module BitPay
    module IPNServerUtils
        def post_for_resend_notification(invoice_id: nil)
            uri = 'https://brianw.bp:8088'
            pem = File.read('bitpaykeymerch.pem')
            urlpath = "invoices/#{invoice_id}/notifications"
            client = BitPay::SDK::Client.new(api_uri: uri, pem: pem, insecure: true)
            client_token = retrieve_client_token(client)
            invoice_token = retrieve_invoice_token(client, invoice_id, client_token)
            return client.post(path: urlpath, token: invoice_token, params: {})
        end

        # def custom_post_for_notifications(urlpath, token, client, pem)
        #     @client_id = client.instance_variable_get("@client_id")
        #     @pub_key = BitPay::KeyUtils.get_public_key_from_pem pem
        #     @user_agent = client.instance_variable_get("@user_agent")
        #     @https = client.instance_variable_get("@https")
        #
        #     urlpath = '/' + urlpath
        #     request = Net::HTTP::Post.new urlpath
        #     params = {}
        #     params[:token] = token if token
        #     params[:guid]  = SecureRandom.uuid
        #     params[:id] = @client_id
        #     request.body = params.to_json
        #     if token
        #         request['X-Signature'] = BitPay::KeyUtils.sign_with_pem(pem, @uri + urlpath + request.body)
        #         request['X-Identity'] = @pub_key
        #     end
        #     request['User-Agent'] = @user_agent
        #     request['Content-Type'] = 'application/json'
        #     request['X-BitPay-Plugin-Info'] = 'Rubylib' + VERSION
        #
        #     begin
        #         response = @https.request request
        #     rescue => error
        #         raise BitPay::ConnectionError, "#{error.message}"
        #     end
        #
        #     puts response
        # end

        def retrieve_client_token(client)
            tokens = client.get(path: "tokens")
            return tokens["data"][0]["merchant"]
        end

        def retrieve_invoice_token(client, invoice_id, token)
            invoice = client.get(path: "invoices/#{invoice_id}", token: token)
            return invoice["data"]["token"]
        end

        def get_invoice(client = nil, invoice_id)
            uri = 'https://brianw.bp:8088'
            pem = File.read('bitpaykeymerch.pem')
            if client.nil?
                client = BitPay::SDK::Client.new(api_uri: uri, pem: pem, insecure: true)
            end

            client_token = retrieve_client_token(client)
            return client.get(path: "invoices/#{invoice_id}", token: client_token)
        end
    end
end
