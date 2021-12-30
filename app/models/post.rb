class Post < ApplicationRecord
    has_one :user 
    has_many_attached :images,  dependent: :destroy
    has_many :comments,  dependent: :destroy

    acts_as_favoritable

end
