class HashtagPost < ApplicationRecord
  belongs_to :child_post
  belongs_to :hashtag
  validates :child_post_id, presence: true
  validates :hashtag_id, presence: true
end
