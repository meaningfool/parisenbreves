ActiveAdmin.register Comment, :as => "BreveComments" do
	menu :priority => 4
	menu :label => "Comments"
  
	controller do 
		with_role :admin 

		def scoped_collection
			end_of_association_chain.includes(:user, :breve)
		end
	end

	config.sort_order = "updated_at_desc"

	index do 
		column :id
		column :content
		column :breve
		column :user
		column :created_at
		default_actions
	end

end
