class Publish::PostsController < ApplicationController
  # before_action :load_category

  def index
    @search = Post.recent.joins(:user).ransack(params[:q])
    @posts = @search.result.page(params[:page])
      .per Settings.per_page.publish.post
    @types = Type.all
    if request.xhr?
      respond_to do |format|
        format.js{}
      end
    end
  end

  private

  def load_category
    @category = Category.find_by id: params[:category_id]
    return if @post
    flash[:error] = "Không tìm thấy danh mục"
    redirect_to publish_posts_path
  end
end
