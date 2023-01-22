class Movie < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :genre
  
  validates :title, presence: true
  validates :year, presence: true
  validates :director, presence: true
  validates :watch, presence: true
  validates :rate, presence: true
  validates :rate_horror, presence: true
end
