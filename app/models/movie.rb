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
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(rate: :desc)}
  scope :horror_count, -> {order(rate_horror: :desc)}
end
