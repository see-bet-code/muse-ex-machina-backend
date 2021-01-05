class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.float :price
      t.string :category
      t.string :title
      t.string :asin
      t.string :brand
      t.string :image
      t.string :merchant_name
      t.text :description
      t.float :rating
      t.integer :ratings_total

      t.timestamps
    end
  end
end
