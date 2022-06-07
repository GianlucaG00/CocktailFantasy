class Review < ApplicationRecord
  belongs_to :Drinker
  belongs_to :Bar
end
