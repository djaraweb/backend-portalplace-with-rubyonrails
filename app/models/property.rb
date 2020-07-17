class Property < ApplicationRecord
  belongs_to :user
  
  validates :placehouse, presence: true
  validates :title, presence: true
  validates :mts2, presence: true
  validates :street, presence: true
  validates :geolat, presence: true
  validates :geolng, presence: true
  validates :visits, presence: true
  validates :price, presence: true
  validates :urlimage, presence: true
  
  validates :user_id, presence: true

end
