class Breve < ActiveRecord::Base
  attr_accessible :description, :title, :location, :source_name, :source_URL, :latitude, :longitude
  has_paper_trail
  
  validates :title, presence: true
  validates :title, :length => { :maximum => 100 }

  validates :location, :length => { :maximum => 100 }
  validates :description, :length => { :maximum => 2000 }
  validates :source_name, :length => { :maximum => 100 }

  validates :latitude, presence: true
  validates :latitude, numericality: true
  validates :latitude, :numericality => {
  	:greater_than => -Math::PI/4,
  	:less_than => Math::PI/4
  }
  
  validates :longitude, presence: true
  validates :longitude, numericality: true
  validates :longitude, :numericality => {
  	:greater_than => -Math::PI/2,
  	:less_than => Math::PI/2
  }

end
