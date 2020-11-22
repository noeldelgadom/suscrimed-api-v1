class CreateTaxTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :tax_types do |t|
      t.string :name
      t.references :iva_type, null: false, foreign_key: true
      t.references :ieps_type, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tax_types, :name, unique: true
  end
end
