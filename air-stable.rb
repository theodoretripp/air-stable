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
  @stalls = Stall.all
  erb :home
end

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

get "/stalls/new" do
  ensure_logged_in!
  @stall = current_user.stalls.new
  erb :new_stall
end

post "/stalls" do
  ensure_logged_in!
  @stall = current_user.stalls.create(params["stall"])
  if @stall.saved?
    redirect "/"
  else
    erb :new_stall
  end
end

get "/rental_requests/new" do
  @rental_request = Rental_Request.new
  erb :new_rental_request
end

post "/rental_requests" do
  ensure_logged_in!
  @rental_request = current_user.created_rental_requests.create(params["rental_request"])
  if @rental_request.saved?
    redirect "/"
  else
    erb :new_rental_request
  end
end

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
