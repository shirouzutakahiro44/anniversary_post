class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :child_post_id
      t.integer :variety
      t.text :content
      t.integer :from_user_id

      t.timestamps
    end
    add_index :notifications, :user_id  # 追記
  end
end
