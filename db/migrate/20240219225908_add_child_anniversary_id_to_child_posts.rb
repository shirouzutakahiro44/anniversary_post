class AddChildAnniversaryIdToChildPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :child_posts, :child_anniversary_id, :integer
  end
end
