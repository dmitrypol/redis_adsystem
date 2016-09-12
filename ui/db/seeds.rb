# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
admin = User.create(email: "admin@email.com", password: 'password')
admin.add_role :admin

REDIS_ADS.del("*")

Ad.delete_all
10.times do |i|
  Ad.create(keywords: "keyword#{rand((1..5))}", cpc: rand(1..10), budget: rand(20..50),
    title: "title#{i}", body: "body#{i}", link: "http://website#{i}.com")
end
