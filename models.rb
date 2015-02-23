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
  has n, :created_rental_requests, "Rental_Request",
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
end

class Rental_Request
  include DataMapper::Resource

  property :id, Serial
  property :name, String, { :required => true }
  # property :rental_date, Date, { :required => true }
  # property :status, String, :default => "pending"

  belongs_to :creator, 'User'
end

DataMapper.finalize
DataMapper.auto_upgrade!
