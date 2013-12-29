class Subject < ActiveRecord::Base

	STATUS = %w[active treated]

	validates :title, presence: :true
	validates :title, :length => { maximum: 100 }
	validates :description, presence: :true
	validates :description, :length => { maximum: 2000 }
	validates :status, :inclusion => { :in => STATUS }

end