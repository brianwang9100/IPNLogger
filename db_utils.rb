require 'rubygems'
require 'logger'
require 'json'
require 'Time'

module BitPay
    module IPNDataBaseUtils
        def get_last_ipn
            if File.exist?('./logs/last_log.json') && !File.zero?('./logs/last_log.json')
                return JSON.parse(File.read('./logs/last_log.json'))
            end
        end

        def get_list_ipn
            if File.exist?('./logs/log.txt') && !File.zero?('./logs/last_log.json')
                return File.open('./logs/log.txt')
            end
        end

        def clear_logs
            if File.exist?('./logs/last_log.json')
                File.delete('./logs/last_log.json')
            end
            if File.exist?('./logs/log.txt')
                File.delete('./logs/log.txt')
            end
        end
    end
end
