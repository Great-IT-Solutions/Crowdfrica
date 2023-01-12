class Admin::CategoriesController < AdminController
  before_action :make_category_available_for, only: %i[edit update destroy]

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    if @category.persisted?
      redirect_to admin_restricted_all_categories_path,
                  notice: "Category with name #{@category.category_name}, was created successfully"
    else
      flash.now[:alert] = "New category, #{@category.category_name}, could not be created!"
    end
  end

  def edit; end

  def update
    return unless @category.update(category_params)

    redirect_to admin_restricted_all_categories_path, notice: 'Category has been successfully updated'
  end

  def destroy
    @category.destroy
    return unless @category.destroyed?

    redirect_to admin_restricted_all_categories_path, notice: "#{@category.category_name}, was successfully deleted"
  end

  private

  def category_params
    params.require(:category).permit(:category_name, :category_description)
  end

  def make_category_available_for
    @category = Category.friendly.find(params[:id])
  end
end
