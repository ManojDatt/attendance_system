# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
("A".."D").each do |i|
Category.create(description:i)
end
ListPrice.create(list_description:"Simplify",list_default_mark: true)
ListPrice.create(list_description:"Complex",list_default_mark: false)
Service.create(description:"ARRASTREE")
Service.create(description:"ARRASDHGFFGTREE")
Service.create(description:"ARRASTRGHFHDFJEE")
Service.create(description:"ARRASTRFDGJHGFKJDEE")