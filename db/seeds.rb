# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Product.count == 0
  path = File.join(File.dirname(__FILE__), "seeds/bestseller.json")
  products = JSON.parse(File.read(path))
  products["bestsellers"].each do |p|
    Product.create!(
      price: p["price"]["value"],
      category: p["current_category"]["name"],
      title: p["title"],
      image: p["image"], 
      asin: p["asin"]
    )
  end
  puts "Products are seeded"
end
