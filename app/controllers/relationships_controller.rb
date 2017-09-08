class RelationshipsController < ApplicationController
	 before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    @follow = current_user.active_relationships.build(followed_id: params[:user_id])
    
    if User.find(params[:user_id]).locked
      @follow.accepted = false
    else
      @follow.accepted = true
    end

    if @follow.save
      redirect_to users_url, notice: "フォローしました"
    else
      redirect_to users_url, alert: "フォローできません"
    end
  end

  def destroy
  @user = User.find(params[:user_id])
  # 解除対象のフォローを取得
  if current_user.send_requested_by?(@user)
    @follow = current_user.send_requested_relationships.find_by!(followed_id: @user.id)
  elsif current_user.recieve_requested_by?(@user)
    @follow = current_user.recieve_requested_relationships.find_by!(following_id: @user.id)
  else
    @follow = current_user.active_relationships.find_by!(followed_id: @user.id)
  end
  # 変数に入っているフォローを削除
  @follow.destroy
  redirect_to users_path(@user), notice: "フォロー解除しました"
 end

 def accept
  # current_userのフォローリクエストの中から１件取得してくる
  @request = current_user.recieve_requested_relationships.find_by(following_id: params[:user_id])
  # @requestが存在してれば申請を許可（true）する
  if @request.present?
    @request.update(accepted: true)
    redirect_to users_path(@user)
  else
    redirect_to users_url, notice: "This account doesn't request to follow you" 
  end
end
 
end
