class Review < ApplicationRecord
  belongs_to :drinker
  belongs_to :bar

  validates :text, :presence => true
  validates :vote, :presence => true
  validates_uniqueness_of :bar_id, scope: :drinker_id
end
