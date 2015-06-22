require 'rubygems'
require 'logger'
require 'json'
require 'Time'

module BitPay
    module IPNLoggerUtils
        # def parse_to_log_string (json_data, time)
        #     # ipn = JSON.parse(json_data)
        #     # log_string =
        #     #     time.inspect + "\n" + "id: " + ipn['id'] + "\n" + "status: " + ipn['status'] + "\n" + "btcPrice: " + ipn['btcPrice'] + "\n"
        #     # ipn.each do |key, value|
        #     #     if key != "id" && key != "status" && key != "btcPrice"
        #     #         log_string = log_string + "    " + key.to_s + ": " + value.to_s + "\n"
        #     #     end
        #     # end
        #     # log_string += "\n"
        #     # return log_string
        #     ipn = JSON.parse(json_data)
        #     log_string =
        # end

        def write_to_files(json_data)
            t = Time.now
            ipn = JSON.parse(json_data)
            ipn["time"] = t.inspect
            # writing logs
            File.open('./logs/log.txt', "a")  { |file| file.write(ipn.to_json + "\n") }
            File.open('./logs/last_log.json', "w") { |file| file.write(ipn.to_json) }
            return ipn
        end
    end
end
