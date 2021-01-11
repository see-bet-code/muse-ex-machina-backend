class Api::V1::CartsController < ApplicationController

  def show
    active = Cart.find(params[:id])
    render json: { active_cart: active.to_json(:include => {:cart_items => {:include =>:product}}) }
  end

  def index
    active = Cart.find_by(checked_out: false, user_id: current_user.id)
    if active
      render json: { carts: Cart.where(user_id: current_user.id), active: active }
    else
      new = Cart.create(user_id: current_user.id)
      render json: { carts: Cart.where(user_id: current_user.id), active: new }
    end
  end

  def create
    @cart = Cart.new(user_id: current_user.id)
    if @cart.save
      render json: { cart: @cart, carts: Cart.where(user_id: current_user.id) }, status: :created
    else
      render json: { errors: 'failed to create cart' }, status: :not_acceptable
    end
  end

  def update
    cart = Cart.find(params[:id])
    if cart.update(update_params)
      cart.products.map { |p| Review.find_or_create_by(user_id: current_user.id, product_id: p.id) }
      # render json: { carts: Cart.where(user_id: current_user.id) }
    else
      render json: { errors: cart.errors.full_messages }, status: :not_acceptable
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
    params.require(:cart).permit(
      :checked_out
      ) 
  end

end
