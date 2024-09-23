class CreateFavoritesJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :messages, table_name: :favorites do |t|
      t.index :user_id
      t.index :message_id
    end
  end
end
