class Ingredient < ApplicationRecord
    has_one :user
    has_and_belongs_to_many :recipes
    has_and_belongs_to_many :lists
end
