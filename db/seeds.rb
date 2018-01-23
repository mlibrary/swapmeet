# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

users = User.create([
  { username: 'botimer', display_name: 'Noah Botimer', email: 'botimer@example.com' },
  { username: 'gkostin', display_name: 'Greg Kostin', email: 'gkostin@example.com' },
])

categories = Category.create([
  { title: 'Computer accessories', body: 'Peripherals and accessories for use with a computer' },
  { title: 'Furniture', body: 'Lightly used office furniture of any type' },
])

listings = Listing.create([
  { title: '4-port USB Hub', body: 'Basic USB 2.0, 4-port hub', owner: users.first, category: categories[0] },
  { title: 'Small filing cabinet', body: 'Two-drawer wooden filing cabinet. Nice condition; maple veneer.', owner: users.first, category: categories[1] },
  { title: 'Split keyboard', body:'Spare ergonomic keyboard; split design, USB or PS/2.', owner: users[1], category: categories[0] },
])
