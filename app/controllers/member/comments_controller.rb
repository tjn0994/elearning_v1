class Member::CommentsController < ApplicationController
  before_action :load_post

  def create
    @comment = @post.comments.build comment_params
    if @comment.save
      respond_to do |format|
        format.html do
          flash[:success] = 'Comment posted.'
          redirect_to publish_post_path(@post)
        end
        format.js # JavaScript response
      end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'Comment deleted.'
        redirect_to publish_post_path(@post)
      end
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
    flash[:error] = t "dashboard.users.not_found"
    redirect_to publish_posts_path
  end
end
