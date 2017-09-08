class Post < ApplicationRecord
	validates :title, presence: true
	validates :title, length: { maximum: 200 }
	validates :body, presence: true
	validates :body, length: { maximum: 200 }
	belongs_to :user
	mount_uploader :image, ImageUploader
	has_many :favorites, dependent: :destroy

	def favorited_by? user
        favorites.where(user_id: user.id).exists?
    end
    has_many :comments
end
