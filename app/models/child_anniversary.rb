class ChildAnniversary < ApplicationRecord
  belongs_to :user
  has_one :child_post, dependent: :destroy
  scope :desc_order, -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 100 }
end
