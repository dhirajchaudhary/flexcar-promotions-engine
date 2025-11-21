# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  before_action :set_cart

  def add_item
    item = Item.find(params[:item_id])

    if item.quantity?
      @cart.add_item(item, quantity: params[:quantity].to_i)
    else
      @cart.add_item(item, weight_grams: params[:weight_grams].to_i)
    end

    PromotionEngine.new(@cart).apply_best_promotions

    redirect_to root_path, notice: "#{item.name} added! Best promotion applied."
  end

  def remove_item
    item = Item.find(params[:item_id])
    @cart.remove_item(item)

    PromotionEngine.new(@cart).apply_best_promotions

    redirect_to root_path, notice: "#{item.name} removed"
  end

  private

  def set_cart
    @cart = Cart.find(session[:cart_id])
  end
end