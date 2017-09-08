class PostsController < ApplicationController
   before_action :authenticate_user!
   before_action :correct_user, only: [:edit, :update]
   before_action :set_request_from, only: :create

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new
  	@post.title = params[:post][:title]
  	@post.body = params[:post][:body]
    @post.user_id = current_user.id
    # =User.find(:id)
  	if @post.save
  		redirect_to post_path(@post.id)
  	else
      return_back and return	
    end
  end

  def index
    @posts = Post.page(params[:page]).per(3).includes(:user)
  end

  def show
  	@post = Post.find(params[:id])
    @comments = @post.comments
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    @post.save
    redirect_to post_path(@post.id)
  end

  def destroy
  	@post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    #:user_idを追加
    params.require(:post).permit(:title, :body, :user_id)
  end

  def correct_user
    post = Post.find(params[:id])
    if current_user.id != post.user.id
      redirect_to root_path
    end
  end

  def set_request_from
    if session[:request_from]
      @request_from = session[:request_from]
    end
    # 現在のURLを保存しておく
    session[:request_from] = request.original_url
  end

  def return_back
    if request.referer
      redirect_back(fallback_location: root_path)
    elsif @request_from
      redirect_to @request_from and return true
    end
  end

end
