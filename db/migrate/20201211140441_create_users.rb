class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password_digest
      t.string :email
      t.integer :age
      t.integer :clothing_size
      t.integer :shoe_size

      t.timestamps
    end
  end
end
