class ChildAnniversary < ApplicationRecord
  belongs_to :user
  has_many :child_posts, dependent: :destroy
  default_scope -> { order(created_at: :desc)}
  validates :user_id, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 100}
end
