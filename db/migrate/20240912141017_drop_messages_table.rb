class DropMessagesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :messages do |t|
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
      t.timestamps
    end
  end
end