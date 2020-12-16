class Api::V1::SessionsController < ApplicationController
  skip_before_action :authorized, only: [:create, :auto_login]

  def create
    @user = User.find_by(username: user_login_params[:username])
    if @user && @user.authenticate(user_login_params[:password])
      token = encode_token(user_id: @user.id)
      render json: { user: @user, jwt: token, message: "Welcome back, #{@user.name}"}, status: :accepted
    else
      render json: { message: 'Invalid username and/or password' }, status: :unauthorized
    end
  end

  # def destroy
  #   session.delete :user_id
  #   render json: { status: 200, logged_out: true}
  # end

  def auto_login
    if current_user
      render json: current_user
    else
      render json: {errors: "No user logged in"}
    end
  end

  def user_auth
    render json: {message: "You are authorized"}
  end

  private

  def user_login_params
    params.require(:user).permit(:username, :password)
  end
end
