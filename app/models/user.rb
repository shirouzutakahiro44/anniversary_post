class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :child_posts, dependent: :destroy
  has_many :child_anniversaries, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships,  source: :followed
  
  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, length: { maximum: 255 }
  validates :profile, length: { maximum: 200 } # 追記
  validates :username, presence: true, length: { maximum: 50 }
  
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  def followed_by?(other_user)
    followers.include?(other_user)
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    ChildPost.desc_order.where("user_id IN (#{following_ids})
                    OR user_id = :user_id", user_id: id)
  end
end
