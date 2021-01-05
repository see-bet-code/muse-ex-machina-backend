class Api::V1::CartItemsController < ApplicationController
  # skip_before_action :authorized

  def create
    @cart_item = CartItem.new(cart_item_params)
    cart_id = cart_item_params[:cart_id]
    if @cart_item.save
      render json: { cart_items: CartItem.where(cart_id: cart_id).to_json(:include => [:product])}, status: :created
    else
      render json: { errors: 'failed to create cart item' }, status: :not_acceptable
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    cart_id = @cart_item.cart_id
    if @cart_item.update(cart_item_params)
      render json: { cart_items: CartItem.where(cart_id: cart_id).to_json(:include => [:product])}
    else
      render json: { errors: 'failed to update cart item' }, status: :not_acceptable
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    cart_id = @cart_item[:cart_id]
    CartItem.destroy(params[:id])
    render json: { cart_items: CartItem.where(cart_id: cart_id).to_json(:include => [:product])}
  end

  def clear_cart
    id = params.require(:cart_item).permit(:cart_id);
    CartItem.where(id).destroy_all
    render json: { cart_items: []}
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(
      :product_id,
      :cart_id,
      :quantity
    )
  end

  
end
