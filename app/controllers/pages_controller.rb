class PagesController < ApplicationController
  before_action :set_cart

  def home
    @items = Item.all
  end

  private

  def set_cart
    @cart = Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] ||= @cart.id
  end
end
