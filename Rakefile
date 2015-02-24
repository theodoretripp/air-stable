require_relative 'config/dotenv'
require_relative 'models'

task :refresh_geolocations do
  Stall.all.each do |stall|
    stall.refresh_geolocation!
  end
end
