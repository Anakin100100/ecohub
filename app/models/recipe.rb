class Recipe < ApplicationRecord
    include PgSearch::Model

    has_one :user
    has_and_belongs_to_many :ingredients
    has_and_belongs_to_many :lists
    pg_search_scope :search_name,
        against: { name: 'A', text: 'B' },
        using: { tsearch: { dictionary: 'english' } }
end
