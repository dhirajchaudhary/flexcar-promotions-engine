# app/controllers/categories_controller.rb
class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_dashboard_path, notice: "Category '#{@category.name}' created!"
    else
      render turbo_stream: turbo_stream.replace(
        "category_form",
        partial: "admin/dashboard/category_form",
        locals: { category: @category }
      )
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
