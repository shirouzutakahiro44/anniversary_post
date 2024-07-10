class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :child_post
  validates :user_id, presence: true  # 追記
  validates :child_post_id, presence: true
end
