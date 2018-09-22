class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username]
    if user.nil?
      redirect_to signin_path, notice: "User #{params[:username]} doesn't exist."
    end
    if user && user.authenticate(params[:password])
    session[:user_id] = user.id if user
    redirect_to user, notice: "Succesfully logged in as: #{user.username}"
    else
      redirect_to signin_path, notice: "Wrong username and / or password."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
