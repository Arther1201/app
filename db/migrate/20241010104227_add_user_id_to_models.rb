class AddUserIdToModels < ActiveRecord::Migration[7.0]
  def change
    if column_exists?(:models, :user_id)
      remove_column :models, :user_id
    end
    add_column :models, :user_id, :bigint, null: false
    add_index :models, :user_id
  end
end