class AddAsinToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :asin, :string
  end
end
