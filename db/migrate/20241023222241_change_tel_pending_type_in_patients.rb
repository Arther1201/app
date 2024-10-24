class ChangeTelPendingTypeInPatients < ActiveRecord::Migration[7.0]
  def up
    change_column :patients, :tel_pending, :string
  end

  def down
    change_column :patients, :tel_pending, :boolean
  end
end
