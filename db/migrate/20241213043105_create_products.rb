class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.integer :stock
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
