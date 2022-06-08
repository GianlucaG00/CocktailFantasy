class Review < ApplicationRecord
  belongs_to :drinker
  belongs_to :bar
end
