class Comment < ApplicationRecord
  belongs_to :child_post
  validates :user_id, presence: true
  validates :child_post_id, presence: true
  validates :content, presence: true, length: { maximum: 50 }
end
