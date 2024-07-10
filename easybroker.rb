require 'uri'
require 'net/http'
require 'json'
require 'dotenv/load'

class Easybroker
    
    def initialize()
        @api_key = ENV['API_KEY']
    end

    def properties_titles
        all_titles = ""
        next_page = 1

        loop do
            response = request_properties(next_page)
            properties = JSON.parse(response)['content']

            break if properties.empty?

            properties.each do |property|
                all_titles += "#{property['title']}\n"
            end

            next_page += 1
        end

        all_titles
    end

    def request_properties(page)
        url = URI("https://api.stagingeb.com/v1/properties?page=#{page}&limit=50")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        
        request = Net::HTTP::Get.new(url)
        request["accept"] = 'application/json'
        request["X-Authorization"] = @api_key
        
        response = http.request(request)
        response.body
    end

end