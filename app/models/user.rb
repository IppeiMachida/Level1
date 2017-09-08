class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  validates :name, length: { in: 2..10 }
  validates :introduction, length: { maximum: 50 }
  has_many :posts
  mount_uploader :image, ImageUploader
  has_many :favorites, dependent: :destroy
  
  has_many :active_relationships, -> { where(accepted: true) }, class_name: 'Relationship', foreign_key: :following_id
  has_many :passive_relationships, -> { where(accepted: true) }, class_name: 'Relationship',foreign_key: :followed_id
  has_many :followings, through: :active_relationships, source: :followed 
  has_many :followers, through: :passive_relationships, source: :following
  
  has_many :comments

  #フォローリクエストが来ているユーザーを集める
  has_many :recieve_requested_relationships, -> { where(accepted: false) }, class_name: "Relationship", foreign_key: :followed_id
  has_many :recieve_requests, through: :recieve_requested_relationships, source: :following

  #自分が送ったフォローリクエストを集める
  has_many :send_requested_relationships, -> { where(accepted: false) }, class_name: "Relationship", foreign_key: :following_id
  has_many :send_requests, through: :send_requested_relationships, source: :followed

  def followed_by?(user)
    # フォローされているユーザーの中から引数に渡されたユーザーがいるかどうかを調べる
    passive_relationships.find_by(following_id: user.id).present?
  end
  
  def recieve_requested_by?(user)
    recieve_requested_relationships.find_by(following_id: user.id).present?
  end

  def send_requested_by?(user)
    send_requested_relationships.find_by(followed_id: user.id).present?
  end
  
end
