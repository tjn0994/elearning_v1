class Publish::PostsController < ApplicationController
  # before_action :load_category

  def index
    @posts = Post.recent.page(params[:page])
      .per Settings.per_page.publish.post
  end

  private

  def load_category
    @category = Category.find_by id: params[:category_id]
    return if @post
    flash[:error] = "Không tìm thấy danh mục"
    redirect_to publish_posts_path
  end
end

