require 'data_mapper'
require 'graticule'
require 'bcrypt'

DataMapper.setup(:default, ENV['DATABASE_URL'])

class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String,  { :required => true }
  property :email, String,  { :required => true,
                              :unique => true,
                              :format => :email_address }
  property :password, BCryptHash

  has n, :stalls, { :child_key => [:creator_id] }
  has n, :created_rentalrequests, "RentalRequest",
  { :child_key => [:creator_id] }

end

class Stall
  SEARCH_RADIUS = 10
  include DataMapper::Resource

  property :id, Serial
  property :name, String, { :required => true }
  property :address, Text, { :required => true}
  property :latitude, Float
  property :longitude, Float

  belongs_to :creator, 'User'

  has n, :stalls_rentalrequests
  has n, :supported_rentalrequests, "RentalRequest", { :through => :stalls_rentalrequests }

  def add_supported_rentalrequest(rentalrequest)
    self.stalls_rentalrequests.first_or_create(:supported_rentalrequest => rentalrequest)
  end

  def self.search(query, options={})
    stalls = all(:name.like => "%#{query}%") |
    all(supported_rentalrequests.name.like => "%#{query}%") |
    all(:address.like => "%#{query}%")

    return stalls unless options[:near]

    location = geocoder.locate(options[:near])

    stalls.select do |stall|
      stall.near?(location)
    end
  end

  def near?(other_location)
    self.location.distance_to(other_location) <= SEARCH_RADIUS
  end

  def refresh_geolocation!
    location = geocoder.locate(address)
    self.latitude = location.latitude
    self.longitude = location.longitude
    self.save
  end

  def location
    @location ||= Graticule::Location.new({ latitude: self.latitude, longitude: self.longitude })
  end

  def geocoder
    self.class.geocoder
  end

  def self.geocoder
    @@geocoder ||= Graticule.service(:google).new ENV['GOOGLE_GEOCODER_API_KEY']
  end
end

class StallsRentalrequest #Wierd case thing going on here - NameError if camelcase.
  include DataMapper::Resource

  property :id, Serial

  belongs_to :supported_rentalrequest, "RentalRequest"
  belongs_to :stall
end


class RentalRequest
  include DataMapper::Resource

  property :id, Serial
  property :name, String, { :required => true }
  # property :rental_date, Date, { :required => true }
  # property :status, String, :default => "pending"

  belongs_to :creator, 'User'
end

DataMapper.finalize
DataMapper.auto_upgrade!
