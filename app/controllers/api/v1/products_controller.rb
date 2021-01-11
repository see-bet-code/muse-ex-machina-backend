class Api::V1::ProductsController < ApplicationController
  skip_before_action :authorized

  def index
    render json: Product.all, each_serializer: ProductSerializer
  end

end
