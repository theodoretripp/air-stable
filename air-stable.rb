require 'sinatra'
require_relative 'config/dotenv'
require_relative 'config/session'
require_relative 'models'


helpers do
  def current_user
      @current_user ||= User.get(session[:current_user])
  end

  def login(user)
      @current_user = user
      session[:current_user] = user.id
      redirect "/"
  end

  def logged_in?
      !session[:current_user].nil?
  end

  def ensure_logged_in!
    unless logged_in?
      halt 403, "You must be logged in to do that!"
    end
  end
end

get "/" do
  @stalls = Stall.search(params["query"])
  erb :home
end

#
# USERS
#

get "/users/new" do
    @user = User.new
    erb :new_user
end

post "/users" do
    @user = User.create(params[:user])

    if @user.saved?
        login(@user)
    else
        erb :new_user
    end
end

#
# STALLS
#

get "/stalls/new" do
  ensure_logged_in!
  @stall = current_user.stalls.new
  erb :new_stall
end

post "/stalls" do
  ensure_logged_in!
  @stall = current_user.stalls.create(params["stall"])
  if @stall.saved?
    @stall.refresh_geolocation!
    redirect "/"
  else
    erb :new_stall
  end
end

get "/stalls/:stall_id/supported_rentalrequests/new" do
  ensure_logged_in!
  @stall = Stall.get(params["stall_id"])
  @available_rentalrequests = RentalRequest.all
  erb :stalls_new_supported_rentalrequest
end

post "/stalls/:stall_id/supported_rentalrequests" do
  ensure_logged_in!
  stall = Stall.get(params["stall_id"])
  rentalrequest = RentalRequest.get(params["supported_rentalrequest"]["id"])

  stall.add_supported_rentalrequest(rentalrequest)

  redirect "/"
end

#
# RENTAL REQUESTS
#

get "/rentalrequests/new" do
  @rentalrequest = RentalRequest.new
  erb :new_rentalrequest
end

post "/rentalrequests" do
  ensure_logged_in!
  @rentalrequest = current_user.created_rentalrequests.create(params["rentalrequest"])
  if @rentalrequest.saved?
    redirect "/"
  else
    erb :new_rentalrequest
  end
end

#
# SESSION
#

get "/session/new" do
    @login_attempt = User.new
    erb :new_session
end

post "/session" do
    @login_attempt = User.first({ :email => params[:user]["email"] })

    if @login_attempt && @login_attempt.password == params[:user]["password"]
        login(@login_attempt)
    else
        @login_attempt = User.new({ :email => params["user"]["email"] })
        @login_attempt.errors.add(:password, "Cloudn't find a user with that email/password combination")

        erb :new_session
    end
end

delete "/session" do
    session.delete(:current_user)
    redirect "/"
end
