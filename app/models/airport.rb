class Airport < ApplicationRecord
  validates :icao, presence: true, uniqueness: true
end