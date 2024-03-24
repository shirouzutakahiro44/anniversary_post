class AddHashbodyToChildPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :child_posts, :hashbody, :text
  end
end
