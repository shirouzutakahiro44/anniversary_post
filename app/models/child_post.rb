class ChildPost < ApplicationRecord
  belongs_to :user
  belongs_to :child_anniversary
  has_one_attached :image
  scope :desc_order, -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 17 }

  def image_content_type
    if image.attached? && !image.content_type.in?(%w[image/jpeg image/png image/gif])
      errors.add(:image, ':ファイル形式が、JPEG, PNG, GIF以外になってます。ファイル形式をご確認ください。')
    end
  end

  def image_size
    if image.attached? && image.blob.byte_size > 1.megabytes
      errors.add(:image, ':1MB以下のファイルをアップロードしてください。')
    end
  end

  def image_as_thumbnail
    return unless image.content_type.in?(%w[image/jpeg image/png])
    image.variant(resize_to_limit: [200, 100]).processed
  end
end
