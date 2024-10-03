class AddDepartmentIdToSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :supplies, :department_id, :integer
  end
end
