class CreateIepsTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :ieps_types do |t|
      t.integer :percentage, null: false

      t.timestamps
    end
    add_index :ieps_types, :percentage, unique: true
  end
end
