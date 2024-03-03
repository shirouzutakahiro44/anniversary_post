class AddAnniversaryIdToChildPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :child_posts, :anniversary_id, :integer
  end
end
