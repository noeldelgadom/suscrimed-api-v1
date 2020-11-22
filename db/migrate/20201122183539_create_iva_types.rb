class CreateIvaTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :iva_types do |t|
      t.integer :percentage, null: false

      t.timestamps
    end
    add_index :iva_types, :percentage, unique: true
  end
end
