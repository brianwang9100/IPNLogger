require 'logger'
require 'json'
require 'Time'

class IPNLogger
    class << self #can now call static methods
        def parse_to_log_string (json_data, time)
            invoice = JSON.parse(json_data)
            log_string =
                time.inspect + "\n" + "id: " + invoice['id'] + "\n" + "status: " + invoice['status'] + "\n" + "btcPrice: " + invoice['btcPrice'] + "\n"
            invoice.each do |key, value|
                if key != "id" && key != "status" && key != "btcPrice"
                    log_string = log_string + "    " + key.to_s + ": " + value.to_s + "\n"
                end
            end
            log_string += "\n"
            return log_string
        end

        # by default logs will be stored on files sorted by day
        # 'id' sorts by id number, so a file per log
        # 'currency' sorts by currency, so
        #
        # all logs are appended onto the preexisting file if it exists
        def write_to_file(json_data, sort_type = 'default')
            t = Time.now
            log_string = parse_to_log_string(json_data, Time.now)
            invoice = JSON.parse(json_data)
            case sort_type
            when 'default' || 'day'
                fileName = t.strftime("./logs/%Y-%m-%d.txt")
            when 'id'
                fileName = "./logs/" + invoice['id']
            else 'currency'
                fileName = "./logs/" + invoice['currency']
            end

            File.open(fileName, "a")  { |file| file.write(log_string) }
        end
    end
end
