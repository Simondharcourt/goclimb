# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



User.create(email: "robert@email.com", password: "123456", route_setter: true)
User.create(email: "simon@email.com", password: "123456")
Route.create(name: "Falling Rock")
Route.create(name: "Flying Jamaican")
Route.create(name: "Swimming Jamaican")
Site.create(name: "Mont-Trenchant")
City.create(name: "Montreal")
State_provinces.create(name: "Quebec")




response = RestClient.get "https://www.mountainproject.com/data/get-routes-for-lat-lon?lat=43.8053486&lon=-71.8125811&maxDistance=200&minDiff=5.6&maxDiff=5.14&maxResults=500&key=200477633-18e31fe418ce3dd71aa4b54df54fa7e0"
routes = JSON.parse(response)

routes["routes"].each do |route|
 # binding.pry
  state = StateProvince.find_by(name: route["location"][0])
  	if state.nil?
  		state = StateProvince.create(name: route["location"][0])
  	end

  city = City.find_by(name: route["location"][1])
  	if city.nil?
  		city = City.create(name: route["location"][1], state_province: state)
  	end

  site = Site.find_by(name: route["location"][2])
    if site.nil?
    	site = Site.create(name: route["location"][2], city: city)
    end

  new_route = Route.create(name: route["name"], site: site, type_of: route["type"], level: route["rating"], rating: route["stars"].to_i, longitude: route["longitude"].to_f, latitude: route["latitude"].to_f)
  Imageable.create(imageable: new_route, photo: route["imgMedium"])

  new_route.save!
end
