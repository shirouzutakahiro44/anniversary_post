class ChildPost < ApplicationRecord
  belongs_to :user
  belongs_to :child_anniversary
  has_one_attached :image
  default_scope -> { order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 17}
end
