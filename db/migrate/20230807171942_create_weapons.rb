class CreateWeapons < ActiveRecord::Migration[7.0]
  def change
    create_table :weapons do |t|
      t.string :name
      t.string :description
      t.integer :power_base
      t.integer :power_step
      t.integer :level, default: 1

      t.timestamps
    end
  end
end
