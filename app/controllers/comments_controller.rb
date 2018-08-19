class CommentsController < ApplicationController
  helper_method :comment
  before_action :set_post, only: [:create, :destroy]

  def create
    #@comment = @post.comments.build(comment_params.merge(user_id: current_user.id))
    redirect_to post_path(@post) if comment.save
  end

  def destroy
    redirect_to post_path(@post) if comment.destroy
  end

  private
  
  def comment_params
    params.permit(:post_id, comment: [:body])
  end
  
  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment_post
    @comment = @post.comments.find_by(id: params[:id])
  end

  def comment
    @comment ||=
    if action_name.eql?("create")
      current_user.comments.build(body: params[:comment][:body], post_id: params[:post_id])
    else
      set_comment_post rescue nil
    end
  end
end
