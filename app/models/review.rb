class Review < ApplicationRecord
  belongs_to :drinker
  belongs_to :bar

  validates :text, :presence => true
end
