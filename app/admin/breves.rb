ActiveAdmin.register Breve do

	controller do 
		with_role :admin 
	end

	menu :priority => 2

	scope :published
	scope :draft
	config.sort_order = "updated_at_desc"

	index do 
		column :id
		column :title
		column :location
		column :status
		column :created_at
		column :updated_at
		default_actions
	end
  
end
