class Admins::CategoriesController < DashboardController
  before_action :load_category, except: [:index, :new, :create]
  load_and_authorize_resource
  before_action :authenticate_admin!, only: [:index, :new, :edit, :update, :destroy]

  def index
    @search = Category.ransack(params[:q])
    @categories =  @search.result.recent.page(params[:page])
      .per Settings.per_page.admins.category
    if request.xhr?
      respond_to do |format|
        format.js{}
      end
    end
  end

  def new
    @category = Category.new
    @type = @category.types.build
  end

  def create
    @category = Category.new category_params
    if @category.save
      create_activity_for_category
      flash[:success] = "Tạo danh mục thành công"
      redirect_to admins_categories_path
    else
      render :new
    end
  end

  def show
    @category = Category.find_by id: params[:id]
    if params[:name].eql? Course.name
      render partial: "teachers/courses/type", local: {types: @category.types}
    elsif  params[:name].eql? Post.name
      render partial: "members/posts/type", local: {types: @category.types}
    else
      respond_to do |format|
        format.html{render partial: "details_information", local: {category: @category}}
      end
    end
  end

  def edit; end

  def update
    if @category.update_attributes category_params
      create_activity_for_category
      flash[:success] = "Cập nhật danh mục thành công"
      redirect_to admins_categories_path
    else
      render :edit
    end
  end

  def destroy
    @category.types.each do |type|
      if type.courses.present? || type.posts.present?
        @destroy = true
        break
      end
    end
    if @destroy.blank?
      if @category.destroy
        create_activity_for_category
        flash[:success] = "Xóa danh mục thành công"
      else
        flash[:error] = "Xóa danh mục không thành công"
      end
    else
      flash[:error] = "Không thể xóa danh mục này"
    end
    redirect_to admins_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :description, types_attributes: [:id, :name, :_destroy])
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:error] = "Không tìm thấy danh mục"
    redirect_to admins_categories_path
  end

  def create_activity_for_category
    create_activity Category.name, @category, @_action_name
  end
end
