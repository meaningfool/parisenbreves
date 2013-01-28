class Breve < ActiveRecord::Base
  attr_accessible :description, :title, :location, :source_name, :source_URL, :latitude, :longitude
  has_paper_trail
  reverse_geocoded_by :latitude, :longitude
  
  validates :title, presence: true
  validates :title, :length => { :maximum => 100 }

  validates :location, :length => { :maximum => 100 }
  validates :description, :length => { :maximum => 2000 }
  validates :source_name, :length => { :maximum => 100 }

  validates :latitude, presence: true
  validates :latitude, numericality: true
  validates :latitude, :numericality => {
  	:greater_than => -90,
  	:less_than => 90
  }
  
  validates :longitude, presence: true
  validates :longitude, numericality: true
  validates :longitude, :numericality => {
  	:greater_than => -180,
  	:less_than => 180
  }



  private

      def self.find_near(coordinates, distance)
        nearby_breves = self.near(coordinates, distance)
        breves_array = []
        #binding.pry
        nearby_breves.each do |breve|
          breve_coordinates = [breve.latitude, breve.longitude]
          breves_array.push([breve, Geocoder::Calculations.distance_between(coordinates, breve_coordinates)])
          #binding.pry
        end
        breves_array = breves_array.sort { |a,b| a[1] <=> b[1] }
        ordered_breves = []
        breves_array.each do |item|
          ordered_breves.push(item[0])
        end
        #binding.pry
        return ordered_breves
      end

end
