class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    redirect_to posts_url
  end

  def index
    @posts = Post.all.order(created_at: :desc)
    @comments = Comment.all.order(created_at: :desc)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      time_limit_check
    else
      deny_non_user
    end
  end

  def show
    @post = Post.find(params[:id])
    redirect_to posts_path
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      @post.destroy
      redirect_to posts_path
    else
      flash[:alert] = "Posts can only be deleted by the user who created them!"
      redirect_to posts_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:message, :user_id)
  end

  def deny_non_user
    flash[:alert] = "Posts can only be updated by the user who created them!"
    redirect_to @post
  end

  def post_or_rerender
    if @post.update(post_params)
      redirect_to posts_path, :notice => "Your post has been updated"
    else
      render "edit"
    end
  end

  def too_late
    flash[:alert] = "Posts can only be updated within 10 minutes of creation!"
    redirect_to @post
  end

  def time_limit_check
    if @post.created_at > 10.minutes.ago
      post_or_rerender
    else
      too_late
    end
  end
end
