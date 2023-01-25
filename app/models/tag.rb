class Tag < ApplicationRecord
    
  has_many :movie_tags, dependent: :destroy
  has_many :movies, through: :movie_tags, dependent: :destroy
end
