# app/controllers/brands_controller.rb
class BrandsController < ApplicationController
  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      redirect_to admin_dashboard_path, notice: "Brand '#{@brand.name}' created!"
    else
      render turbo_stream: turbo_stream.replace(
        "brand_form",
        partial: "admin/dashboard/brand_form",
        locals: { brand: @brand }
      )
    end
  end

  private

  def brand_params
    params.require(:brand).permit(:name)
  end
end
