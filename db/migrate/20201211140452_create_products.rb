class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.float :price
      t.string :category
      t.string :title
      t.string :image
      t.string :merchant_name
      t.textarea :description

      t.timestamps
    end
  end
end
