class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def profile
    render json: { user: current_user }, status: :accepted
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token(user_id: @user.id)
      render json: { user: @user, jwt: @token }, status: :created
    else
      render json: { errors: 'failed to create user' }, status: :not_acceptable
    end
  end

  def update
    if @user.update(user_params)
      render json: { user: @user }, status: :updated
    else
      render json: { errors: @user.errors.full_messages }, status: :not_acceptable
    end 
  end

def destroy
  if @user
    @user.destroy
  else
    render json: { errors: ["User is null. Delete failed"] }, status: :not_acceptable
  end
end

  private
  def user_params
    params.require(:user).permit(
      :username,
      :password,
      :name, 
      :age
      ) 
    # :avatar
  end


end
