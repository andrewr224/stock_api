class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.string :name, index: { unique: true }
      t.string :corporation

      t.timestamps
    end
  end
end
