class Chat < ApplicationRecord
  belongs_to :bar
  belongs_to :drinker

  # Non possono esistere due tuple con stesso bar_id e stesso drinker_id
  validates_uniqueness_of :bar_id, scope: :drinker_id

end
