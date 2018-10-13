class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username]

    if user&.authenticate(params[:password])
      if user.closed
        redirect_to signin_path, notice: "Account closed, please contact admins"
        return
      end
      session[:user_id] = user.id
      redirect_to user, notice: "Welcome back!"
    else
      redirect_to signin_path, notice: "Username or password wrong"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
