class Comment < ActiveRecord::Base
  attr_accessible :content
  belongs_to :breve
  belongs_to :user

  validates :breve_id, presence: true
  validates :user_id, presence: true

  validates :content, presence: true
  validates :content, :length => { maximum: 400 }

end
