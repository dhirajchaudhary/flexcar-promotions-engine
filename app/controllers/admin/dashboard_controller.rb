# app/controllers/admin/dashboard_controller.rb
class Admin::DashboardController < ApplicationController
  def show
    @items = Item.all
    @categories = Category.all
    @brands = Brand.all
    @promotions = Promotion.all
  end
end
