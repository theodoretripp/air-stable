require 'sinatra'
require_relative 'models'

enable :sessions

helpers do
    def current_user
        @current_user ||= User.find(session[:current_user])
    end

    def login(user)
        @current_user = user
        session[:current_user] = user.id
        redirect "/"
    end

    def logged_in?
        !session[:current_user].nil?
    end
end

get "/" do
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

get "/sessions/new" do
    @login_attempt = User.new
    erb :new_session
end

post "/sessions" do
    @login_attempt = User.first({ :email => params[:user]["email"] })

    if @login_attempt && @login_attempt.password == params[:user]["password"]
        login(@login_attempt)
    else
        @login_attempt = User.new({ :email => params["user"]["email"] })
        @login_attempt.errors.add(:password, "Cloudn't find a user with that email/password combination")

        erb :new_session
    end
end



