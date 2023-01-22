class Genre < ApplicationRecord
  has_many :movie, dependent: :destroy
end
