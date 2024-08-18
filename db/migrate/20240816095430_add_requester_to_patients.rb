class AddRequesterToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :requester, :string
  end
end
