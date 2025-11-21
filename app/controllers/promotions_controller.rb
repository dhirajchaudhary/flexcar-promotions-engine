# app/controllers/promotions_controller.rb
class PromotionsController < ApplicationController
  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    if @promotion.save
      redirect_to admin_dashboard_path, notice: "Promotion '#{@promotion.name}' created!"
    else
      redirect_to admin_dashboard_path, alert: "Failed: #{@promotion.errors.full_messages.join(', ')}"
    end
  end

  private

  def promotion_params
    params.require(:promotion).permit(
      :name, :discount_value,
      :buy_quantity, :get_quantity, :threshold_grams,
      :item_id, :category_id, :start_time, :end_time
    ).tap do |p|
      p[:discount_type] = p[:discount_type].to_i if p[:discount_type].present?
      
      p[:buy_quantity] = nil if p[:buy_quantity].blank?
      p[:get_quantity] = nil if p[:get_quantity].blank?
      p[:threshold_grams] = nil if p[:threshold_grams].blank?
      p[:discount_value] = nil if p[:discount_value].blank?
      p[:item_id] = nil if p[:item_id].blank?
      p[:category_id] = nil if p[:category_id].blank?
    end
  end
end