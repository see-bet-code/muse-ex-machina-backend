class Api::V1::ReviewsController < ApplicationController

  def show
    review = Review.find(params[:id])
    render json: { review: ReviewSerializer.new(review) }
  end

  def index
    reviews = Review.where(user_id: current_user.id)
    render json: reviews, each_serializer: ReviewSerializer
  end

  def update
    review = Review.find(params[:id])
    if review.update(update_params)
      render json: Review.all, each_serializer: ReviewSerializer
    else
      render json: { errors: review.errors.full_messages }, status: :not_acceptable
    end 
  end

# def destroy
#   if @cart
#     @cart.destroy
#   else
#     render json: { errors: ["cart is null. Delete failed"] }, status: :not_acceptable
#   end
# end

  private

  def update_params
    params.require(:review).permit(
      :rating,
      :description
      ) 
  end

end
