class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username]
    if !user || user.GitHub
      redirect_to signin_path, notice: "Wrong username and / or password."
    elsif user.closed?
      redirect_to signin_path, notice: 'Account closed, contact an admin.'
    elsif user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Succesfully logged in as: #{user.username}"
    else
      redirect_to signin_path, notice: "Wrong username and / or password."
    end
  end

  def create_oauth
    user = User.find_by username: request.env['omniauth.auth'].info.nickname
    if !user
      user = User.new
      user.username = request.env['omniauth.auth'].info.nickname
      user.GitHub = true
      pass = [*'a'..'z', *'A'..'Z', *1..9].to_a.sample(16).join
      user.password = pass
      user.password_confirmation = pass
      user.save
    end
    if user
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Succesfully logged in as: #{user.username}"
    else
      redirect_to signin_path, notice: "Wrong username and / or password."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
