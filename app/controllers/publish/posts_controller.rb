class Publish::PostsController < ApplicationController
  before_action :load_post, except: [:index, :new, :create]
  before_action :load_category

  def index
    @posts = current_user.posts.recent.page(params[:page])
      .per Settings.per_page.publish.post
  end

  def new
    @post = current_user.posts.new
    @post.post_types.build
  end

  def create
    @post = current_user.posts.new post_params
    if @post.save
      create_activity Post.name, @post, "post.create"
      flash[:success] = t "devise.registrations.signed_up"
      redirect_to publish_posts_path
    else
      render :new
    end
  end

  def show

  end

  def edit; end

  def update
    if @post.update_attributes post_params
      flash[:success] = t "devise.registrations.updated"
      redirect_to publish_posts_path
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t "devise.registrations.destroyed"
    else
      flash[:warning] = t "delete_not_success"
    end
    redirect_to publish_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:category_id, :title, :content,
      post_types_attributes: [:id, :type_id, :_destroy])
  end

  def load_post
    @post = Post.find_by id: params[:id]
    return if @post
    flash[:error] = t "dashboard.users.not_found"
    redirect_to publish_posts_path
  end

  def load_category
    @categories = Category.all
  end
end

