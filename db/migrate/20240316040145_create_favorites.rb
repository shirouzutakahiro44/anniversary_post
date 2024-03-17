class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :child_post_id

      t.timestamps
    end
    add_index :favorites, [:user_id, :child_post_id], unique: true  # 追記
  end
end
