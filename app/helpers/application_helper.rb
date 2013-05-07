# encoding: UTF-8
module ApplicationHelper

	def parent_layout(layout)
		@_content_for[:layout] = self.output_buffer
		self.output_buffer = render(:file => "layouts/#{layout}")
	end

	def history_to_s(version)

	  	history = version.whodunnit == nil ? "Paris en breves" : User.find_by_id(version.whodunnit).name
		if version.event == "create"
			history += " a cree la breve"
		elsif version.event == "update" && version.edit_type == "revert"
			history += " a retabli une version anterieure de la breve"
		else
			modifications = []
			changeset = version.changeset.keys
			changeset.map! { |key| key == "longitude" ? "latitude" : key }
			changeset.map! { |key| key == "source_URL" ? "source_name" : key }
			changeset.uniq!
			changeset.each do |key|
				if key == "title"
					modifications << "le titre"
				elsif key == "location"
					modifications << "le lieu"
				elsif key == "description"
					modifications << "la description"
				elsif key == "source_name"
					modifications << "la source"
				elsif key == "latitude"
					modifications << "la localisation"
				elsif key == "photo"
					modifications << "l'illustration"
				elsif key == "status"
					modifications << "le statut"
				end
			end
			history += " a mis a jour " + modifications.join(", ")
		end

		return history

	end

	def peb_image_tag(item, *args)
		if item.photo.file?
			return image_tag item.photo.url(args[0])
		else
			render :partial => "shared/missing_photo", :locals => {:size => args[0]}
		end	
	end

end
