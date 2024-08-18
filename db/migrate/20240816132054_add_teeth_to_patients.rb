class AddTeethToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :upper_right, :text
    add_column :patients, :upper_left, :text
    add_column :patients, :lower_right, :text
    add_column :patients, :lower_left, :text
  end
end
