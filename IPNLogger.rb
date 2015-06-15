require 'logger'
require 'json'
require 'stringio'
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

        def write_to_file(json_data)
            t = Time.now
            log_string = parse_to_log_string(json_data, Time.now)
            File.open(t.strftime("./logs/%Y-%m-%d.txt"), "a")  { |file| file.write(log_string) }
        end

        # def retrieve_from_file(file_name)
        #
        # end
    end
end
