# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Temperature.destroy_all
def thirtydaytemps
    response = RestClient.get 'http://api.worldweatheronline.com/premium/v1/weather.ashx?key=97ff00345b434479828234737210607&q=30.404251,-97.849442&num_of_days=30&tp=1&format=json'
    json = JSON.parse response

    json["data"]["weather"].each do |day|
        d = day["date"]
        day["hourly"].each do |hour|
            if hour["time"].length === 1
                h = "0"
            elsif hour["time"].length === 3
                h = hour["time"][0...1]
            else
                h = hour["time"][0...2]
            end
            str = d + " " + h
            dt = DateTime.strptime(d + " " + h,'%Y-%m-%d %k')
            Temperature.create(datetime: dt, temperature: hour["tempF"])
        end
    end
end

def 

thirtydaytemps()