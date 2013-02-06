namespace :db do
  desc "Fill database with sample subjects"
  task comments: :environment do

		10.times do |index|
			user = User.new(
				name: "Person_#{index}",
				email: "person_#{index}@gmail.com",
				password: "password",
				password_confirmation: "password"
				)
			user.role = "editor"
			user.save!
		end

		Breve.all[0..20].each do |breve|
			50.times do |index|
				comment = breve.comments.build(content: Faker::Lorem.paragraph(5))
				comment.user_id = User.last.id
			end
			breve.save!
		end

	end
end