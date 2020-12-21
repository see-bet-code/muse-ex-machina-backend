# t.float "price"
# t.string "category"
# t.string "title"
# t.string "image"
# t.string "merchant_name"
# t.text "description"
# t.datetime "created_at", precision: 6, null: false
# t.datetime "updated_at", precision: 6, null: false
# t.string "asin"

class Api::V1::ProductsController < ApplicationController
  skip_before_action :authorized

  def index
    render json: { products: Product.all.to_json(:include => [:views])}
  end

end
