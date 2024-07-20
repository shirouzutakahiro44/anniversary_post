class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :from_user, class_name: 'User'
  belongs_to :child_post
  validates :user_id, presence: true
  validates :child_post_id, presence: true
  validates :variety, presence: true
  validates :from_user_id, presence: true
  scope :ordered, -> { order(created_at: :desc) }
end
