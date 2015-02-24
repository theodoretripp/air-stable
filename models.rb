require 'data_mapper'
require 'bcrypt'

DataMapper.setup(:default, ENV['DATABASE_URL'])

class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String,  { :required => true }
  property :email, String,  { :required => true,
                              :unique => true,
                              :format => :email_address }
  property :password, Text

  has n, :stalls, { :child_key => [:creator_id] }
  has n, :created_rentalrequests, "RentalRequest",
  { :child_key => [:creator_id] }

  def password=(password)
    self.attribute_set(:password, BCrypt::Password.create(password))
  end

  def password
    BCrypt::Password.new(self.attribute_get(:password))
  end
end

class Stall
  include DataMapper::Resource

  property :id, Serial
  property :name, String, { :required => true }
  property :address, Text, { :required => true}

  belongs_to :creator, 'User'

  has n, :stalls_rentalrequests
  has n, :supported_rentalrequests, "RentalRequest", { :through => :stalls_rentalrequests }

  def add_supported_rentalrequest(rentalrequest)
    self.stalls_rentalrequests.first_or_create(:supported_rentalrequest => rentalrequest)
  end

  def self.search(query)
    all(:name.like => "%#{query}%") |
    all(supported_rentalrequests.name.like => "%#{query}%") |
    all(:address.like => "%#{query}%")
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
