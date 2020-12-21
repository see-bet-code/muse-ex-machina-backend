require 'stripe'
# require 'json'
# require 'sinatra'

class Api::V1::CheckoutsController < ApplicationController
  # This example sets up an endpoint using the Sinatra framework.
  # Watch this video to get started: https://youtu.be/8aA9Enb8NVc.

  # Set your secret key. Remember to switch to your live secret key in production!
  # See your keys here: https://dashboard.stripe.com/account/apikeys
  Stripe.api_key = ENV['stripe_api_key']

  def create_session
    line_items = params["_json"].map{|p| {
          price_data: {
            currency: 'usd',
            product_data: {
              name: p["product"]["title"],
              images: [p["product"]["image"]]
            },
            unit_amount: (p["product"]["price"].to_i * 100),
          },
          quantity: p["quantity"],
        } }
    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: line_items,
      mode: 'payment',
      # For now leave these URLs as placeholder values.
      #
      # Later on in the guide, you'll create a real success page, but no need to
      # do it yet.
      success_url: 'http://localhost:3001/profile-page',
      cancel_url: 'http://localhost:3001/cart',
    })
    Cart.find(params["_json"][0]["cart_id"]).update(checked_out: true)
    render json: { id: session.id, session: session }

  end



end