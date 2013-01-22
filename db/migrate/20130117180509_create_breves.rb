class CreateBreves < ActiveRecord::Migration
  def change
    create_table :breves do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
