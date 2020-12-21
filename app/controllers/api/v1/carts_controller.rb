class Api::V1::CartsController < ApplicationController

  def show
    active = Cart.find(params[:id])
    render json: { active_cart: active.to_json(:include => {:cart_items => {:include =>:product}}) }
  end

  def index
    active = Cart.find_by(checked_out: false)
    if active
      render json: { carts: Cart.all.where(user_id: current_user.id), active: active }
    else
      new = Cart.create(user_id: current_user.id)
      render json: { carts: Cart.all.where(user_id: current_user.id), active: new }
    end
  end

  def create
    @cart = Cart.new(user_id: current_user.id)
    if @cart.save
      render json: { cart: @cart, carts: Cart.all.where(user_id: current_user.id) }, status: :created
    else
      render json: { errors: 'failed to create cart' }, status: :not_acceptable
    end
  end

  # def update
  #   if @cart.update(cart_params)
  #     render json: { cart: @cart }, status: :updated
  #   else
  #     render json: { errors: @cart.errors.full_messages }, status: :not_acceptable
  #   end 
  # end

# def destroy
#   if @cart
#     @cart.destroy
#   else
#     render json: { errors: ["cart is null. Delete failed"] }, status: :not_acceptable
#   end
# end

#   private
#   def cart_params
#     params.permit(
#       :user_id
#       # t.boolean :checked_out, default: false
#       ) 
  # end

end
