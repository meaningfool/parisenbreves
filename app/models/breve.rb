class Breve < ActiveRecord::Base
  attr_accessible :description, :title, :location, :source_name, :source_URL, :latitude, :longitude, :photo, :status
  has_many :comments, dependent: :destroy

  scope :published, where(:status => "published" )
  scope :draft, where( :status => "draft" )

  has_paper_trail
  reverse_geocoded_by :latitude, :longitude

  STATUS = %w[draft published]
  
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

  has_attached_file :photo, styles: {
    thumb: '64x64',
    medium: '400x300^',
    large: '1280x960^'
  }, :default_url => "https://s3.amazonaws.com/paris_en_breves/breves/photos/000/000/086/large/missing_large.png"

  validates_attachment_size :photo, :less_than => 3.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  validates :status, presence: true
  validates :status, :inclusion => { :in => STATUS }


  def find_near(distance)
    breve_coordinates = [self.latitude, self.longitude]
    return (Breve.find_near(breve_coordinates, distance, self.status) - [self])
  end

  private

      def self.find_near(coordinates, distance, status)
        nearby_breves = self.near(coordinates, distance)
        breves_array = []
        nearby_breves.each do |breve|
          if breve.status == status
            breve_coordinates = [breve.latitude, breve.longitude]
            breves_array.push([breve, Geocoder::Calculations.distance_between(coordinates, breve_coordinates)])
          end
        end
        breves_array = breves_array.sort { |a,b| a[1] <=> b[1] }
        ordered_breves = []
        breves_array.each do |item|
          ordered_breves.push(item[0])
        end
        return ordered_breves
      end


end
