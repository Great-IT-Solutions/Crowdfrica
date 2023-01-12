class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    redirect_to request.referer if @comment.persisted?
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    redirect_to request.referer if @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commenter_id, :commenter_type, :commentable_id, :commentable_type)
  end
end
