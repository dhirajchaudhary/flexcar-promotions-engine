# app/controllers/items_controller.rb
class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_dashboard_path, notice: "Item '#{@item.name}' created!"
    else
      redirect_to admin_dashboard_path, alert: "Failed: #{@item.errors.full_messages.join(', ')}"
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :price_cents, :weight_per_unit_grams,
      :category_id, :brand_id
    ).merge(unit: params[:item][:unit].to_i)
  end
end