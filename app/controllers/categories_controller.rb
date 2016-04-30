class CategoriesController < ApplicationController
	before_action :set_product, only: :show

	def index

	end

	def show
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)

		if @category.save
			redirect_to @category, notice: 'Category has been created'
		else
			render :new
		end
	end

	private

	def set_product
    @category = Category.find(params[:id])
  end

	def category_params
		params.require(:category).permit(:name)
	end

end