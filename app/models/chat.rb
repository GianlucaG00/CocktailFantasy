class Chat < ApplicationRecord
    # ASSOCIATIONS
    has_many :bars
    has_many :drinkers

end
