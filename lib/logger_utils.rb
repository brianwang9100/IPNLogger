require 'rubygems'
require 'bitpay_sdk'
require 'json'
require 'Time'
require_relative '../config/constants.rb'

module BitPay
    module IPNLoggerUtils
        def write_to_files(json_data, log_path = LOG_PATH, last_log_path = LAST_LOG_PATH)
            t = Time.now
            ipn = JSON.parse(json_data)
            ipn["time"] = t.inspect
            # writing logs
            File.open(log_path, "a")  { |file| file.write(ipn.to_json + "\n") }
            File.open(last_log_path, "w") { |file| file.write(ipn.to_json) }
            return ipn
        end
    end
end
