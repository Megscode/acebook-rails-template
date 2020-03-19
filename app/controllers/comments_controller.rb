class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:format])
    @comment = Comment.new
  end

  def create
    @comment = Comment.create(comment_params)
    redirect_to posts_url
  end

  # def edit
  #   @comment = Comment.find(params[:id])
  # end

  # def update
  #   @comment = Comment.find(params[:id])
  #   if @comment.update(comment_params)
  #   redirect_to posts_path, :notice => "Your comment has been updated"
  #     else 
  #       render "edit"
  #     end
  # end

  # def destroy
  #   @comment = Comment.find(params[:id])
  #   @comment.destroy
  #   redirect_to posts_path
  # end


  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end
end
