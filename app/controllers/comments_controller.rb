class CommentsController < ApplicationController
	before_action :authenticate_user!
def create
  @post = Post.find(params[:post_id])
  @comment = current_user.comments.build(body: params[:comment][:body],post_id:@post.id)
  if @comment.save
    redirect_to post_url(@post), notice: "コメントしました"
  else
    redirect_to post_url(@post), alert: "コメントできません"
  end
end
def destroy
  @comment = Comment.find_by!(post_id: params[:post_id],user_id:current_user.id)
  @comment.destroy
  redirect_to post_url(params[:post_id]), notice: "コメントを削除しました"
end
end
