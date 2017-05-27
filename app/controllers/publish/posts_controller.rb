class Publish::PostsController < ApplicationController
  # before_action :load_category

  def index
    @search = Post.recent.joins(:user).ransack(params[:q])
    @posts = @search.result.page(params[:page])
      .per Settings.per_page.publish.post
    @types = Type.all
    @posts_top = Post.find_by_sql('SELECT posts.id, posts.title, posts.created_at FROM rates left join posts on
      rates.rateable_id = posts.id group by posts.id  order by AVG(rates.stars) desc limit 10')
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
