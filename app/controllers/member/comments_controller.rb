class Member::CommentsController < ApplicationController
  before_action :load_post

  def index
  end

  def create
    @comment = @post.comments.build comment_params
    if @comment.save
      respond_to do |format|
        format.js # JavaScript response
      end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.js # JavaScript response
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge! user_id: current_user.id
  end

  def load_post
    @post = Post.find_by id: params[:post_id]
    return if @post
    flash[:error] = "Không tìm thấy bài viết"
    redirect_to publish_posts_path
  end
end
