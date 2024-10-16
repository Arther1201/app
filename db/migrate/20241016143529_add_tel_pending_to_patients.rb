class AddTelPendingToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :tel_pending, :boolean
  end
end
