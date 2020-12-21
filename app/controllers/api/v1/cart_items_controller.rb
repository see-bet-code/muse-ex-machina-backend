class Api::V1::CartItemsController < ApplicationController
  skip_before_action :authorized

  def index
    render json: {cart_items: CartItem.where().to_json(:include => [:product])}
  end

  def create
    p cart_item_params
    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.save
      render json: { cart_items: CartItem.all.to_json(:include => [:product])}, status: :created
    else
      render json: { errors: 'failed to create cart item' }, status: :not_acceptable
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      render json: { cart_items: CartItem.all.to_json(:include => [:product])}, status: :created
    else
      render json: { errors: 'failed to update cart item' }, status: :not_acceptable
    end
  end

  def destroy
    CartItem.destroy(params[:id])
    render json: { cart_items: CartItem.all.to_json(:include => [:product])}
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
