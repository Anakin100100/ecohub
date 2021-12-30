class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :timeoutable, :confirmable, :lockable
  has_many :recipes
  has_many :ingredients, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments,  dependent: :destroy

  acts_as_favoritor

  def email_changed?
    false
  end

end
