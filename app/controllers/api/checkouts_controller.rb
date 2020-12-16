require 'stripe'
# require 'json'
# require 'sinatra'

class Api::V1::CheckoutsController < ApplicationController
  # This example sets up an endpoint using the Sinatra framework.
  # Watch this video to get started: https://youtu.be/8aA9Enb8NVc.

  # Set your secret key. Remember to switch to your live secret key in production!
  # See your keys here: https://dashboard.stripe.com/account/apikeys
  Stripe.api_key = ENV['stripe_api_key']

  def create_checkout_session
    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: 'RELOAD WALLET',
            images: ["https://assets.website-files.com/5ef5c908f55bc9b2c48a5cc2/5f50d9811e955f59eababcf7_online-wallets-in-india.jpg"]
          },
          unit_amount: params[:amount].to_i * 100,
        },
        quantity: 1,
      }],
      mode: 'payment',
      # For now leave these URLs as placeholder values.
      #
      # Later on in the guide, you'll create a real success page, but no need to
      # do it yet.
      success_url: 'http://localhost:3001/success',
      cancel_url: 'http://localhost:3001/cancel',
    })
    @user.update(balance: @user.balance + params[:amount].to_f)
    render json: { id: session.id, session: session }

  end



end