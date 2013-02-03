# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.new(
	name: "paris_en_breves",
	email: "parisenbreves@gmail.com",
	password: "peb99!",
	password_confirmation: "peb99!"
	)
admin.role = "admin"
admin.save!