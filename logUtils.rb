require 'rubygems'
require 'sinatra'
require 'json'

class LogParser
    class << self

        def parseToLogString(jsonData = "NULLDATA")
            if jsonData != "NULLDATA" do
                invoice = JSON.parse(jsonData)
                logString = logString
                    + "id: " + invoice[:id] + "\n"
                    + "status: " + invoice[:status] + "\n"
                    + "btcPrice: " + invoice[:btcPrice] + "\n"
                invoice.each do |key, value|
                    if key != "id" && key != "status" && key != "btcPrice" do
                        logString = logString + "    " + key + ": " + value + "\n"
                    end
                end
            else
                logString = "NULLDATA"
            end
            return logString
        end

        def parseToJson(logString = "NULLSTRING")

        end

        def writeToFile(logString)

        end

        def retrieveFromFile(logString)

        end

    end
end
