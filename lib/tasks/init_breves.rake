namespace :db do

  desc "Fill database with sample data"
  task init_breves: :environment do
  	require 'csv'

  	CSV.foreach(Rails.root.join("public/Breves_full_last.csv")) do |row|
  		breve = Breve.new(
  			title: row[1],
  			location: row[3],
  			description: row[4],
  			source_name: row[5],
  			source_URL: row[6],
  			latitude: row[7],
  			longitude: row[8]
  			)
  		if row[2] == "publish"
  			breve.status = "published"
  		else
  			breve.status = "draft"
  		end
  		breve.save!
  	end

  end
end
