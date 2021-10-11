class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.string :name, index: { unique: true }
      t.string :corporation
      t.integer :amount
      t.decimal :price, precision: 15, scale: 2
      t.references :bearer, foreign_key: true, index: true

      t.timestamps
    end
  end
end
