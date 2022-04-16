class AddEmployeeIdToKudos < ActiveRecord::Migration[6.1]
  def change
    add_column :kudos, :employee_id, :integer
    add_index :kudos, :employee_id
  end
end
