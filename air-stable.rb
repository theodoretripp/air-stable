require 'sinatra'
require_relative 'models'

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
        redirect "/"
    else
        raise @user.errors.inspect
        # temporary - error handling coming soon.
    end
end
