class Members::PostsController < ApplicationController
  # before_action :authenticate_user!
  before_action :load_user
  before_action :load_post, except: [:index, :new, :create]
  before_action :load_category

  def index
    @posts = @user.posts.page(params[:page])
      .per Settings.per_page.member.post
  end

  def new
    @post = @user.posts.new
    @types = @categories.first.types
  end

  def create
    @post = @user.posts.new post_params
    if @post.save
      create_activity_for_post
      flash[:success] = "Tạo bài viết thành công"
      redirect_to members_user_posts_path
    else
      @types = @post.type.category.types
      @category_ = @post.type.category
      render :new
    end
  end

  def show
    @comment = @post.comments.new
    @comments = @post.comments.recent.page(params[:page])
      .per Settings.per_page.member.post
    @posts = @user.posts
  end

  def edit
    @types = @post.type.category.types
    @category_ = @post.type.category
  end

  def update
    if @post.update_attributes post_params
      create_activity_for_post
      flash[:success] = "Cập nhật bài viết thành công "
      redirect_to members_user_posts_path
    else
      @types = @post.type.category.types
      @category_ = @post.type.category
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "Xóa bài viết thành công"
    else
      flash[:warning] = "Xóa bài viết thành không công"
    end
    redirect_to members_user_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:type_id, :title, :content)
  end

  def load_post
    @post = Post.find_by id: params[:id]
    return if @post
    flash[:error] = "Không tìm thấy bài viết"
    redirect_to members_user_posts_path
  end

  def load_user
    @user = User.find_by id: params[:user_id]
    return if @user
    flash[:error] = "Không tìm thấy người dùng"
    redirect_to root_path
  end

  def load_category
    @categories = Category.all
  end

  def create_activity_for_post
    create_activity Post.name, @post, @_action_name
  end
end
