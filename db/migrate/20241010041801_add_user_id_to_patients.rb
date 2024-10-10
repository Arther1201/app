class AddUserIdToPatients < ActiveRecord::Migration[7.0]
  def change
    if column_exists?(:patients, :user_id)
      remove_column :patients, :user_id
    end
    add_column :patients, :user_id, :bigint, null: false
    # add_index :patients, :user_id
  end
end