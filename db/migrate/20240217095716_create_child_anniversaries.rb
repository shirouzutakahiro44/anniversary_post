class CreateChildAnniversaries < ActiveRecord::Migration[7.1]
  def change
    create_table :child_anniversaries do |t|
      t.string :name
      t.date :date
      t.text :description

      t.timestamps
    end
  end
end
