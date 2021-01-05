class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    if params[:avatar] == "undefined"
      @user = User.new(user_params)
    else
      @user = User.new(user_params.merge(avatar: params[:avatar]))
    end
    if @user.save
      token = encode_token(user_id: @user.id)
      render json: { user: UserSerializer.new(@user), serializer: UserSerializer, jwt: token}, status: :created
    else
      render json: { errors: 'failed to create user' }, status: :not_acceptable
    end
  end

  def update
    if @user.update(user_params)
      avatar = rails_blob_path(@user.avatar)
      render json: { user: @user, avatar: avatar }, status: :updated
    else
      render json: { errors: @user.errors.full_messages }, status: :not_acceptable
    end 
  end

# def update
#   if params[:file]
#     # The data is a file upload coming from <input type="file" />
#     @profile.avatar.attach(params[:file])
#     # Generate a url for easy display on the front end 
#     photo = url_for(@profile.avatar)
#   elsif params[:camera]
#     # The data is Base64 and coming from the camera.  
#     # Use that data to create a file for active storage.
#     blob = ActiveStorage::Blob.create_after_upload!(
#       io: StringIO.new((Base64.decode64(params[:camera].split(",")[1]))),
#       filename: "user.png",
#       content_type: "image/png",
#     )
#     @profile.avatar.attach(blob)
#     photo = url_for(@profile.avatar)
#   else
#     # Maybe we want to just store a url or the raw Base64 data
#     photo = photo_params[:photo]
#   end
#     # Now save that url in the profile
#   if @profile.update(photo: photo)
#     render json: @profile, status: :ok
#   end
# end

def destroy
  if @user
    @user.destroy
  else
    render json: { errors: ["User is null. Delete failed"] }, status: :not_acceptable
  end
end

  private
  def user_params
    params.permit(
      :username,
      :password,
      :email,
      :name,
      :age)
  end


end
