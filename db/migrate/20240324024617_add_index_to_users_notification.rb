class AddIndexToUsersNotification < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :notification, :boolean, default: false
  end
end
