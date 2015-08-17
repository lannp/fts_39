# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name: "long",
             email: "long@gmail.com",
             password: "12341234")
4.times do |n|
	name = "name#{n+1}"
	Category.create!(
		name: name)
end
