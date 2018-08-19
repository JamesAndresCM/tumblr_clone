class PostsController < ApplicationController
  helper_method :post
  helper_method :comment
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:edit, :destroy, :update]
  
  def index; end

  def new; end

  def show; end
  
  def edit; end

  def create
    if post.save
      redirect_to posts_path
    else 
      render 'new'
    end
  end

  def update
    if post.update(post_params)
      redirect_to post
    else 
      render 'edit'
    end
  end

  def destroy
    redirect_to posts_path if post.destroy
  end

  private
  
  def post_params
    params.require(:post).permit(:title, :body, tags_attributes: [:_destroy, :id, :name])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post
    @post ||=
    case action_name
    when "index"
     Post.ordenados
    when "new"
      Post.new
    when "new","create"
      current_user.posts.build(post_params)      
    when "show"
      Post.p_user(params[:id])
    else
      set_post rescue nil
    end
  end

  def comment
    @comment ||= 
    Comment.user_comments(params[:id]) if action_name.eql? "show"
  end
end
