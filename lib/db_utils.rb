require 'rubygems'
require 'bitpay_sdk'
require 'json'
require 'Time'
require_relative '../config/constants.rb'

module BitPay
    module IPNDataBaseUtils
        def get_last_ipn(last_log_path = LAST_LOG_PATH)
            if File.exist?(last_log_path) && !File.zero?(last_log_path)
                return JSON.parse(File.read(last_log_path))
            end
        end

        def get_list_ipn(log_path = LOG_PATH, last_log_path = LOG_PATH)
            if File.exist?(log_path) && !File.zero?(log_path)
                return File.open(log_path)
            end
        end

        def clear_logs(log_path = LOG_PATH, last_log_path = LAST_LOG_PATH)
            if File.exist?(last_log_path)
                File.delete(last_log_path)
            end
            if File.exist?(log_path)
                File.delete(log_path)
            end
        end
    end
end
