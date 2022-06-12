class Review < ApplicationRecord
  belongs_to :drinker
  belongs_to :bar

  validates :text, :presence => true
  validates :vote, :presence => true, inclusion: {in: [1,2,3,4,5]}
  # validates_uniqueness_of :bar_id, scope: :drinker_id
  validates :bar_id, uniqueness: { scope: :drinker_id, message: "Puoi lasciare una sola recensione per Bar" }
end
