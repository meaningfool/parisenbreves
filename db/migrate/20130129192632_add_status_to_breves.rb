class AddStatusToBreves < ActiveRecord::Migration
  def change
    add_column :breves, :status, :string
  end
end
