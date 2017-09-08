module ApplicationHelper
	def accepted_user?(user)
    # ユーザーが鍵付きかどうか
    if user.locked
      # 引数で渡されたuserとcurrent_userが同じ
      # またはRelationshipの中からcurrent_userがuserをフォローしていて申請が許可されているものが存在するか？
      if current_user.id == user.id || Relationship.find_by(following_id: current_user.id, followed_id: user.id, accepted: true).present?
        return true
      else
        return false
      end
    else
      return true
    end
  end
end
