class List < ApplicationRecord
    has_one :user
    has_and_belongs_to_many :ingredients
    has_and_belongs_to_many :recipes
end
