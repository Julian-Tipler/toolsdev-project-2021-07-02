class CreateTemperatures < ActiveRecord::Migration[5.2]
  def change
    create_table :temperatures do |t|
      t.datetime :datetime
      t.integer :temperature

      t.timestamps
    end
  end
end
