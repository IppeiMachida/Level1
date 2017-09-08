class UsersController < ApplicationController
	before_action :authenticate_user!
  def new

  end

  def create
  
  end
  
  def index
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
  	@post = Post.new
    @posts = @user.posts.page(params[:page]).per(3)

  end
  
  def edit
  	@user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(email: params[:user][:email], locked: params[:user][:locked])
    redirect_to user_path(@user), notice: 'ユーザー情報を更新しました!' 
    else
    render :edit, notice: 'ユーザー情報を更新できませんでした...' 
    end
  end

  def favorites
    @user = User.find(params[:id])
  end

  # フォローしているユーザー一覧を表示するためのアクション
  def follows
   @user = User.find(params[:id])
   @follows = @user.followings
  end

  # フォロワー一覧を表示するためのアクション
  def followers
   @user = User.find(params[:id])
   @followers = @user.followers
  end

  def requests
    @user = User.find(params[:id]) 
    @requests = @user.recieve_requests
  end

  private
  def post_params
    params.require(:user).permit(:name, :introduction, :image)
  end
end
